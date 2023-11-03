Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CB6C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 17:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987848708A;
	Fri,  3 Nov 2023 18:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VTpOtaoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C3787086; Fri,  3 Nov 2023 18:13:02 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967BE870DD
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 18:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo3748910a12.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699031577; x=1699636377; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NgzBBHxbl69588xf79Rxt8n15AfxsJjs07GFaWlUQt8=;
 b=VTpOtaoqLcsls4Ou9olMJGPFdtIgR9a5ilSWLyXuq9BNcddvRAe9Tg1qpAR7375/HQ
 BXBBBcBh9uuSvery14cGRLYYeBz73cWg2c/rooTsIGf9/3/DmuSj2ztfWqDyJqiiFt+8
 0R8sxmpwn7XXB3wu+XcM/U9dEv777WnUFZ+uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699031577; x=1699636377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NgzBBHxbl69588xf79Rxt8n15AfxsJjs07GFaWlUQt8=;
 b=vM55AqK0AvJCaMjFDxrGuJsDQBDYA2ROiLno+YpHR7uFveSk1DZgA0/j1tkWiH0dcL
 PU8seXJVXFBpVeTUL+yeWr2ZFCb6bBtXCyrgnlwPwmCwlpq9vZUg2+KpcI5vGho9/Ww2
 e26KqYbsiXhQOjzTfRreO6RJFz+ZJ+lL1YkqzcdBb7Ib8+OcpsvDHpkLA+Lt6M9UI47a
 aWlsTKe2JDvSdSOCZxIQUN00Lg6VY2bn4HIJbh85cR9dIqX386zdn9JkM6YPxxsLuaSa
 gh40beOXGLSlsGXlHNr+13C0VzjtOvvSbwyakVNWZAahY946fNh2kGQ6JrDdxwv186Tm
 71vg==
X-Gm-Message-State: AOJu0YwQm85/0aTjlCmGvIEAPpsdHWlbvuRmzGn6r39XQaLqtbo3Ms+M
 8b4QK8kSu+tY4f5usRZb/LeY50KDTtv5ToB9GywdWg==
X-Google-Smtp-Source: AGHT+IFVITuqXii13WflUSUjoL6MmFMOE5ooREpvLs/Na3q4Fw2XgnUT4cXxFERwMfFnGDt2VJYDhEknCbmzd3y5ICM=
X-Received: by 2002:a50:8a9c:0:b0:543:5116:b55c with SMTP id
 j28-20020a508a9c000000b005435116b55cmr11009152edj.16.1699031576767; Fri, 03
 Nov 2023 10:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
In-Reply-To: <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Nov 2023 11:12:40 -0600
Message-ID: <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
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

Hi,

On Sat, 28 Oct 2023 at 12:41, Simon Glass <sjg@chromium.org> wrote:
>
> [unfortunately I am not receiving email from the list at present]
>
> Hi Heinrich,
>
> On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 10/25/23 04:49, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >>
> > >>
> > >> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > >>> U-Boot typically sets up its malloc() pool near the top of memory. On
> > >>> ARM64 systems this can result in an SMBIOS table above 4GB which is
> > >>> not supported by SMBIOSv2.
> > >>>
> > >>> Work around this problem by providing a new option to choose an address
> > >>> below 4GB (but as high as possible), if needed.
> > >>
> > >> You must not overwrite memory controlled by the EFI subsystem without calling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is only a fallback for outdated tools.
> > >
> > > That is not my intention and I don't believe this code does that. EFI
> > > is not running at this point, is it?
> >
> > The function install_smbios_table() only exists if CONFIG_EFI_LOADER=y.
>
> That is because ARM devices don't normally need it, right? Anyway,
> that option isn't related to this patch. If ARM devices started using
> SMBIOS and had another way to pass it to Linux (other than EFI) then
> we would want to install it.
>
> >
> > We have:
> > EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
> > This is invoked after efi_memory_init().
> >
> > The EFI specification requires that the memory area occupied by the
> > SMBIOS table uses one of a specific set of memory types where
> > EfiRuntimeServicesData is recommended. So you must call
> >
> > u64 addr = UINT_MAX;
> > ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> > EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
> >
> > to allocate the memory. If the return code is not EFI_SUCCESS, no memory
> > below 4 GiB is available.
>
> The root problem here is that x86 and ARM used to work differently.
> When the ARM SMBIOS stuff was done, it worked by writing the SMBIOS
> table as part of the 'bootefi' command. On x86, the tables were
> written on startup, so you can examine them within U-Boot. Clearly the
> x86 approach is correct. For one thing, a previous-stage bootloader
> may set up the tables, so it simply isn't valid to write them in that
> case. So we need to separate writing the tables from telling EFI about
> them.
>
> So I have fixed that, so ARM now writes the tables at the start. But
> using an EFI allocation function is clearly not right. This is generic
> code, nothing to do with EFI, really. In fact, the SMBIOS writing
> should move out of efi_loader. The install_smbios_table() function
> should be somewhere in lib, i suppose, with just efi_smbios_register()
> sitting in lib/efi_loader
>
> Also, why is efi_memory_init() called early in init? Is there anything
> that needs that in the init sequence? Could we move it to the end, or
> perhaps skip it completely until the 'bootefi' command is used?
>
> Another point I should make is that it should be fine for U-Boot to
> put something in memory and then call efi_add_memory_map() to tell EFI
> about it. What problems does that cause? It isn't as if EFI allocates
> things in the 'conventional' memory (is that the name for memory below
> 4GB?) This is how efi_acpi_register() works.
>
> (Aside: it is bizarre to me that CONFIG_EFI_LOADER appears in
> drivers/video/rockchip_rk_vop.c and other such files)
>
> >
> > >
> > > The bit I am confused about is that we don't support SMBIOS3 in
> > > U-Boot. I am trying to fix an introduced bug...
> >
> > I would not know why we should not use SMBIOS 3.
>
> Neither do I. Perhaps there are compatibility concerns? If it is OK to
> do that then we could go back to my previous series [1]. What do you
> think?

Tom responded but I missed it. In part it says:

"So, can we please start by just doing the minimal changes to get the
SMBIOS table done correctly for memory above 4G, via EFI, and then start
the next steps?"

I am OK to do an EFI hack for ARM so long as we agree that after the
release we will revert it and generate the table using generic memory
allocation, not dependent on EFI. Does that sound reasonable?

I don't seem to have received any response from Heinrich to the
various points I made above. I cannot see any response on patchwork
either.

Regards,
Simon


>
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=377650
