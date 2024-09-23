Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A732CF9C6E
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 12:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA2588D1F;
	Mon, 23 Sep 2024 14:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KTflz5od";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5752188CBA; Mon, 23 Sep 2024 14:15:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E74088CBA
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 14:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727093734; x=1727698534; i=xypron.glpk@gmx.de;
 bh=px2dMe47nLNHot+tfVYmCbSzy8Le8QcSkAzor0NYlqQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KTflz5odyJ5dy9AWZUSgLzUkl1s9D3d/aFQGcuoDtlxWXYOMWI2cWF45h0k/p8HB
 eUcp9/FARCddFAeu3DJJxCrRir/t4Qznx0S1nHm17ZVcDdSiOz8peHhAbnQGAlasu
 ibQ628asMsCA4Bue0LXUVBjfk4x5JQCqUbMBhfDsIEF/sR652gVkjH9lGzM6M+inH
 Z+hCpsP5B+5hAq6V/h/2dY8iMSI/09bu3RlC23P1sjjgxeDy3OAT1StKJfgSOA0Ry
 nOgnwIJP+WVtq4vNXoPiGyMUcuRAi0TezKHuE7KFIZY4QEnD+0u9WPZmOgJ6YNfA9
 BwSNjkAukMQefUoAtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1sA25h2rjL-00qmJV; Mon, 23
 Sep 2024 14:15:34 +0200
Message-ID: <8309d2cf-ae84-4907-a6a4-9d6f5a4b8206@gmx.de>
Date: Mon, 23 Sep 2024 14:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] efi: Drop the memset() from efi_alloc()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-2-sjg@chromium.org>
 <52f2da9e-924c-44b4-8390-7d604d07ab33@gmx.de>
 <CAFLszTj9hhNfC8QvRaQnb3HDyJ_+e9uExVo2rvy+K=_1xQOoqg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTj9hhNfC8QvRaQnb3HDyJ_+e9uExVo2rvy+K=_1xQOoqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VPvokG+6NtFdQRdLomjNpTuMtiZU7dlOe+xuArx3yLfjBBWwQOs
 Mn1kDnDaLGGV8YYMd3bZn9bXiCzUEEJX8XJFIMOOXQi1YqWcNfNe9qDiaZps6nKbLVvyl+J
 Ok604ez1rBarMGUKLqFSwiem6SZNArq6a4RIzMgIeSz28+aHvOWezcsf3vQBCnwgGiqDQ0W
 ESqlO/L+zhLZ2EYhyX2Ow==
UI-OutboundReport: notjunk:1;M01:P0:ZjdxrDcH2bQ=;nD8v1OSQZyTFUMQ5/MA6KPNDniN
 hHrD12fFoJrXCnyM96t+ZJT0pEDrjrzN4ITNbN0SY4b+DZfAb/C/jJ9ksm68cKYpGF4XsM3O0
 IAxQFkxw4bb8/zepEH8WE+I0ivDsPKUWkoY4p6FPviaMYcGhBYnc//tMyP8QgYq3zypUYkL7U
 wKBO/3wNbETi96HaCc0ybWNq5tdRDlxD0qK2gaUBNW0QgQC+8A6W/vQ/ypMl3FrHAlSffjRss
 NH96dETfgJurdykxRz8+aptHpHitG8kdLtMx1z02mjNP52zo4lDD0w0djDHLq7Ixwv7n9rSjG
 xiTknpRGY5dS8yZMs+w0Ae+8t5KVd4AoCLnLuj8aa8OX7AtN+vYOpOhWTr5MP54ZrGXqA58Qh
 GTPigrX1LBNxThLjSlL93OPz1KAGHmm+LtVFv806sNXdyj7Tjq39RiwxywWO2Lk5S8SHLsN+n
 /OXjAZ6wxeazB59YCFV32RgTzOTp2T50O3Fz8gtHr7802tHK0VOvjjKaV3IJ9SxY/EpmjO4x1
 aClOe5Fb9n0jqe/dQdc3fo/gj4q1qLuxI1iGThVMioJ1ypX3b5cIWkgfM3IxvneK7ciYg++5A
 bVgmB9PXGU/i/vVJVNezndaKF6F+REANQp6YlGtXOomMsUsPpYrzPWMMKL+3tkuA0CRODmygk
 7Z00BnZyesXYJh7ti9zAfRTy+7058bHuMbSpGRqqzT22Zq1epu9D9DygRD3LUXvODSpyPBIZw
 yZeNBO+OX6IVRl5aF8XTTG1jEIHYZaU1nkcsQgfMlP7bq0xPT+PeEmW1sdS63nuq9GbZ4oeFN
 hK+Nmy4a7wEz/yEIPFINhVBw==
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

On 19.09.24 16:13, Simon Glass wrote:
> Hi Heinrich,
>
> On Sat, 14 Sept 2024 at 09:40, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
>>
>> On 02.09.24 00:22, Simon Glass wrote:
>>>   From my inspection none of the users need the memory to be zeroed. I=
t
>>> is somewhat unexpected that it does so, since the name gives no clue t=
o
>>> this.
>>
>> Though the UEFI specification does not require it, EDK II uses
>> AllocateZeroPool() to implement
>> EFI_DEVICE_PATH_UTILITIES_PROTOCOL.CreateDeviceNode(). We should not
>> deviate from it.
>
> Are you saying that there is an unwritten convention in the spec? My
> inspection of the code leads me to believe that all of the bytes which
> are allocated are written to, within that code, so that zeroing the
> bytes serves no purpose.

EFI_DEVICE_PATH_UTILITIES_PROTOCOL.CreateDeviceNode() is an API:

You have to consider the current and future usage outside U-Boot.

For saving a few microseconds I would not want to give up compatibility
with EDK II.

>
> My goal here is to allow use of malloc(), instead of calloc(), for examp=
le.

The caller of the API has to release with the memory with FreePool(). So
we should allocate it with AllocatePool().

See chapter 10.5.8
"EFI_DEVICE_PATH_UTILITIES_PROTOCOL.CreateDeviceNode()" in the UEFI
specification.

Best regards

Heinrich

>
>>
>>>
>>> Drop the memset() so that it effectively becomes a wrapper around the
>>> normal EFI-pool allocator.
>>>
>>> Another option would be to drop this function and call
>>> efi_allocate_pool() directly, but that increase code size a little.
>>>
>>> Move the function comment to the header file like most other exported
>>> functions in U-Boot.
>>
>> Yes, we should move all non-static EFI function descriptions to headers=
.
>> But it makes no sense to move the comments of a single function and
>> leave the other functions unchanged. Have a look at doc/api/efi.rst.
>
> I normally like to do these things one at a time, when changes are
> needed, to avoid massive wholesale changes with no other purpose. That
> is what has happened with image.h over time. But OK I can drop that
> part of the patch, once we sort out the zeroring.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> Changes in v3:
>>> - Add new patch to drop the memset() from efi_alloc()
>>> - Drop patch to convert device_path allocation to use malloc()
>>>
>>>    include/efi_loader.h        | 11 ++++++++++-
>>>    lib/efi_loader/efi_memory.c |  9 ---------
>>>    2 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>> index f84852e384f..38971d01442 100644
>>> --- a/include/efi_loader.h
>>> +++ b/include/efi_loader.h
>>> @@ -758,8 +758,17 @@ efi_status_t efi_next_variable_name(efi_uintn_t *=
size, u16 **buf,
>>>     * Return:  size in pages
>>>     */
>>>    #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PA=
GE_SHIFT)
>>> -/* Allocate boot service data pool memory */
>>> +
>>> +/**
>>> + * efi_alloc() - allocate boot services data pool memory
>>> + *
>>> + * Allocate memory from pool with type EFI_BOOT_SERVICES_DATA
>>> + *
>>> + * @size:    number of bytes to allocate
>>> + * Return:   pointer to allocated memory, or NULL if out of memory
>>> + */
>>>    void *efi_alloc(size_t len);
>>> +
>>>    /* Allocate pages on the specified alignment */
>>>    void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t alig=
n);
>>>    /* More specific EFI memory allocator, called by EFI payloads */
>>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>>> index c6f1dd09456..50cb2f3898b 100644
>>> --- a/lib/efi_loader/efi_memory.c
>>> +++ b/lib/efi_loader/efi_memory.c
>>> @@ -664,14 +664,6 @@ efi_status_t efi_allocate_pool(enum efi_memory_ty=
pe pool_type, efi_uintn_t size,
>>>        return r;
>>>    }
>>>
>>> -/**
>>> - * efi_alloc() - allocate boot services data pool memory
>>> - *
>>> - * Allocate memory from pool and zero it out.
>>> - *
>>> - * @size:    number of bytes to allocate
>>> - * Return:   pointer to allocated memory or NULL
>>> - */
>>>    void *efi_alloc(size_t size)
>>>    {
>>>        void *buf;
>>> @@ -681,7 +673,6 @@ void *efi_alloc(size_t size)
>>>                log_err("out of memory");
>>>                return NULL;
>>>        }
>>> -     memset(buf, 0, size);
>>>
>>>        return buf;
>>>    }
>>
>
>
> Regards,
> Simon

