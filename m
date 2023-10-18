Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BF9CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 09:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27FBD86F38;
	Wed, 18 Oct 2023 11:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FwtR4ybT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A6A86F44; Wed, 18 Oct 2023 11:13:03 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26B5486F36
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 11:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507b96095abso3041414e87.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697620379; x=1698225179; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=04rRyomkIOCN9YdItZOl0U9EGQQnb0PUmeFb3lg1MLU=;
 b=FwtR4ybTStAiE8OdEdZTbiEvH5cOI9icTHYy4biU5jEdMgXtQY8eFMUFVjjme+W/MY
 nlvAFSFi4+lSBLTgUzA9QhQRPvueNiI+CoHPThPAidDS0A4ljuIvKhsdhnPZD7FOsVHw
 88KDyWP89dNzkIfhlusz60RSLoEGXwJ7b1JEhPjyzwjuF8acMSgop5B1bHi9LJ36Kwtu
 ZNe77tAUQ7o5tW6d6Np7o/o6ufZGNuRlBERQtMe+4aeNz7KV7/PcLDSBKkhXXHx39Bog
 WHNb48TBP+GEhld/BNHiR2v1x5oAnV5k4ST59vyM1ISkrGIvEzZnVlVlUQltrWU1iij4
 i7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697620379; x=1698225179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=04rRyomkIOCN9YdItZOl0U9EGQQnb0PUmeFb3lg1MLU=;
 b=Hk/oQF7dmRsoawTk9ufMf08PAk6a/3+bad3x/eWojWHGhcFgwH6Wxt5QehFAzlmxri
 sueLsBagwZ26LeFkHL/zgYMICV2zeMnvW3vernlxsCBOrE0Lc8j4BE1k8qh0EespEes0
 CI8lZI55M9P+Pq+JSuXBIWnBFtwrI0DCjBcKZ+i8Xi4uBK/W2PGZiUE9cKrvtBCjrQ/V
 8OOiJ6fBizsQbnYTuNMzoKNjCK5KkVjc1zLrQFg3WX1ouFBoFgGt+SEW14Gx1CSYnkPC
 Dsjcu8gLqOvc4wuEjCFahKEpaVWPnKwjxIYHskVSNK81vHIbNTrK940WNFDe9NTy1MDa
 9xrg==
X-Gm-Message-State: AOJu0Ywd3nd1Dh8uiBwptXJ2zJIYHbRXoyUOMFcaTnK/3GYLNEyuSi8G
 gSHomCP+d3Ah2sHtvYYhl3FvezMpyxHbuAURfBgLpA==
X-Google-Smtp-Source: AGHT+IFwJnGMXne5/XnikHxJsIyNP4qIEE+zP3iuqUC5XqLH2IPbHK1An10M+/M9NW+0lvNwFeXNY3opth0B7oOrKNA=
X-Received: by 2002:a05:6512:3b0c:b0:502:fdca:2eaa with SMTP id
 f12-20020a0565123b0c00b00502fdca2eaamr4540202lfv.52.1697620379292; Wed, 18
 Oct 2023 02:12:59 -0700 (PDT)
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
In-Reply-To: <CADQ0-X8ndi2UmqWTkcfp=1UsPRnZKDi3RJfFVJb7A6FsMZ4=Vw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Oct 2023 12:12:23 +0300
Message-ID: <CAC_iWjL8n7Zkm3qa7MHzjS9gi1ap9EJdezFML4bSmzFDUpMW-A@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] efi_loader: create default file boot option
To: Masahisa Kojima <masahisa.kojima@linaro.org>
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

Hi Kojima-san

On Wed, 18 Oct 2023 at 12:07, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ilias,
>
> On Wed, 18 Oct 2023 at 04:47, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi all,
> >
> > On Tue, 17 Oct 2023 at 08:33, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > Hi Heinrich,
> > >
> > > On Mon, 16 Oct 2023 at 23:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 16.10.23 15:00, Masahisa Kojima wrote:
> > > > > On Mon, 16 Oct 2023 at 21:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >>
> > > > >> On 16.10.23 14:31, Ilias Apalodimas wrote:
> > > > >>> Hi Heinrich,
> > > > >>>
> > > > >>> On Mon, 16 Oct 2023 at 10:06, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >>>>
> > > > >>>>
> > > > >>>>
> > > > >>>> Am 16. Oktober 2023 08:45:21 MESZ schrieb Masahisa Kojima <masahisa.kojima@linaro.org>:
> > > > >>>>> Current efibootmgr automatically creates the
> > > > >>>>> boot options of all disks and partitions installing
> > > > >>>>> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
> > > > >>>>> Some of the automatically created boot options are
> > > > >>>>> useless if the disk and partition does not have
> > > > >>>>> the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > > > >>>>>
> > > > >>>>> This commit only creates the boot option if the disk and
> > > > >>>>> partition have the default file so that system can directly
> > > > >>>>> boot from it.
> > > > >>>>
> > > > >>>> I don't directly see the user benefit.
> > > > >>>
> > > > >>> The user can add an HTTP boot option now and the installer will
> > > > >>> automatically start.  That would allow products to ship with a single
> > > > >>> boot option provisioned and run an installer on first boot
> > > > >>
> > > > >> This commit is not about HTTP. It changes how boot options for block
> > > > >> devices are created.
> > > > >>
> > > > >>>
> > > > >>>>
> > > > >>>> Reading all file systems will increase the boot time. Shouldn't we avoid this?
> > > > >>>
> > > > >>> Any idea what would be an alternative?  But when we added the
> > > > >>> automatic boot options we said we should avoid dynamic scanning and
> > > > >>> store results in a file.  This is doing a similar thing.  The only
> > > > >>> difference is that it mounts the iso image before adding the boot
> > > > >>> option.
> > > > >>
> > > > >> The alternative is to keep showing boot options for block devices even
> > > > >> if there is no BOOTxxxx.EFI file.
> > > > >>
> > > > >>>
> > > > >>>>
> > > > >>>> What does EDK II do?
> > > > >>>
> > > > >>> No Idea :)
> > > > >>
> > > > >>
> > > > >> On my workstation I get generated boot options
> > > > >>
> > > > >> Boot0001* UEFI:CD/DVD Drive     BBS(129,,0x0)
> > > > >> Boot0003* UEFI:Removable Device BBS(130,,0x0)
> > > > >> Boot0004* UEFI:Network Device   BBS(131,,0x0)
> > > > >>
> > > > >> without any media inserted and without any PXE server available.
> > > > >
> > > > > It is just information about how the EDK2 works.
> > > > > When I attach the Fedora installation media on EDK2(OVMF),
> > > > > the automatically generated boot option is as follows.
> > > > >
> > > > > UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0)
> > > >
> > > > An ATAPI drive typically is not removable. So I wonder why it is listed.
> > > > Did you set the removable flag on the command line?
> > >
> > > I guess it is not removable(actually I don't know how to set the
> > > device as removable).
> > > I just attached the iso image to QEMU with something like '-hda
> > > Fedora_netinst.iso".
> > >
> > > According to the EDK II implementation[1], the boot option is
> > > enumerated with the following order.
> > >   1. Removable BlockIo
> > >   2. Fixed BlockIo
> > >   3. Non-BlockIo SimpleFileSystem
> > >   4. LoadFile
> > > So boot option for the fixed device such as HDD is also automatically created.
> > >
> > > [1] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/UefiBootManagerLib/BmBoot.c#L2150
> > >
> > > >
> > > > >
> > > > > When this boot option is selected, Fedora installer automatically starts.
> > > > > So EDK II is searching the default file on the fly.
> > > >
> > > > What is shown if you attach a medium without Bootaa64.efi?
> > >
> > > The same boot option is created.
> > > UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0)
> >
> > I went back to reading the spec and I think Heinrich is right.  We
> > don't need that check at all. Going through [0] paragraph 4 says
> > " This search occurs when the device path of the boot image listed in
> > any boot option points directly to an EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
> > device and does not specify the exact file to load"
> >
> > So we should *only* add an automatic variable without the default
> > application.  Our code in try_load_entry() will search for that
> >
>
> Thank you for checking the UEFI specification and sorry for
> overlooking the above.
> So we will go back to the previous on the fly default application search.

Yes, I was about to suggest that.
The problem as I understand it that the current patch not only
disregards disks and partitions that dont have a default (i.e
bootaa64.efi) file. It also *changes* the default boot option we add,
and instead of the disk it adds a file.  That is the part that's
against the spec.  On top of that it changes the behavior of efi
bootmgr and we never call the expand_media_path.

So my suggestion would be
- Drop #4
- Adjust patch 5 and instead of loading the boot entry directly, scan
for the special autogenerated boot option and look for that file there

Heinrich would that work for you?

Thanks
/Ilias
>
> Thanks,
> Masahisa Kojima
>
> > [0] https://uefi.org/specs/UEFI/2.10/03_Boot_Manager.html#load-option-processing
> >
> > Regards
> > /Ilias
> > >
> > > Thanks,
> > > Masahisa Kojima
> > >
> > > >
