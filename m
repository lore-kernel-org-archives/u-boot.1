Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6361DD3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 12:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6068983979;
	Mon,  8 Dec 2025 13:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="JvZpaW2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439A483956; Mon,  8 Dec 2025 13:31:39 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F2E83956
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 13:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1765197092;
 bh=LG/ky4iHP/7YG7H5mU2flIWpMSTLgkpACKtXardSa7A=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=JvZpaW2tLO45hUHQSdY/Ea9fRL2SEV5VZFLnRIHAXqBjzwkNFIvgdaxZoBTHbSg1j
 1/2hh2TYAh6nTzUZNsrpgu27T2f+1rIVGtCLoMMX9SqAFzgzz4AbGPEGTsnfAXkrq9
 WM6+kc8z92V7P9Jwi/hgvdJoTyka10yF0M4d9z/+3rcL1wYSmygnLMAb7b96AO66VS
 WEgZHQEatGfbyQxY91rV8H8l1J1gpOJ9rVfUKjXZ01HiAUoEblBiInSkQ9P3PQNzrZ
 zNYjIKsQsGT+k72NwBRjqXxn0hX5Auyz9r7uV6BdUvkOIxOScYhD8ONS1SMVBtOZSi
 SEGeBGFmXTv4w==
Received: from [192.168.2.54] (unknown [98.97.27.25]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7DB0BB220B1D;
 Mon,  8 Dec 2025 13:31:31 +0100 (CET)
Message-ID: <50c04370-796b-48c7-9e6d-c9c28de259c9@freeshell.de>
Date: Mon, 8 Dec 2025 04:31:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: E Shattow <e@freeshell.de>
Subject: Re: [PATCH v3] doc: board: starfive: update jh7110 common description
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
References: <20251202102931.102692-1-e@freeshell.de>
 <8c4b8339-0bfc-4d2f-8939-198d43ab8b26@gmx.de>
Content-Language: en-US
In-Reply-To: <8c4b8339-0bfc-4d2f-8939-198d43ab8b26@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


On 12/2/25 05:35, Heinrich Schuchardt wrote:
> On 12/2/25 11:29, E Shattow wrote:
...snip...
>> +
>> +First Stage BootLoader
>> +^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +JH-7110 FSBL is typically U-Boot SPL or any vendor flash programming
>> tool.
>> +
>> +====== ====== ===================
>> +RGPIO1 RGPIO0 U-Boot SPL function
>> +====== ====== ===================
>> +0      0      BOOT_DEVICE_SPI @ offset 0x100000 (CONFIG_ENV_OFFSET +
>> CONFIG_ENV_SIZE)
>> +0      1      BOOT_DEVICE_MMC2 @
>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
>> +1      0      BOOT_DEVICE_MMC1 @
>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
>> +1      1      BOOT_DEVICE_UART @ YMODEM
>> +====== ====== ===================
>> +
>> +U-Boot SPL initializes DRAM and configures PLLs needed by CPU and
>> peripherals.
> 
> Thanks a lot E for putting all this effort into the documentation.
> 

> This sentence would better fit above the table.

I agree, and have moved this sentence above the table. Thanks.

> 
>> +U-Boot SPL function is selected by configuration of [RGPIO1:RGPIO0]
>> then copies
>> +data to the start of DRAM and executes.
> 

> "U-Boot SPL function" sounds unfamiliar here.

Yes, it is borrowed from the phrasing in StarFive documents where is
listed a similar-looking "Boot ROM function" heading for a table of
inputs and outcomes. It is not the same meaning as programmer
sub-routine, here it is closer in meaning to the common usage of "function".

> 
> How about:
> 
> "U-Boot SPL uses the same GPIOs as the Boot ROM to decide from where to
> load the next boot stage which is the FIT image containing OpenSBI and
> main U-Boot. When booting via UART Ymodem is used instead of Xmodem at
> this boot stage. In the fit image file fw_dynamic.bin of the "generic"
> OpenSBI platform is used as SBI implementation."

Per-board documentation may include vendor-specific filenames and
expectations by users and to also give some direction about what
switches or buttons on a given hardware revision correspond to the
[RGPIO1:RGPIO0] values. That would be confusing if we try with too much
effort to make summary-of-summary in this snippet document itself; which
summary-of-summary is important for the reader? Let's leave this for
per-board docs. There's good reason why I have the information layout in
a series of tables and logical step-by-step progressions, and with
minimal exposition.

Ref links to documentation on concepts are okay: SBI implementations,
FIT image files, What is XMODEM versus YMODEM and why does a user need
to know that. If you want those hyperlinked in and it's not too
distracting we can find a place for that. It is annoying for me that I
mention "FIT image" without any ref link, but I don't know what part of
U-Boot documentation a user would find this helpful to link to.

> 
> 
>> +
>> +=========== ===========
>> +Address     Description
>> +=========== ===========
>> +0x040000000 start of DRAM
>> +0x240000000 uncached alias of DRAM
>> +=========== ===========
> 

> This table seems to be misplaced. It should be together with the
> sentence "U-Boot SPL initializes DRAM ..." above.
> 

Sorry for the gaps in information in the patch for review.

The way I suggest to review this is apply the patch and read the
document as a whole. It is many substantial changes and so I am not
going to break this patch up into smaller logical changes for review.

There's context information you're missing by having read only the
posted patch for review. I did try to adjust git diff context parameters
but it was never a readable output.

>> +
>> +Note: The largest DRAM size with JH7110 is 8GB because the uncached
>> alias of
>> +DRAM begins at +8GB following the start of DRAM.
>> +
>> +Second Stage BootLoader (OpenSBI fw_dynamic.bin + U-Boot Main)
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Maybe add something like:
> 
> U-Boot SPL selects one of the device-trees contained in the FIT image
> with OpenSBI and main U-Boot according to the device-information
> provided in the EEPROM serial number fields.
> 

Board-specific devicetree topic does not belong in this document. There
are board-specific documents for board-specific topics.

>> +
>> +U-Boot Main is supported in S-mode and depends on prior stage M-mode
>> SBI runtime
> 
> How about:
> 

> OpenSBI invokes main U-Boot in S-mode passing the device-tree received
> from U-Boot SPL.

Is the significance of an "SBI" described elsewhere in U-Boot
documentation that we may ref link to?

If there is a ref link then I would prefer that instead of inventing
again a description. If OpenSBI passed the device-tree from U-Boot SPL
then it makes zero sense why we are again reading EEPROM instead of just
parsing compatibles or whatever, so I am suspicious of that description.

> 
>> +services provided by OpenSBI FW_DYNAMIC firmware.
>> +
>> +Loading U-Boot
>> +--------------
>> +
>> +Vendored versions of U-Boot (as pre-installed on supported boards)
>> are generally
>> +capable in U-Boot console of UART data transfer and updating QSPI Flash.
>> +Additionally there may be a vendor Board Support Package using the
>> deprecated
>> +SDIO3.0 / eMMC5.0 boot modes. It is not documented here how to update
>> U-Boot in
>> +vendor BSP data images, nor use of the deprecated boot modes. The
>> recommended
> 
> If U-Boot is on eMMC or SD-card, you obviously you can use the mmc
> command or write the relevant partitions from Linux.

Board-specific use of the mmc command does not belong in this document.
There are board-specific documents for board-specific topics, and
hopefully some ref link where mmc use is discussed so we are not
repeating it for common situations.

> 
> Please, mention somwhere:
> 
> * which GUID is used by the BootROM to find an image on SD-card:
> 2E54B353-1271-4842-806F-E436D6AF6985

The GUID you have named is included in the cited StarFive loader
description written by Hal. I find that the description is suspect and
does not stand up to basic scrutiny looking at the content of BootROM.

I will not be expanding on something I know to be wrong or misleading.

> * which partition number on eMMC or SD-card is used by U-Boot SPL to
> load main U-Boot by default: 2

CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION is listed in the table. The
number itself may be configurable so left as an exercise for the reader,
it is not necessarily "2".

> 
> Best regards
> 
> Heinrich
> ...snip...

Yes thanks for your review(s) and critique. -E
