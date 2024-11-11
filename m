Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA2CD2E9D6
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 10:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BF689365;
	Mon, 11 Nov 2024 11:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iw3IOEUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E70B89371; Mon, 11 Nov 2024 11:47:09 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDEB788A0A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 11:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731322025; x=1731926825; i=xypron.glpk@gmx.de;
 bh=uNTiIMscBgTqZXpBI2wtLxcRxqrx59nuGgJEcbVA2dE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iw3IOEUam0WjPGN7E66vC8sZlK73QPtTHh+a0Bij/7BEQxy/yk8HSMhRP+azxkHB
 uXSVHSO3YQtMqmk1FkNEkKhImGk+hLdy/GMcGtohQ1xXfuD+xd0Ngyoe7M+9TUNhw
 e66X8K2FoNFDxHM/X/rO2AXgnx2yNzdaE9I7SGt2G/gXEGRouaS6HEWL4mo9T4Q+p
 Wv+VyzJjMwPVSPHjFujCYv4FGfJAnoi9uhWgXJBro0zSUdXPn24aAHapJsScnmaMB
 jhweyltFp7Yr9DnDsCQo84WSYY6ytX3umWsOdqGm3UTEtmWc2JstVoZAa8I93HYvn
 YEJc9ESSr1mjcGdo5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1tvnSo0QQx-00zFPJ; Mon, 11
 Nov 2024 11:47:05 +0100
Message-ID: <c2abb147-43eb-482e-85ae-1dd4d857ef96@gmx.de>
Date: Mon, 11 Nov 2024 11:47:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Correctly unmap and free memory on errors
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241024104603.1340301-1-ilias.apalodimas@linaro.org>
 <1334fa3c-95e1-41d7-b0e4-db1452de136d@gmx.de>
 <CAC_iWjKmJYNRRicG7Fpy_WN+4gGKQrnTWW_r02efYN0ceTZ7Pg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKmJYNRRicG7Fpy_WN+4gGKQrnTWW_r02efYN0ceTZ7Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vu/ycYWDl8oKv/Il504XrdvVGo4V2yF3Apq0t034O/mm2qTPxRM
 VPxQoKZ6WWTkEoymH7jQw8lzV53ae27XanM65fnxXCiL+8eOHWbr6ClrKOmAgGDtK3k6HcJ
 3WYN1KxkJWzIqHBGVhrOfYOyK1cT3IrHoKWAye6RVZsdRyuZz+YHs6dP26FVGNLYONu/acE
 aWJwMXVixtD6EYuxRF5vQ==
UI-OutboundReport: notjunk:1;M01:P0:KixCJ3A6kBQ=;trdrMM2CBdnZi+TGL0RdapRBBHq
 8pi9Lymgzv9TAlglqfVc86l4QsMRYCj94P+su1+arvme/asvCHGLzpp2ZBqC+jLNIl8ZE/u//
 O96/M8yY776ugSH0WnN1Q1OG2/N6dJAPN3cnJNce2O3dIMowzQcOjXpZEZihHmhJaxH4apI6Z
 mDTz31AMztia2q4jmPiG8xZDm1iA4lTYo0PmIDT2VVeKlaR5qkyXbTPYlZGAmJgEqlw/6xaZQ
 Dc+tOfrE8RPpK38wqOw4NquNl/kntXL4ZiJ1Sp4JmL/FYwFi96exWYuGRVOI/in5rZBH7M4p6
 Sb0wMiVIUPxtaezvMUDW4hnsjhrvZCwUoWjEmfSLFXyQYfGZKWKhI5ZA13PYleD+//2EjnRo6
 1owurng5aXmPzrN59z60/tjhir3FiIsdVpX7FpmCAHFJOT3obKZN4illbkTUuPi9hMXQP1pTR
 4tX8ngtPtYv2HT8L59CqLlnkowugj3aCQQlGlHQolQVSSBSNprxT+MtaIBT+BUiymay75W9U1
 wgSKG3GsgLq3ebf9kVBTDPWaCh1XbFriqQ3GRtAXpi1Yvy55Ko+TdVWVDcqqNO5JLGNpydTXl
 j8sS690J2dXorDmjcrr1OEQGUfT567oiwI+uOAoFZZOJ8gbIJ5UsQUKw9Mf4oSFnzBXCrkV38
 ciYSn+c9UNwPyP/bQ/Q544N8tEvuehSU/bax0Hz0bXBsAilqTVL7l03ObHCl70ZHHzDqSqZzZ
 M/5iH7KFuj7ZfkiYt90loY4Zt9TaVv2azl+D4jfRD9WXCNQHRAGDqVerF8T+FRN11ufclFHbX
 3IMmyUwKOJPAQJcnDunjWLVw==
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

On 10/29/24 09:46, Ilias Apalodimas wrote:
> Hi Heinrich
>
> On Mon, 28 Oct 2024 at 08:40, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 10/24/24 12:46, Ilias Apalodimas wrote:
>>> We never free and unmap the memory on errors and we never unmap it whe=
n
>>> freeing it. This won't cause any problems on actual hardware but it wi=
ll
>>> on sandbox
>>>
>>> Fixes: commit 22f2c9ed9f53 ("efi: memory: use the lmb API's for alloca=
ting and freeing memory")
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> ---
>>>    lib/efi_loader/efi_memory.c | 15 ++++++++++-----
>>>    1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>>> index 9f3f08769977..84be5532a655 100644
>>> --- a/lib/efi_loader/efi_memory.c
>>> +++ b/lib/efi_loader/efi_memory.c
>>> @@ -451,7 +451,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_=
type type,
>>>                                enum efi_memory_type memory_type,
>>>                                efi_uintn_t pages, uint64_t *memory)
>>>    {
>>> -     u64 len;
>>> +     u64 efi_addr, len;
>>>        uint flags;
>>>        efi_status_t ret;
>>>        phys_addr_t addr;
>>> @@ -499,14 +499,17 @@ efi_status_t efi_allocate_pages(enum efi_allocat=
e_type type,
>>>                return EFI_INVALID_PARAMETER;
>>>        }
>>>
>>> -     addr =3D (u64)(uintptr_t)map_sysmem(addr, 0);
>>> +     efi_addr =3D (u64)(uintptr_t)map_sysmem(addr, 0);
>>>        /* Reserve that map in our memory maps */
>>> -     ret =3D efi_add_memory_map_pg(addr, pages, memory_type, true);
>>> -     if (ret !=3D EFI_SUCCESS)
>>> +     ret =3D efi_add_memory_map_pg(efi_addr, pages, memory_type, true=
);
>>> +     if (ret !=3D EFI_SUCCESS) {
>>>                /* Map would overlap, bail out */
>>> +             lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags=
);
>>> +             unmap_sysmem((void *)(uintptr_t)efi_addr);
>>>                return  EFI_OUT_OF_RESOURCES;
>>> +     }
>>>
>>> -     *memory =3D addr;
>>> +     *memory =3D efi_addr;
>>>
>>>        return EFI_SUCCESS;
>>>    }
>>> @@ -548,6 +551,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_u=
intn_t pages)
>>>        if (ret !=3D EFI_SUCCESS)
>>>                return EFI_NOT_FOUND;
>>>
>>> +     unmap_sysmem((void *)(uintptr_t)memory);
>>> +
>>>        return ret;
>>>    }
>>>
>>> --
>>> 2.45.2
>>>
>>
>> AllocatePages() only provides access to EfiConventionalMemory.
>>
>> We can safely call map_sysmem() with len =3D 0 and not use unmap_sysmem=
().
>
> I am not sure I am following you here. We are calling it with len =3D 0.
> But map/unmap_sysmem keep track of internal ref counters for sandbox
> and the special tag case. Why shouldn't we call unmap_sysmem()?

As discussed on IRC the sandbox currently does not do reference counting
for conventional memory. Ilias suggested to leave it here for consistency.

Moving the patch to the EFI patch queue.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
> Thanks
> /Ilias
>>
>> Best regards
>>
>> Heinrich

