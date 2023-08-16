Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B78C27C42
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 21:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F5186863;
	Wed, 16 Aug 2023 23:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fcqjE4rC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88E6866D0; Wed, 16 Aug 2023 23:47:44 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E5F586A0E
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 23:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RR1vZ5L3gz9sm6;
 Wed, 16 Aug 2023 23:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692222458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sjff+DUMHCtnhWMmfpPBBBIAbdlAVs6M2B75jIx/vzQ=;
 b=fcqjE4rCpGMbBk8UvbsIFi5TnXK80rq6ccWXn/QcGXPMQqw201P1YW2DWm91GT7MpfYjbE
 PZ0Zo1FS8EmyP77w1nL2dNCIyV1u2jgsQvmv8cP6Y1jaGFUdMmt05qG+RGikpS8yYKIhVi
 WYSugc2ADcs5ao7Eaa65QJ4+HbeVRNnrR1lX5+f17o48LyXg+wy/2XKIYXa0rfw9rlKp/U
 847vGpLt0jKsmuSjQxnQymMoNOW5nnGlXXLTG0iiJLBQFq9nTM4pzGAxlgwryW0SMborUL
 hBP0dZG1+sttrKcorWMISjyf773csK23W8GyDwB+pyiqk5LWGZJEyOh/pmIzwA==
Message-ID: <19345af9-2578-2ff9-b5c6-ee0349e2aae8@mailbox.org>
Date: Wed, 16 Aug 2023 23:47:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] nvmxip: add sandbox support
Content-Language: en-US
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: nd@arm.com, u-boot@lists.denx.de, sjg@chromium.org
References: <CAPnjgZ34z865voaKeShSJpdvWcFLbN0OEWBnus4qt0W_1P4jBw@mail.gmail.com>
 <20230816110551.86930-1-abdellatif.elkhlifi@arm.com>
 <20230816110551.86930-2-abdellatif.elkhlifi@arm.com>
 <2a74558f-1cf5-2333-a585-8871ea163e68@mailbox.org>
 <20230816163940.GA105907@e130802.arm.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230816163940.GA105907@e130802.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3c3d093765fd619c537
X-MBO-RS-META: 5ianuznok641dzwuba397ep7x4hmkq79
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

On 8/16/23 18:39, Abdellatif El Khlifi wrote:
> Hi Marek,

Hi,

> Please kindly find my comments below.
> 
>>> arch/sandbox/dts/sandbox.dts       | 14 ++++++++++++++
>>
>> Please separate DT change
>>
>>>    configs/sandbox_defconfig          |  4 ++--
>>
>> Config change too, separate patch that goes last.
> 
> This commit is doing 1 thing: adding 32-bit sandbox support.

No, it does not do one thing, else I would not ask you to split this up 
into a series. It does multiple things and squashes those in single commit.

> The DT change comes into the same context.
> It makes sense to keep it in this same commit.
> 
> In previous contributions I made, it was accepted that DT
> and defconfig  are part of the same commit as the code.
> 
> Let's see what Simon thinks.
> 
> I'm happy to split if that has becone a new requirement.

This is not a new requirement, that requirement has been around since 
forever, see:

https://docs.kernel.org/process/submitting-patches.html#split-changes

U-Boot follows the same rule set.

>>>    	int devnum;
>>> -#if CONFIG_IS_ENABLED(SANDBOX64)
>>> +#if CONFIG_IS_ENABLED(SANDBOX)
>>>    	sandbox_set_enable_memio(true);
>>
>> This should not be in drivers at all, this should be in tests/ , see
>>
>> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commit/b07772226b405d6212d4faa9329d64a09708b188
> 
> Thanks, I'm happy to improve that one. I'll move it to tests in a seperate commit :)
> 
>>
>>>    #endif
>>> @@ -62,7 +62,7 @@ static int nvmxip_post_bind(struct udevice *udev)
>>>    		return ret;
>>>    	}
>>> -	log_info("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
>>> +	log_debug("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
>>
>> Unrelated change -> separate patch please.
> 
> Valid point, I'll do thanks.
> 
>>> +	l_word = readl(address);
>>> +	h_word = readl((u8 *)address + sizeof(u32));
>>> +	*value = FIELD_PREP(GENMASK_ULL(63, 32), h_word) | l_word;
>>> +#endif
>>>    	return 0;
>>>    }
>>> @@ -67,7 +76,7 @@ static ulong nvmxip_blk_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcn
>>>    	/* assumption: the data is virtually contiguous */
>>>    	for (qdata_idx = 0 ; qdata_idx < qwords ; qdata_idx++)
>>> -		nvmxip_mmio_rawread((phys_addr_t)(virt_blkaddr + qdata_idx), pdst++);
>>> +		nvmxip_mmio_rawread(virt_blkaddr + qdata_idx, pdst++);
>>
>> Separate patch please, or just use this commit as part of this series:
>>
>> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commit/85a662e98c44921a0f5652fa4b170625424ef9a9
> 
> This is part of the 32-bit support work.
> Before this commit, it works fine on sandbox64.

Have you tested the entire test suite ? Like e.g. the DM/UT 'host' test 
? That one fails on sandbox64 iirc .

>>>    	log_debug("[%s]:     src[0]: 0x%llx , dst[0]: 0x%llx , src[-1]: 0x%llx , dst[-1]: 0x%llx\n",
>>>    		  dev->name,
>>> diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_qspi.c
>>> index 7221fd1cb4..faeb99b4ad 100644
>>> --- a/drivers/mtd/nvmxip/nvmxip_qspi.c
>>> +++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
>>> @@ -50,7 +50,7 @@ static int nvmxip_qspi_of_to_plat(struct udevice *dev)
>>>    		return -EINVAL;
>>>    	}
>>> -	log_debug("[%s]: XIP device base addr: 0x%llx , lba_shift: %d , lbas: %lu\n",
>>> +	log_debug("[%s]: XIP device base addr: " PHYS_ADDR_LN " , lba_shift: %d , lbas: %lu\n",
>>>    		  dev->name, plat->phys_base, plat->lba_shift, plat->lba);
>>
>> Another separate patch.
> 
> This is part of the 32-bit support work.

This fixes a print of phys_addr_t and is a good example for others to 
follow if they need to print such an address. If this is a separate 
patch with proper commit message explaining the change, then others can 
be pointed to that commit as an example to follow. If this is buried in 
a mega-patch, this benefit is lost.

>>>    	return 0;
>>> diff --git a/test/dm/Makefile b/test/dm/Makefile
>>> index 7ed00733c1..77172d9012 100644
>>> --- a/test/dm/Makefile
>>> +++ b/test/dm/Makefile
>>> @@ -18,7 +18,7 @@ obj-$(CONFIG_UT_DM) += test-uclass.o
>>>    obj-$(CONFIG_UT_DM) += core.o
>>>    obj-$(CONFIG_UT_DM) += read.o
>>>    obj-$(CONFIG_UT_DM) += phys2bus.o
>>> -ifeq ($(CONFIG_NVMXIP_QSPI)$(CONFIG_SANDBOX64),yy)
>>> +ifeq ($(CONFIG_NVMXIP_QSPI),y)
>>
>> Separate patch.
>>
>> Look here for some ideas:
>>
>> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commits/ci%2Ftest-sandbox64?ref_type=heads
> 
> SANDBOX applies for both sandbox64 and sandbox.
> This is part of enabling sandbox alongside sandbox64.
> 
> This has been tested and works.

If this is split up into proper patches with proper commit messages, the 
resulting change would be identical, so the "tested and works" argument 
still applies, even if this is split into proper series.
