Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CA1C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 13:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D94587F2A;
	Tue, 23 Apr 2024 15:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N6s+SIiK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZT1i6io0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 274BA87F13; Tue, 23 Apr 2024 15:44:53 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2444187F2A
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 15:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VP3Jf68Rdz9sjn;
 Tue, 23 Apr 2024 15:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1713879890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHOwv+Ha04WNtVBz6cd8vfyGRK4Sets23Op64dne0Kc=;
 b=N6s+SIiKjxAraAHrmvFfVGb/SxbjSGT9/WJ7yGTS44T/xVed/iVXDZ9R7hjWS9RMwgZ7qS
 /wB2Eh7koR3SvyAfsXMdQVrApOpp8GQz7dTwmSw1qxjA/m63esE6p5d7pG8nrCpu2PF3Ql
 9IM1ZacKf/9C9qZ8A8s4ngOqEVV/CHDy59cxYJVJ3WfkPMFSz7AF8zAhCLJh3RPmKstlDH
 6GRTTDFjyUJdMyw3+TtWNSJt8AILQOmNu48QWT3oY5vFuEO5TcGlSkK0vnSX1sUlWrFryI
 C3x42qHf46P2u34Zhs0xCdm9wbkH5rVemms++1B7MqRb9Oqahvp8YIWsx/2aKg==
Message-ID: <4ab76588-348d-4cb1-ae0c-e25ccc83cbfb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1713879889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHOwv+Ha04WNtVBz6cd8vfyGRK4Sets23Op64dne0Kc=;
 b=ZT1i6io0wG2YsFDupWOJW98p6giFvRG6QLvMIY4ZBADkPs3zj6FqzbdvF5q5yZjyYIbYRL
 ATYw5AZ6GlthY9T/0TV3ED4mIlA8FJebzxzNdBZyuW9d0Ei5D5FlWmOfO3ASQAPUrG7CL9
 nce2DzYjnEDQVI1Q7NQgfPbD38JG3Z66Dx9YcMV5eAufIlukX7qAqo25F6TxNIwoiyNFGR
 ZRMzp6Y30xiXhL+K46Yn99oWP04ysA9N/8YTaIiCXi2qAPkShJBy3pzvOR9/cCIDZv92f6
 j9TFKQL7gEUjdLXAWuIOUWv/jAgh1+681HVrJvYSS6IXOw8RZJst/J8o+siTdw==
Date: Tue, 23 Apr 2024 15:44:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] net: eth-uclass: Introduce NET_PREFER_ROM_MAC_ADDR
To: Detlev Casanova <detlev.casanova@collabora.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>
References: <20240422135927.23582-1-detlev.casanova@collabora.com>
 <20240422135927.23582-2-detlev.casanova@collabora.com>
 <38f2306f-4c82-4bc4-b2ee-6051dc55a4c2@mailbox.org>
 <12429900.O9o76ZdvQC@arisu>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <12429900.O9o76ZdvQC@arisu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: d7q1des658ypdenqdsut4ndrahdczfww
X-MBO-RS-ID: 19b1d49135953ba763b
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

On 4/23/24 3:35 PM, Detlev Casanova wrote:
> On Monday, April 22, 2024 3:47:21 P.M. EDT Marek Vasut wrote:
>> On 4/22/24 3:56 PM, Detlev Casanova wrote:
>>> On some boards, a MAC address is set based on the CPU ID or other
>>> information. This is usually done in the misc_init_r() function.
>>>
>>> This becomes a problem for net devices that are probed after the call to
>>> misc_init_r(), for example, when the ethernet is on a PCI port, which
>>> needs to be enumerated.
>>>
>>> In this case, misc_init_r() will set the ethaddr variable, then, when
>>> the ethernet device is probed, if it has a ROM address, u-boot will warn
>>> about a MAC address mismatch and use the misc_init_r() address instead
>>> of the one in ROM.
>>>
>>> The operating system later will most likely use the ROM MAC address,
>>> which can be confusing.
>>>
>>> To avoid that, this commit introduces NET_PREFER_ROM_MAC_ADDR that can
>>> be set for boards that have such an interface.
>>>
>>> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
>>
>> Won't the system pick ROM MAC if $ethaddr is not set ?
> 
> Yes, and in the case of rockchip, misc_init_r() will set an $ethaddr based on
> the cpuid, which makes the eth driver use that instead of the ROM one.

Shouldn't the rockchip misc_init_r be fixed then ?
