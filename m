Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68132FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 17:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7B68407D;
	Mon, 27 Apr 2026 19:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Lw446C/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377C584178; Mon, 27 Apr 2026 19:04:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9CB83BC4
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 19:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777309492; x=1777914292; i=xypron.glpk@gmx.de;
 bh=VaN+fQv1YHJH1ZFFhYLzAfzMYSYnzcLqyXRE905vSVA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Lw446C/Mx6M9O9AsdkPlucM3I5bv2aK44pbUAPmGLcTIxiSkk0xjAK8xtzoxSBAz
 ViKvg6X0avUFOAYehStQPqfwZseRXeKJIuwqiw4lLyBJnsenAzeyFxo6h6uUfjZlW
 aAhlF5p/QqKOyUI5SNtht/olfkvLx+YlrW1hlZamkMoeL3N1u6lU9Pd16XdWmEtar
 EumPfaBKoCvqJQ4hxnCNsMQH5ftYgWc/i7XiJCuXyhTjdKRnTlTGbozFKikj2QOhr
 GY9bwdZT0SMRffiX0Kii0YOp2qAyiuboDhc5ihLJK/OvvWGmeqzGnMaHlTaiXtjuW
 cyJ30cr1q8csv0UAvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1vd8g21csE-00fHbt; Mon, 27
 Apr 2026 19:04:52 +0200
Date: Mon, 27 Apr 2026 19:04:49 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
CC: u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH] efi_loader: fix AllocatePages overlap status
User-Agent: Thunderbird for Android
In-Reply-To: <CAC_iWj+iD0m9JL+A++W85+sYQGYSqVHP287ga7g13dkVevy9AA@mail.gmail.com>
References: <20260427150530.3156000-1-harsimransingh.tungal@arm.com>
 <CAC_iWj+iD0m9JL+A++W85+sYQGYSqVHP287ga7g13dkVevy9AA@mail.gmail.com>
Message-ID: <28B9184F-96D7-45AF-84AA-98EB2ECE713A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4BCkp7Ksj88fCydYW7f42GBRVnTP533JKUQyAnycYp64msy5z6r
 gVwYPUEy4mks1RWfiuGjRX5ZkBdqn6kS0rZ3R6FEsHXtCVwQ9olrt6VkCLxe1MyELxvmn6i
 Lx/unSa4lw3BXf04DX9/dQIIA6SJhBczNvDkEox3z+v4g8RRk3QHzMMqC2hqyJmDGjnnDgg
 Qhr7KQhh1Vql26oVrkrUA==
UI-OutboundReport: notjunk:1;M01:P0:fk3SLMa4j7U=;yypFIS+JfJYl9lqHHAx/Kbyxoam
 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
 3YbY6ifOGw0llgSE3/358LMyt4AgMA5gUm20=
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

Am 27=2E April 2026 17:48:21 MESZ schrieb Ilias Apalodimas <ilias=2Eapalodi=
mas@linaro=2Eorg>:
>Hi Harsiman,
>
>On Mon, 27 Apr 2026 at 18:05, Harsimran Singh Tungal
><harsimransingh=2Etungal@arm=2Ecom> wrote:
>>
>> Return EFI_NOT_FOUND for EFI_ALLOCATE_ADDRESS overlap
>>
>> When efi_allocate_pages() is called with EFI_ALLOCATE_ADDRESS, UEFI
>> expects EFI_NOT_FOUND if the requested address range is already
>> allocated or unavailable=2E
>>  U-Boot currently returns
>> EFI_OUT_OF_RESOURCES when efi_update_memory_map() detects an overlap
>> after a successful lmb_alloc_mem(), which does not match
>> EFI_ALLOCATE_ADDRESS semantics=2E
>>
>> Return EFI_NOT_FOUND for EFI_ALLOCATE_ADDRESS requests that fail due
>> to an overlapping EFI memory descriptor, while keeping
>> EFI_OUT_OF_RESOURCES for other allocation types=2E
>>
>> The UEFI specification [1] specifies that
>> EFI_BOOT_SERVICES=2EAllocatePages must return EFI_NOT_FOUND when the
>> requested address range is unavailable or already allocated;
>> EFI_OUT_OF_RESOURCES applies to non=E2=80=91address=E2=80=91specific al=
location
>> failures=2E
>
>Where does the EFI spec say that? EDKII indeed returns EFI_NOT_FOUND
>for AllocateAddress but looking at the function description, I can't
>find anything specific=2E
>
>Thanks
>/Ilias

Thank you Harsimran for investigating this difference to EDJ II=2E

The spec has:

EFI_NOT_FOUND
The requested pages could not be found=2E

and

EFI_OUT_OF_RESOURCEST
The pages could not be allocated=2E

Looking at the text one could assume that EFI_NOT_FOUND should be returned=
 if the pages requested with AllocateAddress don't exist in the memory map=
=2E

If the pages exist and are already allocated EFI_NOT_FOUND does not look l=
ike the right return code according to the spec=2E

It is unclear if for AllocateMaxAddress a comparison to the memory bottom =
is required=2E

The specification should be clarified in the UEFI forum=2E

Best regards

Heinrich=20




>
>>
>> [1] https://uefi=2Eorg/specs/UEFI/2=2E10_A/07_Services_Boot_Services=2E=
html
>>
>> Signed-off-by: Harsimran Singh Tungal <harsimransingh=2Etungal@arm=2Eco=
m>
>> ---
>>  lib/efi_loader/efi_memory=2Ec | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_memory=2Ec b/lib/efi_loader/efi_memory=
=2Ec
>> index b77c2f980cc=2E=2E63cf1a7277f 100644
>> --- a/lib/efi_loader/efi_memory=2Ec
>> +++ b/lib/efi_loader/efi_memory=2Ec
>> @@ -510,7 +510,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_t=
ype type,
>>                 /* Map would overlap, bail out */
>>                 lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
>>                 unmap_sysmem((void *)(uintptr_t)efi_addr);
>> -               return  EFI_OUT_OF_RESOURCES;
>> +               if (type =3D=3D EFI_ALLOCATE_ADDRESS)
>> +                       return EFI_NOT_FOUND;
>> +               return EFI_OUT_OF_RESOURCES;
>>         }
>>
>>         *memory =3D efi_addr;
>> --
>> 2=2E34=2E1
>>

