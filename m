Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06989D59D90
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 10:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4483C89699;
	Tue, 26 Nov 2024 11:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Zf9VFStk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93842896A3; Tue, 26 Nov 2024 11:13:47 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6122789697
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 11:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732616021; x=1733220821; i=xypron.glpk@gmx.de;
 bh=BQXI+hIpmod8FTo513oHfdtJoTYqHFypn8S8O43Z9bA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Zf9VFStkZSX5CrG/uleuY05aVrYiPpV2SWFKzZDrGYqrqEAZL84SrJLXmrY1EgMB
 Fd6G685obiAn5ANUUylSDOSv4yKf4j09QEj6jEXdIkNXyteSe+SZQ8ThllxlAsPZ6
 prMejo+othDuG1lrZcVO53xkghbnEBwJBL7IzxYYUmnmhe4jqw4y1fyP4d2gdtCvq
 45uk8d1nic/eDNXC9YDoFPhjvcAId0V1hayXD+9nZTi9YTPKbtqjNQPUIrbiZi77X
 Tqs5SywLkXmlGffeYPE9q9aPA3n4wy9B4JSLij4IzezAvUckg1T0rCF2Y9dfukVqY
 iuRt8N9oL7ZFg0b50w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1tJzAi2HBp-009mtp; Tue, 26
 Nov 2024 11:13:41 +0100
Message-ID: <e0493294-0e67-4645-bc19-3b895f13c356@gmx.de>
Date: Tue, 26 Nov 2024 11:13:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] efi_loader: Make more use of ulong
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-8-sjg@chromium.org>
 <CAC_iWjKAWrgFuKrNBq_+J9Tr726Aoor4+b=sPYwfydxfC6bevg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKAWrgFuKrNBq_+J9Tr726Aoor4+b=sPYwfydxfC6bevg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pKdCeP0TdDfPdLeEmVbJUBCfA3Wn1rEw1h2lj/Be/F8GuX3lLGY
 GnfeQtpLDLVslJeLF7VjGweiFD0nMKrllNMaba8HBOoOkBbxdQCSh0Mi7vqvUzLL+P0bhvv
 4bsQhGfx9IIOg/9M59aQRtDSEba/Q/FED02igbnGuWwUPi5kbko8O+rS7Oj6FRoSkAcRqBM
 ZmrFRtszAeA76KjjMmkvw==
UI-OutboundReport: notjunk:1;M01:P0:41yx8b9et8A=;VQkcFqqCGFdu7a3bFPUVaxOnRtf
 SSlwptow1srMrQncWFpoqkIrzfEEnFQwfcht9fknmXYuro2wQoENICZ+cgupSn/4ALDz0QSk6
 rV483PV2P8org4l60y8AsjcOej0gXX2uJ1Y8nYwTKdhDfaIrrmz6aC0ojLVssqX4Raqmxw99I
 HszgdvsvzIxbg+KMxplUHlvE09MaKLAB0JTKq9pbYff8N9AyDPcwzKJFWYr5EKfHc+Z5pYzh0
 WeG2D+0JHncqcmhQka4El7f+YnCi5xRgIHuux20dPPMcWhviauROkM7iw/497ue7xpCA/bXa2
 UVJUPKrb6epR6ggSRWjiEokIU+VSdz0rqaQJGu1hCBzyP/hdBF3qDcd3L6TNRW+IdbITzjvsg
 mV8hHkouUXvCjiIYXnecD9VTx7HtPXdlXVFAjMF9RwBZvn6irRyT7WN7J9HPwHaP6/5ZS1Zt7
 4Mq76eWQMvzDKNq42FJqfIEfVg4HSviIyI7AKhnKjLJROG/xvQcro1GH6m9UOCpK32OtT5zcr
 LgMBuzdyjvMRQ07de8Nl/8OdEYWnHnc32osAOEEqzuz0hRqrOFYADDOo/NjgI/78XOvmfUU1s
 4ZmvS1T2TJStJ3ZP1odK7EL9sgWlDvaq4I0VB6eZtIsmFRR4AfJei1RjuqyFyEojPcTzTBNBO
 HO98dUaH3NmnKSdNUQMNud+JyC/EwBg6pknkJjwEjaCYV107AgIYzf6lz6JZwR1fjPs3gIBze
 G010HytJkpX9hwbtG/+vZT64p+lKbFOyQPhED5NHPB+f5Rc89HxuVjeHHg7QveMX3jVPi2I16
 sa5y85J4J9ThfyKLXM/XEaEK9lTEuHLaO4r3DksyZj5OQttuWFQs2I4jG8znAoAqNY7IhTzkU
 F4dWFCEmNaqRNBC/wy258tHINtEQyqgKNCSTyQnDxVr5XW/jy8tKmPwqu
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

On 26.11.24 09:00, Ilias Apalodimas wrote:
> Hi Simon,
>
>
> On Mon, 25 Nov 2024 at 22:45, Simon Glass <sjg@chromium.org> wrote:
>>
>> One of the confusing parts of the EFI loader is that it uses u64 for
>> addresses, whereas the rest of U-Boot typically uses ulong.

You are confusing sandbox virtual addresses (phys_addr_t) with the
physical addresses (EFI_PHYSICAL_ADDRESS) in the UEFI spec.

The EFI specification requires an identity mapping. This means the value
of a EFI_PHYSICAL_ADDRESS must be usable as a pointer.

The sandbox virtual addresses are not usable as pointers on the sandbox
and hence cannot be used for EFI_PHYSICAL_ADDRESS.

EFI_PHYSICAL_ADDRESS is a 64bit type.

The only useful place for sandbox virtual addresses is in the CLI. We
should get rid of them anywhere else to avoid further confusion.

>>
>> There is a case on 32-bit machines where phys_addr_t can be larger than
>> 32 bits, but this is very much the exception. Also, such machines have
>> mostly faded away and generally don't make use of EFI.
>
> I am not sure how true this statement is with LPAE etc. In any case, I
> don't want us to convert to ulong, there's no reason to break things
> for platforms we can't test.  So please drop this patch
>
> Thanks
> /Ilias
>>
>> So in the interests of consistency, update the memory functions to use
>> ulong in most cases.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>>   include/efi_loader.h        |  4 ++--
>>   lib/efi_loader/efi_memory.c | 42 ++++++++++++++++++------------------=
-
>>   2 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index 0ef4c6f7dea..cae94fc4661 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -838,7 +838,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory=
_map_size,
>>    * @mem_type: EFI type of memory added
>>    * Return: status code
>>    */
>> -efi_status_t efi_add_memory_map(u64 start, u64 size,
>> +efi_status_t efi_add_memory_map(ulong start, ulong size,
>>                                  enum efi_memory_type mem_type);
>>
>>   /**
>> @@ -852,7 +852,7 @@ efi_status_t efi_add_memory_map(u64 start, u64 size=
,
>>    *                             memory
>>    * Return:                     status code
>>    */
>> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>> +efi_status_t efi_add_memory_map_pg(ulong start, ulong pages,
>>                                     enum efi_memory_type mem_type,
>>                                     bool overlap_conventional);
>>
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index 2c46915e5b9..4e9c372b622 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -199,10 +199,10 @@ static s64 efi_mem_carve_out(struct efi_mem_list =
*map,
>>   {
>>          struct efi_mem_list *newmap;
>>          struct efi_mem_desc *map_desc =3D &map->desc;
>> -       uint64_t map_start =3D map_desc->physical_start;
>> -       uint64_t map_end =3D map_start + (map_desc->num_pages << EFI_PA=
GE_SHIFT);
>> -       uint64_t carve_start =3D carve_desc->physical_start;
>> -       uint64_t carve_end =3D carve_start +
>> +       ulong map_start =3D map_desc->physical_start;
>> +       ulong map_end =3D map_start + (map_desc->num_pages << EFI_PAGE_=
SHIFT);
>> +       ulong carve_start =3D carve_desc->physical_start;
>> +       ulong carve_end =3D carve_start +
>>                               (carve_desc->num_pages << EFI_PAGE_SHIFT)=
;
>>
>>          /* check whether we're overlapping */
>> @@ -257,17 +257,17 @@ static s64 efi_mem_carve_out(struct efi_mem_list =
*map,
>>          return EFI_CARVE_LOOP_AGAIN;
>>   }
>>
>> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>> +efi_status_t efi_add_memory_map_pg(ulong start, ulong pages,
>>                                     enum efi_memory_type mem_type,
>>                                     bool overlap_conventional)
>>   {
>>          struct efi_mem_list *lmem;
>>          struct efi_mem_list *newlist;
>>          bool carve_again;
>> -       uint64_t carved_pages =3D 0;
>> +       ulong carved_pages =3D 0;
>>          struct efi_event *evt;
>>
>> -       EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
>> +       EFI_PRINT("%s: 0x%lx 0x%lx %d %s\n", __func__,
>>                    start, pages, mem_type, overlap_conventional ?
>>                    "yes" : "no");
>>
>> @@ -370,10 +370,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64=
 pages,
>>          return EFI_SUCCESS;
>>   }
>>
>> -efi_status_t efi_add_memory_map(u64 start, u64 size,
>> +efi_status_t efi_add_memory_map(ulong start, ulong size,
>>                                  enum efi_memory_type mem_type)
>>   {
>> -       u64 pages;
>> +       ulong pages;

The result of efi_size_in_pages() is u64.

>>
>>          pages =3D efi_size_in_pages(size + (start & EFI_PAGE_MASK));

Maybe we should check here that pages <=3D SIZE_T_MAX.

>>          start &=3D ~EFI_PAGE_MASK;
>> @@ -396,13 +396,13 @@ efi_status_t efi_add_memory_map(u64 start, u64 si=
ze,
>>    * @must_be_allocated: return success if the page is allocated
>>    * Return:             status code
>>    */
>> -static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocat=
ed)
>> +static efi_status_t efi_check_allocated(ulong addr, bool must_be_alloc=
ated)
>>   {
>>          struct efi_mem_list *item;
>>
>>          list_for_each_entry(item, &efi_mem, link) {
>> -               u64 start =3D item->desc.physical_start;
>> -               u64 end =3D start + (item->desc.num_pages << EFI_PAGE_S=
HIFT);
>> +               ulong start =3D item->desc.physical_start;
>> +               ulong end =3D start + (item->desc.num_pages << EFI_PAGE=
_SHIFT);

Physical start is u64 as defined in the EFI standard. ulong makes no
sense here.

>>
>>                  if (addr >=3D start && addr < end) {
>>                          if (must_be_allocated ^
>> @@ -420,7 +420,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_t=
ype type,
>>                                  enum efi_memory_type mem_type,
>>                                  efi_uintn_t pages, uint64_t *memory)
>>   {
>> -       u64 efi_addr, len;
>> +       ulong efi_addr, len;

efi_allocate_pages must return u64. Using ulong for efi_addr does not matc=
h.

>>          uint flags;
>>          efi_status_t ret;
>>          phys_addr_t addr;
>> @@ -430,7 +430,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_t=
ype type,
>>                  return EFI_INVALID_PARAMETER;
>>          if (!memory)
>>                  return EFI_INVALID_PARAMETER;
>> -       len =3D (u64)pages << EFI_PAGE_SHIFT;
>> +       len =3D (ulong)pages << EFI_PAGE_SHIFT;
>>          /* Catch possible overflow on 64bit systems */
>>          if (sizeof(efi_uintn_t) =3D=3D sizeof(u64) &&
>>              (len >> EFI_PAGE_SHIFT) !=3D (u64)pages)
>> @@ -491,7 +491,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_t=
ype type,
>>    */
>>   efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
>>   {
>> -       u64 len;
>> +       ulong len;

pages << EFI_PAGE_SHIFT may be more than ULONG_MAX on 32bit systems.

>>          long status;
>>          efi_status_t ret;
>>
>> @@ -506,7 +506,7 @@ efi_status_t efi_free_pages(uint64_t memory, efi_ui=
ntn_t pages)
>>                  return EFI_INVALID_PARAMETER;
>>          }
>>
>> -       len =3D (u64)pages << EFI_PAGE_SHIFT;
>> +       len =3D (ulong)pages << EFI_PAGE_SHIFT;

This might overflow on 32bit systems.

>>          /*
>>           * The 'memory' variable for sandbox holds a pointer which has=
 already
>>           * been mapped with map_sysmem() from efi_allocate_pages(). Co=
nvert
>> @@ -525,10 +525,10 @@ efi_status_t efi_free_pages(uint64_t memory, efi_=
uintn_t pages)
>>   void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
>>                                size_t align)
>>   {
>> -       u64 req_pages =3D efi_size_in_pages(len);
>> -       u64 true_pages =3D req_pages + efi_size_in_pages(align) - 1;
>> -       u64 free_pages;
>> -       u64 aligned_mem;
>> +       ulong req_pages =3D efi_size_in_pages(len);

Please, use efi_uintn_t as this is the parameter type of AllocatePages().

>> +       ulong true_pages =3D req_pages + efi_size_in_pages(align) - 1;
>> +       ulong free_pages;
>> +       ulong aligned_mem;

This does not compile on 32bit. efi_allocate_pages expects *u64 as
parameter.

>>          efi_status_t r;
>>          u64 mem;
>>
>> @@ -572,7 +572,7 @@ efi_status_t efi_allocate_pool(enum efi_memory_type=
 mem_type, efi_uintn_t size,
>>          efi_status_t r;
>>          u64 addr;
>>          struct efi_pool_allocation *alloc;
>> -       u64 num_pages =3D efi_size_in_pages(size +
>> +       ulong num_pages =3D efi_size_in_pages(size +
>>                                            sizeof(struct efi_pool_alloc=
ation));

The EFI specification defines the argument parameter Pages of
AllocatePages() as being UINTN. So we should use efi_uintn_t here.

Best regards

Heinrich

>>
>>          if (!buffer)
>> --
>> 2.43.0
>>

