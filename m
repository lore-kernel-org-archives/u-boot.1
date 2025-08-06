Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759C8C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 15:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E46842F7;
	Wed,  6 Aug 2025 17:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fnv6iUu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D9D48431C; Wed,  6 Aug 2025 17:36:38 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88227842EE
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 17:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxvXX49qhz9scJ;
 Wed,  6 Aug 2025 17:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754494588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfIkUhwtClXl1amud2j4i7H81Hg3qKxguJq56/FETt4=;
 b=fnv6iUu5HhsJpUhYtJyR1WezZ+7u+63lzrWuF0kCuNBt05zXKXpJhkalem16NA0DKiRyP2
 kPqarN+Ti4B2PJ5yLmvcaLjIqqZGeRs/wMCCsgGjet8ZCJyrLQgbWNeiMXMoOq8DV/tW/N
 Jz8TWNnHXJKclhpJUs/Mlv8HEcC5XMeYjDR15tv/b+TCPg3Zjj6nYb1KLng+U8foxLt0Yv
 y9s8TAsymtvkushhcR3YAsaL11ot8fDquJtTMVqqh0sJTOfbS4FmKMYxTVa4lJNtoDDu/n
 XnUXeeufU1gbrtpJWxwQ+E4vL+0SN79KWwwl1oFPZx1PoVGkB49EyWJkgLInyg==
Message-ID: <8a05c8a6-a0eb-4f84-aa48-0d0e0f532fa4@mailbox.org>
Date: Wed, 6 Aug 2025 17:36:27 +0200
MIME-Version: 1.0
Subject: Re: Smatch report for drivers/net/phy/marvell10g.c
To: Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <623c39a5-2438-42d5-aafe-bb80dfd12b82@linaro.org>
 <20250806145315.GO124814@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250806145315.GO124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c2b96c76d98522d3728
X-MBO-RS-META: q7ahzcofg3erbschodb6zgih6cp3ja4h
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

On 8/6/25 4:53 PM, Tom Rini wrote:
> On Tue, Aug 05, 2025 at 05:30:49PM +0100, Andrew Goodbody wrote:
> 
>> I have these Smatch reports.
>>
>> drivers/net/phy/marvell10g.c:384 mv3310_select_mactype() warn: was ||
>> intended here instead of &&?
>> drivers/net/phy/marvell10g.c:387 mv3310_select_mactype() warn: was ||
>> intended here instead of &&?
>> drivers/net/phy/marvell10g.c:390 mv3310_select_mactype() warn: was ||
>> intended here instead of &&?
>>
>> Now there is obviously incorrect code there as it cannot work correctly as
>> is, phydev->interface cannot equal two different enums at the same time, but
>> simply swapping the && for || is not going to work either. Could anyone
>> please point me in the direction of a fix?
> 
> Adding Marek as r8a779f0_spider and r8a779f4_s4sk are the only two
> boards which enable CONFIG_PHY_MARVELL_10G (aside, ./tools/qconfig.py -b
> and then ./tools/qconfig.py -f CONFIG_FOO is handy to see what boards
> enable a given option and helpful when get_maintainer.pl has nothing
> specific).
They use the 2xxx series PHY, so this code is avoided. However, it seems 
even linux-next has the same behavior in .select_mactype() callback . 
They use test_bit() in there, but otherwise also use && instead of || 
which looks odd. Maybe that is a genuine bug which got ported over from 
Linux and needs to be fixed both there and here ?
