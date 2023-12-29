Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6F8C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0997387AA2;
	Fri, 29 Dec 2023 18:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UApNMy/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8821787B50; Fri, 29 Dec 2023 18:30:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FFA287A3D
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703871044; x=1704475844; i=xypron.glpk@gmx.de;
 bh=I7dzdHinKkARrVNp4XxZUM5yY41fxhUcSTAm7sWOlTk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=UApNMy/5YNJe94eS38yBV8d3cgWBGq7c0guOJHsMhy+r9UDpeykudlJXbH+6h7gU
 XJM3mhrfStW+lJAwZHVR+QTHo/e2ISnmysZAKE7FZQlrhvZV7gz60yVKZjPxfpFaS
 t6O7rARujHYkGhlSE0oIM24p6nZAk65D+jvFiFmORHw/xvXTY6mjhs2Xi9/PJrrJ2
 tCs8DZ1Z/s4bRScBdhf7XKaUrzcM8KByIIIphsPRUClvvT1evr101wg7v3/Qw9qF7
 Sv8/n+PxFoQMCcGf+jsoLbr8cP32dJOq9lUXPrNBKV1pl62FVkPWBXcq0WqzlvzvI
 Z/KWFNRUnR0h+abiLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.57] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1qhBvD2QXr-00cMe2; Fri, 29
 Dec 2023 18:30:44 +0100
Message-ID: <eeeba72f-d216-4daf-8f1b-055fc638b689@gmx.de>
Date: Fri, 29 Dec 2023 18:30:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal: U-Boot memory management
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
References: <20231218233130.GP2513409@bill-the-cat>
 <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
 <20231219012600.GQ2513409@bill-the-cat>
 <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
 <20231219124553.GS2513409@bill-the-cat>
 <CAPnjgZ1SUoRKEWaK6k1rrVN4t0WLD24GGeRj7uer3A0XA_MKoA@mail.gmail.com>
 <20231220191219.GP2513409@bill-the-cat>
 <be5fb3fc-2ac9-41ae-a1b5-c08441b1cbe2@gmx.de>
 <20231229164724.GV2652760@bill-the-cat>
 <857521d0-780d-47f1-964f-4720ed09492b@gmx.de>
 <20231229172139.GW2652760@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231229172139.GW2652760@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nxQ/oije37e+ENoKsvb92fLJDy+88kzmRT5ze6Zv00o79Xc1EXT
 e2sZbX6BWNW2RluBhko2FjTh9+HXAlkz7pODxCTrLV5JCLIERifOCEuVej0M/CLJcV1pC4h
 Ch8k4dGQC2FiWJ+Jldtc+KAS5QjlaWPCky/7lYI3lGq9GJuTDNbjN0rZ8jJrccmfz6dsw0w
 vG6ZmGb9aPNPABDcGooGg==
UI-OutboundReport: notjunk:1;M01:P0:vdFTHFIzaR4=;7pVherjY/hwraKWpfNX4UZpymzq
 /bO5DZpa/xVKLZ5R4bRzq16MNbpC3KM7Wh3Csnbfu1xQTurcpDPpmALGfkbL7FXO4zBWhitB3
 tPp0SHw+4pg2SfJicFwy5dqLe5tbSSDAvU7FFJA+UwRuPUFe0dOtU6SaKNbeRauVK2uz9LpIb
 vVU88apw7D+OU3aOtZRTskvNBmhD50zxKpcubr4OV1aijviEAuc6QWJwftA3sB23aSDxY+QW0
 2uhPf4FQ5QzEp/sFNE14N5IsDj5r5OC18sj7OvTsiwhKuNXSmtTBvQFlAMOVF5NP++sV9yegt
 FM9EjLMoBsshbz5TR3BFnh2qvP0XgZw8YR/aNMdpSPnGNDBJdeQ01uS25HwhUFPl6QB7zaP8W
 A2rDMtqR3GQMv1HqWOWWBj9bYuc4hG/BYVjDk9q1Wy4t/FTZeQaXSRSZl0HGh2T8qFowFpUcQ
 FCYV+JKj4zhRvPAQO+AoE7fqCCl7ZYZAkM4Nuoo432OHeZbwEg2Z1oLMqGZluT753OPyRQlWj
 1IfR9C+ESPwthO265VX7Jj9zI8lvtcc2263yvefKlTNAqv+62vRqQ+pPOUcaHxlYIfkLRWJz1
 i5MNo2edSptb7aGZPQHaX4uLqmUynckEnMshaHbPBjdnjwjKtB014NQdqDoK+xo6S4WOPF62G
 7CD5OoFBHyRcG66xXtZjmd+3tzotQWCJb41MLh4fT61bv4Gx1yKeG1It0ahOxiLjjdKjFtiP0
 csNIL8vUXGQBWeMUWvdoTAD1n/qExI3+sb0/JrpdAitvlRYKCm0JfFG9lsSEFRCC3HtKUxI68
 XexqYonyeVkWJyjBji/MZ9gE7cfVdP8QBlfk36Ckzrvu2Y9Sqc7d72y++tGsrgrDIQ9m17Lir
 cO7fWxk1hbCsEubw+wYKHCP8PPQDpseLgohxP0piRD5ZzmMhjLsTwtjy90i75EKHY3kfA3EF5
 2KITPYwFAJ+NPN87n+8lVZozgmg=
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

On 12/29/23 18:21, Tom Rini wrote:
> On Fri, Dec 29, 2023 at 06:09:44PM +0100, Heinrich Schuchardt wrote:
>> On 12/29/23 17:47, Tom Rini wrote:
>>> On Fri, Dec 29, 2023 at 05:42:17PM +0100, Heinrich Schuchardt wrote:
>>>> On 12/20/23 20:12, Tom Rini wrote:
>>>>> On Tue, Dec 19, 2023 at 09:15:21PM -0700, Simon Glass wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Tue, 19 Dec 2023 at 05:46, Tom Rini <trini@konsulko.com> wrote:
>>>>>>>
>>>>>>> On Tue, Dec 19, 2023 at 03:15:38AM +0100, Heinrich Schuchardt wrot=
e:
>>>>>>>>
>>>>>>>>
>>>>>>>> Am 19. Dezember 2023 02:26:00 MEZ schrieb Tom Rini <trini@konsulk=
o.com>:
>>>>>>>>> On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schuchardt wr=
ote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Am 19. Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini@konsu=
lko.com>:
>>>>>>>>>>> On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchardt =
wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@kon=
sulko.com>:
>>>>>>>>>>>>> On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchard=
t wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@k=
onsulko.com>:
>>>>>>>>>>>>>>> On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schucha=
rdt wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> [snip]
>>>>>>>>>>>>>>>> Or take:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> load host 0:1 $c kernel.efi
>>>>>>>>>>>>>>>> load host 0:1 $d initrd.img
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> How could we ensure that initrd.img is not overwriting a =
part of kernel.efi without memory allocation?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Today, invalid checksum as part of some part of the kernel=
 fails. But
>>>>>>>>>>>>>>> how do we do this tomorrow, are you suggesting that "load"=
 perform
>>>>>>>>>>>>>>> malloc() in some predefined size? If $c is below $d and $c=
 + kernel.efi
>>>>>>>>>>>>>>> is now above $d we can throw an error before trying to loa=
d, yes. But
>>>>>>>>>>>>>>> what about:
>>>>>>>>>>>>>>> load host 0:1 $d initrd.img
>>>>>>>>>>>>>>> load host 0:1 $c kernel.efi
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> In that case (which is only marginally contrived, the more=
 real case is
>>>>>>>>>>>>>>> loading device tree in to unexpectedly large ramdisk becau=
se someone
>>>>>>>>>>>>>>> didn't understand the general advice on why device tree is=
 lower than
>>>>>>>>>>>>>>> ramdisk address) I'm fine with an error that amounts to "y=
ou just
>>>>>>>>>>>>>>> corrupted another allocation" and then "fail, reset the bo=
ard" or so.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Our current malloc library cannot manage the complete memor=
y. We need a library like lmb which should also cover the memory managemen=
t that we currently have in lib/efi/efi_memory.c. This must include a memo=
ry type attribute for usage in the GetMemoryMap() service. A management on=
 page level seems sufficient.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The load command should permanently allocate memory in that=
 lmb+ library.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> We need an unload command to free the memory if we want to =
reuse the memory or we might let the load comand free the memory if exactl=
y the same start address is reused.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Our current way of loading things in to memory does not hand=
le the case
>>>>>>>>>>>>> I described, yes. How would what you're proposing handle it?
>>>>>>>>>>>>
>>>>>>>>>>>> If the load command has to allocate memory for the image and =
that allocation is kept, any attempt to allocate overlapping memory would =
fail.
>>>>>>>>>>>
>>>>>>>>>>> So you're saying that the load command has to pre-allocate mem=
ory? Or as
>>>>>>>>>>> it goes? If the latter, in what size chunks? This starts to ge=
t at what
>>>>>>>>>>> Simon was talking about with respect to memory fragmentation. =
Which to
>>>>>>>>>>> be clear is a problem we have today, we just let things overla=
p and hope
>>>>>>>>>>> something later catches an incorrect checksum.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I don't want to replace the malloc library which handles large =
numbets of allocations.
>>>>>>>>>
>>>>>>>>> I'm confused. The normal malloc library is not involved with cur=
rent
>>>>>>>>> image loading, it's direct to memory (with some attempts at sani=
ty
>>>>>>>>> checking by lmb).  Are you proposing a different allocator with
>>>>>>>>> malloc/free like behavior? If so, please outline how it will det=
ermine
>>>>>>>>> pool size, and how we'll use it to load thing to memory.
>>>>>>>>
>>>>>>>> All memory below the stack needs to be managed. Malloc uses a sma=
ll memory area (a few MiB) above the stack.
>>>>>>>
>>>>>>> That's a rather huge change for how U-Boot works.
>>>>>>>
>>>>>>>>>> Closing the eyes when the user loads multiple files does not so=
lve the fragmentation problem.
>>>>>>>>>
>>>>>>>>> Yes. I'm only noting that today we just ignore the problem and s=
ometimes
>>>>>>>>> catch it via checksums.
>>>>>>>>>
>>>>>>>>>> Fragmentation only happens if we have many concurrent allocatio=
ns.  In EFI we are allocating top down. The number of concurrent allocatio=
ns is low. Typically a few dozen at most. After terminating an application=
 these should be freed again.
>>>>>>>>>
>>>>>>>>> OK, so are you saying that we would no longer be loading _to_ a =
location
>>>>>>>>> in memory and instead just be saying "load this thing" and picki=
ng where
>>>>>>>>> dynamically?
>>>>>>>>
>>>>>>>> Both preassigned and allocator assigned adresses are compatible w=
ith memory management.
>>>>>>>>
>>>>>>>> Architectures and binaries have different requirements. On riscv6=
4 you can load Linux kernel, initrd, fdt anywhere. We don't need predefine=
d addresses there. Other architectures have restrictions.
>>>>>>>
>>>>>>> Yes, 64 bit architecture tend to only have alignment requirements =
while
>>>>>>> 32bit architectures have both alignment requirements and some memo=
ry
>>>>>>> window requirement. Whatever we implement here needs to handle bot=
h
>>>>>>> cases.
>>>>>>>
>>>>>>>>>> When loading a file from a file system we know the filesize bef=
orehand. So allocation is trivial.
>>>>>>>>>>
>>>>>>>>>> The loady command currently does not use the  offered size info=
rmation but could do so.
>>>>>>>>>
>>>>>>>>> We should be using that information to make sure we don't overwr=
ite
>>>>>>>>> U-Boot itself, but I don't recall how exactly we handle it today
>>>>>>>>> off-hand.
>>>>>>>>
>>>>>>>> If the user issues multiple load commands, he can overwrite previ=
ous files.
>>>>>>>
>>>>>>> Then it sounds like we lost one benefit of all of this overhead.
>>>>>>>
>>>>>>>> During boot command execution I guess the different allocations r=
espect each other.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> TFTP is problematic because it does not transfer the filesize. =
We would probably try to allocate a large chunk of memory and then downsiz=
e the allocation after reading the whole file.
>>>>>>>>>
>>>>>>>>> Reading from non-filesystem flash also has this problem, but we =
at least
>>>>>>>>> specify the amount to read too. But yes, it gets back to what I =
was
>>>>>>>>> asking about on how you're proposing to handle network load case=
s.
>>>>>>>>>
>>>>>>>>
>>>>>>>> It depends on the protocol. Http conveys the size before the data=
. Tftp does not.
>>>>>>>>
>>>>>>>> If you don't know the size, you must preallocate a big chunk, che=
ck that the download does not exceed it, and downsize the allocation after=
wards. This is not a new problem but exists already with current lmb usage=
.
>>>>>>>
>>>>>>> Yes, and what I'm trying to find out is if what you're suggesting =
would
>>>>>>> do anything about it, since previous statements you made implied t=
o me
>>>>>>> that we would prevent it.
>>>>>>>
>>>>>>> To me, at this point it sounds like what we need is more like pers=
istent
>>>>>>> memory blocks and a hook that can be called in to for both "give m=
e all
>>>>>>> known memory blocks" and "add this memory block to the list", so t=
hat
>>>>>>> EFI can do whatever it needs to do upon starting an application an=
d then
>>>>>>> upon return to U-Boot. Both malloc/free allocations and "load this=
 blob
>>>>>>> to memory from whatever" allocations would call the appropriate ho=
ok for
>>>>>>> tracking.
>>>>>>
>>>>>> In my mind the solution to this entire problem is fairly minor chan=
ges
>>>>>> to how memory is allocated and only for EFI.
>>>>>>
>>>>>> I tried to map out what that would look like and we have IMO got lo=
st
>>>>>> in the weeds a bit.
>>>>>>
>>>>>> I am not trying to solve the problem of the 'load' command doing an
>>>>>> allocation and throwing it away. To be that is WAI, at least until =
we
>>>>>> come up with another type of command. This is one of the reasons fo=
r
>>>>>> standard boot, allowing a more cohesive approach to booting.
>>>>>>
>>>>>> I will think about this some more...
>>>>>
>>>>> OK, but please keep in mind that lmb not being at all persistent is =
a
>>>>> problem for everyone, not just EFI. That really needs to be addresse=
d,
>>>>> maybe with some flags for dis-allowing overwrites to the area. For
>>>>> example, the apple-m1 code to use lmb to find locations for the
>>>>> kernel/etc can be written to more than once (allocate the address, t=
hen
>>>>> write to it to start with, even) but the range that covers U-Boot it=
self
>>>>> (malloc pool and so forth) need to be stopped.
>>>>>
>>>>
>>>> The range managed by the EFI sub-system extends over all of RAM
>>>> including the addresses used by load commands. Hence, "the range that
>>>> covers U-Boot itself (malloc pool and so forth)" includes all memory.
>>>>
>>>> Maybe we could pre-allocate a memory area for file loading. This just
>>>> requires to define a device-specific high file memory address above
>>>> which no file loads will be allowed and below which EFI, bootm, etc w=
ill
>>>> not be allowed to allocate memory for further uses.
>>>
>>> We're not just / only an EFI runtime. When we load something persisten=
t
>>> to memory outside of EFI, we need to note that, so that when EFI_LOADE=
R
>>> beings work it can see this and do whatever it needs to do. And if/whe=
n
>>> EFI_LOADER returns control back to U-Boot itself, it needs to update
>>> that list with any new allocations that were done and mark them
>>> appropriately.
>>
>> The idea of EFI loader returning control is misleading.
>>
>> You can load an EFI driver binary which provides a device to U-Boot.
>> Whenever U-Boot accesses that driver allocations might occur.
>
> We cannot, today, load an EFI driver and then make use of it outside of
> the context of having bootefi'd something, yes?

We already can use iPXE to access iSCSI which provides a U-Boot block
device. But it is an app. A similar binary could be compiled as EFI
driver return to U-Boot and provide a block device to be directly
addressed by the user via the CLI.

>
> Or is this about that separate runtime area from another thread?
>
> But even then, if something is making an allocation it needs to inform
> the rest of the world.

We should have one memory management. When EFI's AllocatPages() or
AllocatePool() is called it should use the same backend as any other
allocation (except for the small region managed by malloc()).

>
>> I thought that we already agreed to have only one memory management and
>> get rid of the LMB/EFI memory management duplication.
>
> We've agreed that today, CONFIG_LMB does not fit the use cases that we
> have in a modern system, for anyones usage. It has been suggested and I
> know it's somewhere on Ilias' TODO list, to try and take what we have
> in the EFI_LOADER & co area and make it usable and useful for all
> contexts. We also have what in some ways feels to me to be the inverse
> of that, which is Simon's proposal.

LMB and efi/loader/efi_memory.c have a big overlap in functionality.

But we use LMB in a unfavorable way discarding all allocations.

Best regards

Heinrich

>
> We have not agreed that the EFI model and restrictions are what
> everything will now be using. What's on Ilias' TODD list might bring us
> in that direction, and I want to see what that looks like in practice.
> But it's not agreed to as the end goal here.
>
> And to be clear, I also would like to see what Simon's proposed, in
> practice.
>

