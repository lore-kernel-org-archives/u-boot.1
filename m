Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E696BC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040C187252;
	Mon, 18 Dec 2023 20:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eP/5uFFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550F0874B1; Mon, 18 Dec 2023 20:55:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6417987076
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702929294; x=1703534094; i=xypron.glpk@gmx.de;
 bh=d80SuclEppA0ljhChDcnLslthESLehxDLECKwGZvtrA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=eP/5uFFVTuY5vaX7eOn20b1tkxY4Y8UCk+oSuj/rkXSlmGj/OAt5mGqivJy5Io5n
 v7yqIUQhuIT/+o0orsrPrZi5O3OKl9l9iY6f5UMM+nYiOCPu4tiWKyLxAtsZ14gmL
 h+Fip1bLDWnCIdREJAkH15rXaVS7yd+Iu75u7jnMMEMz8ebcJ36nu0EPAsIZNzL2V
 vJngrVO6xyF86fQtk4u62Fij3MDFxy21Mwj3cJ3yL0JQyoZaKzaUC75EjaCcofCjX
 5uVZ022nqxYxn8s2sjoUNb4m3/3mYVfuf8fG8Sj3fzZmLnGA2e+2iySgE8hy4Uhn1
 y56+8sosfXZI8ZXTyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1rQq1s2buM-00Beas; Mon, 18
 Dec 2023 20:54:54 +0100
Date: Mon, 18 Dec 2023 20:54:53 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <a55d0848-c70e-43a9-9223-60515aea8052@gmx.de>
 <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
Message-ID: <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tm3CQfCw2wxI3dNPEjh1GZUb6mZl2/lIVyTDF/M1BDS6Nw3zbVZ
 rX9GUX1o6G1nogiDe2cTsNTs3acIow+QMo6B7lZGJTNmWmjJOqn8tLp0JlmkF/5GAszrQCR
 55l/79H0+ivj66Z2XqnQ84SZaEH5ReQmwhEtI6NUvG91nz7WLcPvitWCScU7zs3dIi3GpPW
 Q9sTnt9aM662Dd5ZzvPww==
UI-OutboundReport: notjunk:1;M01:P0:o1jCp0DEmq4=;MbTK/d04/j0ALCGAXn0/UPZA981
 Rrvg3JtBImJrZIYR4dCdk4OflMdhljSHPGFB9KilNjuoNqHQnq1cq8R4zMtt0FtEThznZjeGh
 P7CvJ3cqzUdR4hhbawKpqFLQoziXjJfYZRwoLZ1s6HH4KVwSRjHQaElnDP1Q1m7t922maEqHD
 oxD0ImDVajKLJeh0BPdWkAJx9Wz9ejCH0R6DyiBtdLpRcr+H8iWXxvMLW7Gpqe/bjrtANAvXS
 Fg3jnX/khUKpaO7UKs6oLHXEJXgRHifNl7qMm8IYtTx8OstHl//ik5oNGSPCLZCCuJ+kJHrd3
 1xSC7QSPy2AayhOB7W/2tjNgHpN12s/Oqtx7c9HKIKtHVk8xvkzIN8zvPFbENz1NqLXvqCKA8
 drAbZhz6ebtMrYUOJDPs/g7OSCXcxP0FIVIL/HHnCn4pTJ308vjfwCp8J6IP1rQiK5hyC6WvU
 owXvrfR0FCaPHm0cAx1LgquVAY8yv9qVCDR9Sbwz/T45B8ICy8AFzhy5Cteb7QXHVvqGWBW38
 G0ZHjlLuis4BQ+YfTNDCA41D02ocPOysyalHCQQmc/TWsYQFcFhBkyxN3YDQ7XTeXVwn3VTAH
 erZN0XfbscRpd1NgQ/AcF7sbe9oovaTHvixqpWWYUi0SJXlcUmYPD885KoCPq3yKCvy/z0YxY
 uHtKUEtXN0Eq8dp5W/c1MWrT9LdYzN3p4bjcHXapf0oJYPkfM6WT54Aj6+SYczNOzfW+yu82U
 q4gK+2NknX1/YF3y4R8QU8mtoToR9NOjsxjM/AwuTkJrYPcO4h0RPzRdsI8hakIuhwuSQ11HD
 LAxiJSqsLVoFCDPV+BoK4yQ4v5zGQ91WJKbBNxBOySQd35p9DXp8MuwEKiZGMwokSh2p5ZK/7
 GojgRj3bb16MCzhR/H58JwE5KTrN0d3dhfIujFp1Pb8pIH4UlFR1LBGTkG0Y8qvi+2IX8EbYg
 r911PrZtTKDszKkWSWLGW4N9dkk=
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



Am 18=2E Dezember 2023 19:12:11 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Heinrich,
>
>On Sat, 16 Dec 2023 at 12:04, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>> On 12/16/23 19:01, Simon Glass wrote:
>> > Hi,
>> >
>> > This records my thoughts after a discussion with Ilias & Heinrich re
>> > memory allocation in U-Boot=2E
>> >
>> > 1=2E malloc()
>> >
>> > malloc() is used for programmatic memory allocation=2E It allows memo=
ry
>> > to be freed=2E It is not designed for very large allocations (e=2Eg=
=2E a
>> > 10MB kernel or 100MB ramdisk)=2E
>> >
>> > 2=2E lmb
>> >
>> > lmb is used for large blocks of memory, such as those needed for a
>> > kernel or ramdisk=2E Allocation is only transitory, for the purposes =
of
>> > loading some images and booting=2E If the boot fails, then all lmb
>> > allocations go away=2E
>> >
>> > lmb is set up by getting all available memory and then removing what
>> > is used by U-Boot (code, data, malloc() space, etc=2E)
>> >
>> > lmb reservations have a few flags so that areas of memory can be
>> > provided with attributes
>> >
>> > There are some corner cases=2E=2E=2Ee=2Eg=2E loading a file does an l=
mb
>> > allocation but only for the purpose of avoiding a file being loaded
>> > over U-Boot code/data=2E The allocation is dropped immediately after =
the
>> > file is loaded=2E Within the bootm command, or when using standard bo=
ot,
>> > this would be fairly easy to solve=2E
>> >
>> > Linux has renamed lmb to memblock=2E We should consider doing the sam=
e=2E
>> >
>> > 3=2E EFI
>> >
>> > EFI has its own memory-allocation tables=2E
>> >
>> > Like lmb, EFI is able to deal with large allocations=2E But via a 'po=
ol'
>> > function it can also do smaller allocations similar to malloc(),
>> > although each one uses at least 4KB at present=2E
>> >
>> > EFI allocations do not go away when a boot fails=2E
>> >
>> > With EFI it is possible to add allocations post facto, in which case
>> > they are added to the allocation table just as if the memory was
>> > allocated with EFI to begin with=2E
>> >
>> > The EFI allocations and the lmb allocations use the same memory, so i=
n
>> > principle could conflict=2E
>> >
>> > EFI allocations are sometimes used to allocate internal U-Boot data a=
s
>> > well, if needed by the EFI app=2E For example, while efi_image_parse(=
)
>> > uses malloc(), efi_var_mem=2Ec uses EFI allocations since the code ru=
ns
>> > in the app context and may need to access the memory after U-Boot has
>> > exited=2E Also efi_smbios=2Ec uses allocate_pages() and then adds a n=
ew
>> > mapping as well=2E
>> >
>> > EFI memory has attributes, including what the memory is used for (to
>> > some degree of granularity)=2E See enum efi_memory_type and struct
>> > efi_mem_desc=2E In the latter there are also attribute flags - whethe=
r
>> > memory is cacheable, etc=2E
>> >
>> > EFI also has the x86 idea of 'conventional' memory, meaning (I
>> > believe) that below 4GB that isn't reserved for the hardware/system=
=2E
>> > This is meaningless, or at least confusing, on ARM systems=2E
>> >
>> > 4=2E reservations
>> >
>> > It is perhaps worth mentioning a fourth method of memory management,
>> > where U-Boot reserves chunks of memory before relocation (in
>> > board_init_f=2Ec), e=2Eg=2E for the framebuffer, U-Boot code, the mal=
loc()
>> > region, etc=2E
>> >
>> >
>> > Problems
>> > =E2=80=94-------
>> >
>> > There are no urgent problems, but here are some things that could be =
improved:
>> >
>> > 1=2E EFI should attach most of its data structures to driver model=2E=
 This
>> > work has started, with the partition support, but more effort would
>> > help=2E This would make it easier to see which memory is related to
>> > devices and which is separate=2E
>> >
>> > 2=2E Some drivers do EFI reservations today, whether EFI is used for
>> > booting or not (e=2Eg=2E rockchip video rk_vop_probe())=2E
>>
>> Hello Simon,
>>
>> thank you for summarizing our discussion=2E
>>
>> Some U-Boot drivers including rockchip video inform the EFI sub-system
>> that memory is reserved=2E
>>
>> Furthermore drivers like arch/arm/mach-bcm283x/reset=2Ec exist that are
>> still used after ExitBootServices=2E mmio addresses have to be updated
>> when Linux creates its virtual memory map=2E Currently this is done via
>> efi_add_runtime_mmio()=2E A more UEFI style method would be to register=
 an
>> event handler for ExitBootServices() and use ConvertPointer() in the
>> event handler=2E
>>
>> >
>> > 3=2E U-Boot doesn't really map arch-specific memory attributes (e=2Eg=
=2E
>> > armv8's struct mm_region) to EFI ones=2E
>>
>> U-Boot fails to set up RWX properties=2E E=2Eg=2E the region where a FI=
T image
>> is loaded should not be executable=2E
>>
>> >
>> > 4=2E EFI duplicates some code from bootm, some of which relates to
>> > memory allocation (e=2Eg=2E FDT fixup)=2E
>>
>> Fixup code is not duplicated but invoked via image_setup_libfdt()=2E
>>
>> >
>> > 5=2E EFI code is used even if EFI is never used to boot
>>
>>
>> * Only a minimum initialization of the EFI sub-system happens in
>> efi_init_early()=2E
>> * Some EFI code is called when probing block devices because we wanted
>> the EFI and the dm part to be integrated=2E
>> * The rest of the initialization in efi_init_obj_list() is only invoked
>> if an EFI command is invoked=2E
>>
>> >
>> > 6=2E EFI allocations can result in the same memory being used as has
>> > already been allocated by lmb=2E Users may load files which overwrite
>> > memory allocated by EFI=2E
>>
>> The most worrisome issue is that EFI may allocate memory where U-Boot
>> has loaded files like initrd as the EFI sub-system is never informed
>> which memory is used for files=2E
>>
>> Loading files should not be possible without creating a memory
>> reservation that becomes visible to the EFI sub-system=2E
>>
>> >
>> >
>> > Lifetime
>> > --------
>> >
>> > We have three different memory allocators with different purposes=2E =
Can
>> > we unify them a little?
>> >
>> > Within U-Boot:
>> > - malloc() space lives forever
>> > - lmb lives while setting out images for booting
>> > - EFI (mostly) lives while booting an EFI app
>> >
>> > In practice, EFI is set up early in U-Boot=2E Some of this is necessa=
ry,
>> > some not=2E EFI allocations stay around forever=2E This works OK sinc=
e
>> > large allocations are normally not done in EFI, so memory isn't reall=
y
>> > consumed to any great degree by the boot process=2E
>>
>> U-Boot can load EFI drivers which stay resident in memory after the
>> efi_main() method has returned to U-Boot=2E The next EFI application th=
en
>> may use the driver=2E Therefore is essential that the EFI subsystem has
>> access to a valid memory model at all times=2E
>>
>> >
>> > What happens to EFI allocations if the app returns? They are still
>> > present, in case another app is run=2E This seems fine=2E
>> >
>> > API
>> > =E2=80=93--
>> > Can we unify some APIs?
>> >
>> > It should be possible to use lmb for large EFI memory allocations, so
>> > long as they are only needed for booting=2E We effectively do this
>> > today, since EFI does not manage the arrangement of loaded images in
>> > memory=2E for the most part=2E
>> >
>> > It would not make sense to use EFI allocation to replace lmb and
>> > malloc(), of course=2E
>> >
>> > Could we use a common (lower-level) API for allocation, used by both
>> > lmb and EFI? They do have some similarities=2E However they have
>> > different lifetime constraints (EFI allocations are never dropped,
>> > unlikely lmb)=2E
>>
>> The way lmb is used is a deficiency of U-Boot=2E E=2Eg=2E you can load =
an
>> initrd that overwrites the previously loaded kernel and then try to boo=
t=2E
>>
>> What we need is a common memory management library where allocations ar=
e
>> never dropped and which is used by all file loads=2E
>>
>> >
>> > ** Overall, it seems that the existence of memory allocation in
>> > boot-time services has created confusion=2E Memory allocation is
>> > muddled, with both U-Boot code and boot-time services calling the sam=
e
>> > memory allocator=2E This just has not been clearly thought out=2E
>> >
>>
>> We have to implement what the UEFI specification requires=2E Some
>> boot-time services must allocate memory via AllocatePool() or
>> AllocatePages() because that memory is handed out to the caller of an
>> API function and it is the callers obligation to free the memory via
>> FreePool() or FreePages()=2E
>>
>> >
>> > Proposal
>> > =E2=80=94-------
>> >
>> > Here are some ideas:
>> >
>> > 1=2E For video, use the driver model API to locate the video regions,=
 or
>> > block off the entire framebuffer memory, for all devices as a whole=
=2E
>> > Use efi_add_memory_map()
>>
>> When video memory is located higher than the stack the EFI sub-system
>> will not make use of the memory=2E
>>
>> >
>> > 2=2E Add memory attributes to UCLASS_RAM and use them in EFI, mapping=
 to
>> > the EFI_MEMORY_=2E=2E=2E attributes in struct efi_mem_desc=2E
>> >
>> > 3=2E Add all EFI reservations just before booting the app, as we do w=
ith
>> > devicetree fixup=2E With this model, malloc() and lmb are used for al=
l
>> > allocation=2E Then efi_add_memory_map() is called for each region in
>> > turn just before booting=2E Memory attributes are dealt with above=2E=
 The
>> > type (enum efi_memory_type) can be determined simply by the data
>> > structure stored in it, as is done today=2E For example, SMBIOS table=
s
>> > can use EFI_ACPI_RECLAIM_MEMORY=2E Very few types are used and EFI co=
de
>> > understands the meaning of each=2E
>>
>> This would require a permanent storage of the reservations=2E Keep it
>> easy, unify the memory management and make it persistent=2E
>>
>> >
>> > 4=2E Avoid setting up EFI memory at the start of U-Boot=2E Do it only=
 when
>> > booting=2E This looks to require very little effort=2E
>>
>> There is no such thing as EFI memory=2E We only have one physical memor=
y
>> that we have to keep track of=2E
>>
>> It is not possible to set up the EFI memory map if you don't keep track
>> of all memory allocations including all file loads over the whole
>> lifetime of U-Boot=2E
>>
>> >
>> > 5=2E Avoid calling efi_allocate_pages() and efi_allocate_pool() outsi=
de
>> > boot-time services=2E This solves the problem 6=2E If memory is neede=
d by
>> > an app, allocate it with malloc() and see 3=2E There are only two
>> > efi_allocate_pages() (smbios and efi_runtime)=2E There are more calls=
 of
>> > efi_allocate_pool(), but most of these seem easy to fix up=2E For
>> > example, efi_init_event_log() allocates a buffer, but this can be
>> > allocated in normal malloc() space or in a bloblist=2E
>>
>> If we have a unified memory allocation layer, efi_allocate_pages() and
>> efi_allocate_pool() will be implemented by calls into that layer and
>> issue 6) will vanish=2E
>>
>> >
>> > 6=2E Don't worry too much about whether EFI will be used for booting=
=2E
>> > The cost is likely not that great: use bootstage to measure it as is
>> > done for driver model=2E Try to minmise the cost of its tables,
>> > particularly for execution time, but otherwise just rely on the
>> > ability to disable EFI_LOADER=2E
>>
>> The time intensive part of having EFI enabled is scanning file systems
>> for boot files and capsules=2E
>
>Thank you for your thoughts on this=2E
>
>It does not look like my write-up has helped at all with getting
>aligned on this=2E Do you have any other ideas?
>
>Perhaps we could at least figure out the 'allocation lifetime'
>approach? It seems clear to me that we have allocations with short
>lifetimes (e=2Eg=2E kernel & ramdisk allocations will remain in effect
>only when booting)=2E Do you agree with that?

We agree that we want to have a unified memory management=2E

Memory management implies that memory allocations remain in effect until t=
he memory is freed=2E

This must be true for all allocations whether it is for a kernel, a ramdis=
k, for loading a file, for an allocation by an EFI binary, or for anything =
else=2E

If boot commands like bootm allocate memory and free it after a failure, t=
hat time will be short=2E

If a file is loaded and never unloaded that memory allocation must stay un=
til the OS takes over memory management=2E This is what is missing in U-Boo=
t=2E

Best regards

Heinrich



