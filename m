Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D74EC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 09:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9805881B4B;
	Tue, 28 Jan 2025 10:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738055842;
	bh=Txp/GDv15UgxOHI0jzrOdWkRuy/GcSH+pLEu2MY7nxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dtLoUFrNgMdxV5j5JYtMMCQe2Rtl9/hcrsNhhobn/clG9tkz4/9MocRo993URnoqh
	 cZNrdP2xWZkfQ/5Y0TDy25MhTn2HYT3cZmiYePWDlL1LtolVL3TrBpX5HGNq5GbZIF
	 jDGKEA53j7kkvLR3XxGQcvLfYPqriqnckGWynjn6HIaS7HwbQ+Ta2xpUV7wdJz953P
	 K0lDHyrHixr8/VOez85L6R8b+WBVZDpHgD+9YYlvMLNqpSAwqXccJRbjZgKYEWXqIA
	 xLyr/7deoVUhEjCiMGEVermsCzdYDSH/jTvMqWKV6fCG2A4iWN4fQKx3eU27Ox6hxt
	 tApXqM2qjk0dA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F3081BC0; Tue, 28 Jan 2025 10:17:21 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1ADE819B1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 10:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BRrljYfW"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F2A7210382D08; Tue, 28 Jan 2025 10:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738055837; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Txp/GDv15UgxOHI0jzrOdWkRuy/GcSH+pLEu2MY7nxI=;
 b=BRrljYfW/Psxd3KAerbdL7xP6ZGuwPNuMF3Z2zv/KCLc3wcp0bPIBspKkInxkSI2K+njO8
 z1GwPaQa6WFCOOOBis4Tdr5w7xDyXOjoRkyYHKiJaIo/A6LKl1CEZFyBa73m4GNI03bMg6
 Vy2q3WBWkvQcBllYMhcn2pjkV+yqM3w2N8BzV1AGy2WTJselLCdsSJ+m+Whr5eaS4vTrbt
 prljSYNKVqYP7D7YcOA8mKFJW/1iic2oMhgg1wtFmOWFbFBwYy6lkHNTqpxUAebkTCYzYS
 wdIg9jHvZduBr10CZ8x/RbP/FkK1GGKbzBHc3pX8Ox/1mxrddyg9Ndhm5qi+3w==
Message-ID: <c502e02c-cb64-f0f5-82d0-9e8277fb956d@denx.de>
Date: Tue, 28 Jan 2025 10:17:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] USB: Fix NULLPTR dereference when serial# is unset
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Michael Ferolito <michaelsunn101@gmail.com>,
 u-boot@lists.denx.de
Cc: Kyungmin Park <kyungmin.park@samsung.com>
References: <20250128003010.971175-1-michaelsunn101@gmail.com>
 <2f367a3a-659b-4fe5-be34-e270ee941866@denx.de> <87wmefqp5b.fsf@baylibre.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <87wmefqp5b.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Mattijs,

On 28.01.25 10:11, Mattijs Korpershoek wrote:
> Hi Michael,
> 
> Thank you for the patch.
> 
> On mar., janv. 28, 2025 at 02:49, Marek Vasut <marex@denx.de> wrote:
> 
>> On 1/28/25 1:30 AM, Michael Ferolito wrote:
>>> The current behaviour of this function will dereference a null pointer
>>> if the serial# environment variable is unset. This was discovered on a
>>> board where U-Boot did not have access to the first 256MB of ram,
>>> resulting in a board crash.
>>> In the event that U-Boot has full access to memory, it will still read
>>> from address 0, which is probably not optimal.
>>> This simple check is enough to fix it
>>>
>>> Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: Heiko Schocher <hs@denx.de>
>>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> The subject tag is "usb: gadget: g_dnl:" instead of "USB:" , with that
>> fixed:
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Agreed with Marek on this. Please add:
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> As well.
> 
> Marek, since this is gadget, can this go through my tree?
> In that case, Michael, I can fix up the subject when applying (to avoid
> you sending a v2)

There is already a v4, see:

https://lists.denx.de/pipermail/u-boot/2025-January/578746.html

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
