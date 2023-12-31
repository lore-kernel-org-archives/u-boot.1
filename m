Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9C9C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3DF487885;
	Sun, 31 Dec 2023 16:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="F7Ldtgc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE078788A; Sun, 31 Dec 2023 16:40:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EA28785E
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704037207; x=1704642007; i=xypron.glpk@gmx.de;
 bh=A8KP2G/9fZIKAK5HSgjZoqs37b7ic153llsfBRjx7v4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=F7Ldtgc94sUD1wM89e0HT20SIpI8jJaeSLCL4YFzMVl7LGABldZDVbgszIkueCiQ
 lpTuXXF615k6e9Lj1I7de2UZOOT0LWMRnpjjRK6z0iDN7zQhECxCiirjxnJ3Zw5UI
 uzHtZKIhxBQz0Brfzqm9Y28+Zl7TxK4Pn1P409mKgySgodi98Mk89Gv4CLtQjKmx6
 zwyUU9f4WbvfJUpIy4hgfEGuv3Ji+LQVoLmhUBX86Noux3s0Q5IeDQXcqwU5wdo1Y
 wB+heSeMQZABQDEIWhJ4om9potArpU2fgmMFUrERIdJI0XQfxampd2YToCo8mBNTl
 F0OQXX3gGgjSZ3SMow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1qpuUs2FdN-00nzlK; Sun, 31
 Dec 2023 16:40:07 +0100
Date: Sun, 31 Dec 2023 16:40:06 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
Subject: Re: Proposal: U-Boot memory management
User-Agent: K-9 Mail for Android
In-Reply-To: <20231231151144.GD2652760@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
 <20231229154307.GS2652760@bill-the-cat>
 <7CDAA354-803C-4AFD-BD38-F432B811DB96@gmx.de>
 <20231229161744.GU2652760@bill-the-cat>
 <871qb4nbtc.fsf@bloch.sibelius.xs4all.nl>
 <20231229175215.GY2652760@bill-the-cat>
 <CAFLszTjXrmhOBeMvGfpy3mfZujNrCu2BKmUbEYz-rmxwyWdg3A@mail.gmail.com>
 <20231231135357.GZ2652760@bill-the-cat>
 <CAFLszTgCSDsobu9ak495vnRP-bjakK5Ytxd5YXro0-7GmYj9vA@mail.gmail.com>
 <20231231151144.GD2652760@bill-the-cat>
Message-ID: <5599D28A-0255-4352-93E6-1095743F8983@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ffG9tgzhBkUmoIfpFSDv3bye8vxMyWCB2li3RzC5bdQYnQCWjfy
 6YxY3kOSW8XBaNnsQymMlcvNJNragFFxZ5S1/OLR5xrJd8zmgfhZ7IrWSuleiEl/s4LLbwL
 /R4E12VuPp1S71g4+ZIdEn8ov06BBOodIh6GpDUytIYwi7+ZnuPSw33S9alyVgn9LvHscas
 7Z7zpokMmg3tiIBInhf0Q==
UI-OutboundReport: notjunk:1;M01:P0:sO7a32kNPRI=;60hEXZBgdijbr7NQO7f7GBwKd+y
 Af2MVEWoJCZAd7zEoUM79KIz76ZpfN2iQFMZrDl08jYRS8hPhfzEYQxBTPN2tNOUNztw9Qs6s
 /VytsCRAb2NO9QOBlmcPAPYSUZ2zyWLyydB9lf26/2jrltQrhiR1urqaKg312hczyT/Kq7dWC
 Si3Zzv4aUP+q2nkpGyie6IJ3eHAQUwNSMOeBvD2jWPcwnDyg9gl6sVFDPLGmSjHlIESBpVmYq
 I5kURPkPCbKTtfMeP2/EPixHo0Ocn57z7bEP67KgzH96jXoLhZ/UQ3HZGB6w5uEM1SkyR262b
 9v23l/ubPoN8HLS+t4ALqn3wKtP2EmsnDgPzHFig1LfOshqnAbEUf9ZQB0zaAcOK8c0TL+YWo
 E6+cWlHtlxDLvB5YTWcXbEUSTEdm0L41qz4G7Ctub6ca9D2Fj+g3s93gjL/Qx1thqJwN6Mh5C
 NeFObXfvsmthDBc6eqqN/Jj7LW1z8n4VKC6c++ASz1dFUDp1DTfFysHVhG2HqEl80Wa8D9Hqy
 RFNKVpWfDLl58iZqtWAOHlaGsERNy68IFfQ+o8XtdH2520WSahRwzPedWQNM0jWxRgk8w7DZL
 LSMLUSHpdqsLwKXFrul14EDa+bTr+E8VLZemMNJylp4smTpoz6zEnOzoSFTeJQJ/XdnYhuXLe
 mcK7llkcTIyvnHSOqfH6MnD69NhXf4saVFLCaJw9IECkIsE7Grt6ZfKbw+K931kQ1pfQiJ6D1
 DqX5LI64biqjzmwbwunhyIN7IvIi4Z8KVZSk+3msLI1cv4+lP0TceKySPZYINkSJUe7zzW5sP
 FfzP8Galngn9KJqvHxZvmZ1JIDi/UpFZ6lrV7K4cqhMizhXNT56oF5nA8nj0TULjrR8isI+Bd
 rTHIFoHSjxPafrBUd9q1C3KGG61m5orMo0Uweh9YO0CrgfkCiHGEGAM9sE+4ZVu5qqn4/lhH/
 JbX0kg==
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



Am 31=2E Dezember 2023 16:11:44 MEZ schrieb Tom Rini <trini@konsulko=2Ecom=
>:
>On Sun, Dec 31, 2023 at 07:22:10AM -0700, Simon Glass wrote:
>> Hi Tom,
>>=20
>> On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@konsulko=2Ecom>=
 wrote:
>> >
>> > On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wrote:
>> > > Hi,
>> > >
>> > > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini@konsulko=
=2Ecom> wrote:
>> > > >
>> > > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis wrote:
>> > > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
>> > > > > > From: Tom Rini <trini@konsulko=2Ecom>
>> > > > > >
>> > > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Schuchardt=
 wrote:
>> > > > > > >
>> > > > > > >
>> > > > > > > Am 29=2E Dezember 2023 16:43:07 MEZ schrieb Tom Rini <trini=
@konsulko=2Ecom>:
>> > > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass wrot=
e:
>> > > > > > > >> Hi,
>> > > > > > > >>
>> > > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sjg=
@chromium=2Eorg> wrote:
>> > > > > > > >> >
>> > > > > > > >> > Hi,
>> > > > > > > >> >
>> > > > > > > >> > This records my thoughts after a discussion with Ilias=
 & Heinrich re
>> > > > > > > >> > memory allocation in U-Boot=2E
>> > > > > > > >> >
>> > > > > > > >> > 1=2E malloc()
>> > > > > > > >> >
>> > > > > > > >> > malloc() is used for programmatic memory allocation=2E=
 It allows memory
>> > > > > > > >> > to be freed=2E It is not designed for very large alloc=
ations (e=2Eg=2E a
>> > > > > > > >> > 10MB kernel or 100MB ramdisk)=2E
>> > > > > > > >> >
>> > > > > > > >> > 2=2E lmb
>> > > > > > > >> >
>> > > > > > > >> > lmb is used for large blocks of memory, such as those =
needed for a
>> > > > > > > >> > kernel or ramdisk=2E Allocation is only transitory, fo=
r the purposes of
>> > > > > > > >> > loading some images and booting=2E If the boot fails, =
then all lmb
>> > > > > > > >> > allocations go away=2E
>> > > > > > > >> >
>> > > > > > > >> > lmb is set up by getting all available memory and then=
 removing what
>> > > > > > > >> > is used by U-Boot (code, data, malloc() space, etc=2E)
>> > > > > > > >> >
>> > > > > > > >> > lmb reservations have a few flags so that areas of mem=
ory can be
>> > > > > > > >> > provided with attributes
>> > > > > > > >> >
>> > > > > > > >> > There are some corner cases=2E=2E=2Ee=2Eg=2E loading a=
 file does an lmb
>> > > > > > > >> > allocation but only for the purpose of avoiding a file=
 being loaded
>> > > > > > > >> > over U-Boot code/data=2E The allocation is dropped imm=
ediately after the
>> > > > > > > >> > file is loaded=2E Within the bootm command, or when us=
ing standard boot,
>> > > > > > > >> > this would be fairly easy to solve=2E
>> > > > > > > >> >
>> > > > > > > >> > Linux has renamed lmb to memblock=2E We should conside=
r doing the same=2E
>> > > > > > > >> >
>> > > > > > > >> > 3=2E EFI
>> > > > > > > >> >
>> > > > > > > >> > EFI has its own memory-allocation tables=2E
>> > > > > > > >> >
>> > > > > > > >> > Like lmb, EFI is able to deal with large allocations=
=2E But via a 'pool'
>> > > > > > > >> > function it can also do smaller allocations similar to=
 malloc(),
>> > > > > > > >> > although each one uses at least 4KB at present=2E
>> > > > > > > >> >
>> > > > > > > >> > EFI allocations do not go away when a boot fails=2E
>> > > > > > > >> >
>> > > > > > > >> > With EFI it is possible to add allocations post facto,=
 in which case
>> > > > > > > >> > they are added to the allocation table just as if the =
memory was
>> > > > > > > >> > allocated with EFI to begin with=2E
>> > > > > > > >> >
>> > > > > > > >> > The EFI allocations and the lmb allocations use the sa=
me memory, so in
>> > > > > > > >> > principle could conflict=2E
>> > > > > > > >> >
>> > > > > > > >> > EFI allocations are sometimes used to allocate interna=
l U-Boot data as
>> > > > > > > >> > well, if needed by the EFI app=2E For example, while e=
fi_image_parse()
>> > > > > > > >> > uses malloc(), efi_var_mem=2Ec uses EFI allocations si=
nce the code runs
>> > > > > > > >> > in the app context and may need to access the memory a=
fter U-Boot has
>> > > > > > > >> > exited=2E Also efi_smbios=2Ec uses allocate_pages() an=
d then adds a new
>> > > > > > > >> > mapping as well=2E
>> > > > > > > >> >
>> > > > > > > >> > EFI memory has attributes, including what the memory i=
s used for (to
>> > > > > > > >> > some degree of granularity)=2E See enum efi_memory_typ=
e and struct
>> > > > > > > >> > efi_mem_desc=2E In the latter there are also attribute=
 flags - whether
>> > > > > > > >> > memory is cacheable, etc=2E
>> > > > > > > >> >
>> > > > > > > >> > EFI also has the x86 idea of 'conventional' memory, me=
aning (I
>> > > > > > > >> > believe) that below 4GB that isn't reserved for the ha=
rdware/system=2E
>> > > > > > > >> > This is meaningless, or at least confusing, on ARM sys=
tems=2E
>> > > > > > > >> >
>> > > > > > > >> > 4=2E reservations
>> > > > > > > >> >
>> > > > > > > >> > It is perhaps worth mentioning a fourth method of memo=
ry management,
>> > > > > > > >> > where U-Boot reserves chunks of memory before relocati=
on (in
>> > > > > > > >> > board_init_f=2Ec), e=2Eg=2E for the framebuffer, U-Boo=
t code, the malloc()
>> > > > > > > >> > region, etc=2E
>> > > > > > > >> >
>> > > > > > > >> >
>> > > > > > > >> > Problems
>> > > > > > > >> > =E2=80=94-------
>> > > > > > > >> >
>> > > > > > > >> > There are no urgent problems, but here are some things=
 that could be improved:
>> > > > > > > >> >
>> > > > > > > >> > 1=2E EFI should attach most of its data structures to =
driver model=2E This
>> > > > > > > >> > work has started, with the partition support, but more=
 effort would
>> > > > > > > >> > help=2E This would make it easier to see which memory =
is related to
>> > > > > > > >> > devices and which is separate=2E
>> > > > > > > >> >
>> > > > > > > >> > 2=2E Some drivers do EFI reservations today, whether E=
FI is used for
>> > > > > > > >> > booting or not (e=2Eg=2E rockchip video rk_vop_probe()=
)=2E
>> > > > > > > >> >
>> > > > > > > >> > 3=2E U-Boot doesn't really map arch-specific memory at=
tributes (e=2Eg=2E
>> > > > > > > >> > armv8's struct mm_region) to EFI ones=2E
>> > > > > > > >> >
>> > > > > > > >> > 4=2E EFI duplicates some code from bootm, some of whic=
h relates to
>> > > > > > > >> > memory allocation (e=2Eg=2E FDT fixup)=2E
>> > > > > > > >> >
>> > > > > > > >> > 5=2E EFI code is used even if EFI is never used to boo=
t
>> > > > > > > >> >
>> > > > > > > >> > 6=2E EFI allocations can result in the same memory bei=
ng used as has
>> > > > > > > >> > already been allocated by lmb=2E Users may load files =
which overwrite
>> > > > > > > >> > memory allocated by EFI=2E
>> > > > > > > >>
>> > > > > > > >> 7=2E We need to support doing an allocation when a file =
is loaded (to
>> > > > > > > >> ensure files do not overlap), without making it too diff=
icult to load
>> > > > > > > >> multiple files to the same place, if desired=2E
>> > > > > > > >>
>> > > > > > > >> >
>> > > > > > > >> >
>> > > > > > > >> > Lifetime
>> > > > > > > >> > --------
>> > > > > > > >> >
>> > > > > > > >> > We have three different memory allocators with differe=
nt purposes=2E Can
>> > > > > > > >> > we unify them a little?
>> > > > > > > >> >
>> > > > > > > >> > Within U-Boot:
>> > > > > > > >> > - malloc() space lives forever
>> > > > > > > >> > - lmb lives while setting out images for booting
>> > > > > > > >> > - EFI (mostly) lives while booting an EFI app
>> > > > > > > >> >
>> > > > > > > >> > In practice, EFI is set up early in U-Boot=2E Some of =
this is necessary,
>> > > > > > > >> > some not=2E EFI allocations stay around forever=2E Thi=
s works OK since
>> > > > > > > >> > large allocations are normally not done in EFI, so mem=
ory isn't really
>> > > > > > > >> > consumed to any great degree by the boot process=2E
>> > > > > > > >> >
>> > > > > > > >> > What happens to EFI allocations if the app returns? Th=
ey are still
>> > > > > > > >> > present, in case another app is run=2E This seems fine=
=2E
>> > > > > > > >> >
>> > > > > > > >> > API
>> > > > > > > >> > =E2=80=93--
>> > > > > > > >> > Can we unify some APIs?
>> > > > > > > >> >
>> > > > > > > >> > It should be possible to use lmb for large EFI memory =
allocations, so
>> > > > > > > >> > long as they are only needed for booting=2E We effecti=
vely do this
>> > > > > > > >> > today, since EFI does not manage the arrangement of lo=
aded images in
>> > > > > > > >> > memory=2E for the most part=2E
>> > > > > > > >> >
>> > > > > > > >> > It would not make sense to use EFI allocation to repla=
ce lmb and
>> > > > > > > >> > malloc(), of course=2E
>> > > > > > > >> >
>> > > > > > > >> > Could we use a common (lower-level) API for allocation=
, used by both
>> > > > > > > >> > lmb and EFI? They do have some similarities=2E However=
 they have
>> > > > > > > >> > different lifetime constraints (EFI allocations are ne=
ver dropped,
>> > > > > > > >> > unlikely lmb)=2E
>> > > > > > > >> >
>> > > > > > > >> > ** Overall, it seems that the existence of memory allo=
cation in
>> > > > > > > >> > boot-time services has created confusion=2E Memory all=
ocation is
>> > > > > > > >> > muddled, with both U-Boot code and boot-time services =
calling the same
>> > > > > > > >> > memory allocator=2E This just has not been clearly tho=
ught out=2E
>> > > > > > > >> >
>> > > > > > > >> >
>> > > > > > > >> > Proposal
>> > > > > > > >> > =E2=80=94-------
>> > > > > > > >> >
>> > > > > > > >> > Here are some ideas:
>> > > > > > > >> >
>> > > > > > > >> > 1=2E For video, use the driver model API to locate the=
 video regions, or
>> > > > > > > >> > block off the entire framebuffer memory, for all devic=
es as a whole=2E
>> > > > > > > >> > Use efi_add_memory_map()
>> > > > > > > >> >
>> > > > > > > >> > 2=2E Add memory attributes to UCLASS_RAM and use them =
in EFI, mapping to
>> > > > > > > >> > the EFI_MEMORY_=2E=2E=2E attributes in struct efi_mem_=
desc=2E
>> > > > > > > >> >
>> > > > > > > >> > 3=2E Add all EFI reservations just before booting the =
app, as we do with
>> > > > > > > >> > devicetree fixup=2E With this model, malloc() and lmb =
are used for all
>> > > > > > > >> > allocation=2E Then efi_add_memory_map() is called for =
each region in
>> > > > > > > >> > turn just before booting=2E Memory attributes are deal=
t with above=2E The
>> > > > > > > >> > type (enum efi_memory_type) can be determined simply b=
y the data
>> > > > > > > >> > structure stored in it, as is done today=2E For exampl=
e, SMBIOS tables
>> > > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY=2E Very few types are =
used and EFI code
>> > > > > > > >> > understands the meaning of each=2E
>> > > > > > > >> >
>> > > > > > > >> > 4=2E Avoid setting up EFI memory at the start of U-Boo=
t=2E Do it only when
>> > > > > > > >> > booting=2E This looks to require very little effort=2E
>> > > > > > > >> >
>> > > > > > > >> > 5=2E Avoid calling efi_allocate_pages() and efi_alloca=
te_pool() outside
>> > > > > > > >> > boot-time services=2E This solves the problem 6=2E If =
memory is needed by
>> > > > > > > >> > an app, allocate it with malloc() and see 3=2E There a=
re only two
>> > > > > > > >> > efi_allocate_pages() (smbios and efi_runtime)=2E There=
 are more calls of
>> > > > > > > >> > efi_allocate_pool(), but most of these seem easy to fi=
x up=2E For
>> > > > > > > >> > example, efi_init_event_log() allocates a buffer, but =
this can be
>> > > > > > > >> > allocated in normal malloc() space or in a bloblist=2E
>> > > > > > > >> >
>> > > > > > > >> > 6=2E Don't worry too much about whether EFI will be us=
ed for booting=2E
>> > > > > > > >> > The cost is likely not that great: use bootstage to me=
asure it as is
>> > > > > > > >> > done for driver model=2E Try to minmise the cost of it=
s tables,
>> > > > > > > >> > particularly for execution time, but otherwise just re=
ly on the
>> > > > > > > >> > ability to disable EFI_LOADER=2E
>> > > > > > > >>
>> > > > > > > >> 7=2E Add a flag to the 'load' command:
>> > > > > > > >>
>> > > > > > > >> -m <type> - make an lmb allocation for the file
>> > > > > > > >>    <type> is the image type to use (kernel, ramdisk, fla=
t_dt)
>> > > > > > > >>
>> > > > > > > >> any existing allocation for that type will be automatica=
lly freed
>> > > > > > > >> first=2E If <type> is "none" then no freeing is possible=
: any loaded
>> > > > > > > >> images just stack up in lmb=2E
>> > > > > > > >>
>> > > > > > > >> Add an 'lmb' (or memblock) command to allow listing and =
clearing allocations=2E
>> > > > > > > >
>> > > > > > > >I would really not like to change the user interface and i=
nstead simply
>> > > > > > > >handle this with flags to whatever mark/allocation functio=
n is called=2E
>> > > > > > > >You can always overwrite things that are brought in to mem=
ory, you
>> > > > > > > >cannot overwrite U-Boot or our internals=2E Optionally not=
ing that some
>> > > > > > > >previous load to memory has been at least partially overwr=
itten could be
>> > > > > > > >helpful, if it's not too much extra logic=2E
>> > > > > > > >
>> > > > > > >
>> > > > > > > In most use cases users load exactly one file at  each addr=
ess=2E An
>> > > > > > > unload command would be the cleanest way for a user to indi=
cate that
>> > > > > > > he wants to reuse the memory=2E
>> > > > > >
>> > > > > > I very much do not want to change the API=2E There's untold n=
umbers of
>> > > > > > scripts out there and they should continue to work=2E I menti=
oned to Ilias
>> > > > > > off list just now that I'm not against adding a command to ad=
d flags to
>> > > > > > these areas, but I don't think it's worthwhile to prevent ove=
rwrites the
>> > > > > > user did early=2E The biggest long running problem in this sp=
ace was that
>> > > > > > for 32bit ARM we couldn't know where the kernel BSS was going=
 to be and
>> > > > > > so would have ramdisk at the wrong spot and get partially eat=
en, and
>> > > > > > this was hard to figure out=2E The current example is "ooops,
>> > > > > > decompression buffer for Image=2Egz/etc is too close to other=
 things"
>> > > > > > which ends up failing nice and loudly, and in the future once=
 this
>> > > > > > proposal is done we can just dynamically find and use a spot,=
 since
>> > > > > > we'll have that ability finally=2E
>> > > > >
>> > > > > In order to keep the existing interfaces we need lmb to keep tr=
ack of
>> > > > > (at least ) three different states=2E  I think of those as "fre=
e",
>> > > > > "allocated" and "reserved"=2E  The load command would "reserve"=
 memory
>> > > > > insteaf "allocate"=2E  And it would pass a flag to lmb when res=
erving
>> > > > > memory to indicate that reserving memory that is already reserv=
ed is
>> > > > > ok=2E  Both "reserved" and "allocated" memory should show up as=
 not free
>> > > > > in the EFI memory map (probably as EfiLoaderData)=2E
>> > > >
>> > > > Yes, something like this is what I was getting at, thanks=2E
>> > >
>> > > Yes, that is a good way of putting it=2E There is definitely a dist=
inction there=2E
>> > >
>> > > If we don't want this flag, we could make U-Boot always do a
>> > > reservation on load, with a '-f' command to force loading over an
>> > > existing reservation / releasing it first?
>> >
>> > Again, this is an API change and I don't want to change the API=2E
>>=20
>> The flag is only needed to drop a reservation, since we apparently
>> want the 'load' command to create a permanent reservation=2E It should
>> not affect existing boot scripts since they won't load overlapping
>> images=2E
>>=20
>> Anyway, what do you suggest?
>
>That "load" (and sf read and nand read and tftp and wget and =2E=2E=2E)
>"reserve" memory but not "allocate" memory and "reserve" means something
>is there and "allocate" means that it can't be modified again=2E For
>example, running U-Boot and our malloc pool are "allocated" but just
>loading a file to memory is "reserved"=2E  And then yes, I can see use fo=
r
>the command where some cases might want to "reserve" memory to fiddle
>with it and then "allocate" it so something else can't change it=2E
>
>This is one of those cases where english is terrible to discuss things
>in as both reserve and allocate can mean similar things=2E
>

I have no clue what the semantics of the mentioned "reserved" state might =
be=2E Up to now  memory reservations designated address ranges that U-Boot =
must not use at all, e=2Eg=2E the memory used by OpenSBI or TF-A=2E

Who can and who cannot write into "reserved" memory?

What is wrong about allocating memory for files to forbid any other use un=
til you are done with the file and free the memory?

Best regards

Heinrich
