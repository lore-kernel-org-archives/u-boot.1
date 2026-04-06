Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8854F46C54
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 15:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75F738352B;
	Mon,  6 Apr 2026 17:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="k/IPjqbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7452B84034; Mon,  6 Apr 2026 17:56:48 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 026708341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 17:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fqDTm1vqvz9t3C;
 Mon,  6 Apr 2026 17:56:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775491004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTip3CfntAHg7WoUNMIDeQSXDgZ72tPn+UKxV2r+mec=;
 b=k/IPjqbi6MgqN5GcDZIK8TOkrYhTtHOcl5PV8p+XLvCvXEU6YBqS6Iyl3TpAaTsdy7GWjd
 BSg9HglV09UMKLAFdXzfUn3z6fN7qMxGpJRA6VbVjM2GjcpEL4zO6CFW2vy8zoi/eSFsLC
 7Pkm9wU55yh40PmD4SJZsiLSXpPuEzuKRQmU/ClO4JJat1j17jHPV52z76/vCtiWojYrL1
 NB9kqKemOyp7kBD4DdLn90vLh2mIVqEi0BQFIanxrCb2oHvK9vflVNKQQx/rwJ+I+qXOym
 C9aArdXJoN/+HdLW/0OAfsPttDFoI31Ibwe50kMjr51HbR6k4XH9CdSDjVd7Lw==
Message-ID: <7a190e6d-60db-4087-ae1c-9013dc6706bc@mailbox.org>
Date: Mon, 6 Apr 2026 17:56:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/4] common: move ram_base calculation to independent
 INITCALL()
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, jonas@kwiboo.se,
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-3-ilias.apalodimas@linaro.org>
 <b4015957-76b8-4531-b694-cae143a65f49@mailbox.org>
 <20260406154105.GQ41863@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260406154105.GQ41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oo4g4rq7rrguhhgr9t8nxzmwipneaet6
X-MBO-RS-ID: defdf9745d14d601d1a
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

On 4/6/26 5:41 PM, Tom Rini wrote:
> On Sun, Apr 05, 2026 at 05:59:52AM +0200, Marek Vasut wrote:
>> On 4/3/26 11:01 AM, Ilias Apalodimas wrote:
>>> Currently, ram_base is calculated within setup_dest_addr().
>>> However, upcoming patches that enable U-Boot relocation to the highest
>>> DRAM bank require ram_base to be initialized earlier.
>>>
>>> The default dram_init_banksize() definition relies on ram_base
>>> to calculate the start of the first bank. But following patches
>>> will move that function to execute immediately before setup_dest_addr().
>>>
>>> So let's split the ram_base initialization in its own INITCALL.
>>>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> ---
>>>    common/board_f.c | 12 +++++++++---
>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/common/board_f.c b/common/board_f.c
>>> index 91c569da9682..7df92281c35a 100644
>>> --- a/common/board_f.c
>>> +++ b/common/board_f.c
>>> @@ -329,6 +329,14 @@ __weak int arch_setup_dest_addr(void)
>>>    	return 0;
>>>    }
>>> +static int setup_ram_base(void)
>>> +{
>>> +#ifdef CFG_SYS_SDRAM_BASE
>>> +	gd->ram_base = CFG_SYS_SDRAM_BASE;
>>
>> Would it make sense to reset the variable to 0 in case CFG_SYS_SDRAM_BASE is
>> not defined ?
> 
> In that gd should be zeroed out do we need to?
> 
>> Or better yet, how about moving CFG_SYS_SDRAM_BASE to Kconfig with default
>> value 0 ?
> 
> We don't set default values when a valid value must be provided for a
> platform to work. It wasn't migrated to Kconfig as it's not really a
> configurable value, it's something that if we could pull it from the
> device tree, would be great. A someday middle-ground would be to mimic
> how Zephyr uses the device tree and get some compile-time constants from
> the device tree.
It could still be a Kconfig hex value without description and with 
default value for each platform. That would still be better than the 
CFG_* remnants and would simplify this code.
