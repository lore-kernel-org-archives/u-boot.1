Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DFACD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 13:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA21884C81;
	Fri,  8 May 2026 15:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="G/fj+DKg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RLu/0E2U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08BBA84CBE; Fri,  8 May 2026 15:51:53 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3914684C3C
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 15:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBrBt5TCFz9vFl;
 Fri,  8 May 2026 15:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778248310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzKO8K3oxEHOU8UAQUGGuZ2dYZZcs3eXc/b7pRek8LI=;
 b=G/fj+DKgbESH0/QYZAJvaXyt2XO3UylBushqGaXpdxNQY2bZHxhX41PrWRusvkc/caLA+F
 s7E6+ZSDSpUiC57SSqx0C0uHJfaPOBYdCN6qqYP9EYJ6HB42XPaq0OK7QsLq8H5v4+pOh4
 zY8f5ynM5DfjXOjmRfYvQx30tOuRiCo3dOtvrUGKJdMiXnFSJrw7kNW3S4hJIR43dvElga
 N1lZtmKK7YveNhc0h7WPcjIlTuB4XyNHYxDp096h1NWqnr2KXMw9NKDLL2TxOkEr0sTg8i
 pfEyDeDoGqzCVPPNVEfa17i5hMmfL7StFlNLgGRYJiQIlNOPbEXEJiu3UTfvKw==
Message-ID: <4a54d1b0-47ce-4112-ad98-9d063bedcf69@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778248309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzKO8K3oxEHOU8UAQUGGuZ2dYZZcs3eXc/b7pRek8LI=;
 b=RLu/0E2UlxgYfGjnYf3aiIIYsYdqmJklYCO7GdJDAPcUrFwf87TtkLJZ5aleWeErfYBkqU
 R74yoLbuxNbfbrYJ1xAeAJtp51PEWptWAwe1Hp7lPZ9dpGkYeTMr91MwysHeuLFxUdvIv0
 0mhvCG6xY+cD47m+XVDsqrTYzPC8T1dKW7e1uwMmOXUxknONPrQJd9q4n7l8URoXsELDvs
 yTC+MneuFxsXn0LAviurKFvBvg39uF7wO1sOxMn+agNc9PQw8jjJy9kkPVGC91qT7v08PL
 jKmy3z+KrW687Q8i1bExISIKUhe43q5OzAGWzAw89g3aIBT+VZYFuJPQ5DmkTQ==
Date: Fri, 8 May 2026 15:51:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] cpu: armv8: Staticize and constify driver ops
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260507164338.59399-1-marek.vasut+renesas@mailbox.org>
 <060791c2-e18b-47f4-8dc9-dd7daca8b260@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <060791c2-e18b-47f4-8dc9-dd7daca8b260@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 432100cc5266707cb08
X-MBO-RS-META: 4iniz8kssemgozzmkht1bpea4mccqbti
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

On 5/8/26 3:44 PM, Quentin Schulz wrote:
> Hi Marek,
> 
> On 5/7/26 6:43 PM, Marek Vasut wrote:
>> Set the ops structure as static const. The structure is not accessible
>> from outside of this driver and is not going to be modified at runtime.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/cpu/armv8_cpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
>> index 4eedfe5e2c5..ed87841b723 100644
>> --- a/drivers/cpu/armv8_cpu.c
>> +++ b/drivers/cpu/armv8_cpu.c
>> @@ -124,7 +124,7 @@ int armv8_cpu_fill_madt(const struct udevice *dev, 
>> struct acpi_ctx *ctx)
>>       return 0;
>>   }
>> -struct acpi_ops armv8_cpu_acpi_ops = {
>> +static struct acpi_ops armv8_cpu_acpi_ops = {
> 
> Missing const?
Thanks. I just sent a V2, I had to fix up a few of the patches and 
didn't update the commit message.
