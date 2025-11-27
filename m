Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0ADD116E2
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 15:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD8C184326;
	Thu, 27 Nov 2025 16:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SQK2XMeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23FD48432A; Thu, 27 Nov 2025 16:11:23 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8EF8431E
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 16:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dHKdL3vKSz9tnx;
 Thu, 27 Nov 2025 16:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764256278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9v9E7Z+sZbphgXjPwv/FG4PNqTK388D9EQtgURjCUk=;
 b=SQK2XMeWdEO63tduQtVutJtGePvEVk7GCcZejKU6IZH1h0cTWMRAs/nYfWihZ8DsndgI7c
 K299sEJTCRKth/eScqHJ+Ekuad7P6uPel5Lr7JeZCvIoBPAlTkFbZzhF+dBWBcInUAicbj
 gOJWrr1dJRfwjkKPc+Fzl5O1s57wf9Atq1AmNwHPXC0TjzEQxXpj5k2dWRHEGQk0vDXJTw
 sySxs4B7ZLE12AvxmDwSr2JibYJ+RQDxg/7O6MW1vyqxntH5DafW/y3v5Xmp64L/GJt55U
 ax8jQ4GrPv09KtOngxgIiyY7XlvjhAhs/Miz74JaKPUwdeJcx8M4RZv3yLxqdA==
Message-ID: <95c32a08-7843-49ff-afd8-f302b55d4011@mailbox.org>
Date: Thu, 27 Nov 2025 16:11:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e5af0e26-6b84-4321-bb26-c6848d233f4a@mailbox.org>
 <7b563e58-a4d4-42ef-bbec-87af97b1ac95@siemens.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <7b563e58-a4d4-42ef-bbec-87af97b1ac95@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1w6amni4wq7obxt4tsgj6iutfzdstbcd
X-MBO-RS-ID: f503a36763e9bcae54e
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

On 11/27/25 8:42 AM, Jan Kiszka wrote:
> On 25.11.25 13:20, Marek Vasut wrote:
>> On 11/14/25 6:13 PM, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> If U-Boot is located on MMC, SPL and U-Boot proper are glued together.
>>> More precisely, SPL is stored 4 times. Take this and its padding into
>>> account and adjust sector number via board_spl_mmc_get_uboot_raw_sector.
>>> This allows loading from a partition, without the need to hard-code the
>>> offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>    arch/arm/mach-socfpga/board.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/
>>> board.c
>>> index 28554b7a109..d756f7381fb 100644
>>> --- a/arch/arm/mach-socfpga/board.c
>>> +++ b/arch/arm/mach-socfpga/board.c
>>> @@ -14,6 +14,7 @@
>>>    #include <hang.h>
>>>    #include <handoff.h>
>>>    #include <image.h>
>>> +#include <spl.h>
>>>    #include <usb.h>
>>>    #include <usb/dwc2_udc.h>
>>>    #include <asm/global_data.h>
>>> @@ -209,3 +210,11 @@ void lmb_arch_add_memory(void)
>>>        }
>>>    }
>>>    #endif
>>> +
>>> +#ifdef CONFIG_SPL
>>> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>>> +                         unsigned long raw_sect)
>>> +{
>>> +    return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
>> Please add a comment whether this is offset within a partition or within
>> a raw block device.
> 
> Depends on the mode. It is relative to the partition when using any of
> those modes, otherwise relative to base sector. Will add that.

Thank you.

>> Also, I see the long discussion thread, maybe it would be good to point
>> out which commit exactly broken the DE0 board.
> 
> 2a00d73d081a14e7c2ecf23794b6d029268d8ca3 - though it is not completely
> fair to say it broke things because the code paths we took before that
> change were not really consistent and papered over issues which the
> refactoring than surfaced.
I see.
