Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0648D2E9D8
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 11:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13BA089099;
	Mon, 11 Nov 2024 12:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DCtXT4CQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888E58917A; Mon, 11 Nov 2024 12:23:04 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7102388FBF
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 12:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731324180; x=1731928980; i=xypron.glpk@gmx.de;
 bh=SrqX32lh188RRJnnIEVW0DA4dRxwy9C6wFbq0StnXPI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DCtXT4CQ5Coh5D40ZMUdXAmseHgB7U8UlEp51H0J6tOE6q6Q9BYbWqLVGZQ1F2c+
 AJWPs/cZ4SPMaZCucWtrSsx1qzwPRPdjILQt0pd/s8HZbuGVLEdHNUUf3FB5QiGgy
 v/1xw9oupBvzlaaAo+InWzeb0SaPch/Dlu+6vdEkK79S3C6fPxGmPxf7TI6xSFfzG
 O2RiEbj1H4oF+5oLKKD9txdBElho4Cr5+CxrgUOgPTjwjcB7i2HF6MEApzYjD46rY
 whhmVZEmkTrPoP4XEreg0p30YpWVPAnpic3xuWCPxQ37a1bhsfvIbNXCuB6zjm9oH
 C+IV2lK5eluanr+Gjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1tnpki37zc-016jta; Mon, 11
 Nov 2024 12:23:00 +0100
Message-ID: <1321cc2e-5234-4be1-b50c-f50de04c3d06@gmx.de>
Date: Mon, 11 Nov 2024 12:23:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] efi_loader: preserve installer images in pmem
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-4-sughosh.ganu@linaro.org>
 <35b2ecd1-5d92-4bbe-886a-82c567f0e20d@gmx.de>
 <CAC_iWjKikR4QuPODRbAw3i7v0jjC3JnEaHJ3eTcj4=P4_S0pSw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKikR4QuPODRbAw3i7v0jjC3JnEaHJ3eTcj4=P4_S0pSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0RPS0SMlOWjAga+Vzq0a9jb4E/FDcBVCVz9CQCXF7llA6cPQSBG
 n48mqSwveDg7u8jw5lsBwpg7tiEGr5ZFEepulKuz6kjeLxXvUaPeY00XoIJQX2DHny+P9CP
 /U4kheLXp3voPTaIcbKklbWo6iRQrv7rULYs3foRep+kdnahsXsgdAjYyB72LtC2ZwddkK1
 a/braFHi9gujhYTAXMGOA==
UI-OutboundReport: notjunk:1;M01:P0:/aJN7BGnxwQ=;Qg+2SJ+7dHrsOju2n6bD70W70zX
 qc3tlogOrvEGgzOjrkHvYhKfKRN4P6GYGUPQzDwehc3lH8Q+RaOV+DX8AMORHZLHE+B673HiL
 CV6Basn+jWquirGaWmSYH5AuPKE4NMHALScuuMSvKPX9jed1CUvRt8gGGXSmELjlzn8tsap3t
 tzePzJcuaPHrezXrDLjMaIsZ6YWwRlLEtxt4+1f1CR+7CBfQKgGnAzZviUMyHnp/pnus6/msh
 WaoP0CZDKNv3Uc3n25sAany4jRsY1WYCrBGQyLLblLtTw7OyCTvrvuslTzJsGWbGDZPu+zM7u
 9wDWx6CTAgxPS8cBhJiZmAqEQ7N0Ew7GgoTHci9dqZ1VmaxKVWkdFp4HT/oGuFY+9DN1J0Ei6
 cxY+x2Jy2WpQ293bGUhK/0y61DAQzmE/LNFbwd4j17NI+FNarzwWI9nZJ3+QahI8Xa03/pUDV
 Si2D239rPiVhO2Z2v/hNGgg5S28Ci7sdL7pyHO+jzwapARYnSJWxiLRxvDVY1pkdLZCTg5e90
 rGXdS2I0x1L7vr4WyCEX1wZeFgfVpO6vSnGwWoooAKUsF5rBhX4JSULiN5U8Z5klPihOcfDCL
 w/z2N6Bo80CyMzd6tr/86eI71ygPJkNKNakl6WQCc6LwNO5mUiJ3lA+cxJN7b3FoIY6haYRL9
 vt9Zt1riGxsAbBq0K23QmnnPAkXpWvkyskvXpjFasqMZZLG/T4jiP/V5M5g4t20nJ1eW709hw
 97SopMDW6OepsEMwy0bM4E+8zk2jm/+4uv4Go7k1kKXqNUoGYCYS7ucl2lK3LCa8vnKZu/lCG
 XDGjULriZyaU/Ucgu1oFZZVzMo1UfJlsGkPosaHckPyftVhbpy7wqmDCnYjh740DjgPRQCAAy
 9Q32GPBHSvDJsRkRRkRC5xwFHeWlWOl0ybHukkL7McuCYZMCmIWQKy/4e
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

On 11/11/24 11:46, Ilias Apalodimas wrote:
> On Mon, 11 Nov 2024 at 10:05, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 10/25/24 13:14, Sughosh Ganu wrote:
>>> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>
>>> One of the problems OS installers face, when running in EFI, is that
>>> the mounted ISO after calling ExitBootServices goes away. For some
>>> distros this is a problem since they rely on finding some core package=
s
>>> before continuing the installation. Distros have works around this --
>>> e.g Fedora has a special kernel command line parameter called
>>> inst.stage2 [0].
>>>
>>> ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
>>> don't have anything in place for DTs. Linux and device trees have supp=
ort
>>> for persistent memory devices.
>>>
>>> It's worth noting that for linux to instantiate the /dev/pmemX device,
>>> the memory described in the pmem node has to be omitted from the EFI
>>> memory map we hand over to the OS if ZONE_DEVICES and SPARSEMEM is
>>> enabled. With those enabled the pmem driver ends up calling
>>> devm_memremap_pages() instead of devm_memremap(). The latter works
>>> whether the memory is omitted or marked as reserved, but mapping pages
>>> only works if the memory is omitted.
>>>
>>> On top of that, depending on how the kernel is configured, that memory
>>> area must be page aligned or 2MB aligned. PowerPC is an exception here
>>> and requires 16MB alignment, but since we don't have EFI support for
>>> it, limit the alignment to 2MB.
>>>
>>> Ensure that the ISO image is 2MB aligned and remove the region
>>> occupied by the image from the EFI memory map.
>>>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> ---
>>>    lib/efi_loader/efi_bootmgr.c | 22 +++++++++++++++++-----
>>>    1 file changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr=
.c
>>> index a3aa2b8d1b..16f75555f6 100644
>>> --- a/lib/efi_loader/efi_bootmgr.c
>>> +++ b/lib/efi_loader/efi_bootmgr.c
>>> @@ -18,6 +18,8 @@
>>>    #include <efi_loader.h>
>>>    #include <efi_variable.h>
>>>    #include <asm/unaligned.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/sizes.h>
>>>
>>>    static const struct efi_boot_services *bs;
>>>    static const struct efi_runtime_services *rs;
>>> @@ -358,13 +360,16 @@ static efi_status_t prepare_loaded_image(u16 *la=
bel, ulong addr, ulong size,
>>>        }
>>>
>>>        /*
>>> -      * TODO: expose the ramdisk to OS.
>>> -      * Need to pass the ramdisk information by the architecture-spec=
ific
>>> -      * methods such as 'pmem' device-tree node.
>>> +      * Linux supports 'pmem' which allows OS installers to find, rec=
laim
>>> +      * the mounted images and continue the installation since the co=
ntents
>>> +      * of the pmem region are treated as local media.
>>> +      *
>>> +      * The memory regions used for it needs to be carved out of the =
EFI
>>> +      * memory map.
>>>         */
>>> -     ret =3D efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE)=
;
>>> +     ret =3D efi_remove_memory_map(addr, size, EFI_CONVENTIONAL_MEMOR=
Y);
>>>        if (ret !=3D EFI_SUCCESS) {
>>> -             log_err("Memory reservation failed\n");
>>> +             log_err("Failed to reserve memory\n");
>>>                goto err;
>>>        }
>>>
>>> @@ -486,6 +491,13 @@ static efi_status_t try_load_from_uri_path(struct=
 efi_device_path_uri *uridp,
>>>                ret =3D EFI_INVALID_PARAMETER;
>>>                goto err;
>>>        }
>>> +     /*
>>> +      * Depending on the kernel configuration, pmem memory area must =
be page
>>> +      * aligned or 2MB aligned. PowerPC is an exception here and requ=
ires
>>> +      * 16MB alignment, but since we don't have EFI support for it, l=
imit
>>> +      * the alignment to 2MB.
>>> +      */
>>> +     image_size =3D ALIGN(image_size, SZ_2M);
>>
>> The code regarding .iso and .img handling seems to be misplaced. Why
>> should we treat a file loaded from a block device differently to a file
>> loaded from the network?
>
> If the installer is located in a block device, the kernel will find
> the image when it scans those devices during boot. It's only when we
> have it on a memory area that we need to preserve it

I meant we could have a block device with an '*.iso' file on it, which
we load into memory.

Simon has been working on keeping track of loaded images. Possibly
besides EFI binaries we can keep track of loaded ISOs in the same way in
future.

For the moment being let't use the patch as is.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
> Thanks
> /Ilias
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>>        /*
>>>         * If the file extension is ".iso" or ".img", mount it and try =
to load
>>

