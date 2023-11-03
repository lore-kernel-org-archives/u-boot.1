Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CF4C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 18:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 549668711B;
	Fri,  3 Nov 2023 19:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q1mC5vOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF2C6871A6; Fri,  3 Nov 2023 19:15:13 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA5EE8711A
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 19:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so3967934a12.2
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699035305; x=1699640105; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5rao7ToSwPphiCHOYYaEXgCbctYHwmb0zwOyV/hEYGc=;
 b=Q1mC5vODoUGxWKNacQcKN2cYbf+jb4M38NXcMIYjYeNUrMuf8JzeABTuxmbXofQ01I
 qB1z9Xi8KvZLtUA1Z2WIK26J+jbceh9CeVJXStOHMw+dXXLZvDlm9HGWOaNwITVwYvzv
 idH3qKjIexSq0Oeo0ZP4vZ+ETRcrkZffeuViI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699035305; x=1699640105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5rao7ToSwPphiCHOYYaEXgCbctYHwmb0zwOyV/hEYGc=;
 b=QDjgjm0ND994gSVbV3HcRchKYqIA5cFzoyH5cVhCNvEySnGi/TaSIMQoyynmZjvRVT
 /zE2a9OSDUdxw5fxCSnQHLzErDu6JNAKKLPJ9M6IufIkm+YxQ2mrsE1BeFq7FYNBjCRJ
 bVY4dAaXb/lCf8GuF0XqQ+h9r/D7ubr7i0ntBk37c68IH6UUfs428lJIAahxJjGGIi5e
 XRhWLFGqQsC3oO95F2dHKrV6fzn6iOwXq6GbiENbM/ICj8487LpGIxXl+RryBQkfWauR
 tlv0rcsQZq1xn7fvAISKlIGBdL//w5I4+KkF5VkGoTo2RNHxKpyvD9y5FtXR6kxFf1uU
 z7lQ==
X-Gm-Message-State: AOJu0Yzv1zjrAaGBXn5/6p1pIaVXp2ei4tBJOG6rBWNOhQlAclJ/0lIt
 AP6Pt3emb+/Lz0cz/6orY8dHGUifI0tqV0JmUP+cJw==
X-Google-Smtp-Source: AGHT+IH4afNfilaMTNS2mTSzgjkCyh3dcMvFF2pK5FUVJMTlcrRYpSSxiy+Tcpbx7GNU1654mfim+J8GTQ+FM+APntQ=
X-Received: by 2002:aa7:d402:0:b0:540:fcc5:3ada with SMTP id
 z2-20020aa7d402000000b00540fcc53adamr19219307edq.9.1699035304536; Fri, 03 Nov
 2023 11:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
 <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
 <CC91949C-3BBF-452B-906F-93520A314858@gmx.de>
In-Reply-To: <CC91949C-3BBF-452B-906F-93520A314858@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Nov 2023 12:14:46 -0600
Message-ID: <CAPnjgZ0sgCtPXa5ZOOpW-zyCnVm_cNU3OyDjzPercdY1=Y1_dQ@mail.gmail.com>
Subject: Re: [PATCH v2] smbios: arm64: Allow table to be written at a fixed
 addr
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
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

Hi Heinrich,

On Fri, 3 Nov 2023 at 11:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 3. November 2023 19:12:40 OEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi,
> >
> >On Sat, 28 Oct 2023 at 12:41, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> [unfortunately I am not receiving email from the list at present]
> >>
> >> Hi Heinrich,
> >>
> >> On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >> >
> >> > On 10/25/23 04:49, Simon Glass wrote:
> >> > > Hi Heinrich,
> >> > >
> >> > > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >> > >>
> >> > >>
> >> > >>
> >> > >> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >> > >>> U-Boot typically sets up its malloc() pool near the top of memory. On
> >> > >>> ARM64 systems this can result in an SMBIOS table above 4GB which is
> >> > >>> not supported by SMBIOSv2.
> >> > >>>
> >> > >>> Work around this problem by providing a new option to choose an address
> >> > >>> below 4GB (but as high as possible), if needed.
> >> > >>
> >> > >> You must not overwrite memory controlled by the EFI subsystem without calling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is only a fallback for outdated tools.
> >> > >
> >> > > That is not my intention and I don't believe this code does that. EFI
> >> > > is not running at this point, is it?
> >> >
> >> > The function install_smbios_table() only exists if CONFIG_EFI_LOADER=y.
> >>
> >> That is because ARM devices don't normally need it, right? Anyway,
> >> that option isn't related to this patch. If ARM devices started using
> >> SMBIOS and had another way to pass it to Linux (other than EFI) then
> >> we would want to install it.
> >>
> >> >
> >> > We have:
> >> > EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
> >> > This is invoked after efi_memory_init().
> >> >
> >> > The EFI specification requires that the memory area occupied by the
> >> > SMBIOS table uses one of a specific set of memory types where
> >> > EfiRuntimeServicesData is recommended. So you must call
> >> >
> >> > u64 addr = UINT_MAX;
> >> > ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> >> > EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
> >> >
> >> > to allocate the memory. If the return code is not EFI_SUCCESS, no memory
> >> > below 4 GiB is available.
> >>
> >> The root problem here is that x86 and ARM used to work differently.
> >> When the ARM SMBIOS stuff was done, it worked by writing the SMBIOS
> >> table as part of the 'bootefi' command. On x86, the tables were
> >> written on startup, so you can examine them within U-Boot. Clearly the
> >> x86 approach is correct. For one thing, a previous-stage bootloader
> >> may set up the tables, so it simply isn't valid to write them in that
> >> case. So we need to separate writing the tables from telling EFI about
> >> them.
> >>
> >> So I have fixed that, so ARM now writes the tables at the start. But
> >> using an EFI allocation function is clearly not right. This is generic
> >> code, nothing to do with EFI, really. In fact, the SMBIOS writing
> >> should move out of efi_loader. The install_smbios_table() function
> >> should be somewhere in lib, i suppose, with just efi_smbios_register()
> >> sitting in lib/efi_loader
> >>
> >> Also, why is efi_memory_init() called early in init? Is there anything
> >> that needs that in the init sequence? Could we move it to the end, or
> >> perhaps skip it completely until the 'bootefi' command is used?
> >>
> >> Another point I should make is that it should be fine for U-Boot to
> >> put something in memory and then call efi_add_memory_map() to tell EFI
> >> about it. What problems does that cause? It isn't as if EFI allocates
> >> things in the 'conventional' memory (is that the name for memory below
> >> 4GB?) This is how efi_acpi_register() works.
> >>
> >> (Aside: it is bizarre to me that CONFIG_EFI_LOADER appears in
> >> drivers/video/rockchip_rk_vop.c and other such files)
> >>
> >> >
> >> > >
> >> > > The bit I am confused about is that we don't support SMBIOS3 in
> >> > > U-Boot. I am trying to fix an introduced bug...
> >> >
> >> > I would not know why we should not use SMBIOS 3.
> >>
> >> Neither do I. Perhaps there are compatibility concerns? If it is OK to
> >> do that then we could go back to my previous series [1]. What do you
> >> think?
> >
> >Tom responded but I missed it. In part it says:
> >
> >"So, can we please start by just doing the minimal changes to get the
> >SMBIOS table done correctly for memory above 4G, via EFI, and then start
> >the next steps?"
> >
> >I am OK to do an EFI hack for ARM so long as we agree that after the
> >release we will revert it and generate the table using generic memory
> >allocation, not dependent on EFI. Does that sound reasonable?
> >
> >I don't seem to have received any response from Heinrich to the
> >various points I made above. I cannot see any response on patchwork
> >either.
> >
> >Regards,
> >Simon
>
> All memory below the stack is controlled by the EFI subsystem. I notified you of the function you need to call. I can't see what information you are lacking.

That is fine when EFI is used, but what about when it is not? That is
the piece I don't yet understand.

Regards,
Simon
