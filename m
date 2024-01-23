Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6CAC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 20:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED6D87BC3;
	Tue, 23 Jan 2024 21:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZjBVCnbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C5A87B75; Tue, 23 Jan 2024 21:38:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F60187CAF
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 21:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706042331; x=1706647131; i=xypron.glpk@gmx.de;
 bh=f9dD4J4beP1DaRU077zDtxQfkMizU7cj9qUXljbHiOo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ZjBVCnbVJZOZRedUQfOSjxiZaH9yEV4y6EPoMqMpbU6Obyi90bai9gSTm5VWXrIu
 8RPkZ4lTf5GKlLYWgnzv1N0BGVoYiK470Q4ABtl7jHM6F16bX5x3TvywA9hSzSbuc
 t0dtPqs3eB+JTVvziFS2kUDD9E4NpFte7KF6M8eqwpsdj8eGROiUyYQ9UmOx4Ukd0
 460dU16SsHG10G3qUabMCI7oC81AGL9jYK3a36R+75AluCITEA0+FlDz8Jx8eN5ZP
 K/R1+X6rAgRgmbJyY+m7tq8r39qmyL8l5SBK88VytnRyoJRHK+11YIF+fCceVUzT4
 EpnFWGboqO95pzsllw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1rWpVj0JXc-00UsAK; Tue, 23
 Jan 2024 21:38:51 +0100
Message-ID: <d3f3fc7f-b29a-4503-9fe0-97468bbe1f71@gmx.de>
Date: Tue, 23 Jan 2024 21:38:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader : Suppress error print message
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
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <BL3PR12MB64505057156F40CDD884FB90D8742@BL3PR12MB6450.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QmcH2TAS9a2wC3yEk/+Om9bW5EGt63Vq/9+2vd1lw7EGFvjLfpl
 Uy5IjvJSx6iDGvq7oqal28Ssgsvq1s9kPOvJEV7JuaJwJp09IpuCLVL/iewPvZokgiBeol8
 /sTzpdKZSvSyLyF0CuhHjXqc4xzNwPAHRBdzw78F/WEcrQT4mBrKs+G/45SwR/t470xOCqj
 q3loaeksmmI8NXfu0NNEg==
UI-OutboundReport: notjunk:1;M01:P0:6J2ieXlE6hc=;jJxUvzgSpYAgpSCALSrXbdQ5NA3
 hYrlRyKZptjxTQHSoCaUgF6HJWz1jNY7/mf9DCjW3siPyVErQ4O0s7aDHuuBVdBaxbGnCDVMK
 vj1Ll/8m8Bf15DL4tCjvMtMC96jrWfNIdVUprKDG+RU9hHjtI2VpNqEk6rRFvO33CtsihOz3e
 XtvQTKL7bJvZe6D9RuWWsIcnP2dh14LIXXlkHB845o3OFlx2vyKxknAM07K9VRfu+QiKWqlzI
 M+UvnDdaPwPzhwUNC46xUDMiVF/vd5YkA8gFkC3iMavmbNcO0XkZyhykPV2EVW42SfSFPCPBn
 r352VmcrGkXvPG4dN+QS2ypMNB5us+3hmqXFw/L5jyJDzZbM3Jd+5JQ7PnsYSmDBQl3srrSbW
 eqL6ukK5pMDVOUYY3VzAlp7yXOQcrig02wGy7Xhz3OE5Nqh59VGUVx/FMQIjMinIf8ZZlESvQ
 fazcipMgOvtj8JGPqAw4kNGqrKliK2NaurSlUpB9VJO31HHLLiX2SY2lm5WbT2IawO2TQFJJn
 i9aDbOi4KFJZfx89JeaQeab178SmcH4ylPt84CQFTfZsmJ1LveQ4COWnE2BewICo+Iw7FffRF
 pxE/CgJWLfVhRpCHRT+5mxJPvbAze8i0any4BQT0pttf3DpOe08wLjz2/+kEFkcST7QKEV6KL
 GauM/CgHp1ZcDTJOaqKMhfQXyahu2eJtzS6y+zBVtawP2wHX86QnDn8Mwk6VcnzXIOKFsKItm
 xhhv0/ssns71DwvC9E96GjhRfPNxQMwAEs6MWr7mv/mOZMjOLW5CNMT0BX/I2QgR1lxPgibfc
 odSBI0FyEAUYrQr7cF0wtv0/jGTto3vLgA6bV448haJmx8B4f5tZYJurG+NocqWEbDfrwXoVW
 BDSSrBM8SDeEfnvuIY8UFOcYXaf1NL3A/ntWLPe5GCvr47tx2Z5u+4Z+CSKgPsmg+PMD1YOhG
 9tsjbg==
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

On 1/23/24 19:53, Bhumkar, Tejas Arvind wrote:
> [AMD Official Use Only - General]
>
> Hi Ilias & Heinrich,
>
>> -----Original Message-----
>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Sent: Tuesday, January 23, 2024 3:30 PM
>> To: Ilias Apalodimas <ilias.apalodimas@linaro.org>; Bhumkar, Tejas Arvi=
nd
>> <tejas.arvind.bhumkar@amd.com>
>> Cc: u-boot@lists.denx.de; xypron.glpk@gmx.de; trini@konsulko.com;
>> sjg@chromium.org; Simek, Michal <michal.simek@amd.com>; Abbarapu,
>> Venkatesh <venkatesh.abbarapu@amd.com>; git@xilinx.com
>> Subject: Re: [PATCH] efi_loader : Suppress error print message
>>
>> Caution: This message originated from an External Source. Use proper ca=
ution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 1/23/24 09:33, Ilias Apalodimas wrote:
>>> Hi Tejas,
>>>
>>> On Mon, 22 Jan 2024 at 21:12, Tejas Bhumkar
>>> <tejas.arvind.bhumkar@amd.com> wrote:
>>>>
>>>> Currently, on certain Xilinx platforms, an issue has been identified,
>>>> manifesting as follows:
>>
>> Hello Tejas,
>>
>> thank you for bringing forward this issue.
>>
>> Which defconfig are you relating to?
>
> [Tejas]:
> Checking with xilinx_zynqmp_virt_defconfig
>
>>
>>>>
>>>> Starting kernel ...
>>>>
>>>> efi_free_pool: illegal free 0x0000000077830040
>>>> efi_free_pool: illegal free 0x000000007782d040
>>>> efi_free_pool: illegal free 0x000000007782c040
>>>>
>>>> The issue arises when the ramdisk image is relocated, placing it
>>>> within the previously allocated EFI memory region( as EFI is
>>>> established quite early in U-Boot).
>>
>> Which version of U-Boot are you on? Commit 06d514d77c37 ("lmb: consider=
 EFI
>> memory map") was meant to avoid such a situation.
>
> [Tejas] :
> I'm verifying against the latest changes in the master branch. The intro=
duction of commit 06d514d77c37 ("lmb: consider EFI memory map") has resolv=
ed the occurrence of the "efi_free_pool: illegal free" error. but, it lead=
s to a new error, as detailed in the following patch: https://lore.kernel.=
org/all/20230212150706.2967007-1-sjoerd@collabora.com/

Could you, please, try to reproduce your issues with origin/master as of
today and provide the full boot log. Please, also provide the output of
the bdinfo and the printenv command as well as the sizes of the kernel
and the RAM disk.

Best regards

Heinrich

>
>>
>>>
>>> I don't mind suppressing the print for some time, but out of
>>> curiosity, how is the ramdisk relocated? LMB should be aware of the
>>> EFI regions by then, so I assume the relocation code doesn't check
>>> those?
>
>
> [Tejas] :  I observe that the relocation of the RAM disk is taking place=
 in the line below.
> https://github.com/u-boot/u-boot/blob/master/lib/lmb.c#L480-L491
> Yes, the relocated code specifically examines the LMB region and does no=
t consider the EFI region.
>
>>
>> The indicated situation is serious. If the EFI sub-system is using the =
same memory
>> area as the ramdisk, this may lead to corruption of the ramdisk. Suppre=
ssing the
>> messages is by no means adequate to solve the problem.
>
> [Tejas] :
> The challenge arises when relocating the ramdisk image, inserting it int=
o the previously assigned EFI memory region,
> established early in U-Boot. Consequently, when attempting to release me=
mory in the EFI region during the handover
> process to the kernel in the efi_free_pool function, we first verify if =
the memory was allocated by efi_allocate_pool().
> The issue originates from a checksum mismatch because, during the ramdis=
k relocation, we overwrite memory allocated by EFI.
> This leads to the appearance of the error message: efi_free_pool: illega=
l free 0x0000000077830040.
> Crucially, there is no corruption of the ramdisk seen since we do not ac=
tually releasing memory due to the checksum mismatch.
> In our testing, this issue was observed only when the ramdisk size excee=
ded approximately 24 MB.
>
>>
>> Best regards
>>
>> Heinrich
>>
>>
>>>
>>> Thanks
>>> /Ilias
>>>
>>>> Consequently, when
>>>> attempting to release memory in the EFI memory region during the
>>>> handover process to the kernel,we encounter memory violations.
>>>>
>>>> Highlighting that EFI remains active primarily during the booting of
>>>> an EFI application, and the lmb persists while configuring images for
>>>> the boot process. Since we aren't utilizing the EFI memory region
>>>> during the boot process, there is no adverse impact even in the event
>>>> of a violation.
>>>>
>>>> Currently, there is an ongoing discussion regarding the handling
>>>> strategies of three memory allocators: malloc, lmb, and EFI. This
>>>> discussion is documented in the email chain titled "Proposal: U-Boot
>>>> memory management."
>>>>
>>>> Therefore, it is advisable to suppress the print message during the
>>>> boot process for now.
>>>>
>>>> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
>>>> ---
>>>>    lib/efi_loader/efi_memory.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/efi_loader/efi_memory.c
>>>> b/lib/efi_loader/efi_memory.c index edfad2d95a..821fe7616e 100644
>>>> --- a/lib/efi_loader/efi_memory.c
>>>> +++ b/lib/efi_loader/efi_memory.c
>>>> @@ -713,7 +713,7 @@ efi_status_t efi_free_pool(void *buffer)
>>>>           /* Check that this memory was allocated by efi_allocate_poo=
l() */
>>>>           if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
>>>>               alloc->checksum !=3D checksum(alloc)) {
>>>> -               printf("%s: illegal free 0x%p\n", __func__, buffer);
>>>> +               debug("%s: illegal free 0x%p\n", __func__, buffer);
>>>>                   return EFI_INVALID_PARAMETER;
>>>>           }
>>>>           /* Avoid double free */
>>>> --
>>>> 2.27.0
>>>>
>

