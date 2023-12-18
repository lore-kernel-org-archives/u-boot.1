Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F09C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 21:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1362C874F6;
	Mon, 18 Dec 2023 22:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EoXHb4ej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3FC187252; Mon, 18 Dec 2023 22:37:41 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B930D871CC
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702935458; x=1703540258; i=xypron.glpk@gmx.de;
 bh=iMSvBISXpgu2kNJ+y4m2K0s3tEFvr5Um7akHkAt8Twc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=EoXHb4ej6vzL+TWtz9DKPBIIYibPpP9orSZDpFRyMAXrDfvvasxDfVvzZgqXJ7Pl
 lt+gO2b/Pg7FdrMYJBlQG6JX0sVMwi+KZERDBd64Dhve5MpQ18/lOUhim1BMdHsFt
 KofbDXI8lqNe58thFkSMffoiODxNimW43uuGMssGxuvVE52ORoozCPy+I6oihY1XW
 UN/vTbgUVc65DweWMQwdDoXlf0lRqUBNg5VwG9RlxAVWeE3VRx4xO/JM072Itb7dg
 db+ZdTffM7A6a91j4DjEjlijogpnLUpwtYC1raOzCHD/vL/dTSDT9K6bezLXi3Zro
 ldeoTPswMylBfZNZ6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FjR-1rLeR30Kql-006Rhq; Mon, 18
 Dec 2023 22:37:38 +0100
Date: Mon, 18 Dec 2023 22:37:36 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <a55d0848-c70e-43a9-9223-60515aea8052@gmx.de>
 <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
 <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
 <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
Message-ID: <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HcxS/cByDt4fwjb6xmV3KKMhkkt6ADIx8NOjZif4qdAF7rX0BL+
 VMPq++nDK6dhAMR/owkegFbTIUiJBzHtoMIfHjom7IbfDrT5fO1k7mC8Zgk2q79Z7cJjidn
 Y2fOPIANMmmQNZgTn7l4fa8muvsd/HJwOuPkL9I3iM+v4BpIxMs2DmfVOZIkJF7HBr3CGpk
 x+962N9MSV+pT+umDTdqA==
UI-OutboundReport: notjunk:1;M01:P0:Yle2f6OmrC8=;WqWs06oUB2SDy2BecVqWErTnpsk
 01x1svhYrAPikUOGGAZZDcP8O2zjOiWQXx5xj2cMgmuuKwA0Xy80+pJ53NowV0/idQs7klnOz
 Uo08Z5FcB15dLTa/B6UWSCQH+1xaJjAOSExtKwoLLRxgNeP2pJB9Us7LHkHUI7Yc3XeIHfTfD
 jqlv0r0sfObwhvR/ocbxLa/DqR1E1MnVE+ob+341M8PzCF5MjvUfJZNeA9JwSs3rdZ5BFWX+F
 GIauws6+mlRWMMQV1uJNxqsXW4XvIl6lyJHQ6If1MsSdo9o9O1ErPaW4CSKQmDxFoYRBS9NAx
 FBGtk7qinJwr2C6+1579F6jBcEzYorO3Cab91Bagf900UfCtIr9iZa4bvRz+sQhiBRhC/hIOz
 KX7+okHnNOzk4L4VZ+tNoQTqXrXdgKt22Hht+o81vBtbsgDMd30lnmFnFcV2tzkN68pd8i6GD
 gDaWmEJQI9aC+EMemjE0AZTXEQTwG6hLOVnd0vwBymyOvYj1KcVGQ6pz9hGCmVfV/dN+5c3W+
 B0FtZrwTwYd/exd9ilmpLh2+SfBOXW3iy+JTVGZnSLMyR1dp4zSd4Vovv1zPHHuKAHzaLf7r2
 punpARCo57yhyYOSID0BvZ2MiwNO9GjyomYcclsdGCs6YqIgklVyF2jxbImixK07DWzi7j3y/
 uAQYRdUWOup/Oo+lOlXQQlnMEpurBAQjycIshls0+OtcH45R65rWEwxIv7ZoqyH8tfDG+Ei5Q
 TspRhHePwqsnmGGj4gyKWrjU2dyJc0TrLnCcl8c1l3sohbE3lXD+WzIr+PZuKhRELzeSnyz75
 KavI/WNIgISEpPEZIWfP8OOPkn8W9kGxEpL+2o7TFzUaR174NKAsN5MO+p+tyh1Cuk+Jszcze
 pj+u9CupZP3O4vDw6NxF0KXM058dpjbpdpq/APodJ+jMriDVwtQ7vzGPtmrAvfTrwOb03Z6wi
 Uw7toOBOsk4SCbBIEiRT9TO9M/g=
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



Am 18=2E Dezember 2023 22:03:41 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Heinrich,
>
>On Mon, 18 Dec 2023 at 13:00, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>>
>>
>> Am 18=2E Dezember 2023 19:12:11 MEZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
>> >Hi Heinrich,
>> >
>> >On Sat, 16 Dec 2023 at 12:04, Heinrich Schuchardt <xypron=2Eglpk@gmx=
=2Ede> wrote:
>> >>
>> >> On 12/16/23 19:01, Simon Glass wrote:
>> >> > Hi,
>> >> >
>> >> > This records my thoughts after a discussion with Ilias & Heinrich =
re
>> >> > memory allocation in U-Boot=2E
>> >> >
>> >> > 1=2E malloc()
>> >> >
>> >> > malloc() is used for programmatic memory allocation=2E It allows m=
emory
>> >> > to be freed=2E It is not designed for very large allocations (e=2E=
g=2E a
>> >> > 10MB kernel or 100MB ramdisk)=2E
>> >> >
>> >> > 2=2E lmb
>> >> >
>> >> > lmb is used for large blocks of memory, such as those needed for a
>> >> > kernel or ramdisk=2E Allocation is only transitory, for the purpos=
es of
>> >> > loading some images and booting=2E If the boot fails, then all lmb
>> >> > allocations go away=2E
>> >> >
>> >> > lmb is set up by getting all available memory and then removing wh=
at
>> >> > is used by U-Boot (code, data, malloc() space, etc=2E)
>> >> >
>> >> > lmb reservations have a few flags so that areas of memory can be
>> >> > provided with attributes
>> >> >
>> >> > There are some corner cases=2E=2E=2Ee=2Eg=2E loading a file does a=
n lmb
>> >> > allocation but only for the purpose of avoiding a file being loade=
d
>> >> > over U-Boot code/data=2E The allocation is dropped immediately aft=
er the
>> >> > file is loaded=2E Within the bootm command, or when using standard=
 boot,
>> >> > this would be fairly easy to solve=2E
>> >> >
>> >> > Linux has renamed lmb to memblock=2E We should consider doing the =
same=2E
>> >> >
>> >> > 3=2E EFI
>> >> >
>> >> > EFI has its own memory-allocation tables=2E
>> >> >
>> >> > Like lmb, EFI is able to deal with large allocations=2E But via a =
'pool'
>> >> > function it can also do smaller allocations similar to malloc(),
>> >> > although each one uses at least 4KB at present=2E
>> >> >
>> >> > EFI allocations do not go away when a boot fails=2E
>> >> >
>> >> > With EFI it is possible to add allocations post facto, in which ca=
se
>> >> > they are added to the allocation table just as if the memory was
>> >> > allocated with EFI to begin with=2E
>> >> >
>> >> > The EFI allocations and the lmb allocations use the same memory, s=
o in
>> >> > principle could conflict=2E
>> >> >
>> >> > EFI allocations are sometimes used to allocate internal U-Boot dat=
a as
>> >> > well, if needed by the EFI app=2E For example, while efi_image_par=
se()
>> >> > uses malloc(), efi_var_mem=2Ec uses EFI allocations since the code=
 runs
>> >> > in the app context and may need to access the memory after U-Boot =
has
>> >> > exited=2E Also efi_smbios=2Ec uses allocate_pages() and then adds =
a new
>> >> > mapping as well=2E
>> >> >
>> >> > EFI memory has attributes, including what the memory is used for (=
to
>> >> > some degree of granularity)=2E See enum efi_memory_type and struct
>> >> > efi_mem_desc=2E In the latter there are also attribute flags - whe=
ther
>> >> > memory is cacheable, etc=2E
>> >> >
>> >> > EFI also has the x86 idea of 'conventional' memory, meaning (I
>> >> > believe) that below 4GB that isn't reserved for the hardware/syste=
m=2E
>> >> > This is meaningless, or at least confusing, on ARM systems=2E
>> >> >
>> >> > 4=2E reservations
>> >> >
>> >> > It is perhaps worth mentioning a fourth method of memory managemen=
t,
>> >> > where U-Boot reserves chunks of memory before relocation (in
>> >> > board_init_f=2Ec), e=2Eg=2E for the framebuffer, U-Boot code, the =
malloc()
>> >> > region, etc=2E
>> >> >
>> >> >
>> >> > Problems
>> >> > =E2=80=94-------
>> >> >
>> >> > There are no urgent problems, but here are some things that could =
be improved:
>> >> >
>> >> > 1=2E EFI should attach most of its data structures to driver model=
=2E This
>> >> > work has started, with the partition support, but more effort woul=
d
>> >> > help=2E This would make it easier to see which memory is related t=
o
>> >> > devices and which is separate=2E
>> >> >
>> >> > 2=2E Some drivers do EFI reservations today, whether EFI is used f=
or
>> >> > booting or not (e=2Eg=2E rockchip video rk_vop_probe())=2E
>> >>
>> >> Hello Simon,
>> >>
>> >> thank you for summarizing our discussion=2E
>> >>
>> >> Some U-Boot drivers including rockchip video inform the EFI sub-syst=
em
>> >> that memory is reserved=2E
>> >>
>> >> Furthermore drivers like arch/arm/mach-bcm283x/reset=2Ec exist that =
are
>> >> still used after ExitBootServices=2E mmio addresses have to be updat=
ed
>> >> when Linux creates its virtual memory map=2E Currently this is done =
via
>> >> efi_add_runtime_mmio()=2E A more UEFI style method would be to regis=
ter an
>> >> event handler for ExitBootServices() and use ConvertPointer() in the
>> >> event handler=2E
>> >>
>> >> >
>> >> > 3=2E U-Boot doesn't really map arch-specific memory attributes (e=
=2Eg=2E
>> >> > armv8's struct mm_region) to EFI ones=2E
>> >>
>> >> U-Boot fails to set up RWX properties=2E E=2Eg=2E the region where a=
 FIT image
>> >> is loaded should not be executable=2E
>> >>
>> >> >
>> >> > 4=2E EFI duplicates some code from bootm, some of which relates to
>> >> > memory allocation (e=2Eg=2E FDT fixup)=2E
>> >>
>> >> Fixup code is not duplicated but invoked via image_setup_libfdt()=2E
>> >>
>> >> >
>> >> > 5=2E EFI code is used even if EFI is never used to boot
>> >>
>> >>
>> >> * Only a minimum initialization of the EFI sub-system happens in
>> >> efi_init_early()=2E
>> >> * Some EFI code is called when probing block devices because we want=
ed
>> >> the EFI and the dm part to be integrated=2E
>> >> * The rest of the initialization in efi_init_obj_list() is only invo=
ked
>> >> if an EFI command is invoked=2E
>> >>
>> >> >
>> >> > 6=2E EFI allocations can result in the same memory being used as h=
as
>> >> > already been allocated by lmb=2E Users may load files which overwr=
ite
>> >> > memory allocated by EFI=2E
>> >>
>> >> The most worrisome issue is that EFI may allocate memory where U-Boo=
t
>> >> has loaded files like initrd as the EFI sub-system is never informed
>> >> which memory is used for files=2E
>> >>
>> >> Loading files should not be possible without creating a memory
>> >> reservation that becomes visible to the EFI sub-system=2E
>> >>
>> >> >
>> >> >
>> >> > Lifetime
>> >> > --------
>> >> >
>> >> > We have three different memory allocators with different purposes=
=2E Can
>> >> > we unify them a little?
>> >> >
>> >> > Within U-Boot:
>> >> > - malloc() space lives forever
>> >> > - lmb lives while setting out images for booting
>> >> > - EFI (mostly) lives while booting an EFI app
>> >> >
>> >> > In practice, EFI is set up early in U-Boot=2E Some of this is nece=
ssary,
>> >> > some not=2E EFI allocations stay around forever=2E This works OK s=
ince
>> >> > large allocations are normally not done in EFI, so memory isn't re=
ally
>> >> > consumed to any great degree by the boot process=2E
>> >>
>> >> U-Boot can load EFI drivers which stay resident in memory after the
>> >> efi_main() method has returned to U-Boot=2E The next EFI application=
 then
>> >> may use the driver=2E Therefore is essential that the EFI subsystem =
has
>> >> access to a valid memory model at all times=2E
>> >>
>> >> >
>> >> > What happens to EFI allocations if the app returns? They are still
>> >> > present, in case another app is run=2E This seems fine=2E
>> >> >
>> >> > API
>> >> > =E2=80=93--
>> >> > Can we unify some APIs?
>> >> >
>> >> > It should be possible to use lmb for large EFI memory allocations,=
 so
>> >> > long as they are only needed for booting=2E We effectively do this
>> >> > today, since EFI does not manage the arrangement of loaded images =
in
>> >> > memory=2E for the most part=2E
>> >> >
>> >> > It would not make sense to use EFI allocation to replace lmb and
>> >> > malloc(), of course=2E
>> >> >
>> >> > Could we use a common (lower-level) API for allocation, used by bo=
th
>> >> > lmb and EFI? They do have some similarities=2E However they have
>> >> > different lifetime constraints (EFI allocations are never dropped,
>> >> > unlikely lmb)=2E
>> >>
>> >> The way lmb is used is a deficiency of U-Boot=2E E=2Eg=2E you can lo=
ad an
>> >> initrd that overwrites the previously loaded kernel and then try to =
boot=2E
>> >>
>> >> What we need is a common memory management library where allocations=
 are
>> >> never dropped and which is used by all file loads=2E
>> >>
>> >> >
>> >> > ** Overall, it seems that the existence of memory allocation in
>> >> > boot-time services has created confusion=2E Memory allocation is
>> >> > muddled, with both U-Boot code and boot-time services calling the =
same
>> >> > memory allocator=2E This just has not been clearly thought out=2E
>> >> >
>> >>
>> >> We have to implement what the UEFI specification requires=2E Some
>> >> boot-time services must allocate memory via AllocatePool() or
>> >> AllocatePages() because that memory is handed out to the caller of a=
n
>> >> API function and it is the callers obligation to free the memory via
>> >> FreePool() or FreePages()=2E
>> >>
>> >> >
>> >> > Proposal
>> >> > =E2=80=94-------
>> >> >
>> >> > Here are some ideas:
>> >> >
>> >> > 1=2E For video, use the driver model API to locate the video regio=
ns, or
>> >> > block off the entire framebuffer memory, for all devices as a whol=
e=2E
>> >> > Use efi_add_memory_map()
>> >>
>> >> When video memory is located higher than the stack the EFI sub-syste=
m
>> >> will not make use of the memory=2E
>> >>
>> >> >
>> >> > 2=2E Add memory attributes to UCLASS_RAM and use them in EFI, mapp=
ing to
>> >> > the EFI_MEMORY_=2E=2E=2E attributes in struct efi_mem_desc=2E
>> >> >
>> >> > 3=2E Add all EFI reservations just before booting the app, as we d=
o with
>> >> > devicetree fixup=2E With this model, malloc() and lmb are used for=
 all
>> >> > allocation=2E Then efi_add_memory_map() is called for each region =
in
>> >> > turn just before booting=2E Memory attributes are dealt with above=
=2E The
>> >> > type (enum efi_memory_type) can be determined simply by the data
>> >> > structure stored in it, as is done today=2E For example, SMBIOS ta=
bles
>> >> > can use EFI_ACPI_RECLAIM_MEMORY=2E Very few types are used and EFI=
 code
>> >> > understands the meaning of each=2E
>> >>
>> >> This would require a permanent storage of the reservations=2E Keep i=
t
>> >> easy, unify the memory management and make it persistent=2E
>> >>
>> >> >
>> >> > 4=2E Avoid setting up EFI memory at the start of U-Boot=2E Do it o=
nly when
>> >> > booting=2E This looks to require very little effort=2E
>> >>
>> >> There is no such thing as EFI memory=2E We only have one physical me=
mory
>> >> that we have to keep track of=2E
>> >>
>> >> It is not possible to set up the EFI memory map if you don't keep tr=
ack
>> >> of all memory allocations including all file loads over the whole
>> >> lifetime of U-Boot=2E
>> >>
>> >> >
>> >> > 5=2E Avoid calling efi_allocate_pages() and efi_allocate_pool() ou=
tside
>> >> > boot-time services=2E This solves the problem 6=2E If memory is ne=
eded by
>> >> > an app, allocate it with malloc() and see 3=2E There are only two
>> >> > efi_allocate_pages() (smbios and efi_runtime)=2E There are more ca=
lls of
>> >> > efi_allocate_pool(), but most of these seem easy to fix up=2E For
>> >> > example, efi_init_event_log() allocates a buffer, but this can be
>> >> > allocated in normal malloc() space or in a bloblist=2E
>> >>
>> >> If we have a unified memory allocation layer, efi_allocate_pages() a=
nd
>> >> efi_allocate_pool() will be implemented by calls into that layer and
>> >> issue 6) will vanish=2E
>> >>
>> >> >
>> >> > 6=2E Don't worry too much about whether EFI will be used for booti=
ng=2E
>> >> > The cost is likely not that great: use bootstage to measure it as =
is
>> >> > done for driver model=2E Try to minmise the cost of its tables,
>> >> > particularly for execution time, but otherwise just rely on the
>> >> > ability to disable EFI_LOADER=2E
>> >>
>> >> The time intensive part of having EFI enabled is scanning file syste=
ms
>> >> for boot files and capsules=2E
>> >
>> >Thank you for your thoughts on this=2E
>> >
>> >It does not look like my write-up has helped at all with getting
>> >aligned on this=2E Do you have any other ideas?
>> >
>> >Perhaps we could at least figure out the 'allocation lifetime'
>> >approach? It seems clear to me that we have allocations with short
>> >lifetimes (e=2Eg=2E kernel & ramdisk allocations will remain in effect
>> >only when booting)=2E Do you agree with that?
>>
>> We agree that we want to have a unified memory management=2E
>>
>> Memory management implies that memory allocations remain in effect unti=
l the memory is freed=2E
>>
>> This must be true for all allocations whether it is for a kernel, a ram=
disk, for loading a file, for an allocation by an EFI binary, or for anythi=
ng else=2E
>>
>> If boot commands like bootm allocate memory and free it after a failure=
, that time will be short=2E
>>
>> If a file is loaded and never unloaded that memory allocation must stay=
 until the OS takes over memory management=2E This is what is missing in U-=
Boot=2E
>
>I see that more as a reservation than an allocation=2E The 'load'
>command can never do a useful memory allocation, since the user may
>want to load a different file to the same address=2E

We lack an unload command to free the memory=2E

>
>We don't 'free' memory reserved for the kernel/ramdisk=2E=2E=2Ethe
>allocation is only temporary=2E This is what we need to align on=2E Those
>allocations should be collated and reported to EFI before booting,
>then dropped if the boot fails=2E This in fact works today, with lmb, so
>we should not need to change it=2E

Tempory allocations must use a free=2E This is trivial to implement=2E

>
>Trying to bring in alloc/free semantics for lmb seems unnecessary and
>confusing=2E Let's keep in mind the problem we are trying to solve=2E Wit=
h
>bootstd we can set up an lmb and place everything that is needed (in
>the read_all() method), then boot=2E

The problem we want to solve is that we don't have a proper memory managen=
ent=2E

The current lmb usage is obviously not memory management and must be repla=
ced by alloc/free semantics=2E

Best regards

Heinrich




>
>Regards,
>Simon
