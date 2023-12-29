Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C7DC47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 16:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64A8387A54;
	Fri, 29 Dec 2023 17:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OtHAJbbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFB987A72; Fri, 29 Dec 2023 17:42:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F3087A3D
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 17:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703868143; x=1704472943; i=xypron.glpk@gmx.de;
 bh=mdyNBxSUHwq35UQ9Fjr2vEUuS5PLz+IrTc+7XJS52Dg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=OtHAJbbsCtnm3Jybq3qnwnv5gPsKYpNb1jMYV2lxLERmvj6LijvYRsDh1JEzrmnf
 /lg74u8v0M0SfSApkMypmt0JACkMPxRzOLS9H46tWYEvb1TMsBfYt/tgA2L5Jg6OF
 n9G3q+PJ/qipSHqzoPsGjKV/r7FQyLc58JzRXPLH9cVcwspSeAjh0B+fa9eSoymIJ
 DLtZCxurVJQDhWwntHJrSwHIMJNtL9NrA7/CvQhTCPA0ubkv8lR8zDmsTxKKNP5L3
 3uS8S/jZ5tWM7l//BhOB2bBD1coKQU/AOmuzeDT8HS5kiJQmHHI4IGec286tliA1g
 WI5ixRGFG/LCdo+xwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.57] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDj4-1rOAoD14wQ-00CiOO; Fri, 29
 Dec 2023 17:42:23 +0100
Message-ID: <be5fb3fc-2ac9-41ae-a1b5-c08441b1cbe2@gmx.de>
Date: Fri, 29 Dec 2023 17:42:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal: U-Boot memory management
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
References: <20231218224108.GN2513409@bill-the-cat>
 <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
 <20231218231640.GO2513409@bill-the-cat>
 <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
 <20231218233130.GP2513409@bill-the-cat>
 <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
 <20231219012600.GQ2513409@bill-the-cat>
 <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
 <20231219124553.GS2513409@bill-the-cat>
 <CAPnjgZ1SUoRKEWaK6k1rrVN4t0WLD24GGeRj7uer3A0XA_MKoA@mail.gmail.com>
 <20231220191219.GP2513409@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231220191219.GP2513409@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ys5zEy1XTwS2+bfHE9lBvte2OHkLakMbKsjULh/PnTfVnf+Irxe
 Kg/GiPRAvXdMnfpRpl/+7OOfyBmDK71e32D3iOWuRv9IjM8JHspzRuOP3ZRfcT75svoWb+H
 PGER0VUiYXjnUbNKfcQJg008R/164QUp6SZCXeRxlrNAhyQPhe1AFatvD0diSEWFu3X9TFl
 HomVugNj5eceXywRaC9aw==
UI-OutboundReport: notjunk:1;M01:P0:+MQPUAMYTCE=;y4z0ZMvtbtP7ylOoWxGA68MQu03
 Vz5o7bgu+T7p20BFN9syJqakbiFtv5Sn2Q0j/Zeajy3dfZqcrIgH7+Y2B6biPQZPpIcYp3utF
 BE8hbVoCbrSAOTLsqjxWNIX0PaDOW60tuaIQ2YLBcPsfWvbnlNGGpxxXtEErVTJ8jqFnZxUJq
 l8XGtR8njztXjBa1s4qv+W1WOolp299RWCNYitb2VMmecmc2ZexfjyVbScpAbF1f9MjwqYz31
 oLaC+XtRq7AjB5XejmorKrHrSJCjg73mOl4WMpT8UC2GbmdDqo2yUp+u9L7+ygJznPV3bmdi3
 b0BR5IDAqaOceR0VEBqOYRB4H5zUal1SEY+h50+l7ppM4M79YzS6p4Yt/pZTb7cdAgvAwaSUW
 mIfi8kFjtKGWouFrFWtEgVj2PZagofrpVi3EjiqUNVx+dvMZZuHQZLZHhj2Bc125B6S4qa9rU
 cKgBwvQhjNl2qIpxwxDfpUcmweJGS5QUcpypTDRelssi+9to0HE6cAnIFXhutlT7eF6Vc85Cr
 eLkAn+rWPDCL7ZFGpiG6h0B3/xzS4A1Y+sZqAwXNuzbDuTufYcroeL37073oa2cyhi1G4fvtY
 caatQ0Cbb93Ck2yzbi/NiuKcceRlnFHu69kqESZkTZNS41obDDx2zQkOwYVCz3CmIQBdG3aEk
 MjPJsnrSqMwm9hw9ee0mp1KMhburknJMQBGM4j8nwQWYsvDEp+gNWF4RcyhaDO3sqmTJMgyW7
 1IiQ3R6aXSgnaw+6nxgcf2kiCnwbFVjAQlV76qcy0ojI4eeUY7uDyUKyTTL0/0+0BvX31a3gM
 YXNGoJWVUvoqsgfyQMhnITwlso2pfSdQQ7HMp2WnDpbt6hPqxIvv0tXAIO1d6ycS7N2m53u/w
 XyIeIc0NMtWt8p11a7r6exMxobAnh4Gs0LC/mCDN4r5cuGnf6DC+D8nKjwWBbZCrhexqe1fsY
 hGknQIfckgOAcVUUPXJN5OQi+1w=
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

On 12/20/23 20:12, Tom Rini wrote:
> On Tue, Dec 19, 2023 at 09:15:21PM -0700, Simon Glass wrote:
>> Hi,
>>
>> On Tue, 19 Dec 2023 at 05:46, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Tue, Dec 19, 2023 at 03:15:38AM +0100, Heinrich Schuchardt wrote:
>>>>
>>>>
>>>> Am 19. Dezember 2023 02:26:00 MEZ schrieb Tom Rini <trini@konsulko.co=
m>:
>>>>> On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schuchardt wrote:
>>>>>>
>>>>>>
>>>>>> Am 19. Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini@konsulko.=
com>:
>>>>>>> On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchardt wrot=
e:
>>>>>>>>
>>>>>>>>
>>>>>>>> Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@konsulk=
o.com>:
>>>>>>>>> On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt wr=
ote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@konsu=
lko.com>:
>>>>>>>>>>> On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt =
wrote:
>>>>>>>>>>>
>>>>>>>>>>> [snip]
>>>>>>>>>>>> Or take:
>>>>>>>>>>>>
>>>>>>>>>>>> load host 0:1 $c kernel.efi
>>>>>>>>>>>> load host 0:1 $d initrd.img
>>>>>>>>>>>>
>>>>>>>>>>>> How could we ensure that initrd.img is not overwriting a part=
 of kernel.efi without memory allocation?
>>>>>>>>>>>
>>>>>>>>>>> Today, invalid checksum as part of some part of the kernel fai=
ls. But
>>>>>>>>>>> how do we do this tomorrow, are you suggesting that "load" per=
form
>>>>>>>>>>> malloc() in some predefined size? If $c is below $d and $c + k=
ernel.efi
>>>>>>>>>>> is now above $d we can throw an error before trying to load, y=
es. But
>>>>>>>>>>> what about:
>>>>>>>>>>> load host 0:1 $d initrd.img
>>>>>>>>>>> load host 0:1 $c kernel.efi
>>>>>>>>>>>
>>>>>>>>>>> In that case (which is only marginally contrived, the more rea=
l case is
>>>>>>>>>>> loading device tree in to unexpectedly large ramdisk because s=
omeone
>>>>>>>>>>> didn't understand the general advice on why device tree is low=
er than
>>>>>>>>>>> ramdisk address) I'm fine with an error that amounts to "you j=
ust
>>>>>>>>>>> corrupted another allocation" and then "fail, reset the board"=
 or so.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Our current malloc library cannot manage the complete memory. W=
e need a library like lmb which should also cover the memory management th=
at we currently have in lib/efi/efi_memory.c. This must include a memory t=
ype attribute for usage in the GetMemoryMap() service. A management on pag=
e level seems sufficient.
>>>>>>>>>>
>>>>>>>>>> The load command should permanently allocate memory in that lmb=
+ library.
>>>>>>>>>>
>>>>>>>>>> We need an unload command to free the memory if we want to reus=
e the memory or we might let the load comand free the memory if exactly th=
e same start address is reused.
>>>>>>>>>
>>>>>>>>> Our current way of loading things in to memory does not handle t=
he case
>>>>>>>>> I described, yes. How would what you're proposing handle it?
>>>>>>>>
>>>>>>>> If the load command has to allocate memory for the image and that=
 allocation is kept, any attempt to allocate overlapping memory would fail=
.
>>>>>>>
>>>>>>> So you're saying that the load command has to pre-allocate memory?=
 Or as
>>>>>>> it goes? If the latter, in what size chunks? This starts to get at=
 what
>>>>>>> Simon was talking about with respect to memory fragmentation. Whic=
h to
>>>>>>> be clear is a problem we have today, we just let things overlap an=
d hope
>>>>>>> something later catches an incorrect checksum.
>>>>>>>
>>>>>>
>>>>>> I don't want to replace the malloc library which handles large numb=
ets of allocations.
>>>>>
>>>>> I'm confused. The normal malloc library is not involved with current
>>>>> image loading, it's direct to memory (with some attempts at sanity
>>>>> checking by lmb).  Are you proposing a different allocator with
>>>>> malloc/free like behavior? If so, please outline how it will determi=
ne
>>>>> pool size, and how we'll use it to load thing to memory.
>>>>
>>>> All memory below the stack needs to be managed. Malloc uses a small m=
emory area (a few MiB) above the stack.
>>>
>>> That's a rather huge change for how U-Boot works.
>>>
>>>>>> Closing the eyes when the user loads multiple files does not solve =
the fragmentation problem.
>>>>>
>>>>> Yes. I'm only noting that today we just ignore the problem and somet=
imes
>>>>> catch it via checksums.
>>>>>
>>>>>> Fragmentation only happens if we have many concurrent allocations. =
 In EFI we are allocating top down. The number of concurrent allocations i=
s low. Typically a few dozen at most. After terminating an application the=
se should be freed again.
>>>>>
>>>>> OK, so are you saying that we would no longer be loading _to_ a loca=
tion
>>>>> in memory and instead just be saying "load this thing" and picking w=
here
>>>>> dynamically?
>>>>
>>>> Both preassigned and allocator assigned adresses are compatible with =
memory management.
>>>>
>>>> Architectures and binaries have different requirements. On riscv64 yo=
u can load Linux kernel, initrd, fdt anywhere. We don't need predefined ad=
dresses there. Other architectures have restrictions.
>>>
>>> Yes, 64 bit architecture tend to only have alignment requirements whil=
e
>>> 32bit architectures have both alignment requirements and some memory
>>> window requirement. Whatever we implement here needs to handle both
>>> cases.
>>>
>>>>>> When loading a file from a file system we know the filesize beforeh=
and. So allocation is trivial.
>>>>>>
>>>>>> The loady command currently does not use the  offered size informat=
ion but could do so.
>>>>>
>>>>> We should be using that information to make sure we don't overwrite
>>>>> U-Boot itself, but I don't recall how exactly we handle it today
>>>>> off-hand.
>>>>
>>>> If the user issues multiple load commands, he can overwrite previous =
files.
>>>
>>> Then it sounds like we lost one benefit of all of this overhead.
>>>
>>>> During boot command execution I guess the different allocations respe=
ct each other.
>>>>
>>>>>
>>>>>> TFTP is problematic because it does not transfer the filesize. We w=
ould probably try to allocate a large chunk of memory and then downsize th=
e allocation after reading the whole file.
>>>>>
>>>>> Reading from non-filesystem flash also has this problem, but we at l=
east
>>>>> specify the amount to read too. But yes, it gets back to what I was
>>>>> asking about on how you're proposing to handle network load cases.
>>>>>
>>>>
>>>> It depends on the protocol. Http conveys the size before the data. Tf=
tp does not.
>>>>
>>>> If you don't know the size, you must preallocate a big chunk, check t=
hat the download does not exceed it, and downsize the allocation afterward=
s. This is not a new problem but exists already with current lmb usage.
>>>
>>> Yes, and what I'm trying to find out is if what you're suggesting woul=
d
>>> do anything about it, since previous statements you made implied to me
>>> that we would prevent it.
>>>
>>> To me, at this point it sounds like what we need is more like persiste=
nt
>>> memory blocks and a hook that can be called in to for both "give me al=
l
>>> known memory blocks" and "add this memory block to the list", so that
>>> EFI can do whatever it needs to do upon starting an application and th=
en
>>> upon return to U-Boot. Both malloc/free allocations and "load this blo=
b
>>> to memory from whatever" allocations would call the appropriate hook f=
or
>>> tracking.
>>
>> In my mind the solution to this entire problem is fairly minor changes
>> to how memory is allocated and only for EFI.
>>
>> I tried to map out what that would look like and we have IMO got lost
>> in the weeds a bit.
>>
>> I am not trying to solve the problem of the 'load' command doing an
>> allocation and throwing it away. To be that is WAI, at least until we
>> come up with another type of command. This is one of the reasons for
>> standard boot, allowing a more cohesive approach to booting.
>>
>> I will think about this some more...
>
> OK, but please keep in mind that lmb not being at all persistent is a
> problem for everyone, not just EFI. That really needs to be addressed,
> maybe with some flags for dis-allowing overwrites to the area. For
> example, the apple-m1 code to use lmb to find locations for the
> kernel/etc can be written to more than once (allocate the address, then
> write to it to start with, even) but the range that covers U-Boot itself
> (malloc pool and so forth) need to be stopped.
>

The range managed by the EFI sub-system extends over all of RAM
including the addresses used by load commands. Hence, "the range that
covers U-Boot itself (malloc pool and so forth)" includes all memory.

Maybe we could pre-allocate a memory area for file loading. This just
requires to define a device-specific high file memory address above
which no file loads will be allowed and below which EFI, bootm, etc will
not be allowed to allocate memory for further uses.

Best regards

Heinrich
