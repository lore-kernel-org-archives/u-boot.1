Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECDEC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 21:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08525808A2;
	Wed,  5 Mar 2025 22:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t9eBECXA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gzxaTCZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE44980BAA; Wed,  5 Mar 2025 22:19:41 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B338083E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 22:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z7QRb120dz9t7n;
 Wed,  5 Mar 2025 22:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741209579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=goXz0vZm6YBbSAXaEZqqZSaYKB9dRw5vO836ggycoM8=;
 b=t9eBECXAuQI5OCc8/ycAjStiwfCbGW+FtcccZbK3342XckAaSslOG9vDFigteplaDbAF6s
 02WEEbt1IBIn0iOJbXBRJzbJiRbVA2CVa8zRf/2FRo4M9WgBS2q+7JitOce71q1vxF+Xfb
 qKJEJ/3HKi0Spb5Z1QlCHn5TwDhzuhm6NI3lNqcSNTnGzPaVuew/fVLa7esCfJSZ3XYQnu
 t8O1yvmruKcw6Bi7hu+B/h7KunmeK5Fk7O/rhdh3K2M/DS3syX7v+lHlf4wshqRBpzhkU3
 IbS+4kW7lmrFMa6+CV4ei129YSmkw3prHn+rnnKm6aFA/IzQ7x7ZoeaGjZ3IRA==
Message-ID: <b82dcaff-2085-4e38-b584-fbfede57c4a3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741209577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=goXz0vZm6YBbSAXaEZqqZSaYKB9dRw5vO836ggycoM8=;
 b=gzxaTCZjcfYZQ3v67JDUqfTdKzEV112LOnjM6vkD5+YCCP1xEIJEWK4JrdV2GixiXBmqTN
 prnVU76vUbsJYxV/3Gl5wK08m9g9lVQmjq4xg3ZqPdo8CLJNBDA1I2rFL9GZzV2ArFBb0H
 pFkjS+7vOciI89FKk1H/reytzGjuEa7zv5DUZ8xT2gT56P3OJYHdJAnYWMuKCpVZoS+QAF
 uhW+TFBMcTd7WBSr3KKBZN6Md/N0l4uW4f7gkTI4FP5tFyvG2m6vTg4pHcWomFUo/CK7Aq
 GgQjEeoSDPFMYXfyXHJ07Oxv7IcZfRUYKGhvklYSUNCgvyMRRaAMFim2TkvMfg==
Date: Wed, 5 Mar 2025 22:19:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] net: ravb: Fix RX frame size limit
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250304200712.92514-1-paul.barker.ct@bp.renesas.com>
 <20250304200712.92514-3-paul.barker.ct@bp.renesas.com>
 <8aa61771-e37c-4f5a-a24a-473be3080352@mailbox.org>
 <120dbcf7-2650-4b18-950b-c1aa209a52f1@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <120dbcf7-2650-4b18-950b-c1aa209a52f1@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 900ac3407cc31b75634
X-MBO-RS-META: yazmstmmom1iu5zcfd3js5wfd1co4dns
X-Rspamd-Queue-Id: 4Z7QRb120dz9t7n
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

On 3/5/25 9:40 PM, Paul Barker wrote:
> Hi Marek,
> 
> On 05/03/2025 19:53, Marek Vasut wrote:
>> On 3/4/25 9:07 PM, Paul Barker wrote:
>>> The value written to the RFLR register includes the length of the CRC
>>> data at the end of each Ethernet frame. So we need to increase the value
>>> written to this register to ensure that we can receive full size frames.
>>>
>>> While we're here we can also copy the improved comment from the Linux
>>> kernel.
>>>
>>> Fixes: 8ae51b6f324e ("net: ravb: Add Renesas Ethernet RAVB driver")
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> ---
>>>    drivers/net/ravb.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
>>> index 6129929568a3..6bd94cf6bb1b 100644
>>> --- a/drivers/net/ravb.c
>>> +++ b/drivers/net/ravb.c
>>> @@ -354,8 +354,14 @@ static int ravb_mac_init(struct ravb_priv *eth)
>>>    	/* Disable MAC Interrupt */
>>>    	writel(0, eth->iobase + RAVB_REG_ECSIPR);
>>>    
>>> -	/* Recv frame limit set register */
>>> -	writel(RFLR_RFL_MIN, eth->iobase + RAVB_REG_RFLR);
>>> +	/* Set receive frame length
>>
>> /*
>>    * Set receive ...
>>
>> Please don't use netdev-style comments here.
>>
>> With that fixed:
>>
>> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> I can also fix while applying, please let me know.
> 
> I copied the comment straight from the kernel sources, didn't think
> about the comment style sorry. Please fix up while applying.
Done, thanks .
