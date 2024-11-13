Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED203D41C04
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 12:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C1589577;
	Wed, 13 Nov 2024 13:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="e7Oj3b9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB0B89583; Wed, 13 Nov 2024 13:33:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8123589574
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 13:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731501209; x=1732106009; i=xypron.glpk@gmx.de;
 bh=zLlBhGLCC5QeUWH+2hde6jM7WV8JO3OMJitPjV1iMjw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=e7Oj3b9q2gdfqlFZiBCED0BFqheo2UvdWkoakkE/wcafcgwN9BE9IqGdKrPx27jn
 zkMbuaEvldqeovHp8W5wozY2k09SJ1NnYqqGtoTHzDnkbyV8Wy8QEmVhTubWYYoUc
 I+0FcMGsry+ta0VE9ZSxUqyReGQg69+zMLqGXKurJ+e8v5N4kRgS+KtJsTf/HS2BO
 ztqfKkBqUIhfBfm5f4T/GEXOkCjw+BgoRNePhrEreYi4+CqsctbByhn/b4b3vBP68
 Uv7Giy4hgvhsuh1QYht9QcvEBFKvopVszWQTE1uIYFy6UzHzJJrlvYSk6+4Pu5Tdz
 iotUYfJS/Xlt7SxPuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma20k-1tEaEO3xuG-00KRZO; Wed, 13
 Nov 2024 13:33:29 +0100
Message-ID: <dc1d08c6-45c9-4826-bae4-15bd1216ea7e@gmx.de>
Date: Wed, 13 Nov 2024 13:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20241112131830.576864-1-sjg@chromium.org>
 <CADg8p949qx=irjZKgf9-B4wtCYx1pDj29LFH86YR4T1zyKtAvg@mail.gmail.com>
 <CAC_iWj+U945S96mE4E3d_bLxQ-9iQhErXBaJW0WCpLB1X=VVqQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWj+U945S96mE4E3d_bLxQ-9iQhErXBaJW0WCpLB1X=VVqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sId81F3zlr/b6AijqBXIXutPQZcs59CJ/kFwYeuUMgaA494qPU2
 +qpkrmJ299NVZ4PciLDhXyWIwTUOFAe12vtrfsAYe3lh0BNkfUxJnsYKBmziFsb1tyo/iZz
 cy5rAlMGQvEnzVBktyJdBFM0wCMXTjlr/kpUigiPy1sf+HsYIansGLy0Tb+7n3glXP7wj63
 QGdRgGgryJSrXIss4vXVA==
UI-OutboundReport: notjunk:1;M01:P0:l+47t2hyXYk=;lVbExsZ+9NopJYW/vquGtxNLQ9z
 gAfjvP2xSOuCF+96ERQzGJUW6cyXczbp7BbPVPmNyiJvfCopBBQsV/NJWD9WlriOkN5FsfiRr
 noB1k/y1pwc/iatskeoouxUz61R+Gqw5O+A99HQcimREDfrPJpJ755M8Nif4PbsxaSBFMXp5g
 uLTYt2b621s6tJ5djlE59mA1nV7BoT4dmHHmldFsGdv+kjwDRmaqgP36tNaWxTZ6CfZlnWAAC
 jsxPJKXrcn9QpTouthh159obs/4fy9autV8AstG6MsNmgbv0RKkWrYJ0EZLfIkkw7f0iFonlG
 fKyhSGZwo4TrS63kgWvicVEufPwZK6Naz2lt+eJBcvhPfmNS0M8sHqW5mMx0iX0IvP/OMBhNt
 hTVZBrJEzo6CPL/VYVEOXG/SmTjXTGKKsBy26A7bdR7dUbV2Omxx3hHYs4+Ae06+2QdRILhgy
 vp1yrlHYXuUgrj6D7HYYWxiEVV7LWGOnDjVmgbGeSUMYkF9G6CtMVucYCRBVtFM5ZsC+PHV1D
 9SFSqOEm3MoaD4ZV1GwOg+tcPXIKdZ2npBaa457JqQmlPvCCt6CCuOcJEjGOJ1xP52fhVUpyH
 SGsfhNyb/o0UJlNPxHsuMMmmRzuoCrTaQsqpWrgYBLx+a+0WlVrp9BbNJ8qU5klmkBjm+4agS
 J6+OuBYrbSbZn39R91C0fe9+ZCgHwnOVJRVc5Y9t7dhr+NDrBoyO/D4mlkRUO9+L9Ga8RmODH
 9dqe75KgeDZA0cR2Q1GmuExPqzKqPetZtIxEyzV3jhB75UQCVdQnjGE4e7RwbULYg1yrRiEOT
 qqUE/91/t4MyFI0GWde7Oeov0nO8WsjxRJEfP7j+2ZDeN03rrXYeQ8C5xJADAwmDbMWPHhmSS
 HM8zhXGUjIU9jggypEbsMY5v9cUEQoJhnyqIvjRK8fr8v6L/CJtXNizGx
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

On 11/13/24 12:28, Ilias Apalodimas wrote:
> Hi Sughosh
>
> On Tue, 12 Nov 2024 at 20:46, Sughosh Ganu <sughosh.ganu@linaro.org> wro=
te:
>>
>> On Tue, 12 Nov 2024 at 18:48, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in thi=
s
>>> patch. I am not sure how to investigate it.
>>>
>>> The boot hangs at some point during booting of the install image, befo=
re
>>> the Ubuntu logo appears.

I tried to replicate the problem with an Ubuntu 24.04.1 cloud image
using a 6.8 kernel.

I see efi_exit_boot_services being reached but not
efi_set_virtual_address_map. The kernel seems to be stuck in an endless
loop in a virtual address range (0xffffffff????????).

The memory map looks wrong:

=3D> efidebug memmap
Type             Start            End              Attributes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CONVENTIONAL     0000000000000000-00000000000a0000 WB
RESERVED         00000000000a0000-00000000000f0000 WB
ACPI RECLAIM MEM 00000000000f0000-00000000000f1000 WB
RESERVED         00000000000f1000-0000000000100000 WB
CONVENTIONAL     0000000000100000-000000003dca4000 WB
BOOT DATA        000000003dca4000-000000003dca6000 WB
RUNTIME DATA     000000003dca6000-000000003dca7000 WB|RT
BOOT DATA        000000003dca7000-000000003dca8000 WB
RUNTIME DATA     000000003dca8000-000000003dcca000 WB|RT
BOOT DATA        000000003dcca000-000000003ecda000 WB
RESERVED         000000003ecda000-000000003ece0000 WB
ACPI RECLAIM MEM 000000003ece0000-000000003ed02000 WB
RUNTIME DATA     000000003ed02000-000000003ed03000 WB|RT
RESERVED         000000003ed03000-000000003ef1a000 WB
RUNTIME CODE     000000003ef1a000-000000003ef1c000 WB|RT
RESERVED         000000003ef1c000-0000000040000000 WB
RESERVED         00000000e0000000-00000000f0000000 WB

The relocated U-Boot code should not be marked as EfiReservedMemoryType
but as EfiServicesCode according to the UEFI specification.

The ACPI table is marked as EfiACPIReclaimMemory but I don't think
memory in the BIOS memory range should be reclaimable. In the journal on
my laptop I see

BIOS-provided physical RAM map
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved

The e820 table is generated from the EFI memory map in setup_e820() of
the Linux efi stub.

Best regards

Heinrich

>>>
>>> I will sent a series with a script showing how it is run.
>>>
>>> This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>
>> This seems to be an issue specific to the x86 architecture. The
>> installation works on arm64 and riscv (confirmed by Heinrich)
>> architectures. I checked the output of the EFI memory map with the
>> above commit against the master branch, and the only difference is
>> that with this revert, the EFI memory map has the u-boot memory region
>> marked as EFI_BOOT_SERVICES_CODE, whereas without this commit, that
>> region is marked as reserved.
>
> Hmm why? LMB is adding this with EFI_BOOT_SERVICES_CODE  in
> lmb_map_update_notify(). Who's switching it to reserved?
> This is a pretty big change since the memory switches from reusable to
> reserved for the OS.
>
>> I need to look into this in more detail,
>> but it would seem like the x86 kernel (or some efi stub code ?) is
>> expecting some region of memory marked as EFI_BOOT_SERVICES_CODE,
>> which is not the case for other architectures.
>
> Not EFI_BOOT_SERVICES_CODE explicitly, probably just a reusable type of =
memory.
>
> Cheers
> /Ilias
>
>
>
>>
>> -sughosh
>>
>>>
>>>   lib/efi_loader/efi_memory.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>>> index d2f5d563f2a..c7400ec9854 100644
>>> --- a/lib/efi_loader/efi_memory.c
>>> +++ b/lib/efi_loader/efi_memory.c
>>> @@ -809,6 +809,16 @@ static void add_u_boot_and_runtime(void)
>>>   {
>>>          unsigned long runtime_start, runtime_end, runtime_pages;
>>>          unsigned long runtime_mask =3D EFI_PAGE_MASK;
>>> +       unsigned long uboot_start, uboot_pages;
>>> +       unsigned long uboot_stack_size =3D CONFIG_STACK_SIZE;
>>> +
>>> +       /* Add U-Boot */
>>> +       uboot_start =3D ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>>> +                      uboot_stack_size) & ~EFI_PAGE_MASK;
>>> +       uboot_pages =3D ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
>>> +                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
>>> +       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVI=
CES_CODE,
>>> +                             false);
>>>
>>>   #if defined(__aarch64__)
>>>          /*
>>> --
>>> 2.34.1
>>>

