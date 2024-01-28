Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98A0C47DDB
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 22:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169C187B13;
	Sun, 28 Jan 2024 23:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VBoDWa5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE16087B1A; Sun, 28 Jan 2024 23:38:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A3D487897
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 23:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706481518; x=1707086318; i=xypron.glpk@gmx.de;
 bh=BsjC6le/EXp2uSXI3h+ZTFOHDmXrCeBbeinZxdxrdW8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=VBoDWa5za3PRvsiAvhrt92gZSoocKXFaWigAzI06zX61pUrLEmDCsyG/pNkLEqnc
 zeDEbSVfIRLpx6PMZCkujPnrbJvtTbZnYju4j+L/b+CCUoce3yfA5wneBcIUka3qg
 UZRpDJUxpzcpify6LWZwsMG4zVbknF+miOW7zqEeUmXTFVGf/fZXjD55MJkFk6IeO
 Y0STEmSV9cIHgHabotYROaYaO7LNgc7TgXQGFOvk+g/Y0Mx6otbtpdt60sR8DSpnJ
 ENpqGlfcBqc787stOTyXXHJM4WecgJssXskvWyKPs9XDGlc+VbiqbRiIsDubQi/BC
 XJCL0YyZEqb6gLUVHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.82] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybKp-1r9NUe3XYr-00ywlE; Sun, 28
 Jan 2024 23:38:37 +0100
Message-ID: <09ecad76-d5c4-4611-ada8-aaa8dda34853@gmx.de>
Date: Sun, 28 Jan 2024 23:38:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader : Suppress error print message
Content-Language: en-US
To: "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>
References: <20240122191242.2989327-1-tejas.arvind.bhumkar@amd.com>
 <CAC_iWjKEMs_0WHyu7ttfvP30vG=sJnhY5XWY=5hGBTAW_5oxyg@mail.gmail.com>
 <d2b79924-87bc-42a2-9d06-6fcba06ed267@gmx.de>
 <BL3PR12MB64505057156F40CDD884FB90D8742@BL3PR12MB6450.namprd12.prod.outlook.com>
 <d3f3fc7f-b29a-4503-9fe0-97468bbe1f71@gmx.de>
 <BL3PR12MB645027991850D2C0887FA80DD87F2@BL3PR12MB6450.namprd12.prod.outlook.com>
 <5fb62d66-3aad-475b-9175-86e53e06fde6@gmx.de>
 <BL3PR12MB6450453ECBEBB20B945C40E8D87F2@BL3PR12MB6450.namprd12.prod.outlook.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <BL3PR12MB6450453ECBEBB20B945C40E8D87F2@BL3PR12MB6450.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:muU/HQi0lsG1XVMs0HDRwJYlRqQ/sKJai7StsG6KLTqLSp0KOJB
 r8IqFzRN1nE3etXfeq+Ax0p8mm46O7+HW9nygEfONy3ZAqETzgKaf1YovpIurY+UUtt/3oa
 qkQxfpnRxbUPgdlkkQhYCM8fTRAE7TxDgLFA1jC9v3nWxv/WbASLru3WJQOMvI5NGEpQsaR
 /TbT6LaFOXFFuaYLdMwzQ==
UI-OutboundReport: notjunk:1;M01:P0:t04BKgmNiYE=;oWunV7JbU3MKjPoH/I4d/npEsJN
 rjYzHGLv7niw27pFYScM99gr3kgPZeEx6cmq9rAP/TFhZv2E1Njv1wge1J/av10STEX6LgBR1
 7Vt392npiBraw4hxKV8sV8IZb1MEd0EwUnyD2W8wkc4dKghD8qgqe6t5qPsjoWc7R4P2Ji8LY
 WQ2Yv3KSNTF7kvNcjH53viuoUQ6zTxeC1h96PSpUVRbSDT9y5uLc1hSMMkgD1OR+jVy4tXrkR
 NUw0ofVpqGJmvccw1pxcmU7AzoRQpAubsq9mXTqCJHrnIDZW0KysCfXWsibX13479m1/GQi9e
 kzGfZ8D631NLaMLBqe88Wc/bmQekwBaYK/5wcUtH6P9LIQQ2/uJr0H/waTPZKMGlkk254ZmTo
 oOg72bnEB40VNSd/c5xpNcep5XxmQLWeKb3ZI5cUXzE2FFGNHmmMGoekJIKxIe3EnC50zpB7T
 8yUWccbSuGX2ocpXWoWSqDh9VdANsOM+G3yRL5pcPlxkGHIJQeiI2Mdj6kwFKknm7ZmFA14jQ
 g/8nLHZPVdNzOexg04kU1LdrQJLq0LzGk+cLJhgqMv5VCX1TUOcbafgLt4NvVrB0FcwraEp89
 iNDIlEo8EakM67Sf6fB+RbCrkWkNhdvj3xS4mxAN3DxFwfRkNucy6hmdBSxOKi33y87yIzM4o
 2RtWj8JvbmKITK6Zz4AxGQKtD7gp5k212/q/RFAmY9XC2PYWi0KOSogcpeZB60IMpPwoG7ETe
 8wh67SIFYSD7MrVKLx9JEJsXmDbWWYfEKy/jsyiovT4uzcTBkrUpoySHP5YTHGg/TVkyTpYqT
 1DnPuz3nzrDoe9bNkRYSS31SSj72HgXzTlLnne5GTT2oDu3Bxg5835AF9giPdCWxL7FUn2DZQ
 JbFrva8UkocTG/74t68dW1H7tyGggoQsj97hCP7O63powqDQCoXMJjy2EfCPyRBZI/LrCQgNl
 i1nfELI0XYHid7a+DwaXuBSTofI=
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

On 1/28/24 18:38, Bhumkar, Tejas Arvind wrote:
> [AMD Official Use Only - General]
>
> Hi Heinrich,
>
>> -----Original Message-----
>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Sent: Sunday, January 28, 2024 2:51 PM
>> To: Bhumkar, Tejas Arvind <tejas.arvind.bhumkar@amd.com>
>> Cc: u-boot@lists.denx.de; trini@konsulko.com; sjg@chromium.org; Simek, =
Michal
>> <michal.simek@amd.com>; Abbarapu, Venkatesh
>> <venkatesh.abbarapu@amd.com>; git@xilinx.com; Ilias Apalodimas
>> <ilias.apalodimas@linaro.org>
>> Subject: Re: [PATCH] efi_loader : Suppress error print message
>>
>> Caution: This message originated from an External Source. Use proper ca=
ution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 1/28/24 06:20, Bhumkar, Tejas Arvind wrote:
>>> [AMD Official Use Only - General]
>>>
>>> Hi Heinrich,
>>>
>>>> -----Original Message-----
>>>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>> Sent: Wednesday, January 24, 2024 2:09 AM
>>>> To: Bhumkar, Tejas Arvind <tejas.arvind.bhumkar@amd.com>
>>>> Cc: u-boot@lists.denx.de; trini@konsulko.com; sjg@chromium.org;
>>>> Simek, Michal <michal.simek@amd.com>; Abbarapu, Venkatesh
>>>> <venkatesh.abbarapu@amd.com>; git@xilinx.com; Ilias Apalodimas
>>>> <ilias.apalodimas@linaro.org>
>>>> Subject: Re: [PATCH] efi_loader : Suppress error print message
>>>>
>>>> Caution: This message originated from an External Source. Use proper
>>>> caution when opening attachments, clicking links, or responding.
>>>>
>>>>
>>>> On 1/23/24 19:53, Bhumkar, Tejas Arvind wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>> Hi Ilias & Heinrich,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>>> Sent: Tuesday, January 23, 2024 3:30 PM
>>>>>> To: Ilias Apalodimas <ilias.apalodimas@linaro.org>; Bhumkar, Tejas
>>>>>> Arvind <tejas.arvind.bhumkar@amd.com>
>>>>>> Cc: u-boot@lists.denx.de; xypron.glpk@gmx.de; trini@konsulko.com;
>>>>>> sjg@chromium.org; Simek, Michal <michal.simek@amd.com>; Abbarapu,
>>>>>> Venkatesh <venkatesh.abbarapu@amd.com>; git@xilinx.com
>>>>>> Subject: Re: [PATCH] efi_loader : Suppress error print message
>>>>>>
>>>>>> Caution: This message originated from an External Source. Use
>>>>>> proper caution when opening attachments, clicking links, or respond=
ing.
>>>>>>
>>>>>>
>>>>>> On 1/23/24 09:33, Ilias Apalodimas wrote:
>>>>>>> Hi Tejas,
>>>>>>>
>>>>>>> On Mon, 22 Jan 2024 at 21:12, Tejas Bhumkar
>>>>>>> <tejas.arvind.bhumkar@amd.com> wrote:
>>>>>>>>
>>>>>>>> Currently, on certain Xilinx platforms, an issue has been
>>>>>>>> identified, manifesting as follows:
>>>>>>
>>>>>> Hello Tejas,
>>>>>>
>>>>>> thank you for bringing forward this issue.
>>>>>>
>>>>>> Which defconfig are you relating to?
>>>>>
>>>>> [Tejas]:
>>>>> Checking with xilinx_zynqmp_virt_defconfig
>>>>>
>>>>>>
>>>>>>>>
>>>>>>>> Starting kernel ...
>>>>>>>>
>>>>>>>> efi_free_pool: illegal free 0x0000000077830040
>>>>>>>> efi_free_pool: illegal free 0x000000007782d040
>>>>>>>> efi_free_pool: illegal free 0x000000007782c040
>>>>>>>>
>>>>>>>> The issue arises when the ramdisk image is relocated, placing it
>>>>>>>> within the previously allocated EFI memory region( as EFI is
>>>>>>>> established quite early in U-Boot).
>>>>>>
>>>>>> Which version of U-Boot are you on? Commit 06d514d77c37 ("lmb:
>>>>>> consider EFI memory map") was meant to avoid such a situation.
>>>>>
>>>>> [Tejas] :
>>>>> I'm verifying against the latest changes in the master branch. The
>>>>> introduction of commit 06d514d77c37 ("lmb: consider EFI memory map")
>>>>> has resolved the occurrence of the "efi_free_pool: illegal free"
>>>>> error. but, it leads to a new error, as detailed in the following
>>>>> patch:
>>>>> https://lore.kernel.org/all/20230212150706.2967007-1-sjoerd@collabor=
a.
>>>>> com/
>>>>
>>>> Could you, please, try to reproduce your issues with origin/master as
>>>> of today and provide the full boot log. Please, also provide the
>>>> output of the bdinfo and the printenv command as well as the sizes of=
 the
>> kernel and the RAM disk.
>>>
>>> [Tejas]: I've provided two logs: one obtained from the latest u-boot
>> origin/master, resulting in the "ERROR: reserving fdt memory region fai=
led" error,
>> and the other from reverting commit 06d514d77c37 ("lmb: consider EFI me=
mory
>> map"), which leads to the "efi_free_pool: illegal free" error.
>>>
>>> Thank You,
>>> Tejas.
>>
>> Where can I find these logs?
> [Tejas ] : I've sent the attachment in a previous email. I'm not sure wh=
y you didn't receive it.
> I've attached it again now. Please confirm if you still haven't received=
 it.
>
> Thank You,
> Tejas.
>>

If I understand your FDT_memory_region_failed.log correctly:

Except for some added debug messages this log matches booting with an
unmodified upstream U-Boot as of Jan 22nd.

Your memory is split into two regions:

0x0 - 0x7ffffff and
0x800000000 - 0x87ffffff.

Your device-tree has a reserved region 0x7ff00000-0x7fffffff.

U-Boot relocates itself into the lower memory block due to current design.

efi_lmb_reserve() marks memory up to 0x7fffffff and
0x800000000-0x87fffffff as reserved.

boot_fdt_reserve_region() writes an error when it tries to reserve the
overlapping region 0x7ff00000-0x7fffffff because LMB recognizes this
region is already reserved.

This should not interfere with booting as boot_fdt_reserve_region() does
not have a return value but is not very clean and should be fixed.

Best regards

Heinrich
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> I don't mind suppressing the print for some time, but out of
>>>>>>> curiosity, how is the ramdisk relocated? LMB should be aware of
>>>>>>> the EFI regions by then, so I assume the relocation code doesn't
>>>>>>> check those?
>>>>>
>>>>>
>>>>> [Tejas] :  I observe that the relocation of the RAM disk is taking
>>>>> place in the line
>>>> below.
>>>>> https://github.com/u-boot/u-boot/blob/master/lib/lmb.c#L480-L491
>>>>> Yes, the relocated code specifically examines the LMB region and
>>>>> does not
>>>> consider the EFI region.
>>>>>
>>>>>>
>>>>>> The indicated situation is serious. If the EFI sub-system is using
>>>>>> the same memory area as the ramdisk, this may lead to corruption of
>>>>>> the ramdisk. Suppressing the messages is by no means adequate to
>>>>>> solve the
>>>> problem.
>>>>>
>>>>> [Tejas] :
>>>>> The challenge arises when relocating the ramdisk image, inserting it
>>>>> into the previously assigned EFI memory region, established early in
>>>>> U-Boot. Consequently, when attempting to release memory in the EFI
>>>>> region
>>>> during the handover process to the kernel in the efi_free_pool
>>>> function, we first verify if the memory was allocated by efi_allocate=
_pool().
>>>>> The issue originates from a checksum mismatch because, during the
>>>>> ramdisk
>>>> relocation, we overwrite memory allocated by EFI.
>>>>> This leads to the appearance of the error message: efi_free_pool:
>>>>> illegal free
>>>> 0x0000000077830040.
>>>>> Crucially, there is no corruption of the ramdisk seen since we do
>>>>> not actually
>>>> releasing memory due to the checksum mismatch.
>>>>> In our testing, this issue was observed only when the ramdisk size
>>>>> exceeded
>>>> approximately 24 MB.
>>>>>
>>>>>>
>>>>>> Best regards
>>>>>>
>>>>>> Heinrich
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks
>>>>>>> /Ilias
>>>>>>>
>>>>>>>> Consequently, when
>>>>>>>> attempting to release memory in the EFI memory region during the
>>>>>>>> handover process to the kernel,we encounter memory violations.
>>>>>>>>
>>>>>>>> Highlighting that EFI remains active primarily during the booting
>>>>>>>> of an EFI application, and the lmb persists while configuring
>>>>>>>> images for the boot process. Since we aren't utilizing the EFI
>>>>>>>> memory region during the boot process, there is no adverse impact
>>>>>>>> even in the event of a violation.
>>>>>>>>
>>>>>>>> Currently, there is an ongoing discussion regarding the handling
>>>>>>>> strategies of three memory allocators: malloc, lmb, and EFI. This
>>>>>>>> discussion is documented in the email chain titled "Proposal:
>>>>>>>> U-Boot memory management."
>>>>>>>>
>>>>>>>> Therefore, it is advisable to suppress the print message during
>>>>>>>> the boot process for now.
>>>>>>>>
>>>>>>>> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
>>>>>>>> ---
>>>>>>>>      lib/efi_loader/efi_memory.c | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/lib/efi_loader/efi_memory.c
>>>>>>>> b/lib/efi_loader/efi_memory.c index edfad2d95a..821fe7616e 100644
>>>>>>>> --- a/lib/efi_loader/efi_memory.c
>>>>>>>> +++ b/lib/efi_loader/efi_memory.c
>>>>>>>> @@ -713,7 +713,7 @@ efi_status_t efi_free_pool(void *buffer)
>>>>>>>>             /* Check that this memory was allocated by efi_alloca=
te_pool() */
>>>>>>>>             if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
>>>>>>>>                 alloc->checksum !=3D checksum(alloc)) {
>>>>>>>> -               printf("%s: illegal free 0x%p\n", __func__, buffe=
r);
>>>>>>>> +               debug("%s: illegal free 0x%p\n", __func__,
>>>>>>>> + buffer);
>>>>>>>>                     return EFI_INVALID_PARAMETER;
>>>>>>>>             }
>>>>>>>>             /* Avoid double free */
>>>>>>>> --
>>>>>>>> 2.27.0
>>>>>>>>
>>>>>
>>>
>

