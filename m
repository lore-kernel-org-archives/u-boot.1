Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4372CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 06:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4D787174;
	Thu, 19 Oct 2023 08:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="caysgowt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2507A87178; Thu, 19 Oct 2023 08:45:19 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F8B8716B
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27d3ede72f6so5170277a91.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697697914; x=1698302714; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3l6Sy0VblFqSkfz6piZJJWlzPr/i29AcGBC4P4/scQI=;
 b=caysgowtmo7AybHjx3b5SjZApyEzFocKbtyA9TdCWD9X8Oh46ltCTBnHTrWo2gn0K5
 wDq6+7xJPMsW4ywtBu2yqPhIiPMClcWKvoJVX5b+iZnc2Cy4FNCZ/NAATbddoY3GNMZt
 IH8aZr4edhX/mNM4Ahwa+mzXpB8oLRbU3BQZ+y8uWbr5s0QGKwZLfaMwPnPYc4dfoTU9
 h+QOg+Anu1xh7ODIOR21oKQX8rZkFcoF8dBFwNlR44YWxL/55GKyKgWOWdVKF6f1/bxu
 MpZC6cw1kUoq9hh1dFjUsxKlEwjL0Okft7Xl2+H/4Sq3+sZHQY6m0De3Z6i0VodTU7RQ
 XFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697697914; x=1698302714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3l6Sy0VblFqSkfz6piZJJWlzPr/i29AcGBC4P4/scQI=;
 b=v2l01gpeqKj1um/RLND48fsoYVgyRiy6zEk0485b80Jor2ilB9sXN6XNkor+9I3wgp
 Gch5yPrtUI4yJWWnuvz050bFOPuJj6G9ixBqybzKzKRocIrHGTi1QsC3N5y6pp3w2Gie
 WM7TClW61cZQgvaPwmtKO3ZE1M2VtcUeoxTOVCHmg5wzRTMIuWTHkHsZTQbcXfkeT4uQ
 S+iB8uAMulasVbqQbY0aL4nmkuSz5wgbgR7tOyQfsSda5VG/hDJertNooIdlEDWReTBz
 E6FIdA3rSzzD/z3rYqQcZpTDymvEA3vd+Wg5hdaRDQD6ntttkWlm7cdn5sc4qnZ2zBTo
 a2bw==
X-Gm-Message-State: AOJu0YwwEcPoNp4pqQOXq54QDLGC3WLXLdSKvrtWfSdGlB2eoPN9dd3F
 ESDsMwDPq0MTC6vcvK2PHPDgv+yBL8mj3KV9ktv6UA==
X-Google-Smtp-Source: AGHT+IEd+nScO1PVSvU0xKLYQj/ZFYAFJWlbjogk6YHzBs6v4+5UkIvjIyyLjIMHelsT2Y7LGh5fEebB08M3n0QCwNM=
X-Received: by 2002:a17:90a:f481:b0:27d:ae6:229f with SMTP id
 bx1-20020a17090af48100b0027d0ae6229fmr1445661pjb.41.1697697913765; Wed, 18
 Oct 2023 23:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-5-masahisa.kojima@linaro.org>
 <A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de>
 <CAC_iWj+koNjVBR7TCJH_u_PvY5xDHgtBGRTHBRRgAx_aDeC8-A@mail.gmail.com>
 <ae12d900-fe7f-4f7b-9eb1-018aa719174f@gmx.de>
 <CADQ0-X8XGiek9oBEFeDtXaR2vcBsQS-NhJK5mL9TRLK+9gTJ2A@mail.gmail.com>
 <050e8bea-771b-491d-8d66-14fadcff0487@gmx.de>
 <CADQ0-X9n24HVJ_AoMszTUQy1wk+q=TfZG915mzd3gd=GScxjMA@mail.gmail.com>
 <CAC_iWjJccjJPEWpiBKOA+ue21JAcosVHsgQH7QJvMzcRBASkAw@mail.gmail.com>
 <CADQ0-X8ndi2UmqWTkcfp=1UsPRnZKDi3RJfFVJb7A6FsMZ4=Vw@mail.gmail.com>
 <CAC_iWjL8n7Zkm3qa7MHzjS9gi1ap9EJdezFML4bSmzFDUpMW-A@mail.gmail.com>
In-Reply-To: <CAC_iWjL8n7Zkm3qa7MHzjS9gi1ap9EJdezFML4bSmzFDUpMW-A@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 19 Oct 2023 15:45:02 +0900
Message-ID: <CADQ0-X-H4YQiANnSveqdub_-N8cz23wBkzq32DOUOxb0XigJwg@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] efi_loader: create default file boot option
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

On Wed, 18 Oct 2023 at 18:12, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san
>
> On Wed, 18 Oct 2023 at 12:07, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 18 Oct 2023 at 04:47, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi all,
> > >
> > > On Tue, 17 Oct 2023 at 08:33, Masahisa Kojima
> > > <masahisa.kojima@linaro.org> wrote:
> > > >
> > > > Hi Heinrich,
> > > >
> > > > On Mon, 16 Oct 2023 at 23:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > > On 16.10.23 15:00, Masahisa Kojima wrote:
> > > > > > On Mon, 16 Oct 2023 at 21:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > >>
> > > > > >> On 16.10.23 14:31, Ilias Apalodimas wrote:
> > > > > >>> Hi Heinrich,
> > > > > >>>
> > > > > >>> On Mon, 16 Oct 2023 at 10:06, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > >>>>
> > > > > >>>>
> > > > > >>>>
> > > > > >>>> Am 16. Oktober 2023 08:45:21 MESZ schrieb Masahisa Kojima <masahisa.kojima@linaro.org>:
> > > > > >>>>> Current efibootmgr automatically creates the
> > > > > >>>>> boot options of all disks and partitions installing
> > > > > >>>>> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
> > > > > >>>>> Some of the automatically created boot options are
> > > > > >>>>> useless if the disk and partition does not have
> > > > > >>>>> the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > > > > >>>>>
> > > > > >>>>> This commit only creates the boot option if the disk and
> > > > > >>>>> partition have the default file so that system can directly
> > > > > >>>>> boot from it.
> > > > > >>>>
> > > > > >>>> I don't directly see the user benefit.
> > > > > >>>
> > > > > >>> The user can add an HTTP boot option now and the installer will
> > > > > >>> automatically start.  That would allow products to ship with a single
> > > > > >>> boot option provisioned and run an installer on first boot
> > > > > >>
> > > > > >> This commit is not about HTTP. It changes how boot options for block
> > > > > >> devices are created.
> > > > > >>
> > > > > >>>
> > > > > >>>>
> > > > > >>>> Reading all file systems will increase the boot time. Shouldn't we avoid this?
> > > > > >>>
> > > > > >>> Any idea what would be an alternative?  But when we added the
> > > > > >>> automatic boot options we said we should avoid dynamic scanning and
> > > > > >>> store results in a file.  This is doing a similar thing.  The only
> > > > > >>> difference is that it mounts the iso image before adding the boot
> > > > > >>> option.
> > > > > >>
> > > > > >> The alternative is to keep showing boot options for block devices even
> > > > > >> if there is no BOOTxxxx.EFI file.
> > > > > >>
> > > > > >>>
> > > > > >>>>
> > > > > >>>> What does EDK II do?
> > > > > >>>
> > > > > >>> No Idea :)
> > > > > >>
> > > > > >>
> > > > > >> On my workstation I get generated boot options
> > > > > >>
> > > > > >> Boot0001* UEFI:CD/DVD Drive     BBS(129,,0x0)
> > > > > >> Boot0003* UEFI:Removable Device BBS(130,,0x0)
> > > > > >> Boot0004* UEFI:Network Device   BBS(131,,0x0)
> > > > > >>
> > > > > >> without any media inserted and without any PXE server available.
> > > > > >
> > > > > > It is just information about how the EDK2 works.
> > > > > > When I attach the Fedora installation media on EDK2(OVMF),
> > > > > > the automatically generated boot option is as follows.
> > > > > >
> > > > > > UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0)
> > > > >
> > > > > An ATAPI drive typically is not removable. So I wonder why it is listed.
> > > > > Did you set the removable flag on the command line?
> > > >
> > > > I guess it is not removable(actually I don't know how to set the
> > > > device as removable).
> > > > I just attached the iso image to QEMU with something like '-hda
> > > > Fedora_netinst.iso".
> > > >
> > > > According to the EDK II implementation[1], the boot option is
> > > > enumerated with the following order.
> > > >   1. Removable BlockIo
> > > >   2. Fixed BlockIo
> > > >   3. Non-BlockIo SimpleFileSystem
> > > >   4. LoadFile
> > > > So boot option for the fixed device such as HDD is also automatically created.
> > > >
> > > > [1] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/UefiBootManagerLib/BmBoot.c#L2150
> > > >
> > > > >
> > > > > >
> > > > > > When this boot option is selected, Fedora installer automatically starts.
> > > > > > So EDK II is searching the default file on the fly.
> > > > >
> > > > > What is shown if you attach a medium without Bootaa64.efi?
> > > >
> > > > The same boot option is created.
> > > > UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0)
> > >
> > > I went back to reading the spec and I think Heinrich is right.  We
> > > don't need that check at all. Going through [0] paragraph 4 says
> > > " This search occurs when the device path of the boot image listed in
> > > any boot option points directly to an EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
> > > device and does not specify the exact file to load"
> > >
> > > So we should *only* add an automatic variable without the default
> > > application.  Our code in try_load_entry() will search for that
> > >
> >
> > Thank you for checking the UEFI specification and sorry for
> > overlooking the above.
> > So we will go back to the previous on the fly default application search.
>
> Yes, I was about to suggest that.
> The problem as I understand it that the current patch not only
> disregards disks and partitions that dont have a default (i.e
> bootaa64.efi) file. It also *changes* the default boot option we add,
> and instead of the disk it adds a file.  That is the part that's
> against the spec.  On top of that it changes the behavior of efi
> bootmgr and we never call the expand_media_path.

What do you mean by "we never call the expand_media_path"?
Do you expect we search the partition whether it has a default file,
then load the default file with efi_load_image() only when the
partition has a default file?

Thanks,
Masahisa Kojima


>
> So my suggestion would be
> - Drop #4
> - Adjust patch 5 and instead of loading the boot entry directly, scan
> for the special autogenerated boot option and look for that file there
>
> Heinrich would that work for you?
>
> Thanks
> /Ilias
> >
> > Thanks,
> > Masahisa Kojima
> >
> > > [0] https://uefi.org/specs/UEFI/2.10/03_Boot_Manager.html#load-option-processing
> > >
> > > Regards
> > > /Ilias
> > > >
> > > > Thanks,
> > > > Masahisa Kojima
> > > >
> > > > >
