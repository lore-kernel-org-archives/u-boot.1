Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23F0C47072
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 16:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16DE287A54;
	Fri, 29 Dec 2023 17:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="M74tNvnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B341D87AA2; Fri, 29 Dec 2023 17:05:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E0FA87A01
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 17:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703865918; x=1704470718; i=xypron.glpk@gmx.de;
 bh=Bm2BQsBfYZrQZGSBz9168SB06rsleApndahTrIkDBeY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=M74tNvnPaZ7rRqosMHsOxBLr9HAYgmRTpHa57HWSB1KCZWX85LqPq5TjxWV++SUt
 kksq7qYI4ikO41pj29fwkXamMbfh4SiL4WAVdZHbUIIMLpzrIPeXa6Hi1oIK0or5A
 +o+XE6V3qumlUjMhAKwkbEj3IrVMLMjGBLU1wTNSl2D4zaWeGHos4QhhopRy15th3
 tZVlSTzlXqcW8W1oqqC+Ei85Lrtz+wmMpAdNROeP0kgFZHyiI72n272jIJZ1cuDgT
 hW2UZyGQIc+9/cQforidbWNAw3sgovHTfRBRGjP8hDfe4NxAYsjxRM4VNyQ6Rf4IJ
 UJzzbkVmoQnYY5cHOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17YY-1r7RlE0ERe-012Zud; Fri, 29
 Dec 2023 17:05:18 +0100
Date: Fri, 29 Dec 2023 17:05:17 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Proposal: U-Boot memory management
User-Agent: K-9 Mail for Android
In-Reply-To: <20231229154307.GS2652760@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
 <20231229154307.GS2652760@bill-the-cat>
Message-ID: <7CDAA354-803C-4AFD-BD38-F432B811DB96@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mqJ2oatF2HMGJcOzgl4RlwO3Oc9cRO1tAikmRzoT4gxw+VJpU9m
 TawKEmnlVt9vPfEKOJqrPw9Mbm44Mh03NAp72SugdN3ND/6tneIMQ0yjup4NIxZErvWpdWp
 I+HGAmBGDWojZsMsi2iJze77iXTrPnI75k9xPgkH9mOS+9FvMWKa0QCyJCYcgWdLkPWimYN
 fmJQEJGNS0xhC3aMG00cQ==
UI-OutboundReport: notjunk:1;M01:P0:zKqhcgcqjyo=;dXRazzYMRZgv88GoaQnG1JuIoWg
 SUNGk/RtttKVunbw2esknZJsIZiUC8uSiQievYvu9Gh2AGc+fMboK1m2Z5HuUk4+neSV5tMgH
 Q16oldDXLrSpex1RrLUPoo9/yaCr3wnGbfP5l4dousmDt4SMfTTjLErZ7NwzSvL0PfswNOTet
 gT87pzKNfbGDc2xvRIjaG3BAFsr8G3HqncmeSxW17OWU7xn97MgpFEDPvDjwgBy8vD4t6oW5g
 C8B7I2orp6ZXX3RaaeRMDlRtNqpi1PUIXalIQWU+C2hRyaHX6OWOYco7Stjz+F7rpQvRKnxuG
 95oxYnQXFGXEEQIVlz4Y8GVQc6tdU8pfmJM0TCBsAwP4gGzMaBlVODSdKPoH679iLaP6BhcCZ
 sfs74GlJ62mHPcvD4byGgBObJ7CPyHqVsWMXarxLMeYJ4jnUM3nP7j3mBvPyV/EeIJGqIDaPv
 5HUwf/KH4f5eUr/C2MJgBazu+Yrg1xwneWsHEzu5LvAZyX50RgUTzLaZMA93KgGSbniKRiZw0
 niN7pGeQoayFL0NTMgm41MCO8k1UUQ6zrpRjAPD7rs/WBU1TACaF5kFPcRuj3ownsWdwvOnBh
 UhnGOal4aBuJJ9jzn9M8LUAdFq4A0rNlRZdq5bCq5LQi+35s7869VE/5Ux8ZMLhjWzXJDT5RI
 E1lx/SeFqLP2H7xsbpVKa8pBxxRo8TJkQADPUhLN4jZE2HTbe784qg/TVOe8/gmasAeuHJa4T
 UeHfejs8uYqxHnkEuHRRBuk+fKhZYdehZgSsXIT8dkNObTfdEN9TqWmW1cTXWvnkTPcxWkkpS
 oHwHlwT1lbsVD5E8XKWiYy8tpROnOzXUqo8r8A3WeB7n9WGB2LAk8gYnIAZto0X7e/qL3PTa0
 pgGrayHnfWVfvWNmWSLnH5pBfeBQYrdPnbxQe0rXjlfW7jDW6mp7LexIGcd761vjCBY0xx6Qi
 I0f9Lk2nAICSt6I9w1PWNmT3F8c=
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



Am 29=2E Dezember 2023 16:43:07 MEZ schrieb Tom Rini <trini@konsulko=2Ecom=
>:
>On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass wrote:
>> Hi,
>>=20
>> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium=2Eorg=
> wrote:
>> >
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
>> >
>> > 3=2E U-Boot doesn't really map arch-specific memory attributes (e=2Eg=
=2E
>> > armv8's struct mm_region) to EFI ones=2E
>> >
>> > 4=2E EFI duplicates some code from bootm, some of which relates to
>> > memory allocation (e=2Eg=2E FDT fixup)=2E
>> >
>> > 5=2E EFI code is used even if EFI is never used to boot
>> >
>> > 6=2E EFI allocations can result in the same memory being used as has
>> > already been allocated by lmb=2E Users may load files which overwrite
>> > memory allocated by EFI=2E
>>=20
>> 7=2E We need to support doing an allocation when a file is loaded (to
>> ensure files do not overlap), without making it too difficult to load
>> multiple files to the same place, if desired=2E
>>=20
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
>> >
>> > ** Overall, it seems that the existence of memory allocation in
>> > boot-time services has created confusion=2E Memory allocation is
>> > muddled, with both U-Boot code and boot-time services calling the sam=
e
>> > memory allocator=2E This just has not been clearly thought out=2E
>> >
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
>> >
>> > 4=2E Avoid setting up EFI memory at the start of U-Boot=2E Do it only=
 when
>> > booting=2E This looks to require very little effort=2E
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
>> >
>> > 6=2E Don't worry too much about whether EFI will be used for booting=
=2E
>> > The cost is likely not that great: use bootstage to measure it as is
>> > done for driver model=2E Try to minmise the cost of its tables,
>> > particularly for execution time, but otherwise just rely on the
>> > ability to disable EFI_LOADER=2E
>>=20
>> 7=2E Add a flag to the 'load' command:
>>=20
>> -m <type> - make an lmb allocation for the file
>>    <type> is the image type to use (kernel, ramdisk, flat_dt)
>>=20
>> any existing allocation for that type will be automatically freed
>> first=2E If <type> is "none" then no freeing is possible: any loaded
>> images just stack up in lmb=2E
>>=20
>> Add an 'lmb' (or memblock) command to allow listing and clearing alloca=
tions=2E
>
>I would really not like to change the user interface and instead simply
>handle this with flags to whatever mark/allocation function is called=2E
>You can always overwrite things that are brought in to memory, you
>cannot overwrite U-Boot or our internals=2E Optionally noting that some
>previous load to memory has been at least partially overwritten could be
>helpful, if it's not too much extra logic=2E
>

In most use cases users load exactly one file at  each address=2E An unloa=
d command would be the cleanest way for a user to indicate that he wants to=
 reuse the memory=2E

Best regards

Heinrich
