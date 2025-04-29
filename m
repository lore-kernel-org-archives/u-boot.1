Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229DAC369CB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 08:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA6980EFB;
	Tue, 29 Apr 2025 10:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hQlafwq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5326E82075; Tue, 29 Apr 2025 10:04:51 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237C980BAD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 10:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 28ACE43D27;
 Tue, 29 Apr 2025 08:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9380BC4CEE3;
 Tue, 29 Apr 2025 08:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745913886;
 bh=b9BK9xcbs37nW1uigghFeh7aQ/C0uDCv5tiZULGt4M4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hQlafwq2ASUrV8USdAJ3uqlotR530c4+9chKf2yOzvf6J8SZLJcHouYu+YuY0snz6
 cKN2xdzP77/J8h52b09CoXcjgjdzQjh6uvTwxAy5O9au98fPRKmzPySw9RZoYg5CKe
 hZWc9tIdQ6vWeSZ7WTN18PKENKJv9PLGIWiYjbDD7P8FNPDD9kNpMdTOVu1zt6UvYn
 FkkLS4YJFZ3vWQ6kNhfKHKlJQ5rPde9nGdjVwzfU19kF/nVeKZWF1pI39JMoIp6Fbc
 MhbWSaDdCEYb1f0sCnpWXwuj0SGQDq27XTSjJcwSQ1ZXeBREk4ZzH/aEHgVm1gMby2
 gHft1Nglph+Sg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: neil.armstrong@linaro.org, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Dmitrii Merkurev
 <dimorinny@google.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH RFT v2 1/3] fastboot: blk: introduce fastboot block
 flashing support
In-Reply-To: <359a5f7c-4c65-4813-be8e-97e12c7786ae@linaro.org>
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
 <20250409-topic-fastboot-blk-v2-1-c676f21d414f@linaro.org>
 <877c3cgwsf.fsf@kernel.org>
 <359a5f7c-4c65-4813-be8e-97e12c7786ae@linaro.org>
Date: Tue, 29 Apr 2025 10:04:42 +0200
Message-ID: <87zffzwfz9.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On mer., avril 23, 2025 at 09:38, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On 22/04/2025 15:17, Mattijs Korpershoek wrote:
>> Hi Neil,
>> 
>> Thank you for the patch.
>
> Thx for the review
>
>> 
>> On mer., avril 09, 2025 at 09:58, neil.armstrong@linaro.org wrote:
>> 
>>> From: Dmitrii Merkurev <dimorinny@google.com>
>>>
>>> Introduce fastboot block flashing functions and helpers
>>> to be shared with the MMC implementation.
>>>
>>> The write logic comes from the mmc implementation, while
>>> the partition lookup is much simpler and could be extended.
>>>
>>> For the erase logic, allmost no block drivers exposes the
>>> erase operation, except mmc & virtio, so in order to allow
>>> erasiong any partition a soft-erase logic has been added
>>> to write zero-ed buffers in a loop.
>>>
>>> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   drivers/fastboot/Kconfig    |  20 ++-
>>>   drivers/fastboot/Makefile   |   4 +-
>>>   drivers/fastboot/fb_block.c | 313 ++++++++++++++++++++++++++++++++++++++++++++
>>>   include/fb_block.h          | 104 +++++++++++++++
>>>   4 files changed, 438 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>>> index 1eb460f5a02a87089d85b252375202d9acaec9fa..76b35d8419e02a7f1d36988fbdac190b10bff35e 100644
>>> --- a/drivers/fastboot/Kconfig
>>> +++ b/drivers/fastboot/Kconfig
>>> @@ -92,7 +92,7 @@ config FASTBOOT_USB_DEV
>>>   config FASTBOOT_FLASH
>>>   	bool "Enable FASTBOOT FLASH command"
>>>   	default y if ARCH_SUNXI || ARCH_ROCKCHIP
>>> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
>>> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
>>>   	select IMAGE_SPARSE
>>>   	help
>>>   	  The fastboot protocol includes a "flash" command for writing
>>> @@ -114,12 +114,16 @@ choice
>>>   
>>>   config FASTBOOT_FLASH_MMC
>>>   	bool "FASTBOOT on MMC"
>>> -	depends on MMC
>>> +	depends on MMC && BLK
>>>   
>>>   config FASTBOOT_FLASH_NAND
>>>   	bool "FASTBOOT on NAND"
>>>   	depends on MTD_RAW_NAND && CMD_MTDPARTS
>>>   
>>> +config FASTBOOT_FLASH_BLOCK
>>> +	bool "FASTBOOT on block device"
>>> +	depends on BLK
>>> +
>>>   endchoice
>>>   
>>>   config FASTBOOT_FLASH_MMC_DEV
>>> @@ -194,6 +198,18 @@ config FASTBOOT_MMC_USER_NAME
>>>   	  defined here.
>>>   	  The default target name for erasing EMMC_USER is "mmc0".
>>>   
>>> +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>>> +	string "Define FASTBOOT block interface name"
>>> +	depends on FASTBOOT_FLASH_BLOCK
>>> +	help
>>> +	  "Fastboot block interface name (mmc, virtio, etc)"
>> 
>> Maybe use another example in the help mmc. for MMC, we have FASTBOOT_FLASH_MMC.
>> FASTBOOT_FLASH_MMC has more features than FASTBOOT_FLASH_BLOCK_INTERFACE="mmc".
>> 
>> For example, boot partition labels.
>> 
>> When using this diff:
>> 
>> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
>> index b77a44ce859b..bfe4db90963c 100644
>> --- a/configs/khadas-vim3_android_defconfig
>> +++ b/configs/khadas-vim3_android_defconfig
>> @@ -65,8 +65,9 @@ CONFIG_BUTTON_ADC=y
>>   CONFIG_USB_FUNCTION_FASTBOOT=y
>>   CONFIG_FASTBOOT_BUF_ADDR=0x6000000
>>   CONFIG_FASTBOOT_FLASH=y
>> -CONFIG_FASTBOOT_FLASH_MMC_DEV=2
>> -CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>> +CONFIG_FASTBOOT_FLASH_BLOCK=y
>> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
>> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=2
>>   CONFIG_DM_I2C=y
>>   CONFIG_SYS_I2C_MESON=y
>>   CONFIG_MMC_MESON_GX=y
>> 
>> We cannot flash the "bootloader" partition:
>> $ fastboot flash bootloader u-boot_kvim3_noab.bin
>> Warning: skip copying bootloader image avb footer (bootloader partition size: 0, bootloader image size: 1285488).
>> Sending 'bootloader' (1255 KB)                     OKAY [  0.054s]
>> Writing 'bootloader'                               FAILED (remote: 'failed to get partition info')
>> fastboot: error: Command failed
>> 
>> If we do want to merge both (at some later time) the above should be supported.
>
> Right, I don't think we want to merge them, and boot partitions are an MMC specific feature,
> I don't think any other storages has those specific hardware boot partitions.

Yes, indeed. We should not want to merge all the code because we would
end up with missing features for MMC.

>
> In any case, we can still just name the boot partition "bootloader" and raw flash it.

But using raw partition descriptors[1] does not work with the above

[1] https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors

>
>> 
>>> +
>>> +config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>>> +	int "Define FASTBOOT block device id"
>>> +	depends on FASTBOOT_FLASH_BLOCK
>>> +	help
>>> +	  "Fastboot block device id"
>> 
>> This is similar as CONFIG_FASTBOOT_FLASH_MMC_DEV, no?
>
> No, the MMC one makes the mmc type implicit, while the block one
> can target any block device (and mmc)

I understand, but when CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc",
CONFIG_FASTBOOT_FLASH_MMC_DEV and FASTBOOT_FLASH_BLOCK_DEVICE_ID are the
same thing.

>
>> 
>> To me, it's confusing to have similar KConfig entries based on interface
>> type.
>> 
>> If we really want to do it this way, then we should add a safeguard in
>> the code: test if FASTBOOT_FLASH_BLOCK_INTERFACE_NAME is "mmc" and if so, add a
>> warning to recommend using FASTBOOT_FLASH_MMC instead.
>> 
>> What's your opinion on this?
>
> Perhaps, not sure it's really problematic

Maybe not for you, because you have the history on this project. But to
a newcomer, having both options seems a bit strange.

If we look at how the blk-uclass is implemented, it inconsisent with how
it's done with fastboot.

longer term, I'd rather deprecate the CONFIG_FASTBOOT_FLASH_MMC_DEV
entry so that we use FASTBOOT_FLASH_BLOCK_INTERFACE_NAME for everything
(including mmc)

I understand that you might not have the time for doing so, so as a
first step can we add a (printf) warning in the fastboot block layer
when the interface name is mmc ?

>
>> 
>>> +
>>>   config FASTBOOT_GPT_NAME
>>>   	string "Target name for updating GPT"
>>>   	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
>>> diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
>>> index 048af5aa823436956142a536c5f7dcf1a8948726..91e98763e8eab84ccd9b8e5354ff1419f61ef372 100644
>>> --- a/drivers/fastboot/Makefile
>>> +++ b/drivers/fastboot/Makefile
>>> @@ -3,5 +3,7 @@
>>>   obj-y += fb_common.o
>>>   obj-y += fb_getvar.o
>>>   obj-y += fb_command.o
>>> -obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_mmc.o
>>> +obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
>>> +# MMC reuses block implementation
>>> +obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
>>>   obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
>>> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..e79429a9732c1da1ce88358747cf1cb9419cd12b
>>> --- /dev/null
>>> +++ b/drivers/fastboot/fb_block.c
>>> @@ -0,0 +1,313 @@
>>> +// SPDX-License-Identifier: BSD-2-Clause
>> 
>> Should this be GPL?
>
> Very good qustion, I'm not the copyright holder, the original author is Dmitrii, not sure about
> the legal things here.
>
> Tom can you help ?

I think we need Dmitrii to acknowledge publicly (on the list) it's okay
to re-licence this.

Dmitrii, are you okay to re-licence this code under GPL v2 (which is
common licence for this project)

>
>> 
>> See:
>> https://docs.u-boot.org/en/latest/develop/sending_patches.html#notes
>> 
>>> +/*
>>> + * Copyright (C) 2024 The Android Open Source Project
>>> + */
>>> +
>>> +#include <blk.h>
>>> +#include <div64.h>
>>> +#include <fastboot-internal.h>
>>> +#include <fastboot.h>
>>> +#include <fb_block.h>
>>> +#include <image-sparse.h>
>>> +#include <part.h>
>>> +#include <malloc.h>
>>> +
>>> +/**
>>> + * FASTBOOT_MAX_BLOCKS_ERASE - maximum blocks to erase per derase call
>>> + *
>>> + * in the ERASE case we can have much larger buffer size since
>>> + * we're not transferring an actual buffer
>>> + */
>>> +#define FASTBOOT_MAX_BLOCKS_ERASE 1048576
>>> +/**
>>> + * FASTBOOT_MAX_BLOCKS_SOFT_ERASE - maximum blocks to software erase at once
>>> + */
>>> +#define FASTBOOT_MAX_BLOCKS_SOFT_ERASE 4096
>>> +/**
>>> + * FASTBOOT_MAX_BLOCKS_WRITE - maximum blocks to write per dwrite call
>>> + */
>>> +#define FASTBOOT_MAX_BLOCKS_WRITE 65536
>>> +
>>> +struct fb_block_sparse {
>>> +	struct blk_desc	*dev_desc;
>>> +};
>>> +
>>> +static lbaint_t fb_block_write(struct blk_desc *block_dev, lbaint_t start,
>>> +			       lbaint_t blkcnt, const void *buffer)
>>> +{
>>> +	lbaint_t blk = start;
>>> +	lbaint_t blks_written = 0;
>>> +	lbaint_t cur_blkcnt = 0;
>>> +	lbaint_t blks = 0;
>>> +	void *erase_buf = NULL;
>>> +	int erase_buf_blks = 0;
>>> +	int step = buffer ? FASTBOOT_MAX_BLOCKS_WRITE : FASTBOOT_MAX_BLOCKS_ERASE;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < blkcnt; i += step) {
>>> +		cur_blkcnt = min((int)blkcnt - i, step);
>>> +		if (buffer) {
>>> +			if (fastboot_progress_callback)
>>> +				fastboot_progress_callback("writing");
>>> +			blks_written = blk_dwrite(block_dev, blk, cur_blkcnt,
>>> +						  buffer + (i * block_dev->blksz));
>>> +		} else {
>>> +			if (fastboot_progress_callback)
>>> +				fastboot_progress_callback("erasing");
>>> +
>>> +			if (!erase_buf) {
>>> +				blks_written = blk_derase(block_dev, blk, cur_blkcnt);
>>> +
>>> +				/* Allocate erase buffer if erase is not implemented */
>>> +				if ((long)blks_written == -ENOSYS) {
>>> +					erase_buf_blks = min_t(long, blkcnt,
>>> +							       FASTBOOT_MAX_BLOCKS_SOFT_ERASE);
>>> +					erase_buf = malloc(erase_buf_blks * block_dev->blksz);
>>> +					memset(erase_buf, 0, erase_buf_blks * block_dev->blksz);
>>> +
>>> +					printf("Slowly writing empty buffers due to missing erase operation\n");
>>> +				}
>>> +			}
>>> +
>>> +			/* Write 0s instead of using erase operation, inefficient but functional */
>>> +			if (erase_buf) {
>>> +				int j;
>>> +
>>> +				blks_written = 0;
>>> +				for (j = 0; j < cur_blkcnt; j += erase_buf_blks) {
>>> +					lbaint_t remain = min_t(lbaint_t, cur_blkcnt - j,
>>> +								erase_buf_blks);
>>> +
>>> +					blks_written += blk_dwrite(block_dev, blk + j,
>>> +								   remain, erase_buf);
>>> +					printf(".");
>> 
>> Can we move soft erase to a separate function? Here we already handle
>> normal block write and normal block erase. Having software erase as well
>> makes the function a bit too long/nested in my opinion.
>> 
>> I't also avoid writing things like:
>> 
>>      blks_written = blk_derase(block_dev, blk, cur_blkcnt);
>> 
>> Where blks_written actually means "amount of blocks that were erased".
>> 
>> Or maybe split write/erase to make each function do only one thing.
>
> Sure, I'll move it to a separate function

Great, thanks.

[...]

>
>>>
>>> -- 
>>> 2.34.1
