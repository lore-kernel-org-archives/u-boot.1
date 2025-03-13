Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB82C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 08:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA2480756;
	Thu, 13 Mar 2025 09:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="W1d2jsfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7108480F9C; Thu, 13 Mar 2025 09:38:12 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B347380540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B8D103F287
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741855087;
 bh=EWyzIiXxt272Jorpl49u7Xp1pzNgtZL++pok8JPrGx8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=W1d2jsfMup0DMrB8fgPjjOaoxXODxE9eu6Pe0H6GRX1zsB3P44d+ph+1QO/UhHJE/
 1iP2fqJ7wfwI6whrKd8hjmWb4rw5LBp4SPVYbL95wHJHlxfa9C7y1Wc1Jn8htTz7Az
 45mlusq8YixS3Hja0DerSwEGTCtSsEGXDU4CN9C4lvWqDWgZHwnDb+fCW3vdZkpM27
 33iKvAG4CelAWrzcDmpNFsmlWCEKoPdUxGfDlRfFuoZBzoInehm4oTiE41JI3xjVnD
 l4j+MgPFIuPxNCnrNaZRmBBxdtAd8QZ77Tix/ZyNFY70ZxtqsA7Pf8o3F+yufAmPRK
 gSuIJBykVi/jQ==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912580843fso462166f8f.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 01:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741855086; x=1742459886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EWyzIiXxt272Jorpl49u7Xp1pzNgtZL++pok8JPrGx8=;
 b=e4Sc/TJxbG5iNmOjMdEv7bIjaiQl82mgTfZBGncZCwCKALD8cLqBU7Rpkd18g9k+G8
 UbVOW13pP+EQ+OQeambM/UKi12dJLmr7mI8PZCS5GCB/RnTDnemHjzfcTrvPom0zD89W
 HKsY85rS7FuNFesdU+qe2mJo+6qlCkN7jbipUurMQHtigZFOOJGmlODQT1Vn9mGltUKQ
 fE0NIGJOdh1630X3ijdUplyYemm937xcCMh0N7NMsoFe24X1I6YiLxTGxNfJhKpYZJDm
 iHlQrK9jWa5nnr9UoB3S5DWDshc9+IKdCx2A1JQRs0TE+xkt836sBfDr/S81GhgaUWdf
 G1qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmdbU/ES6Wa7s8SLc2w82vUNYYrk4f6KAxQDEEcJYNqrczFSurSOgJzaP2xE63iBCg1HbY5RA=@lists.denx.de
X-Gm-Message-State: AOJu0YyR+ynvlMcMCaKPQFdlTxMg0sg7J8KTFKsfbw5a8jbBp0WrbXXc
 X1qle9m2/UU4WY4EKpptrHIO1dk84SkJ/eEpI3KahIm3fScffRVBb1HhcBUd9qCmzeRA/YGJPqu
 Fv56W5/Tc1RcOLeSjvTZtRqPWZ6/ViyUdmg86J4Cg+Tb1fkVOOQjXkiMXl4yReFyqvl1skCi2GH
 8=
X-Gm-Gg: ASbGncvK4xxj3LsUfG51RFeL7W5t1JrWkxX9tSrXBo7SG/k42zbunFj49lGycGFKdXo
 829LhL4rHJpekdhq0SXjYucFDFcq0mfWB0S893DTDINVkTTCjgXjbU/SPtqF8r7FRPq4yGMlpQc
 WpXWLXMBFd0CyorOBkS9Whu64atzfGi6+GblqOlyGeFDhEopQVJNhx99JbrIqW7b+MKXx1EezFD
 0iIwwBBc7Sg7dUTppZ+sUbw3s9Ofa3uHZbxCVBzBG4tvyYYjmTSHBUUvjPcT89PDKZR/2HOAOnu
 wvnmLmG2qAgv+O3j1BXHaNi8esiWP/F98HPuKOmSQG3Q2+xBnggcwYK2s0ceFDAL69XXTN65CeD
 BI1zM4w==
X-Received: by 2002:a5d:6d03:0:b0:390:fe05:da85 with SMTP id
 ffacd0b85a97d-392641bff2dmr12594741f8f.16.1741855085893; 
 Thu, 13 Mar 2025 01:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvgDsLKNA9zyBcQE8ZGKV+4BUvgGpxFMyR9SomTahwrv/AKqJgTbsIqBig4iPf29kVDvz2QQ==
X-Received: by 2002:a5d:6d03:0:b0:390:fe05:da85 with SMTP id
 ffacd0b85a97d-392641bff2dmr12594700f8f.16.1741855085490; 
 Thu, 13 Mar 2025 01:38:05 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:345b:e644:8505:68cc:d761?
 ([2a02:3035:6e0:345b:e644:8505:68cc:d761])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb40cdafsm1323387f8f.62.2025.03.13.01.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 01:38:04 -0700 (PDT)
Message-ID: <b9cdc226-9703-4c16-af0a-eb4894bc9445@canonical.com>
Date: Thu, 13 Mar 2025 09:38:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] blkmap: pass information on ISO image to the OS
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-9-sughosh.ganu@linaro.org>
 <ab576278-e196-4def-8cd4-5c828259cbc5@canonical.com>
 <CADg8p97hJLu0zKAOL-J3FkTbgBrKGZ+FRvYAJ8se0MOs94VoJw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CADg8p97hJLu0zKAOL-J3FkTbgBrKGZ+FRvYAJ8se0MOs94VoJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 13.03.25 08:46, Sughosh Ganu wrote:
> On Thu, 13 Mar 2025 at 02:38, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 12.03.25 09:54, Sughosh Ganu wrote:
>>> The EFI HTTP boot puts the ISO installer image at some location in
>>> memory. Information about this image has to be passed on to the OS
>>> kernel, which is done by adding a persistent memory(pmem) node to the
>>> devicetree(DT) that is passed to the OS. The OS kernel then gets
>>> information about the presence of this ISO image and proceeds with the
>>> installation.
>>>
>>> In U-Boot, this ISO image gets mounted as a memory mapped blkmap
>>> device slice, with the 'preserve' attribute. Add a helper function
>>> which iterates through all such slices, and invokes a callback. The
>>> callback adds the pmem node to the DT and removes the corresponding
>>> memory region from the EFI memory map. Invoke this helper function as
>>> part of the DT fixup which happens before booting the OS.
>>>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
>>> ---
>>> Changes since V7:
>>> * Fix checkpatch errors in blkmap.c and efi_helper.c
>>>
>>>    boot/image-fdt.c            |  7 ++++++
>>>    drivers/block/blkmap.c      | 44 +++++++++++++++++++++++++++++++++++++
>>>    include/blkmap.h            | 17 ++++++++++++++
>>>    include/efi.h               | 13 +++++++++++
>>>    lib/efi_loader/efi_helper.c | 39 ++++++++++++++++++++++++++++++++
>>>    5 files changed, 120 insertions(+)
>>>
>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>> index 9d1598b1a93..8f718ad29f6 100644
>>> --- a/boot/image-fdt.c
>>> +++ b/boot/image-fdt.c
>>> @@ -11,6 +11,7 @@
>>>    #include <command.h>
>>>    #include <fdt_support.h>
>>>    #include <fdtdec.h>
>>> +#include <efi.h>
>>>    #include <env.h>
>>>    #include <errno.h>
>>>    #include <image.h>
>>> @@ -649,6 +650,12 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
>>>        if (!ft_verify_fdt(blob))
>>>                goto err;
>>>
>>> +     if (CONFIG_IS_ENABLED(BLKMAP) && CONFIG_IS_ENABLED(EFI_LOADER)) {
>>> +             fdt_ret = fdt_efi_pmem_setup(blob);
>>> +             if (fdt_ret)
>>> +                     goto err;
>>> +     }
>>> +
>>>        /* after here we are using a livetree */
>>>        if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
>>>                struct event_ft_fixup fixup;
>>> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
>>> index eefed615998..5f7602d0405 100644
>>> --- a/drivers/block/blkmap.c
>>> +++ b/drivers/block/blkmap.c
>>> @@ -498,6 +498,50 @@ err:
>>>        return err;
>>>    }
>>>
>>
>> Please, add the missing documentation.
>> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
> 
> Sorry, I do not understand. Which function do you need documentation for?

blkmap_mem_preserve_slice() is not documented. See line below.

> 
>>
>>> +static bool blkmap_mem_preserve_slice(struct blkmap_slice *bms)
>>> +{
>>> +     return (bms->attr & (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE)) ==
>>> +             (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE);
>>> +}
>>> +
>>> +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
>>> +                                           u32 size), void *ctx)
>>> +{
>>> +     int ret;
>>> +     u32 size;
>>> +     ulong addr;
>>> +     struct udevice *dev;
>>> +     struct uclass *uc;
>>> +     struct blkmap *bm;
>>> +     struct blkmap_mem *bmm;
>>> +     struct blkmap_slice *bms;
>>> +     struct blk_desc *bd;
>>> +
>>> +     if (!cb) {
>>> +             log_debug("%s: No callback passed to the function\n", __func__);
>>> +             return 0;
>>> +     }
>>> +
>>> +     uclass_id_foreach_dev(UCLASS_BLKMAP, dev, uc) {
>>> +             bm = dev_get_plat(dev);
>>> +             bd = dev_get_uclass_plat(bm->blk);
>>> +
>>> +             list_for_each_entry(bms, &bm->slices, node) {
>>> +                     if (!blkmap_mem_preserve_slice(bms))
>>> +                             continue;
>>> +
>>> +                     bmm = container_of(bms, struct blkmap_mem, slice);
>>> +                     addr = (ulong)(uintptr_t)bmm->addr;
>>> +                     size = (u32)bms->blkcnt << bd->log2blksz;
>>> +                     ret = cb(ctx, addr, size);
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>    int blkmap_destroy(struct udevice *dev)
>>>    {
>>>        int err;
>>> diff --git a/include/blkmap.h b/include/blkmap.h
>>> index 754d8671b01..30ce80c0ad1 100644
>>> --- a/include/blkmap.h
>>> +++ b/include/blkmap.h
>>> @@ -7,6 +7,7 @@
>>>    #ifndef _BLKMAP_H
>>>    #define _BLKMAP_H
>>>
>>> +#include <blk.h>
>>>    #include <dm/lists.h>
>>>
>>>    /**
>>> @@ -104,4 +105,20 @@ int blkmap_destroy(struct udevice *dev);
>>>    int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
>>>                          struct udevice **devp);
>>>
>>> +/**
>>> + * blkmap_get_preserved_pmem_slice() - Look for memory mapped preserved slice
>>> + * @cb: Callback function to call for the blkmap slice
>>
>> Please, describe in sufficient detail for a developer who has to
>> implement such a callback function what information should be provided
>> by the function.
>>
>> All arguments of cb and its return value need to be described.
> 
> Shouldn't the callback be an abstract interface which allows the
> caller of this function to do whatever configuration that the caller
> wants to do. Which is why I have framed it as such in the function's
> comments.

The description should provide all information that is needed to use 
function without reading its implementation.

The existing documentation does not describe:

* What information ctx, addr, size will contain.
* When the callback function will be invoked. Is it just once or for 
every matching slice?
* Does the callback function have to fill some data structure that 
blkmap_get_preserved_pmem_slice() needs to do its job.

It is unclear what values the return value should take and if it has any 
influence on the output of blkmap_get_preserved_pmem_slice(). Will 
iterating stop at the first error reported by the callback? Or will all 
iterations be executed?

> 
> -sughosh
> 
>>
>> Best regards
>>
>> Heinrich
>>
>>> + * @ctx: Argument to be passed to the callback function
>>> + *
>>> + * The function is used to iterate through all the blkmap slices, looking
>>> + * specifically for memory mapped blkmap mapping which has been

%s/mapping which has been/mappings which have been/

>>> + * created with the preserve attribute. The function looks for such slices
>>> + * with the relevant attributes and then calls the callback function which
>>> + * then does additional configuration as needed.
>>> + *
>>> + * Return: 0 on success, negative error on failure
>>> + */
>>> +int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
>>> +                                           u32 size), void *ctx);
>>> +
>>>    #endif      /* _BLKMAP_H */
>>> diff --git a/include/efi.h b/include/efi.h
>>> index d005cb6181e..f9bbb175c3a 100644
>>> --- a/include/efi.h
>>> +++ b/include/efi.h
>>> @@ -705,4 +705,17 @@ static inline bool efi_use_host_arch(void)
>>>     */
>>>    int efi_get_pxe_arch(void);
>>>
>>> +/**
>>> + * fdt_efi_pmem_setup() - Pmem setup in DT and EFI memory map
>>> + * @fdt: Devicetree to add the pmem nodes to
>>> + *
>>> + * Iterate through all the blkmap devices, look for BLKMAP_MEM devices,
>>> + * and add pmem nodes corresponding to the blkmap slice to the
>>> + * devicetree along with removing the corresponding region from the
>>> + * EFI memory map.
>>> + *
>>> + * Returns: 0 on success, negative error on failure
>>> + */
>>> +int fdt_efi_pmem_setup(void *fdt);
>>> +
>>>    #endif /* _LINUX_EFI_H */
>>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
>>> index 37e5859741f..62772a0d747 100644
>>> --- a/lib/efi_loader/efi_helper.c
>>> +++ b/lib/efi_loader/efi_helper.c
>>> @@ -5,6 +5,7 @@
>>>
>>>    #define LOG_CATEGORY LOGC_EFI
>>>
>>> +#include <blkmap.h>
>>>    #include <bootm.h>
>>>    #include <env.h>
>>>    #include <image.h>
>>> @@ -680,3 +681,41 @@ out:
>>>
>>>        return ret;
>>>    }
>>> +
>>> +/**
>>> + * pmem_node_efi_memmap_setup() - Add pmem node and tweak EFI memmap
>>> + * @fdt: The devicetree to which pmem node is added
>>> + * @addr: start address of the pmem node
>>> + * @size: size of the memory of the pmem node
>>> + *
>>> + * The function adds the pmem node to the device-tree along with removing

%s/along with removing/and removes/

Best regards

Heinrich

>>> + * the corresponding region from the EFI memory map. Used primarily to
>>> + * pass the information of a RAM based ISO image to the OS.
>>> + *
>>> + * Return: 0 on success, -ve value on error
>>> + */
>>> +static int pmem_node_efi_memmap_setup(void *fdt, ulong addr, u32 size)
>>> +{
>>> +     int ret;
>>> +     efi_status_t status;
>>> +
>>> +     ret = fdt_fixup_pmem_region(fdt, addr, size);
>>> +     if (ret) {
>>> +             log_err("Failed to setup pmem node for addr %#lx, size %#x, err %d\n",
>>> +                     addr, size, ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     status = efi_remove_memory_map(addr, size,
>>> +                                    EFI_CONVENTIONAL_MEMORY);
>>> +     if (status != EFI_SUCCESS)
>>> +             return -1;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +int fdt_efi_pmem_setup(void *fdt)
>>> +{
>>> +     return blkmap_get_preserved_pmem_slice(pmem_node_efi_memmap_setup,
>>> +                                            fdt);
>>> +}
>>

