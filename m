Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACABC47072
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E05E87A3D;
	Fri, 29 Dec 2023 18:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YCGo0LR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 199A487A6E; Fri, 29 Dec 2023 18:09:49 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E266486EF1
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703869785; x=1704474585; i=xypron.glpk@gmx.de;
 bh=b8I+QxLrwXHM3ytrBaYcX0axgzWUIHaIFeNo8fKVqcA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=YCGo0LR35eCuC8/q9oqc/U1S1kJT9YqagOQhkz4+3qt61Tw4lp0o8KdICuDQa3Cy
 DWyLT/C0oJIebtyW+CQQIifZ61GpeHQpnClO8WoOWIYXfYAp2ll9BU0tK5bIBQod7
 igrbig4UUcVPot8t9W+C/S0RSQtEQBACW4lJcR5SalNLrcZ4RLfgd7988KMAwEYdD
 168DD4CX1o79w2wP7soRtqChTPzOAtXT/UhUIwBaOzre2Fswwk5yZl6bniNDLYEg4
 Rm9Ulr5Rp9Zhjp6GCdKBySt50wGHaCUKyJeUXsYbBgJFcztpxfjZiSxVTtL3b2m9j
 tpjJh8PzehFfU9yCHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.57] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1qkzwL0b8O-00h3fD; Fri, 29
 Dec 2023 18:09:45 +0100
Message-ID: <857521d0-780d-47f1-964f-4720ed09492b@gmx.de>
Date: Fri, 29 Dec 2023 18:09:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal: U-Boot memory management
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
References: <20231218231640.GO2513409@bill-the-cat>
 <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
 <20231218233130.GP2513409@bill-the-cat>
 <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
 <20231219012600.GQ2513409@bill-the-cat>
 <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
 <20231219124553.GS2513409@bill-the-cat>
 <CAPnjgZ1SUoRKEWaK6k1rrVN4t0WLD24GGeRj7uer3A0XA_MKoA@mail.gmail.com>
 <20231220191219.GP2513409@bill-the-cat>
 <be5fb3fc-2ac9-41ae-a1b5-c08441b1cbe2@gmx.de>
 <20231229164724.GV2652760@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231229164724.GV2652760@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5uHhTv4xPyX1KHaICq00wvOeu/rDFP61b+o5E+DCEUo6r/IAJH3
 hVS9lTEZfHH5b03PufgJN2ik2nSO86yZ4Ffb5ICUQvKr4lgIOKrruON/w24PCQK2nNLQENS
 pPc7XgRv1wIow2OHycbtF+IsCc/DonoNeZtddR+GJkX5jhN9F4iQgIz1iy0K9HBb1aK30On
 iXdViV7NXVxyUF2cB4LUg==
UI-OutboundReport: notjunk:1;M01:P0:GxUyqcuPq5c=;goGn+/Aw/naC4zlWrD3962LE02i
 alJJ82ghb+Faip99LpcuFqSXZv7nhey1qXNTnT4vMn/1HnBWTpGPv44HW4oq0cmS05LTzePSk
 lbkUUL80Bfs5qrF48uy4s5Fj74AVf0dhA8rOsCw712JUabYCh3AwF5eeYasWrLeLvSp2glMg8
 7h7iXQsT7Pg/falPx0Xfja3ZFk5p27hpM6Ztnp/oBDio+XvNKuIf4O+8EJE1esAo2Smzz+edU
 3ucjJxI7CWhC7Ko5zgATBGaLQslN/QQZcyPcbjA456EPMdeoDQopu4o+7ATtVKTrL6EZclCrd
 ex6wrEPI7jKVchSS36r+0JECOsNltTgxjb1K4SqkzhaeuVKzAjtpRzbE83CbrvXNdbHp+y9+X
 32qYdFkmEYCnryxiF8yi1lP6C4bX8cqR3wNrn4FcfLC2bNT2nlPEU50RaTABR/J3mLSYsdc3F
 CuMm8+F3zYdw6SUp5I9hMOYFMvcSOBmn5EDNuSEYlakc+7z+NHcR2DOODR/Iw6edcQHDt0Pmm
 VxPLhjoqRRpJZp4noaaPhWEyJGheLvhqgTGMjxocaX6YMJf0/YO0DFwxQqzHpIOi+ix4B0ng/
 bx4rSgz09oi/E3MQKykUsoWMYNdxKCjcIjDsZJP8XcYGegHJTVLfja6xu6/c0n0Dx2WOfFYdK
 dkeJGfL/J+4YcLWJYMVk5UpSdQJJBE96jRO3merNCdF/GhuBs2KOfdZnLjRF7OVWUJov0Oiyc
 N77/k+ck06r1sy1Ti6gB1D3KMUUZadJIIfd8qA/38/FG/Q9OrF85c/Sp4l2KlDFHdI+demfrP
 lPNwOcHFbFD4Z8wsF6IXQFdJTzitMqA5gRh2bA809rpd9Qoxlqgfq0ejlUIfiTWzqzJ4Mng85
 TMQEnzVeKkYmobuunty+bF1olCEY/I49QaMaU15ljaqEdpjIOG3YFLBsC9JpepHqa1G63+gYw
 lD/uRvRhZSGLbMI9lDe0tGbckW8=
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

On 12/29/23 17:47, Tom Rini wrote:
> On Fri, Dec 29, 2023 at 05:42:17PM +0100, Heinrich Schuchardt wrote:
>> On 12/20/23 20:12, Tom Rini wrote:
>>> On Tue, Dec 19, 2023 at 09:15:21PM -0700, Simon Glass wrote:
>>>> Hi,
>>>>
>>>> On Tue, 19 Dec 2023 at 05:46, Tom Rini <trini@konsulko.com> wrote:
>>>>>
>>>>> On Tue, Dec 19, 2023 at 03:15:38AM +0100, Heinrich Schuchardt wrote:
>>>>>>
>>>>>>
>>>>>> Am 19. Dezember 2023 02:26:00 MEZ schrieb Tom Rini <trini@konsulko.=
com>:
>>>>>>> On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schuchardt wrot=
e:
>>>>>>>>
>>>>>>>>
>>>>>>>> Am 19. Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini@konsulk=
o.com>:
>>>>>>>>> On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchardt wr=
ote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@konsu=
lko.com>:
>>>>>>>>>>> On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt =
wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@kon=
sulko.com>:
>>>>>>>>>>>>> On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchard=
t wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> [snip]
>>>>>>>>>>>>>> Or take:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> load host 0:1 $c kernel.efi
>>>>>>>>>>>>>> load host 0:1 $d initrd.img
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> How could we ensure that initrd.img is not overwriting a pa=
rt of kernel.efi without memory allocation?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Today, invalid checksum as part of some part of the kernel f=
ails. But
>>>>>>>>>>>>> how do we do this tomorrow, are you suggesting that "load" p=
erform
>>>>>>>>>>>>> malloc() in some predefined size? If $c is below $d and $c +=
 kernel.efi
>>>>>>>>>>>>> is now above $d we can throw an error before trying to load,=
 yes. But
>>>>>>>>>>>>> what about:
>>>>>>>>>>>>> load host 0:1 $d initrd.img
>>>>>>>>>>>>> load host 0:1 $c kernel.efi
>>>>>>>>>>>>>
>>>>>>>>>>>>> In that case (which is only marginally contrived, the more r=
eal case is
>>>>>>>>>>>>> loading device tree in to unexpectedly large ramdisk because=
 someone
>>>>>>>>>>>>> didn't understand the general advice on why device tree is l=
ower than
>>>>>>>>>>>>> ramdisk address) I'm fine with an error that amounts to "you=
 just
>>>>>>>>>>>>> corrupted another allocation" and then "fail, reset the boar=
d" or so.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Our current malloc library cannot manage the complete memory.=
 We need a library like lmb which should also cover the memory management =
that we currently have in lib/efi/efi_memory.c. This must include a memory=
 type attribute for usage in the GetMemoryMap() service. A management on p=
age level seems sufficient.
>>>>>>>>>>>>
>>>>>>>>>>>> The load command should permanently allocate memory in that l=
mb+ library.
>>>>>>>>>>>>
>>>>>>>>>>>> We need an unload command to free the memory if we want to re=
use the memory or we might let the load comand free the memory if exactly =
the same start address is reused.
>>>>>>>>>>>
>>>>>>>>>>> Our current way of loading things in to memory does not handle=
 the case
>>>>>>>>>>> I described, yes. How would what you're proposing handle it?
>>>>>>>>>>
>>>>>>>>>> If the load command has to allocate memory for the image and th=
at allocation is kept, any attempt to allocate overlapping memory would fa=
il.
>>>>>>>>>
>>>>>>>>> So you're saying that the load command has to pre-allocate memor=
y? Or as
>>>>>>>>> it goes? If the latter, in what size chunks? This starts to get =
at what
>>>>>>>>> Simon was talking about with respect to memory fragmentation. Wh=
ich to
>>>>>>>>> be clear is a problem we have today, we just let things overlap =
and hope
>>>>>>>>> something later catches an incorrect checksum.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I don't want to replace the malloc library which handles large nu=
mbets of allocations.
>>>>>>>
>>>>>>> I'm confused. The normal malloc library is not involved with curre=
nt
>>>>>>> image loading, it's direct to memory (with some attempts at sanity
>>>>>>> checking by lmb).  Are you proposing a different allocator with
>>>>>>> malloc/free like behavior? If so, please outline how it will deter=
mine
>>>>>>> pool size, and how we'll use it to load thing to memory.
>>>>>>
>>>>>> All memory below the stack needs to be managed. Malloc uses a small=
 memory area (a few MiB) above the stack.
>>>>>
>>>>> That's a rather huge change for how U-Boot works.
>>>>>
>>>>>>>> Closing the eyes when the user loads multiple files does not solv=
e the fragmentation problem.
>>>>>>>
>>>>>>> Yes. I'm only noting that today we just ignore the problem and som=
etimes
>>>>>>> catch it via checksums.
>>>>>>>
>>>>>>>> Fragmentation only happens if we have many concurrent allocations=
.  In EFI we are allocating top down. The number of concurrent allocations=
 is low. Typically a few dozen at most. After terminating an application t=
hese should be freed again.
>>>>>>>
>>>>>>> OK, so are you saying that we would no longer be loading _to_ a lo=
cation
>>>>>>> in memory and instead just be saying "load this thing" and picking=
 where
>>>>>>> dynamically?
>>>>>>
>>>>>> Both preassigned and allocator assigned adresses are compatible wit=
h memory management.
>>>>>>
>>>>>> Architectures and binaries have different requirements. On riscv64 =
you can load Linux kernel, initrd, fdt anywhere. We don't need predefined =
addresses there. Other architectures have restrictions.
>>>>>
>>>>> Yes, 64 bit architecture tend to only have alignment requirements wh=
ile
>>>>> 32bit architectures have both alignment requirements and some memory
>>>>> window requirement. Whatever we implement here needs to handle both
>>>>> cases.
>>>>>
>>>>>>>> When loading a file from a file system we know the filesize befor=
ehand. So allocation is trivial.
>>>>>>>>
>>>>>>>> The loady command currently does not use the  offered size inform=
ation but could do so.
>>>>>>>
>>>>>>> We should be using that information to make sure we don't overwrit=
e
>>>>>>> U-Boot itself, but I don't recall how exactly we handle it today
>>>>>>> off-hand.
>>>>>>
>>>>>> If the user issues multiple load commands, he can overwrite previou=
s files.
>>>>>
>>>>> Then it sounds like we lost one benefit of all of this overhead.
>>>>>
>>>>>> During boot command execution I guess the different allocations res=
pect each other.
>>>>>>
>>>>>>>
>>>>>>>> TFTP is problematic because it does not transfer the filesize. We=
 would probably try to allocate a large chunk of memory and then downsize =
the allocation after reading the whole file.
>>>>>>>
>>>>>>> Reading from non-filesystem flash also has this problem, but we at=
 least
>>>>>>> specify the amount to read too. But yes, it gets back to what I wa=
s
>>>>>>> asking about on how you're proposing to handle network load cases.
>>>>>>>
>>>>>>
>>>>>> It depends on the protocol. Http conveys the size before the data. =
Tftp does not.
>>>>>>
>>>>>> If you don't know the size, you must preallocate a big chunk, check=
 that the download does not exceed it, and downsize the allocation afterwa=
rds. This is not a new problem but exists already with current lmb usage.
>>>>>
>>>>> Yes, and what I'm trying to find out is if what you're suggesting wo=
uld
>>>>> do anything about it, since previous statements you made implied to =
me
>>>>> that we would prevent it.
>>>>>
>>>>> To me, at this point it sounds like what we need is more like persis=
tent
>>>>> memory blocks and a hook that can be called in to for both "give me =
all
>>>>> known memory blocks" and "add this memory block to the list", so tha=
t
>>>>> EFI can do whatever it needs to do upon starting an application and =
then
>>>>> upon return to U-Boot. Both malloc/free allocations and "load this b=
lob
>>>>> to memory from whatever" allocations would call the appropriate hook=
 for
>>>>> tracking.
>>>>
>>>> In my mind the solution to this entire problem is fairly minor change=
s
>>>> to how memory is allocated and only for EFI.
>>>>
>>>> I tried to map out what that would look like and we have IMO got lost
>>>> in the weeds a bit.
>>>>
>>>> I am not trying to solve the problem of the 'load' command doing an
>>>> allocation and throwing it away. To be that is WAI, at least until we
>>>> come up with another type of command. This is one of the reasons for
>>>> standard boot, allowing a more cohesive approach to booting.
>>>>
>>>> I will think about this some more...
>>>
>>> OK, but please keep in mind that lmb not being at all persistent is a
>>> problem for everyone, not just EFI. That really needs to be addressed,
>>> maybe with some flags for dis-allowing overwrites to the area. For
>>> example, the apple-m1 code to use lmb to find locations for the
>>> kernel/etc can be written to more than once (allocate the address, the=
n
>>> write to it to start with, even) but the range that covers U-Boot itse=
lf
>>> (malloc pool and so forth) need to be stopped.
>>>
>>
>> The range managed by the EFI sub-system extends over all of RAM
>> including the addresses used by load commands. Hence, "the range that
>> covers U-Boot itself (malloc pool and so forth)" includes all memory.
>>
>> Maybe we could pre-allocate a memory area for file loading. This just
>> requires to define a device-specific high file memory address above
>> which no file loads will be allowed and below which EFI, bootm, etc wil=
l
>> not be allowed to allocate memory for further uses.
>
> We're not just / only an EFI runtime. When we load something persistent
> to memory outside of EFI, we need to note that, so that when EFI_LOADER
> beings work it can see this and do whatever it needs to do. And if/when
> EFI_LOADER returns control back to U-Boot itself, it needs to update
> that list with any new allocations that were done and mark them
> appropriately.

The idea of EFI loader returning control is misleading.

You can load an EFI driver binary which provides a device to U-Boot.
Whenever U-Boot accesses that driver allocations might occur.

I thought that we already agreed to have only one memory management and
get rid of the LMB/EFI memory management duplication.

Best regards

Heinrich

> The user gets full memory minus a bit, to do with as they
> need for their use case.



