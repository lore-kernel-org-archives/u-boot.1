Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1FEC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 22:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B269874F6;
	Mon, 18 Dec 2023 23:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bgwETF7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A77488753C; Mon, 18 Dec 2023 23:34:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457AC871DF
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 23:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702938857; x=1703543657; i=xypron.glpk@gmx.de;
 bh=zeNps3I04sW4UE7aaeUScrCxl0KipMQ27hjfNf5FiQQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=bgwETF7TupxqC/O3Ze+fJbfVVAUdEBH86cgxaanW+X+MWq9Rd0VqyiKqF3dX7mut
 oua7eewqkglermmj2dXPZ+E/haU4/naGc0DnUF7XJb7q1OlH4IcsaQP05TdDXDIop
 YnS/W1PWC/jppvpBscNAoV52xsK2l8GtMG3WN6AS9g0NE+1BhdbvyNz/uqzei54dg
 V2V4HcynxQZhls7WpiWbcPFEsFScw8+ENJYw8MCWdwUYpBDz4UXKYNhU8+USiuUUj
 JKB3Um3tZOMMdiQUVY1wmz+Yb9952Xd1KN4V3jH96ScG0PQOvWHYRgEoHdcM3KdPv
 20502YFfw57cAAW+xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1rOBsP1CWu-008ola; Mon, 18
 Dec 2023 23:34:17 +0100
Date: Mon, 18 Dec 2023 23:34:16 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <a55d0848-c70e-43a9-9223-60515aea8052@gmx.de>
 <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
 <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
 <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
 <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
 <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
Message-ID: <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:grJtQicluc6JijCJkH6oums7XVeBsMFKCuzQP1Hydk0WLp6O6pK
 w/PGXbjxCAIQKLh6bRqnacENGsPlGoUGfc4Cws+BFPR0VNTmU/w60g3AKGodGHlAPKRLB0A
 uze2l+uzEUWiyXDX43frnv2rNnAgTaJWLjTtWXNyQtFiymWjPIZiWESwPSkER8JtvoyMMDz
 qHOr8gRIzGzJWWn4J5wnA==
UI-OutboundReport: notjunk:1;M01:P0:P0RI1rPF+l8=;J1cPhFthc0lGAZAbY6qKbx8GR22
 fOz3HHSfZSfZTh4n43YDfcnWp5FtXaO70aPsX+6w2lPUmys4b10cyW5Hpi7qGizC2vDRdh33Y
 6PYa4FpKJFbvHaIIjSKrWZO5ADCKGdTKFJKAbjd8WyFcMrXyKlmrP1dEeqECALfLpimw5KuwJ
 KjRU9AXw5PjDNqVrz6/jSdLCzBctkIPXQ0AXwSy8keARprNY6cipAo6fiho3TZXcEWfloux+g
 kZMvHH+P3+AVV8OkRUhXBdiIkUGxs0sahq4PV5Td0hKVullcAXXm203SXRm66IGKr00Je4eNW
 SkNsHLfc2whvAIlDz3NslmSmJSe3NSoNwgaAyHHyEOKMOWnujM5+rzBC7Kwd6a7ulYplLHk5I
 EsN7J/IoMaENrzxcyantFzRNJQmxRhkuisY2gcFZ1gDBdRrwv8fXfE4Z/hTeX+Kja5/iFHIN6
 qTzvNyo5lHjdqGuww9tzfNBu/AJWi60B5OwFvCOKqgcvTrUqM2U1ylLN6dhy2W3UBFf4Rv6HF
 Cs+gM2aw8Q2oeA4rTU3Avc40s6CEynNJhst/wkc8CmUtBKiVmikKVTUxw42ejsSjAEoETmJoW
 iMBnUnjWLi1wu9GPAdZ0Jq7ZPiaMVVdYXdmdTTJ2x5d5UjVzJw0NszXsoNV5wCKGRAlRh1gdR
 U7oSAVo/jfk7kv+1Jp+o+gLIXgHvss5be2gLPAQ0SIhgFjsLGv4R6oRLgOhpJ9AdZRZL69OUs
 dYyYA4ct3vtFe51ylKGd9MwvJZ9HIG6NfykokpF4rH5O+jcqDKgxyMjcUXYmEm+v7IO38rqWy
 NRUgChfwaPgkwOB1teKylQTdEcxxrdkqVFgaFMZ61WmhBx16gesKvtvLuVz+I0uSIK11B7TfS
 Yv7spDnCk9nAm2hUhGl+KuLCRE7+eJm0WruFH99Gbw9h44uL1WK9qJ5EmPjvEz2YWi888G2qA
 w3ygtHwOQOXemLoRK8ErqTHEEkA=
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



Am 18=2E Dezember 2023 22:48:43 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Heinrich,
>
>On Mon, 18 Dec 2023 at 14:37, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>>
>>
>> Am 18=2E Dezember 2023 22:03:41 MEZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
>> >Hi Heinrich,
>> >
>> >On Mon, 18 Dec 2023 at 13:00, Heinrich Schuchardt <xypron=2Eglpk@gmx=
=2Ede> wrote:
>> >>
>> >>
>> >>
>> >> Am 18=2E Dezember 2023 19:12:11 MEZ schrieb Simon Glass <sjg@chromiu=
m=2Eorg>:
>> >> >Hi Heinrich,
>> >> >
>> >> >On Sat, 16 Dec 2023 at 12:04, Heinrich Schuchardt <xypron=2Eglpk@gm=
x=2Ede> wrote:
>> >> >>
>> >> >> On 12/16/23 19:01, Simon Glass wrote:
>> >> >> > Hi,
>> >> >> >
>> >> >> > This records my thoughts after a discussion with Ilias & Heinri=
ch re
>> >> >> > memory allocation in U-Boot=2E
>> >> >> >
>> >> >> > 1=2E malloc()
>> >> >> >
>> >> >> > malloc() is used for programmatic memory allocation=2E It allow=
s memory
>> >> >> > to be freed=2E It is not designed for very large allocations (e=
=2Eg=2E a
>> >> >> > 10MB kernel or 100MB ramdisk)=2E
>> >> >> >
>> >> >> > 2=2E lmb
>> >> >> >
>> >> >> > lmb is used for large blocks of memory, such as those needed fo=
r a
>> >> >> > kernel or ramdisk=2E Allocation is only transitory, for the pur=
poses of
>> >> >> > loading some images and booting=2E If the boot fails, then all =
lmb
>> >> >> > allocations go away=2E
>> >> >> >
>> >> >> > lmb is set up by getting all available memory and then removing=
 what
>> >> >> > is used by U-Boot (code, data, malloc() space, etc=2E)
>> >> >> >
>> >> >> > lmb reservations have a few flags so that areas of memory can b=
e
>> >> >> > provided with attributes
>> >> >> >
>> >> >> > There are some corner cases=2E=2E=2Ee=2Eg=2E loading a file doe=
s an lmb
>> >> >> > allocation but only for the purpose of avoiding a file being lo=
aded
>> >> >> > over U-Boot code/data=2E The allocation is dropped immediately =
after the
>> >> >> > file is loaded=2E Within the bootm command, or when using stand=
ard boot,
>> >> >> > this would be fairly easy to solve=2E
>> >> >> >
>> >> >> > Linux has renamed lmb to memblock=2E We should consider doing t=
he same=2E
>> >> >> >
>> >> >> > 3=2E EFI
>> >> >> >
>> >> >> > EFI has its own memory-allocation tables=2E
>> >> >> >
>> >> >> > Like lmb, EFI is able to deal with large allocations=2E But via=
 a 'pool'
>> >> >> > function it can also do smaller allocations similar to malloc()=
,
>> >> >> > although each one uses at least 4KB at present=2E
>> >> >> >
>> >> >> > EFI allocations do not go away when a boot fails=2E
>> >> >> >
>> >> >> > With EFI it is possible to add allocations post facto, in which=
 case
>> >> >> > they are added to the allocation table just as if the memory wa=
s
>> >> >> > allocated with EFI to begin with=2E
>> >> >> >
>> >> >> > The EFI allocations and the lmb allocations use the same memory=
, so in
>> >> >> > principle could conflict=2E
>> >> >> >
>> >> >> > EFI allocations are sometimes used to allocate internal U-Boot =
data as
>> >> >> > well, if needed by the EFI app=2E For example, while efi_image_=
parse()
>> >> >> > uses malloc(), efi_var_mem=2Ec uses EFI allocations since the c=
ode runs
>> >> >> > in the app context and may need to access the memory after U-Bo=
ot has
>> >> >> > exited=2E Also efi_smbios=2Ec uses allocate_pages() and then ad=
ds a new
>> >> >> > mapping as well=2E
>> >> >> >
>> >> >> > EFI memory has attributes, including what the memory is used fo=
r (to
>> >> >> > some degree of granularity)=2E See enum efi_memory_type and str=
uct
>> >> >> > efi_mem_desc=2E In the latter there are also attribute flags - =
whether
>> >> >> > memory is cacheable, etc=2E
>> >> >> >
>> >> >> > EFI also has the x86 idea of 'conventional' memory, meaning (I
>> >> >> > believe) that below 4GB that isn't reserved for the hardware/sy=
stem=2E
>> >> >> > This is meaningless, or at least confusing, on ARM systems=2E
>> >> >> >
>> >> >> > 4=2E reservations
>> >> >> >
>> >> >> > It is perhaps worth mentioning a fourth method of memory manage=
ment,
>> >> >> > where U-Boot reserves chunks of memory before relocation (in
>> >> >> > board_init_f=2Ec), e=2Eg=2E for the framebuffer, U-Boot code, t=
he malloc()
>> >> >> > region, etc=2E
>> >> >> >
>> >> >> >
>> >> >> > Problems
>> >> >> > =E2=80=94-------
>> >> >> >
>> >> >> > There are no urgent problems, but here are some things that cou=
ld be improved:
>> >> >> >
>> >> >> > 1=2E EFI should attach most of its data structures to driver mo=
del=2E This
>> >> >> > work has started, with the partition support, but more effort w=
ould
>> >> >> > help=2E This would make it easier to see which memory is relate=
d to
>> >> >> > devices and which is separate=2E
>> >> >> >
>> >> >> > 2=2E Some drivers do EFI reservations today, whether EFI is use=
d for
>> >> >> > booting or not (e=2Eg=2E rockchip video rk_vop_probe())=2E
>> >> >>
>> >> >> Hello Simon,
>> >> >>
>> >> >> thank you for summarizing our discussion=2E
>> >> >>
>> >> >> Some U-Boot drivers including rockchip video inform the EFI sub-s=
ystem
>> >> >> that memory is reserved=2E
>> >> >>
>> >> >> Furthermore drivers like arch/arm/mach-bcm283x/reset=2Ec exist th=
at are
>> >> >> still used after ExitBootServices=2E mmio addresses have to be up=
dated
>> >> >> when Linux creates its virtual memory map=2E Currently this is do=
ne via
>> >> >> efi_add_runtime_mmio()=2E A more UEFI style method would be to re=
gister an
>> >> >> event handler for ExitBootServices() and use ConvertPointer() in =
the
>> >> >> event handler=2E
>> >> >>
>> >> >> >
>> >> >> > 3=2E U-Boot doesn't really map arch-specific memory attributes =
(e=2Eg=2E
>> >> >> > armv8's struct mm_region) to EFI ones=2E
>> >> >>
>> >> >> U-Boot fails to set up RWX properties=2E E=2Eg=2E the region wher=
e a FIT image
>> >> >> is loaded should not be executable=2E
>> >> >>
>> >> >> >
>> >> >> > 4=2E EFI duplicates some code from bootm, some of which relates=
 to
>> >> >> > memory allocation (e=2Eg=2E FDT fixup)=2E
>> >> >>
>> >> >> Fixup code is not duplicated but invoked via image_setup_libfdt()=
=2E
>> >> >>
>> >> >> >
>> >> >> > 5=2E EFI code is used even if EFI is never used to boot
>> >> >>
>> >> >>
>> >> >> * Only a minimum initialization of the EFI sub-system happens in
>> >> >> efi_init_early()=2E
>> >> >> * Some EFI code is called when probing block devices because we w=
anted
>> >> >> the EFI and the dm part to be integrated=2E
>> >> >> * The rest of the initialization in efi_init_obj_list() is only i=
nvoked
>> >> >> if an EFI command is invoked=2E
>> >> >>
>> >> >> >
>> >> >> > 6=2E EFI allocations can result in the same memory being used a=
s has
>> >> >> > already been allocated by lmb=2E Users may load files which ove=
rwrite
>> >> >> > memory allocated by EFI=2E
>> >> >>
>> >> >> The most worrisome issue is that EFI may allocate memory where U-=
Boot
>> >> >> has loaded files like initrd as the EFI sub-system is never infor=
med
>> >> >> which memory is used for files=2E
>> >> >>
>> >> >> Loading files should not be possible without creating a memory
>> >> >> reservation that becomes visible to the EFI sub-system=2E
>> >> >>
>> >> >> >
>> >> >> >
>> >> >> > Lifetime
>> >> >> > --------
>> >> >> >
>> >> >> > We have three different memory allocators with different purpos=
es=2E Can
>> >> >> > we unify them a little?
>> >> >> >
>> >> >> > Within U-Boot:
>> >> >> > - malloc() space lives forever
>> >> >> > - lmb lives while setting out images for booting
>> >> >> > - EFI (mostly) lives while booting an EFI app
>> >> >> >
>> >> >> > In practice, EFI is set up early in U-Boot=2E Some of this is n=
ecessary,
>> >> >> > some not=2E EFI allocations stay around forever=2E This works O=
K since
>> >> >> > large allocations are normally not done in EFI, so memory isn't=
 really
>> >> >> > consumed to any great degree by the boot process=2E
>> >> >>
>> >> >> U-Boot can load EFI drivers which stay resident in memory after t=
he
>> >> >> efi_main() method has returned to U-Boot=2E The next EFI applicat=
ion then
>> >> >> may use the driver=2E Therefore is essential that the EFI subsyst=
em has
>> >> >> access to a valid memory model at all times=2E
>> >> >>
>> >> >> >
>> >> >> > What happens to EFI allocations if the app returns? They are st=
ill
>> >> >> > present, in case another app is run=2E This seems fine=2E
>> >> >> >
>> >> >> > API
>> >> >> > =E2=80=93--
>> >> >> > Can we unify some APIs?
>> >> >> >
>> >> >> > It should be possible to use lmb for large EFI memory allocatio=
ns, so
>> >> >> > long as they are only needed for booting=2E We effectively do t=
his
>> >> >> > today, since EFI does not manage the arrangement of loaded imag=
es in
>> >> >> > memory=2E for the most part=2E
>> >> >> >
>> >> >> > It would not make sense to use EFI allocation to replace lmb an=
d
>> >> >> > malloc(), of course=2E
>> >> >> >
>> >> >> > Could we use a common (lower-level) API for allocation, used by=
 both
>> >> >> > lmb and EFI? They do have some similarities=2E However they hav=
e
>> >> >> > different lifetime constraints (EFI allocations are never dropp=
ed,
>> >> >> > unlikely lmb)=2E
>> >> >>
>> >> >> The way lmb is used is a deficiency of U-Boot=2E E=2Eg=2E you can=
 load an
>> >> >> initrd that overwrites the previously loaded kernel and then try =
to boot=2E
>> >> >>
>> >> >> What we need is a common memory management library where allocati=
ons are
>> >> >> never dropped and which is used by all file loads=2E
>> >> >>
>> >> >> >
>> >> >> > ** Overall, it seems that the existence of memory allocation in
>> >> >> > boot-time services has created confusion=2E Memory allocation i=
s
>> >> >> > muddled, with both U-Boot code and boot-time services calling t=
he same
>> >> >> > memory allocator=2E This just has not been clearly thought out=
=2E
>> >> >> >
>> >> >>
>> >> >> We have to implement what the UEFI specification requires=2E Some
>> >> >> boot-time services must allocate memory via AllocatePool() or
>> >> >> AllocatePages() because that memory is handed out to the caller o=
f an
>> >> >> API function and it is the callers obligation to free the memory =
via
>> >> >> FreePool() or FreePages()=2E
>> >> >>
>> >> >> >
>> >> >> > Proposal
>> >> >> > =E2=80=94-------
>> >> >> >
>> >> >> > Here are some ideas:
>> >> >> >
>> >> >> > 1=2E For video, use the driver model API to locate the video re=
gions, or
>> >> >> > block off the entire framebuffer memory, for all devices as a w=
hole=2E
>> >> >> > Use efi_add_memory_map()
>> >> >>
>> >> >> When video memory is located higher than the stack the EFI sub-sy=
stem
>> >> >> will not make use of the memory=2E
>> >> >>
>> >> >> >
>> >> >> > 2=2E Add memory attributes to UCLASS_RAM and use them in EFI, m=
apping to
>> >> >> > the EFI_MEMORY_=2E=2E=2E attributes in struct efi_mem_desc=2E
>> >> >> >
>> >> >> > 3=2E Add all EFI reservations just before booting the app, as w=
e do with
>> >> >> > devicetree fixup=2E With this model, malloc() and lmb are used =
for all
>> >> >> > allocation=2E Then efi_add_memory_map() is called for each regi=
on in
>> >> >> > turn just before booting=2E Memory attributes are dealt with ab=
ove=2E The
>> >> >> > type (enum efi_memory_type) can be determined simply by the dat=
a
>> >> >> > structure stored in it, as is done today=2E For example, SMBIOS=
 tables
>> >> >> > can use EFI_ACPI_RECLAIM_MEMORY=2E Very few types are used and =
EFI code
>> >> >> > understands the meaning of each=2E
>> >> >>
>> >> >> This would require a permanent storage of the reservations=2E Kee=
p it
>> >> >> easy, unify the memory management and make it persistent=2E
>> >> >>
>> >> >> >
>> >> >> > 4=2E Avoid setting up EFI memory at the start of U-Boot=2E Do i=
t only when
>> >> >> > booting=2E This looks to require very little effort=2E
>> >> >>
>> >> >> There is no such thing as EFI memory=2E We only have one physical=
 memory
>> >> >> that we have to keep track of=2E
>> >> >>
>> >> >> It is not possible to set up the EFI memory map if you don't keep=
 track
>> >> >> of all memory allocations including all file loads over the whole
>> >> >> lifetime of U-Boot=2E
>> >> >>
>> >> >> >
>> >> >> > 5=2E Avoid calling efi_allocate_pages() and efi_allocate_pool()=
 outside
>> >> >> > boot-time services=2E This solves the problem 6=2E If memory is=
 needed by
>> >> >> > an app, allocate it with malloc() and see 3=2E There are only t=
wo
>> >> >> > efi_allocate_pages() (smbios and efi_runtime)=2E There are more=
 calls of
>> >> >> > efi_allocate_pool(), but most of these seem easy to fix up=2E F=
or
>> >> >> > example, efi_init_event_log() allocates a buffer, but this can =
be
>> >> >> > allocated in normal malloc() space or in a bloblist=2E
>> >> >>
>> >> >> If we have a unified memory allocation layer, efi_allocate_pages(=
) and
>> >> >> efi_allocate_pool() will be implemented by calls into that layer =
and
>> >> >> issue 6) will vanish=2E
>> >> >>
>> >> >> >
>> >> >> > 6=2E Don't worry too much about whether EFI will be used for bo=
oting=2E
>> >> >> > The cost is likely not that great: use bootstage to measure it =
as is
>> >> >> > done for driver model=2E Try to minmise the cost of its tables,
>> >> >> > particularly for execution time, but otherwise just rely on the
>> >> >> > ability to disable EFI_LOADER=2E
>> >> >>
>> >> >> The time intensive part of having EFI enabled is scanning file sy=
stems
>> >> >> for boot files and capsules=2E
>> >> >
>> >> >Thank you for your thoughts on this=2E
>> >> >
>> >> >It does not look like my write-up has helped at all with getting
>> >> >aligned on this=2E Do you have any other ideas?
>> >> >
>> >> >Perhaps we could at least figure out the 'allocation lifetime'
>> >> >approach? It seems clear to me that we have allocations with short
>> >> >lifetimes (e=2Eg=2E kernel & ramdisk allocations will remain in eff=
ect
>> >> >only when booting)=2E Do you agree with that?
>> >>
>> >> We agree that we want to have a unified memory management=2E
>> >>
>> >> Memory management implies that memory allocations remain in effect u=
ntil the memory is freed=2E
>> >>
>> >> This must be true for all allocations whether it is for a kernel, a =
ramdisk, for loading a file, for an allocation by an EFI binary, or for any=
thing else=2E
>> >>
>> >> If boot commands like bootm allocate memory and free it after a fail=
ure, that time will be short=2E
>> >>
>> >> If a file is loaded and never unloaded that memory allocation must s=
tay until the OS takes over memory management=2E This is what is missing in=
 U-Boot=2E
>> >
>> >I see that more as a reservation than an allocation=2E The 'load'
>> >command can never do a useful memory allocation, since the user may
>> >want to load a different file to the same address=2E
>>
>> We lack an unload command to free the memory=2E
>>
>> >
>> >We don't 'free' memory reserved for the kernel/ramdisk=2E=2E=2Ethe
>> >allocation is only temporary=2E This is what we need to align on=2E Th=
ose
>> >allocations should be collated and reported to EFI before booting,
>> >then dropped if the boot fails=2E This in fact works today, with lmb, =
so
>> >we should not need to change it=2E
>>
>> Tempory allocations must use a free=2E This is trivial to implement=2E
>
>I 100% disagree, sorry=2E We don't want to deal with
>memory-fragmentation issues, etc=2E This is not an aloc()/free()
>situation=2E It is an 'image layout' problem=2E
>
>We need to align on this point before we can make any progress=2E
>
>>
>> >
>> >Trying to bring in alloc/free semantics for lmb seems unnecessary and
>> >confusing=2E Let's keep in mind the problem we are trying to solve=2E =
With
>> >bootstd we can set up an lmb and place everything that is needed (in
>> >the read_all() method), then boot=2E
>>
>> The problem we want to solve is that we don't have a proper memory mana=
genent=2E
>>
>> The current lmb usage is obviously not memory management and must be re=
placed by alloc/free semantics=2E
>
>As above=2E That statement is completely wrong from my POV, sorry=2E

I have absolutely no clue why throwing away allocations in lmb should be b=
eneficial=2E The EFI subsystem needs to know which memory contains a loaded=
 file or it might pass out that very same memory to EFI binaries=2E=20

Take the following user input:

load host 0:1 $a fdt
load host 0:1 $b driver=2Eefi
bootefi $b
load host 0:1 $c kernel=2Eefi
bootefi $c $a

We must ensure that memory at $a is not been used by driver=2Eefi when cal=
ling AllocatePages()=2E This requires a memory allocation by the load comma=
nd=2E

Or take:

load host 0:1 $c kernel=2Eefi
load host 0:1 $d initrd=2Eimg

How could we ensure that initrd=2Eimg is not overwriting a part of kernel=
=2Eefi without memory allocation?

You immediately comprehend that our use of lmb is broken=2E

Beat regards

Heinrich
