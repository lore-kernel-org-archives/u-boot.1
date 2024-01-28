Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E9EC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 09:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC7988145;
	Sun, 28 Jan 2024 10:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V5GJFxJf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9032888154; Sun, 28 Jan 2024 10:20:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B288988121
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 10:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706433636; x=1707038436; i=xypron.glpk@gmx.de;
 bh=yVDNJJ7KAL322Pg7PnvmqLXjYOaT3fwfbMaX9ejQwC0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=V5GJFxJfP+Mcw73rZO/+5rba4VW4XNIQg4s3nu6/q5WggqMwY5UQ1bHhvS5fFNQY
 ROCrDowFWuLFqouuKqkIMd8nYO99/Giz3V/tpbaOZKL1tcBn839oNDUgNZ0gvmvNB
 R+/fO795Hmfrdb6yHSuFKVRGxWxWRj8hIKi2RKYkVr+hxZP5LDHhK0POw/2Vdejo1
 JlhbWiluFxybv5YgU7UqZ1X5z2pC4+l0Z+RxfJ2IeoHJi5YeYbnWIPoGVEO33rbtr
 I4fxVYUCeWjwMN054JKIHi9bX/Ql8howPQqihlN9s5lNYW9SIAIfRntMbcw5+MQnq
 TpAXFBcMJiUwGtlCsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowGa-1qiJmk14BC-00qSLF; Sun, 28
 Jan 2024 10:20:36 +0100
Message-ID: <5fb62d66-3aad-475b-9175-86e53e06fde6@gmx.de>
Date: Sun, 28 Jan 2024 10:20:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader : Suppress error print message
Content-Language: en-US, de-DE
To: "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "Simek, Michal"
 <michal.simek@amd.com>, "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "git@xilinx.com" <git@xilinx.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240122191242.2989327-1-tejas.arvind.bhumkar@amd.com>
 <CAC_iWjKEMs_0WHyu7ttfvP30vG=sJnhY5XWY=5hGBTAW_5oxyg@mail.gmail.com>
 <d2b79924-87bc-42a2-9d06-6fcba06ed267@gmx.de>
 <BL3PR12MB64505057156F40CDD884FB90D8742@BL3PR12MB6450.namprd12.prod.outlook.com>
 <d3f3fc7f-b29a-4503-9fe0-97468bbe1f71@gmx.de>
 <BL3PR12MB645027991850D2C0887FA80DD87F2@BL3PR12MB6450.namprd12.prod.outlook.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <BL3PR12MB645027991850D2C0887FA80DD87F2@BL3PR12MB6450.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IoUJ9NOqxGAc6sD1COpyBC8LsivbCCKMv6Quoys2MSaYKmICLE8
 YZw1CLzdODAvwZIOGz7viI5X2Rs1cKxJDit7pcF1rLanz+UbFcxtklbyvAV0VrqCW+MzGNP
 N5adHgrIpogpKx994XEF6c4qpiNj9G4umpZ0fuc75X5ZKKLtnPsg3Ov2yqncBvf0/lwmQ+1
 +pRF+9eL90m784bnRwPiQ==
UI-OutboundReport: notjunk:1;M01:P0:DJxlJXN+/go=;hTE+VupfkcqoN2t1TvTPZiyCMuZ
 SQZ5t7XWX5zSuBydmaRx25yChdDmvbhBs+7z6jmocQ/Jlx5AdyVRN2QGJsV6dX5ZMYThqCRT7
 /bD8eQRMaCDUmA31fxFMoOh2ohqbli93sz8t5BFPJBB68tdWIu/km40mYEPY7Kd8zLLfgPov5
 aAXW89oMnL6eEvoBJz/ppxktT+84YeUj8tcSDTzD358Gc+mmHp5CKfJ/ttzgNbhUg6D33jA6P
 MfnBl5+GzvE8OppjEG7hJR4H3RB8fm/jcomvxmvdMXskNpKmDoynbHj/yd7RtvqdbLNUbmc51
 NGarDv4kC0PIajmgXTcatq7eNz/16l4BL+0FTpULMdH0At58nrcGIi5Hyn3pfh+TK44CkXoYd
 E+5+El8jEFAf2Jj7kOaH2LtDRyL2ib2rjptXKY9TLoYPxI6dURCCB+Aij9BV6eEV85/BUZPUS
 pAL/KrLXUovZoKDJhDXqb5WNNZ3GbW9bWw0Ns4Sd2aX7PPvmOYBLRzBpYDqh4OEoQjHelf8IR
 SW40A/rGC7a7RUwHv7y05IRH6ye98J78kaRaCJ0T6nSOrGDEXeSOUJgNV4iN0Fyel1zLTTPQy
 JzFT1NinSUKXfFpEHUihi6cnO11L3hliaQFxeTr4+Xtsvyq8ShQ5dMFnexKkMPA/whM994gEe
 XfyVKVFnsQty3bTg9kxoY0+062prMaME201OFH47bu8rr1qBM26exzl1AM7oZl5bvKpVwJawd
 Q0ze92N4R1JE02Rz05E3BYuDwX22bqxu/JqLGSOyE9GeeSe41tuV/HWFuFyzKiFSAN9MVI9b3
 p/bs6DmzgWpYiouFPq2BfhURiXe4DIGb9wLbp0dTyYf+9o6H9Yd9BvekQu8vRaYVfR+NG18WY
 Euq26P7wZFqSqmiIZWwpuZg8ZzX3PtX5b30f4ydPAvnCmTqSs/eR2rVpuuyFzu4CyUXmjA6z/
 qhLlYb3WYY1xUUXg+X+tcKTE4Cg=
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

On 1/28/24 06:20, Bhumkar, Tejas Arvind wrote:
> [AMD Official Use Only - General]
>
> Hi Heinrich,
>
>> -----Original Message-----
>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Sent: Wednesday, January 24, 2024 2:09 AM
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
>> On 1/23/24 19:53, Bhumkar, Tejas Arvind wrote:
>>> [AMD Official Use Only - General]
>>>
>>> Hi Ilias & Heinrich,
>>>
>>>> -----Original Message-----
>>>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>> Sent: Tuesday, January 23, 2024 3:30 PM
>>>> To: Ilias Apalodimas <ilias.apalodimas@linaro.org>; Bhumkar, Tejas
>>>> Arvind <tejas.arvind.bhumkar@amd.com>
>>>> Cc: u-boot@lists.denx.de; xypron.glpk@gmx.de; trini@konsulko.com;
>>>> sjg@chromium.org; Simek, Michal <michal.simek@amd.com>; Abbarapu,
>>>> Venkatesh <venkatesh.abbarapu@amd.com>; git@xilinx.com
>>>> Subject: Re: [PATCH] efi_loader : Suppress error print message
>>>>
>>>> Caution: This message originated from an External Source. Use proper
>>>> caution when opening attachments, clicking links, or responding.
>>>>
>>>>
>>>> On 1/23/24 09:33, Ilias Apalodimas wrote:
>>>>> Hi Tejas,
>>>>>
>>>>> On Mon, 22 Jan 2024 at 21:12, Tejas Bhumkar
>>>>> <tejas.arvind.bhumkar@amd.com> wrote:
>>>>>>
>>>>>> Currently, on certain Xilinx platforms, an issue has been
>>>>>> identified, manifesting as follows:
>>>>
>>>> Hello Tejas,
>>>>
>>>> thank you for bringing forward this issue.
>>>>
>>>> Which defconfig are you relating to?
>>>
>>> [Tejas]:
>>> Checking with xilinx_zynqmp_virt_defconfig
>>>
>>>>
>>>>>>
>>>>>> Starting kernel ...
>>>>>>
>>>>>> efi_free_pool: illegal free 0x0000000077830040
>>>>>> efi_free_pool: illegal free 0x000000007782d040
>>>>>> efi_free_pool: illegal free 0x000000007782c040
>>>>>>
>>>>>> The issue arises when the ramdisk image is relocated, placing it
>>>>>> within the previously allocated EFI memory region( as EFI is
>>>>>> established quite early in U-Boot).
>>>>
>>>> Which version of U-Boot are you on? Commit 06d514d77c37 ("lmb:
>>>> consider EFI memory map") was meant to avoid such a situation.
>>>
>>> [Tejas] :
>>> I'm verifying against the latest changes in the master branch. The
>>> introduction of commit 06d514d77c37 ("lmb: consider EFI memory map")
>>> has resolved the occurrence of the "efi_free_pool: illegal free"
>>> error. but, it leads to a new error, as detailed in the following
>>> patch:
>>> https://lore.kernel.org/all/20230212150706.2967007-1-sjoerd@collabora.
>>> com/
>>
>> Could you, please, try to reproduce your issues with origin/master as o=
f today and
>> provide the full boot log. Please, also provide the output of the bdinf=
o and the
>> printenv command as well as the sizes of the kernel and the RAM disk.
>
> [Tejas]: I've provided two logs: one obtained from the latest u-boot ori=
gin/master, resulting in the "ERROR: reserving fdt memory region failed" e=
rror, and the other from reverting commit 06d514d77c37 ("lmb: consider EFI=
 memory map"), which leads to the "efi_free_pool: illegal free" error.
>
> Thank You,
> Tejas.

Where can I find these logs?

Best regards

Heinrich

>
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>>>
>>>>>
>>>>> I don't mind suppressing the print for some time, but out of
>>>>> curiosity, how is the ramdisk relocated? LMB should be aware of the
>>>>> EFI regions by then, so I assume the relocation code doesn't check
>>>>> those?
>>>
>>>
>>> [Tejas] :  I observe that the relocation of the RAM disk is taking pla=
ce in the line
>> below.
>>> https://github.com/u-boot/u-boot/blob/master/lib/lmb.c#L480-L491
>>> Yes, the relocated code specifically examines the LMB region and does =
not
>> consider the EFI region.
>>>
>>>>
>>>> The indicated situation is serious. If the EFI sub-system is using
>>>> the same memory area as the ramdisk, this may lead to corruption of
>>>> the ramdisk. Suppressing the messages is by no means adequate to solv=
e the
>> problem.
>>>
>>> [Tejas] :
>>> The challenge arises when relocating the ramdisk image, inserting it
>>> into the previously assigned EFI memory region, established early in
>>> U-Boot. Consequently, when attempting to release memory in the EFI reg=
ion
>> during the handover process to the kernel in the efi_free_pool function=
, we first
>> verify if the memory was allocated by efi_allocate_pool().
>>> The issue originates from a checksum mismatch because, during the ramd=
isk
>> relocation, we overwrite memory allocated by EFI.
>>> This leads to the appearance of the error message: efi_free_pool: ille=
gal free
>> 0x0000000077830040.
>>> Crucially, there is no corruption of the ramdisk seen since we do not =
actually
>> releasing memory due to the checksum mismatch.
>>> In our testing, this issue was observed only when the ramdisk size exc=
eeded
>> approximately 24 MB.
>>>
>>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>>
>>>>
>>>>>
>>>>> Thanks
>>>>> /Ilias
>>>>>
>>>>>> Consequently, when
>>>>>> attempting to release memory in the EFI memory region during the
>>>>>> handover process to the kernel,we encounter memory violations.
>>>>>>
>>>>>> Highlighting that EFI remains active primarily during the booting
>>>>>> of an EFI application, and the lmb persists while configuring
>>>>>> images for the boot process. Since we aren't utilizing the EFI
>>>>>> memory region during the boot process, there is no adverse impact
>>>>>> even in the event of a violation.
>>>>>>
>>>>>> Currently, there is an ongoing discussion regarding the handling
>>>>>> strategies of three memory allocators: malloc, lmb, and EFI. This
>>>>>> discussion is documented in the email chain titled "Proposal:
>>>>>> U-Boot memory management."
>>>>>>
>>>>>> Therefore, it is advisable to suppress the print message during the
>>>>>> boot process for now.
>>>>>>
>>>>>> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
>>>>>> ---
>>>>>>     lib/efi_loader/efi_memory.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/lib/efi_loader/efi_memory.c
>>>>>> b/lib/efi_loader/efi_memory.c index edfad2d95a..821fe7616e 100644
>>>>>> --- a/lib/efi_loader/efi_memory.c
>>>>>> +++ b/lib/efi_loader/efi_memory.c
>>>>>> @@ -713,7 +713,7 @@ efi_status_t efi_free_pool(void *buffer)
>>>>>>            /* Check that this memory was allocated by efi_allocate_=
pool() */
>>>>>>            if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
>>>>>>                alloc->checksum !=3D checksum(alloc)) {
>>>>>> -               printf("%s: illegal free 0x%p\n", __func__, buffer)=
;
>>>>>> +               debug("%s: illegal free 0x%p\n", __func__, buffer);
>>>>>>                    return EFI_INVALID_PARAMETER;
>>>>>>            }
>>>>>>            /* Avoid double free */
>>>>>> --
>>>>>> 2.27.0
>>>>>>
>>>
>

