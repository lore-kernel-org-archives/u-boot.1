Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49B1CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 19:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E06B86F59;
	Tue, 17 Oct 2023 21:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iAXHdWlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D2EF86308; Tue, 17 Oct 2023 21:47:12 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED9E86F40
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 21:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507a62d4788so4988775e87.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697572029; x=1698176829; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rt9YpblNIfMF4ZpdMZ+Q72EWloFlS/AUCdZQ05nNlmM=;
 b=iAXHdWlpqcp/xKG+FXo5MZTLzYsp5my9lKdTkjci0VCbN3Qa3bjJfC7HKrRBkoBVVL
 2stHSEfP6oZBLdDszyAnF5OxxBC7aNQfygisSXxDm3q7ZVpdhx3jxuH86Ar//LiWAIJY
 x7KpQsnCMatCcpTt+4C2Yd4VQIVQhQEJXZoDsscLBMAHK7C05A9/iNKnrVrGIKeD2OC5
 yfjTXrRvpSlec/agJ2IdBYN1yQf9GzIjpmW0bLkDhjSq09vrL+e80jsx7yn8j8iPzjIN
 0faWlXE2PW1Xqs9CBssCsmz+/uIIwMQcjNPCRzHYw6aok7iHx7yTkh2Uuhb5D1wygACf
 BqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697572029; x=1698176829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rt9YpblNIfMF4ZpdMZ+Q72EWloFlS/AUCdZQ05nNlmM=;
 b=E9M5kFC4rRvZDfPeN8vOiJOvbKmBBkRqcrivDgvMIhp8V9aNEcpJG3DhDqQyMbkjva
 Cqla4cSfV9B6eLgZyOVgff3GlYLodtTna9/f++9QS59Cr5mZbKPNPdjidtrOSHt5RnKF
 /MQrer3BdHEW+q9wDnh/JolxiRSTzLxCB+62yLmW3NajFzxGRZ0LQxEHTVd7gXN6WNRH
 VDqalbJmyhKvsl4/4QHkJ375CEXXSbFtqMGTn7jPXHuf8NQDArnxhi2wJaSdgdrVIjg1
 1rsckNq0Re67R13lhmZOlz/dpy+euQa2kjCm6VC7/l64/6XWcVHbLeVkWo3BvHdkJOMj
 2drA==
X-Gm-Message-State: AOJu0Yz2JK/jXVJHLUy9f3Up9u2EJnFgK1NqBPezeiWL9MkkiSLsKckR
 LjINW2R7pyw6HtPRwC0mQNB0ZwWDrs9IhKGRn4w8CQ==
X-Google-Smtp-Source: AGHT+IGNd2ime1CL6dOh7Rvygnra+X5yV5EYggRT5F+q6ARepDvjjvFeRZDtX1uv+Ne1gEKle3IiFgMADV9ViX4JT5Y=
X-Received: by 2002:ac2:5f4d:0:b0:507:9d71:2a77 with SMTP id
 13-20020ac25f4d000000b005079d712a77mr2277785lfz.17.1697572029015; Tue, 17 Oct
 2023 12:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-5-masahisa.kojima@linaro.org>
 <A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de>
 <CAC_iWj+koNjVBR7TCJH_u_PvY5xDHgtBGRTHBRRgAx_aDeC8-A@mail.gmail.com>
 <ae12d900-fe7f-4f7b-9eb1-018aa719174f@gmx.de>
 <CADQ0-X8XGiek9oBEFeDtXaR2vcBsQS-NhJK5mL9TRLK+9gTJ2A@mail.gmail.com>
 <050e8bea-771b-491d-8d66-14fadcff0487@gmx.de>
 <CADQ0-X9n24HVJ_AoMszTUQy1wk+q=TfZG915mzd3gd=GScxjMA@mail.gmail.com>
In-Reply-To: <CADQ0-X9n24HVJ_AoMszTUQy1wk+q=TfZG915mzd3gd=GScxjMA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Oct 2023 22:46:33 +0300
Message-ID: <CAC_iWjJccjJPEWpiBKOA+ue21JAcosVHsgQH7QJvMzcRBASkAw@mail.gmail.com>
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

Hi all,

On Tue, 17 Oct 2023 at 08:33, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Heinrich,
>
> On Mon, 16 Oct 2023 at 23:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 16.10.23 15:00, Masahisa Kojima wrote:
> > > On Mon, 16 Oct 2023 at 21:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >> On 16.10.23 14:31, Ilias Apalodimas wrote:
> > >>> Hi Heinrich,
> > >>>
> > >>> On Mon, 16 Oct 2023 at 10:06, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> Am 16. Oktober 2023 08:45:21 MESZ schrieb Masahisa Kojima <masahisa.kojima@linaro.org>:
> > >>>>> Current efibootmgr automatically creates the
> > >>>>> boot options of all disks and partitions installing
> > >>>>> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
> > >>>>> Some of the automatically created boot options are
> > >>>>> useless if the disk and partition does not have
> > >>>>> the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > >>>>>
> > >>>>> This commit only creates the boot option if the disk and
> > >>>>> partition have the default file so that system can directly
> > >>>>> boot from it.
> > >>>>
> > >>>> I don't directly see the user benefit.
> > >>>
> > >>> The user can add an HTTP boot option now and the installer will
> > >>> automatically start.  That would allow products to ship with a single
> > >>> boot option provisioned and run an installer on first boot
> > >>
> > >> This commit is not about HTTP. It changes how boot options for block
> > >> devices are created.
> > >>
> > >>>
> > >>>>
> > >>>> Reading all file systems will increase the boot time. Shouldn't we avoid this?
> > >>>
> > >>> Any idea what would be an alternative?  But when we added the
> > >>> automatic boot options we said we should avoid dynamic scanning and
> > >>> store results in a file.  This is doing a similar thing.  The only
> > >>> difference is that it mounts the iso image before adding the boot
> > >>> option.
> > >>
> > >> The alternative is to keep showing boot options for block devices even
> > >> if there is no BOOTxxxx.EFI file.
> > >>
> > >>>
> > >>>>
> > >>>> What does EDK II do?
> > >>>
> > >>> No Idea :)
> > >>
> > >>
> > >> On my workstation I get generated boot options
> > >>
> > >> Boot0001* UEFI:CD/DVD Drive     BBS(129,,0x0)
> > >> Boot0003* UEFI:Removable Device BBS(130,,0x0)
> > >> Boot0004* UEFI:Network Device   BBS(131,,0x0)
> > >>
> > >> without any media inserted and without any PXE server available.
> > >
> > > It is just information about how the EDK2 works.
> > > When I attach the Fedora installation media on EDK2(OVMF),
> > > the automatically generated boot option is as follows.
> > >
> > > UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0)
> >
> > An ATAPI drive typically is not removable. So I wonder why it is listed.
> > Did you set the removable flag on the command line?
>
> I guess it is not removable(actually I don't know how to set the
> device as removable).
> I just attached the iso image to QEMU with something like '-hda
> Fedora_netinst.iso".
>
> According to the EDK II implementation[1], the boot option is
> enumerated with the following order.
>   1. Removable BlockIo
>   2. Fixed BlockIo
>   3. Non-BlockIo SimpleFileSystem
>   4. LoadFile
> So boot option for the fixed device such as HDD is also automatically created.
>
> [1] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/UefiBootManagerLib/BmBoot.c#L2150
>
> >
> > >
> > > When this boot option is selected, Fedora installer automatically starts.
> > > So EDK II is searching the default file on the fly.
> >
> > What is shown if you attach a medium without Bootaa64.efi?
>
> The same boot option is created.
> UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0)

I went back to reading the spec and I think Heinrich is right.  We
don't need that check at all. Going through [0] paragraph 4 says
" This search occurs when the device path of the boot image listed in
any boot option points directly to an EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
device and does not specify the exact file to load"

So we should *only* add an automatic variable without the default
application.  Our code in try_load_entry() will search for that

[0] https://uefi.org/specs/UEFI/2.10/03_Boot_Manager.html#load-option-processing

Regards
/Ilias
>
> Thanks,
> Masahisa Kojima
>
> >
