Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BF3C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 15:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDD088216;
	Wed, 15 May 2024 17:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715785885;
	bh=VtLxjhvxB+JakY9qQP49jMgRFX/7W/gIczvh2EHnxyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JwfpzTPPz4KTPDmp8QHpf9CMIDXQZEaTehh+mN4EOsYRudXZD+SeeE8FtuFCdmOmd
	 oe0qjS9DRinP5gMdLNUGDZOWpZKBJlULljm0JR0MIocerU/K5aLNQSgLnprE9klNdt
	 CwLLZhuDxrJgUuK5C+1VM7+1D0On3AZeGa9Qa6QQg2zaT9YYWmjIQTiOwALwIccI9u
	 UJB4zU2wSgwiJdnP2uGIYumm6J36sYcixDkWqvcJtHoHf51PXge6yck4z7gQoCWYK4
	 uyV92ZaV3cygB9mvWTDKyLYyzOJwy5lmTn5F7S4TK5WrxojHvb2F3vxeg4P5aLOmYz
	 xau3DtNcga8sw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A83C88262; Wed, 15 May 2024 17:11:23 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3E888010
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 17:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VfcBH5Fz5z9sld;
 Wed, 15 May 2024 17:11:19 +0200 (CEST)
Message-ID: <f6ad2812-40bf-438c-b2ea-ed2b5526fc89@denx.de>
Date: Wed, 15 May 2024 17:11:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu 10/10] arm: mvebu: turris_omnia: Support old
 DDR3 training, selectable via env var
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240415163043.7482-1-kabel@kernel.org>
 <20240415163043.7482-11-kabel@kernel.org>
 <149e251a-baa7-4512-990a-d332d0d6177f@denx.de>
 <20240515105906.3cfca4fb@dellmb>
 <8ea997c2-e164-4ea1-9a75-28bbf159827b@denx.de>
 <20240515112431.5ba3f2a0@dellmb>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240515112431.5ba3f2a0@dellmb>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/15/24 11:24, Marek Behún wrote:
> On Wed, 15 May 2024 11:10:09 +0200
> Stefan Roese <sr@denx.de> wrote:
> 
>> Hi Marek,
>>
>> On 5/15/24 10:59, Marek Behún wrote:
>>> On Mon, 6 May 2024 12:03:55 +0200
>>> Stefan Roese <sr@denx.de> wrote:
>>>    
>>>> Hi Marek,
>>>>
>>>> On 4/15/24 18:30, Marek Behún wrote:
>>>>> Support old DDR3 training code on Turris Omnia, selectable by U-Boot
>>>>> enviroment variable.
>>>>>
>>>>> Users experiencing DDR3 initialization failures or random crashes of the
>>>>> operating system due to incorrect DDR3 configuration can select the old
>>>>> DDR3 training implementation to fix those issues by setting the
>>>>> environment variable
>>>>>      env set omnia_ddr3_training old
>>>>>      env save
>>>>>
>>>>> Signed-off-by: Marek Behún <kabel@kernel.org>
>>>>> ---
>>>>>     arch/arm/mach-mvebu/Kconfig                   |  1 +
>>>>>     board/CZ.NIC/turris_omnia/Makefile            |  1 +
>>>>>     board/CZ.NIC/turris_omnia/old_ddr3_training.c | 79 +++++++++++++++++++
>>>>>     board/CZ.NIC/turris_omnia/turris_omnia.c      |  2 +-
>>>>>     4 files changed, 82 insertions(+), 1 deletion(-)
>>>>>     create mode 100644 board/CZ.NIC/turris_omnia/old_ddr3_training.c
>>>>
>>>> For turris_omnia_defconfig, this is dropped when compiled:
>>>>
>>>> drivers/ddr/marvell/a38x/old/ddr3_debug.c:776:12: warning:
>>>> 'ddr3_tip_access_atr' declared 'static' but never defined
>>>> [-Wunused-function]
>>>>      776 | static int ddr3_tip_access_atr(u32 dev_num, u32 flag_id, u32
>>>> value, u32 **ptr);
>>>>          |            ^~~~~~~~~~~~~~~~~~~
>>>
>>> And it also seems that there is still something wrong with this
>>> old DDR training code port. Some boards still experience random bugs
>>> with this, but not with the U-Boot from 2015. :-(
>>
>> Hmmm, strange.
>>
>> How to continue? Are these "old DDR training patches" on hold for now?
> 
> The first 5 patches should be fine, the "old DDR training" comes in the
> second half. Is it possible to merge only the first 5? And also the one
> patch I sent on April 30:
>    arm: mvebu: turris_omnia: Fix ethernet PHY reset gpio FDT fixup

Yes, that might be possible. Let me check...

Thanks,
Stefan
