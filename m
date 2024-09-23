Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E54CF9C69
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 12:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8800588D3F;
	Mon, 23 Sep 2024 14:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uFRr+PYU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A383D88D45; Mon, 23 Sep 2024 14:30:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F1D88CBA
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 14:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727094642; x=1727699442; i=xypron.glpk@gmx.de;
 bh=hpMPFgh1KTRDvMLSqGjaY/m6k+iyGYQthyDmFWUNBrk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uFRr+PYUYgqfBNB9yLsl4xFKE4/HS6dOjKs10+6aOYYumbrt1mgRCDV+buhCfs1a
 1VQGX04qAlvXSkSN/dJZ38VqvobkEMxA+Q0ixkAQlHL5ern9ePggXArWmBf2dBO6D
 tgJQHPLgQ1YA6yhYBv/FzvJB9B5v/D6aShKf0VqwRXz8i+j/ZB9y/ik4LgCDIiUzC
 PxErPu4RQlRakr1HYfBpUjjJ2ISwA7WJ3bUwwPq5IT+GL3ryxN0k+2qARd5r92Qcj
 f6WGVwrxiFa88/4TGyDpbrP5p2kWiNVg9yI5Dl8uk681Ov7X+Mi180bGxUK038yqG
 cECxcpvhQqx7lOJkBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfUe-1sm8d80bdY-00B81Y; Mon, 23
 Sep 2024 14:30:42 +0200
Message-ID: <8bcde947-2b34-4401-b847-121818d8bcef@gmx.de>
Date: Mon, 23 Sep 2024 14:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] efi: Allow use of malloc() for the EFI pool
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-3-sjg@chromium.org>
 <CADg8p96GUQcWXt3HPjjmZxF9o50d05GmPut5icqRr3Z1NA4hrg@mail.gmail.com>
 <CAFLszTiH=c1RYOOgQZMkYn2HQhL9h0d6bq6VRmzW8Hrk1YG6cg@mail.gmail.com>
 <CADg8p95a1iAzmwd-n8Y9EarX03cFUyBE5k+kwGm2PDy1W+PHNA@mail.gmail.com>
 <CAFLszThDsQrjWerLYiMf=T9VVbdT=i0FKbiD_v+Lv7uUZYsZBA@mail.gmail.com>
 <CADg8p953_gFWNigt+rUhLDVDz=DpQwefdpN8qgLaWNcpDZrrKg@mail.gmail.com>
 <CAFLszTiJkS23KGQ20dziPe5sQ0Ey+wCSSO6uV+Y4Ln=-cpuT=w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTiJkS23KGQ20dziPe5sQ0Ey+wCSSO6uV+Y4Ln=-cpuT=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rA7nu44xX0MbirmamhV7PxmYGSimvPW5hZFYz3ndGByPjsg83X3
 726YlMgAfJHQ1/yKeFFpidFQJs/5FHPqaWpnHt4LHqplU070pwiUTKIRelgxalfL7mNo3pW
 Sr2QWjM2gjN453FO7Ztk7TfG58NjAAoKKs7WH1ZP5KVjadefW6qLrVD0j46KyXqsCQ571F3
 /VPchC0iXRYSEX+icOCdQ==
UI-OutboundReport: notjunk:1;M01:P0:TxdQEsOikUI=;NgDcxi4rO0/vtibQy7iFucQhLNx
 yJFnhEfL6lu+mqu8LgWYmer9ITiy+tCT55RN1jA1Sz25ROnS6gkSePLFKMxxK4LRR8xpdhLHY
 9ssIeNdftMTPYzVVndzRcTJVzLNvGx7zlqyJVHfhw4LLm4H8JR2WwVDJ4MqfMofjwHIBE2vMw
 quohweiuI3aHjzESSslVGz6h579jAmT7DXplO/jo0XSoP+F+VWkjhwZ6elZwBjT5cbXhgm9aq
 uWrsjxZBOOU7E5GMSf8E2KB6D8/br/ieYI3RX5VQejQ2zHqyY5y8g/G3DzT74Z9lD279od2Nf
 1jHjd55MkUADFrYefOrCkls4X55P7NZgYqa8i+kRjtLMka9xoETwABTW+WaXSvXd4jeP7gbWI
 kiWiEra4CX0pfrUbOMywu805DNfMuGwYWsvT2i/dv06pvLAIf+L0OX+yzUsC4J+FQXh7894at
 NZP35kPsy90I+Tkt37a/FPB9wmEAjxu4gknDhii1724zXf9k4AeFOelIhMU4BO62HQCcvOaOC
 LeAPpsJ9OT92lO6K+CSP4U5Z8wv+a/6Bzhp/OVhHf/uL3FsxXiOZQnXlV1/3r2Y4YyjAI9Lew
 ZIPJIVhBzTzKZJa8Rj7QUnO+VQFQSIkh3jUNW2A3kb4n6oSunTDMnD5BmroaWCRIoexHZ6Yfd
 hXBgHe1c5hJcWySfNUmBjvSY0RPg/5Lfb4AP/ruqC3imsVOoBKkfxHi8qIwaRiEldk9rj0bHb
 +fjY/FwAAN/WKAi/OAA7622ULAvLGmpDtLwk4yY1HBGGr1dKZGEU9Fw+UA84HcLilb0umu1Wf
 BN7PA0LBaARPj//kAxEKnnBw==
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

On 12.09.24 02:59, Simon Glass wrote:
> Hi Sughosh,
>
> On Wed, 11 Sept 2024 at 00:50, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
>>
>> On Wed, 11 Sept 2024 at 00:14, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> Hi Sughosh,
>>>
>>> On Mon, 9 Sept 2024 at 01:44, Sughosh Ganu <sughosh.ganu@linaro.org> w=
rote:
>>>>
>>>> On Fri, 6 Sept 2024 at 18:31, Simon Glass <sjg@chromium.org> wrote:
>>>>>
>>>>> Hi Sughosh,
>>>>>
>>>>> On Fri, 6 Sept 2024 at 00:23, Sughosh Ganu <sughosh.ganu@linaro.org>=
 wrote:
>>>>>>
>>>>>> On Mon, 2 Sept 2024 at 03:53, Simon Glass <sjg@chromium.org> wrote:
>>>>>>>
>>>>>>> This API call is intended for allocating small amounts of memory,
>>>>>>> similar to malloc(). The current implementation rounds up to whole=
 pages
>>>>>>> which can waste large amounts of memory. It also implements its ow=
n
>>>>>>> malloc()-style header on each block.
>>>>>>>
>>>>>>> For certain allocations (those of type EFI_BOOT_SERVICES_DATA) we =
can
>>>>>>> use U-Boot's built-in malloc() instead, at least until the app sta=
rts.
>>>>>>> This avoids poluting the memory space with blocks of data which ma=
y
>>>>>>> interfere with boot scripts, etc.
>>>>>>>
>>>>>>> Once the app has started, there is no advantage to using malloc(),=
 since
>>>>>>> it doesn't matter what memory is used: everything is under control=
 of
>>>>>>> the EFI subsystem. Also, using malloc() after the app starts might
>>>>>>> result in running of memory, since U-Boot's malloc() space is typi=
cally
>>>>>>> quite small.
>>>>>>>
>>>>>>> In fact, malloc() is already used for most EFI-related allocations=
, so
>>>>>>> the impact of this change is fairly small.
>>>>>>>
>>>>>>> One side effect is that this seems to be showing up some bugs in t=
he
>>>>>>> EFI code, since the malloc() pool becomes corrupted with some test=
s.
>>>>>>> This has likely crept in due to the very large gaps between alloca=
tions
>>>>>>> (around 4KB), which provides a lot of leeway when the allocation s=
ize is
>>>>>>> too small. Work around this by increasing the size for now, until =
these
>>>>>>> (presumed) bugs are located.
>>>>>>>
>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>>> ---
>>>>>>>
>>>>>>> (no changes since v1)
>>>>>>>
>>>>>>>   common/dlmalloc.c            |   7 +++
>>>>>>>   include/efi_loader.h         |  18 ++++++
>>>>>>>   include/malloc.h             |   7 +++
>>>>>>>   lib/efi_loader/efi_bootbin.c |   2 +
>>>>>>>   lib/efi_loader/efi_memory.c  | 110 ++++++++++++++++++++++++++---=
------
>>>>>>>   5 files changed, 117 insertions(+), 27 deletions(-)
>>>>>>>
>>>>>>> diff --git a/common/dlmalloc.c b/common/dlmalloc.c
>>>>>>> index 1ac7ce3f43c..48e9f3515f7 100644
>>>>>>> --- a/common/dlmalloc.c
>>>>>>> +++ b/common/dlmalloc.c
>>>>>>> @@ -613,6 +613,13 @@ void mem_malloc_init(ulong start, ulong size)
>>>>>>>   #endif
>>>>>>>   }
>>>>>>>
>>>>>>> +bool malloc_check_in_range(void *ptr)
>>>>>>> +{
>>>>>>> +       ulong val =3D (ulong)ptr;
>>>>>>> +
>>>>>>> +       return val >=3D mem_malloc_start && val < mem_malloc_end;
>>>>>>> +}
>>>>>>> +
>>>>>>>   /* field-extraction macros */
>>>>>>>
>>>>>>>   #define first(b) ((b)->fd)
>>>>>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>>>>>> index 38971d01442..d07bc06bad4 100644
>>>>>>> --- a/include/efi_loader.h
>>>>>>> +++ b/include/efi_loader.h
>>>>>>> @@ -805,6 +805,24 @@ int efi_disk_probe(void *ctx, struct event *e=
vent);
>>>>>>>   int efi_disk_remove(void *ctx, struct event *event);
>>>>>>>   /* Called by board init to initialize the EFI memory map */
>>>>>>>   int efi_memory_init(void);
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * enum efi_alloc_flags - controls EFI memory allocation
>>>>>>> + *
>>>>>>> + * @EFIAF_USE_MALLOC: Use malloc() pool for pool allocations of t=
ype
>>>>>>> + *     EFI_BOOT_SERVICES_DATA, otherwise use page allocation
>>>>>>> + */
>>>>>>> +enum efi_alloc_flags {
>>>>>>> +       EFIAF_USE_MALLOC        =3D BIT(0),
>>>>>>> +};
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * efi_set_alloc() - Set behaviour of EFI memory allocation
>>>>>>> + *
>>>>>>> + * @flags: new value for allocation flags (see enum efi_alloc_fla=
gs)
>>>>>>> + */
>>>>>>> +void efi_set_alloc(int flags);
>>>>>>> +
>>>>>>>   /* Adds new or overrides configuration table entry to the system=
 table */
>>>>>>>   efi_status_t efi_install_configuration_table(const efi_guid_t *g=
uid, void *table);
>>>>>>>   /* Sets up a loaded image */
>>>>>>> diff --git a/include/malloc.h b/include/malloc.h
>>>>>>> index 07d3e90a855..a64f117e2f2 100644
>>>>>>> --- a/include/malloc.h
>>>>>>> +++ b/include/malloc.h
>>>>>>> @@ -983,6 +983,13 @@ extern ulong mem_malloc_brk;
>>>>>>>
>>>>>>>   void mem_malloc_init(ulong start, ulong size);
>>>>>>>
>>>>>>> +/**
>>>>>>> + * malloc_check_in_range() - Check if a pointer is within the mal=
loc() region
>>>>>>> + *
>>>>>>> + * Return: true if within malloc() region
>>>>>>> + */
>>>>>>> +bool malloc_check_in_range(void *ptr);
>>>>>>> +
>>>>>>>   #ifdef __cplusplus
>>>>>>>   };  /* end of extern "C" */
>>>>>>>   #endif
>>>>>>> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_boo=
tbin.c
>>>>>>> index a87006b3c0e..5bb0fdcf75d 100644
>>>>>>> --- a/lib/efi_loader/efi_bootbin.c
>>>>>>> +++ b/lib/efi_loader/efi_bootbin.c
>>>>>>> @@ -201,6 +201,8 @@ efi_status_t efi_binary_run(void *image, size_=
t size, void *fdt)
>>>>>>>   {
>>>>>>>          efi_status_t ret;
>>>>>>>
>>>>>>> +       efi_set_alloc(0);
>>>>>>> +
>>>>>>
>>>>>> Here we are setting the flags to use the efi_allocate_pages() route=
 to
>>>>>> allocate memory, when booting into an EFI app. Do we need to set it
>>>>>> back to EFIAF_USE_MALLOC if the app exits and control lands back in
>>>>>> U-Boot? I am not sure that is being handled.
>>>>>
>>>>> I don't believe so. Once we have booted into the app, U-Boot loses
>>>>> control of its memory layout, in the sense that the
>>>>> efi_allocate_pages() has likely been called and placed things all ov=
er
>>>>> the place in the memory. People should expect this.
>>>>
>>>> I am referring to a scenario where the app exits and control returns
>>>> back to U-Boot, which I believe is a valid scenario. In such a case,
>>>> should control not switch back to the malloc based allocations.
>>>> Otherwise we do not have consistent behaviour with the allocations --
>>>> any subsequent calls to efi_allocate_pool on return from an EFI app
>>>> would continue using the other (efi_allocate_pages() based) path.
>>>
>>> Thanks for reviewing.
>>>
>>> I completely understand your scenario, but I think I explained it
>>> above. The important thing is to keep memory 'consistent' from a
>>> U-Boot point of view until we actually boot something.
>>
>> How does reverting back to using the malloc heap for
>> efi_allocate_pool() after returning back from the EFI app affect
>> memory consistency? We now have the LMB memory map which is global and
>> persistent. So any allocations that were done (and not freed) from the
>> app, would be using the memory that you mention -- from 0 to bottom of
>> the stack. In fact, I would argue that not reverting back to malloc
>> based allocations on return from the app is inconsistent behaviour.
>
> No, I mean we should *not* use memory from 0 to the bottom of the
> stack. That is supposed to be reserved for image loading. Scripts may
> assume they can do anything in this space and most boards have fixed
> addresses for kernel, etc.
>
>>
>>>
>>> U-Boot expects memory from 0 to the bottom of the stack to be
>>> available for loading images. That is why it relocates itself.
>>
>> The EFI app is supposed to use the memory allocation API's
>> (efi_allocate_{pages,pool}) for getting memory. And those requests are
>> going to come from the LMB allocations (after the latest LMB rework
>> series). So the heap memory is not supposed to be trampled over with.
>
> I'm not quite sure what you are getting at here? My goal is to tidy up
> the allocation of memory *before* the app boots.


AllocatePool() can be used to allocate multiple GiB of memory. The
malloc pool is too small for this purpose. You would first have to
change the malloc implementation to acquire arbitrary amounts of memory
from LMB.

Please, don't complicate the code by treating different memory types
differently in AllocatePool().

The way forward is to change LMB to store EFI memory types. This will
allow us to remove most of the code in lib/efi_loader/efi_memory.c.

Once that integration work is done we can start thinking about
generalizing malloc() to support multiple memory pools of arbitrary size
to encompass AllocatePool().

Best regards

Heinrich

>
>>>> This is of course with the assumption that the EFI maintainers are
>>>> fine with using this hybrid approach on the allocations.
>>>
>>> Yes, I certainly hope so. This whole problem has caused an enormous
>>> amount of confusion and I very much want to clean it up.
>>>>
>
>>>>>
>>>>> We can potentially deal with this if we find a specific problem, but=
 I
>>>>> can't think of one at the moment.
>>>>>
>
> [..]
>
> Regards,
> Simon

