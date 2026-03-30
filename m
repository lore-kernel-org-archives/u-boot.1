Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0775C1061B20
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 21:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05CB8403D;
	Mon, 30 Mar 2026 23:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Dw5hyBVY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="m2Cohtuy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2931480212; Mon, 30 Mar 2026 23:07:52 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F3A38403D
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 23:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fl3jw6xygz9v7X;
 Mon, 30 Mar 2026 23:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774904869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFJQ9l0Rnwn0AKCXkMyDXfsd0WV8y3qyoPbO847dn2I=;
 b=Dw5hyBVY52sE+EkqiqVrIbUV1t+S0TJ0SywYOLfViNxLGbX8LlUOmV+ipi20Y67zou3fKK
 uJojAA/d9MNXe2t1MsVcAYelnctepGnGHDmZeQRMDTnxVMJfP7rzZjkI2vNMZ7w09JnWYt
 DPtyMut3FpngkoBJW8Org1ChZ3NVHLp21VBCw75J/7uzwsjdrnTENjoQTumvsbpyYAEdT0
 gvO0Tl6Agzqv+EUaXWGkD19EdgK15Pp61PPS85Hh8dPOdSujzHGOLlzcbY4ZSQ7QtcK620
 HhZg9Q+T5bvxwhpZSH9nqzqH7CAaZh7+B2l+X3WtzFIeg+g2yuNu8xy35h4PxQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=m2Cohtuy;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <2c4f13c9-ff78-42c6-b770-71d06f59d522@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774904867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFJQ9l0Rnwn0AKCXkMyDXfsd0WV8y3qyoPbO847dn2I=;
 b=m2CohtuynH+9MFpS/Tsk9MKpzq4y3ADx86I9Xf7y9korhsv7mw+ZZPOkts7RpRjxBORj/m
 tDsojoqvX8hDEBPk3DN099HKc2tWhp2+NEvsFGiHFbNs+7li2ISo98iN0bIAN9wHqeTq1Z
 hPr3H1TocQ7D5lloqBgx3ciABOIKuBi6XN9DcMc5XuHgeKue9sEQJVGTgvyJv1HLb7QN60
 zEbc1rmU3pC4ikdt6vVqkcOFy+/Ud7dZlL5d9ES77dubD/Mh281sY+fsd1PpJlwffAPAVh
 kiKyy+r9CNjiH8C+VMA+fK4ryW/i/zCidrAAX9Mn7ZHWiCoQciuGY08NyLwxlg==
Date: Mon, 30 Mar 2026 19:24:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] dm: Respect dma-ranges size
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20260315235756.304972-1-marek.vasut+renesas@mailbox.org>
 <DHG5MITAHNOS.3KKMVUI98SAZ0@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DHG5MITAHNOS.3KKMVUI98SAZ0@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: n5x5w4z3u4mgtofk131oruzgj1i3h91r
X-MBO-RS-ID: 1bdc6ef08470a72c9a0
X-Rspamd-Queue-Id: 4fl3jw6xygz9v7X
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

On 3/30/26 3:34 PM, Markus Schneider-Pargmann wrote:

Hello Markus,

> On Mon Mar 16, 2026 at 12:57 AM CET, Marek Vasut wrote:
>> Rework dev_phys_to_bus() and dev_bus_to_phys() to respect the size
>> of the area specified in dma-ranges DT property. The area outside
>> of ranges is remapped 1:1, while the area in the ranges is remapped
>> according to the description in the dma-ranges property.
>>
>> Adjust the test to test the area within the remapped range, not area
>> outside the remapped range, which was incorrect.
>>
> 
> Should this have a Fixes tag?
> 
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Not a big expert, but this looks good to me:
> 
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

This was broken long enough, so this should go into next so it would get 
sufficient testing before the next release.

[...]

>> +++ b/include/dm/device.h
>> @@ -166,8 +166,9 @@ enum {
>>    *		When CONFIG_DEVRES is enabled, devm_kmalloc() and friends will
>>    *		add to this list. Memory so-allocated will be freed
>>    *		automatically when the device is removed / unbound
>> - * @dma_offset: Offset between the physical address space (CPU's) and the
>> - *		device's bus address space
>> + * @dma_cpu: DMA physical address space (CPU's)
>> + * @dma_bus: DMA device's bus address space
>> + * @dma_size: DMA window size
>>    * @iommu: IOMMU device associated with this device
>>    */
>>   struct udevice {
>> @@ -196,7 +197,9 @@ struct udevice {
>>   	struct list_head devres_head;
>>   #endif
>>   #if CONFIG_IS_ENABLED(DM_DMA)
>> -	ulong dma_offset;
>> +	phys_addr_t dma_cpu;
>> +	dma_addr_t dma_bus;
>> +	u64 dma_size;
>>   #endif

[...]

>> +++ b/include/phys2bus.h
>> @@ -21,17 +21,23 @@ static inline unsigned long bus_to_phys(unsigned long bus)
>>   }
>>   #endif
>>   
>> -#if CONFIG_IS_ENABLED(DM)
>> +#if CONFIG_IS_ENABLED(DM_DMA)
> 
> This is not related to the code changes right?

It is, see the matching hunk above and below why this is guarded by DM_DMA .

>>   #include <dm/device.h>
>>   
>>   static inline dma_addr_t dev_phys_to_bus(struct udevice *dev, phys_addr_t phys)
>>   {
>> -	return phys - dev_get_dma_offset(dev);
>> +	/* If the PA is in the remap range, apply remap. */
>> +	if (phys >= dev->dma_cpu && phys < dev->dma_cpu + dev->dma_size)
>> +		phys -= dev->dma_cpu - dev->dma_bus;
>> +	return phys;
[...]
