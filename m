Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79652C7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 09:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A79381D6A;
	Mon, 30 Jun 2025 11:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fQVZuSmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3FA81FEE; Mon, 30 Jun 2025 11:28:14 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F10480B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 11:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bW16f40g3z9t0t;
 Mon, 30 Jun 2025 11:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751275690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWafNUkmmtO/r5TKM0wBEROwq7sbgmj1ZygsZDn8GvM=;
 b=fQVZuSmF3VlXq53yMWddRLp6PvQjk9yfCYVikS4ge4RjlaKvK0LGFS0f6WEMmo94lb0OsF
 4VvUZWTQ2OQVvGqA/PCSgKEcKQY5NJlyxdDnTI979n2JLlZ4B3hETO7Cp0Nsygf2XgIp6+
 CrYAWANIMMX0tZyyP8njKxP69JqQL1XMXWxr+nbmcFNfUvr5LYUvBdMxdUQ0JHVdKRkVqx
 QbLY6QQbbCW1mODYBV0x7IFaBl4T3LWH+bC7As+CYCTqmYP3W/rdvPNvTZAzzzbZKUj0p9
 nLlny7okci9x6e8m0O5c2QlF2RYcfrYsW6xZSd3OsuilbESgw1CY90xxeRKi3w==
Message-ID: <ae58844c-da5c-4951-a1bc-05757788955a@mailbox.org>
Date: Mon, 30 Jun 2025 11:28:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] reset: stm32: Fix header misuse
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20250630000926.952277-1-marek.vasut@mailbox.org>
 <8341a0eb-4182-4c40-9f0a-26b92941c18e@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8341a0eb-4182-4c40-9f0a-26b92941c18e@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zaiq8tzjss5kjtn36dnnhimdqrnswqqe
X-MBO-RS-ID: 7217b8de11fc4359b27
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

On 6/30/25 8:17 AM, Patrice CHOTARD wrote:

>> diff --git a/drivers/reset/stm32/stm32-reset.c b/drivers/reset/stm32/stm32-reset.c
>> index 975f67f712a..918e81e588f 100644
>> --- a/drivers/reset/stm32/stm32-reset.c
>> +++ b/drivers/reset/stm32/stm32-reset.c
>> @@ -5,7 +5,7 @@
>>    */
>>   
>>   #include <dm.h>
>> -#include <stm32-reset-core.h>
>> +#include "stm32-reset-core.h"
>>   
>>   /* Timeout for deassert */
>>   #define STM32_DEASSERT_TIMEOUT_US	10000
> 
> Which version of gcc do you use ? on my side i got no issue with arm-none-eabi-gcc (Arm GNU Toolchain 14.2.Rel1 (Build arm-14.52)) 14.2.1 20241119
> But nevertheless :
arm-linux-gnueabi-gcc (Debian 14.2.0-19) 14.2.0
aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0

Both STM32MP1 and, as I discovered now, stm32mp25_defconfig fail to 
build. I suspect the ARM GCC fork might be setting up some CFLAGS, or 
some other such environment variables, which avoid this issue ? Try and 
check your build environment ("$ env") and see if there is something 
like that.
