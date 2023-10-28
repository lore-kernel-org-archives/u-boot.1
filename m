Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72649C4332F
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 18:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 299C987890;
	Sat, 28 Oct 2023 20:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JIR/zODM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4193D8789B; Sat, 28 Oct 2023 20:41:45 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046648786B
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so5355736a12.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698518502; x=1699123302; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xKtiQWqfvlfv4sG0Otsg2TCXlT4zCq44/ro0uvf+eUI=;
 b=JIR/zODMt/IyI191/S8F3Gh/U97xTHDO/91lGMq3SSzyYE4oj7OIam+kTqlUlLFikO
 qZeDh4J4im+sCXRW8gPUUfd8lUI+B00Cl0dIMR//Sr6ay5ExMH+KTUXUre1bEuhOexj5
 H6e9Il6cN4t4Zo1sBwR5zJwT61cyi/uYWNth8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698518502; x=1699123302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xKtiQWqfvlfv4sG0Otsg2TCXlT4zCq44/ro0uvf+eUI=;
 b=XgzSJXv64Rjk0R2zKSXAZiIK3uPqcyWtqNV/dylHrGIiAyO6ZmCPxyfBanyFVEV4f8
 bNRhpEan4DFBXiW+Xn3ceMEBaw6hd6l1XVlDx6bQjE2VOZO/xVA1EXOaWCXgFu/RF4U4
 GwtW48FMhetRODoCnGQQj493Mdx3hcgbJhAJqtQhORTghDfyc0Ns7mzA2KQmCwiLDIzV
 cbo/DnwQaYMYNYK2qEVcW/4YEtcbSSd20Pg5vxIGNR/pxuGIjSIfKMb9saMc4hXM2A2N
 OuUMIZOtZAzONm+wIgAN0c0oJlFt7MwCTkInDSOu5zI06ZEn4SMVsFm0hDopkQTXFDny
 RImQ==
X-Gm-Message-State: AOJu0YwWahOz1IdLewtPWB3QvtVo7nGbcoe3U2+xMJ67chuNy64K4BO6
 uus/DL6qii63JtWstl2CiADDzhcb6JiclSngLOTv4Q==
X-Google-Smtp-Source: AGHT+IHo8tTc5jIbmxxV2gtm2y6x2465pNY/j4gVq6L1ad1urE3vGgy8E16IKckfXGOMKalkfZ/PFo7PahRCBtGtADs=
X-Received: by 2002:a50:d603:0:b0:53e:4762:9373 with SMTP id
 x3-20020a50d603000000b0053e47629373mr4493684edi.18.1698518502123; Sat, 28 Oct
 2023 11:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
In-Reply-To: <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 29 Oct 2023 07:41:27 +1300
Message-ID: <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
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

[unfortunately I am not receiving email from the list at present]

Hi Heinrich,

On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/25/23 04:49, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >>
> >>
> >> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >>> U-Boot typically sets up its malloc() pool near the top of memory. On
> >>> ARM64 systems this can result in an SMBIOS table above 4GB which is
> >>> not supported by SMBIOSv2.
> >>>
> >>> Work around this problem by providing a new option to choose an address
> >>> below 4GB (but as high as possible), if needed.
> >>
> >> You must not overwrite memory controlled by the EFI subsystem without calling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is only a fallback for outdated tools.
> >
> > That is not my intention and I don't believe this code does that. EFI
> > is not running at this point, is it?
>
> The function install_smbios_table() only exists if CONFIG_EFI_LOADER=y.

That is because ARM devices don't normally need it, right? Anyway,
that option isn't related to this patch. If ARM devices started using
SMBIOS and had another way to pass it to Linux (other than EFI) then
we would want to install it.

>
> We have:
> EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
> This is invoked after efi_memory_init().
>
> The EFI specification requires that the memory area occupied by the
> SMBIOS table uses one of a specific set of memory types where
> EfiRuntimeServicesData is recommended. So you must call
>
> u64 addr = UINT_MAX;
> ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
>
> to allocate the memory. If the return code is not EFI_SUCCESS, no memory
> below 4 GiB is available.

The root problem here is that x86 and ARM used to work differently.
When the ARM SMBIOS stuff was done, it worked by writing the SMBIOS
table as part of the 'bootefi' command. On x86, the tables were
written on startup, so you can examine them within U-Boot. Clearly the
x86 approach is correct. For one thing, a previous-stage bootloader
may set up the tables, so it simply isn't valid to write them in that
case. So we need to separate writing the tables from telling EFI about
them.

So I have fixed that, so ARM now writes the tables at the start. But
using an EFI allocation function is clearly not right. This is generic
code, nothing to do with EFI, really. In fact, the SMBIOS writing
should move out of efi_loader. The install_smbios_table() function
should be somewhere in lib, i suppose, with just efi_smbios_register()
sitting in lib/efi_loader

Also, why is efi_memory_init() called early in init? Is there anything
that needs that in the init sequence? Could we move it to the end, or
perhaps skip it completely until the 'bootefi' command is used?

Another point I should make is that it should be fine for U-Boot to
put something in memory and then call efi_add_memory_map() to tell EFI
about it. What problems does that cause? It isn't as if EFI allocates
things in the 'conventional' memory (is that the name for memory below
4GB?) This is how efi_acpi_register() works.

(Aside: it is bizarre to me that CONFIG_EFI_LOADER appears in
drivers/video/rockchip_rk_vop.c and other such files)

>
> >
> > The bit I am confused about is that we don't support SMBIOS3 in
> > U-Boot. I am trying to fix an introduced bug...
>
> I would not know why we should not use SMBIOS 3.

Neither do I. Perhaps there are compatibility concerns? If it is OK to
do that then we could go back to my previous series [1]. What do you
think?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=377650
