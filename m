Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD540D216A3
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E7A8814D;
	Tue, 15 Oct 2024 15:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CO/B0iOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D9F8881FD; Tue, 15 Oct 2024 15:32:16 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3D8F8811C
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e2e2d09decso3262337a91.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728999132; x=1729603932; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0n7Pl5MFgqk76YzvjEXIa/HOoCF2CoJcdVJrMoNNF5g=;
 b=CO/B0iOxNfxjWNn3Q3q2zPvU8KYuvlyfGsB7D+joA4zUTM9wak6JOtVoSe3bv/HhAp
 mWq1EsTlZ/yamaBFEBSDpN0L2sIQliD1BQJx0bFy8JUN5foEzd1dLgwWX9d1ZNAqoa+r
 0Xqel48t/EcPXiUiciw+Zw+gWK3chQFbFzsoMzR9gOuqp4fUpaK7uG5TFmcmRXsTIxNd
 CwfNZ9hgx82ZDNEkV8VVk7YnBb8PQRawmlb+HAfZpuXRrcfCJ4qxpER3uoK3J1XLBLjH
 dc0GkyC2rWgXuPHHe41HVUX4kXikHXJIx9MdlgFfsGzlaCFHTtXeY5ScUQyBB5VtOcpj
 8j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728999132; x=1729603932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0n7Pl5MFgqk76YzvjEXIa/HOoCF2CoJcdVJrMoNNF5g=;
 b=A4xbJRDSB2pAy9RCGLy9vd8HJf6wQ2qVSD13RuOuHGvDF2N4ksCIe62JExvnXEu0Mx
 Z0xztZzZLwFpJYIKJkATFqpj9y7WRL2cJqo8GCaPRno1ZttNlbGohwdNghTqg6rX3+9W
 90F/doD4Mb2Ppe+4Y284bo7i/sBtsiS97ldHYKEyNM4Q4d22zSrWiGOYWgufv+9eEHAF
 EHboqlbRJ85RCG0h48nW2d2JJ92kJ2LndeBdAKkTZvL/MxWt2+xqwI3rh6X5eTcpvfI9
 U3sbexTdriUlAC7ngi45mEiXMQLflrPvb8UIMvDzDiDLHKrRomGJId/SZbfeEm7ctCMw
 5+cw==
X-Gm-Message-State: AOJu0YyjREEFH740XCOQIrABtNWtYGIEoH+BaoFxcOK5QnJQ/gUhAbdZ
 bXc9XmY9hfjKVrhVtr3Yyft6diRD6TMutoNEWZBtPQOPFRjSa4+PU6/gg/n4Y8iv/KesRy96nOl
 T9NmfwVq39+2Akq6ZjKt01H1geLBhT9itO1+1LQ==
X-Google-Smtp-Source: AGHT+IEZssrM9irh6S02Y33HSImLH7jGsv677McZolRAkoC/MRgxMO1Vsl26tdfaEagaMGBauVbjhLn04lVSbtG+e3A=
X-Received: by 2002:a17:90b:4d91:b0:2e2:bb32:73e7 with SMTP id
 98e67ed59e1d1-2e2f0d7c8e2mr23351084a91.15.1728999131863; Tue, 15 Oct 2024
 06:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <CAC_iWjKD=05pf=gcfCPUA0mGNbAX+jjyx5D03y0MWJRgxYDPOA@mail.gmail.com>
 <CAFLszTgJW2KPbD1dogSVKbxgyYtvKGgSAcB_j5kXtWdkTGvtNA@mail.gmail.com>
In-Reply-To: <CAFLszTgJW2KPbD1dogSVKbxgyYtvKGgSAcB_j5kXtWdkTGvtNA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Oct 2024 16:31:35 +0300
Message-ID: <CAC_iWjJdoFLAyaa+NBoY1Hm0Q140ExU0rq-RKEqDV_yki9jojA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Adjust initial EFI memory-allocation to be in the
 U-Boot region
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Artur Rojek <artur@conclusive.pl>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Tue, 15 Oct 2024 at 16:26, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Mon, 14 Oct 2024 at 22:28, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Sat, 12 Oct 2024 at 00:23, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > U-Boot relocates itself to the top of memory and is supposed to avoid
> > > using any memory below that region. This allows the maximum amount of
> > > memory to be available for loading images.
> > >
> > > The lmb subsystem automatically protects U-Boot's code and data from
> > > being overwritten. It relies on this region being a contiguous area of
> > > memory. This setup has worked well for at least 15 years and has been
> > > documented in the README for as long.
> > >
> > > The EFI_LOADER subsystem currently uses memory outside the U-Boot region
> > > when starting up.
> > >
> > > Some of the downstream problems this causes are:
> > >
> > > 1. It can overwrite images that have been loaded
> >
> > So can the load command
>
> Can you point to where? If lmb is enabled, it should be using that, so
> not overwrite anything.
>

If you load the initrd in memory X and make the kernel ovelap you will
overwrite parts of the initrd.
Let's try once again, the ''''problem''' that was discussed in IRC, is
that the initramfs overwrites memory that was allocated by the EFI
subsystem *because* we haven't merged the LMB followup patches yet.

> >
> > > 2. Requires lmb reservations to avoid (1) even if EFI_LOADER is not
> > >    being used
> > > 3. Uses regions which scripts expect to be available, e.g. the existing
> > >    kernel_addr_r variables
> > > 4. Introduces confusion as to what memory U-Boot can use for itself
> > >
> > > This series sets up a very small region of memory which EFI can used at
> > > start-up, thus avoiding touching memory outside the U-Boot region.
> >
> > EFI *is* U-Boot memory region. It lies outside the U-Boot binary,
> > because some services are instantiated on boot. It also *is* U-Boot
> > executable code. We should start treating it as such
>
> This seems like semantics to me. What do you think of this patch?

I don't see any reason for doing this. I've asked for a reproducer of
the problem you are trying to solve quite a few times and I still
don't have an email with one

Thanks
/Ilias
>
> Regards,
> Simon
>
>
> >
> > Thanks
> > /Ilias
> > >
> > > There are still a few tables which are not in the bloblist, but that
> > > will be resolved separately.
> > >
> > > Other than tables, the amount of API-visible memory allocated by EFI
> > > before booting is actually very small: 3 allocations, of a total of
> > > about 250 bytes. However, there are some areas where EFI allocations are
> > > done unnecessarily. For example efi_disk_add_dev() uses page-allocation
> > > to allocate an efi_device_path, then immediately frees it again. In this
> > > case it would be better to use malloc(). Since each allocation consumes
> > > a page (4KB), 256KB has been chosen for the size here, enough for 64
> > > allocations.
> > >
> > > As soon as efi_init_obj_list() is called, we know that the EFI subsystem
> > > is to be used, so we can relax the restrictions and allow EFI to use any
> > > memory it likes. This is handled using a simple boolean flag in BSS, since
> > > it cannot happen before relocation.
> > >
> > > Changes in v4:
> > > - Expand the commit message
> > > - Reword the commit message since this feature is needed
> > > - Use a different technique to keep the memory-usage in place
> > > - Drop changes to pool allocation
> > > - Reorder the patches
> > > - Rewrite the cover letter
> > > - Make it a debug message for now
> > >
> > > Changes in v3:
> > > - Add new patch to drop the memset() from efi_alloc()
> > > - Drop patch to convert device_path allocation to use malloc()
> > >
> > > Changes in v2:
> > > - Drop patch 'Show more information in efi index'
> > > - Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
> > > - Add the word 'warning', use log_warning() and show the end address
> > >
> > > Simon Glass (5):
> > >   efi: Drop the memset() from efi_alloc()
> > >   efi: Show the location of the bounce buffer when debugging
> > >   event: Add a generic way to reserve memory
> > >   efi: Reserve some memory for initial use
> > >   efi: Keep early allocations to the U-Boot region
> > >
> > >  common/board_f.c                  |  1 +
> > >  common/event.c                    |  1 +
> > >  include/asm-generic/global_data.h |  6 ++++
> > >  include/efi_loader.h              | 24 +++++++++++++-
> > >  include/event.h                   | 11 +++++++
> > >  lib/efi_loader/efi_bootbin.c      |  9 ++++++
> > >  lib/efi_loader/efi_memory.c       | 54 ++++++++++++++++++++++++-------
> > >  lib/efi_loader/efi_setup.c        |  5 +++
> > >  test/py/tests/test_event_dump.py  |  1 +
> > >  9 files changed, 100 insertions(+), 12 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
