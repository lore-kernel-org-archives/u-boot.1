Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFD3EDEC08
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C6C283F0A;
	Wed,  4 Mar 2026 05:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uG+GPSIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B139B83F75; Wed,  4 Mar 2026 05:06:29 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6AFC83E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 05:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fQfHN5YsFz9tlc;
 Wed,  4 Mar 2026 05:06:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772597185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxdMTceSIFMIINiEAGpc5FQVUFQjxci+QnE3wSBuLeg=;
 b=uG+GPSIT0yh1qXXH1sPv5w5FNSVFMUh+8sTIvl+8gNvuST7XsCloH1uvJW7G8yWW5k8PgG
 BqiUz7Yt38xdVtqm6JRd3m7jz3xBVYujbbcnbyqsZWO26z97engPwlcZqibGTpN6qHFhjW
 f9/cTy6lg1rIK36nJtMAqWr7pAOY0Wgy4pd5s8Zj+0MbTG8h0HmKIjy2hR/93wWFyvBsRB
 xEIYI30Z/VvoXFewz2dlTceOvuZW51pToj+Oi9tw8IJZ7QfRI2ZAzwr6c0umHJWTbnSv6M
 gkrWkDa+H0pqP6Txq6RqXU5KNSnEofBj03w3LgsxdE88xcQ9VFbC9Fcr0JwGQw==
Message-ID: <860de90a-ef7f-499f-9288-61b1f6150342@mailbox.org>
Date: Tue, 3 Mar 2026 15:07:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and
 probe parent
To: Siddharth Vadapalli <s-vadapalli@ti.com>, marex@denx.de
Cc: trini@konsulko.com, minda.chen@starfivetech.com, u-boot@lists.denx.de,
 srk@ti.com
References: <20260227055954.3916518-1-s-vadapalli@ti.com>
 <4d8848d2-3a4e-4025-aeac-c15592b16276@mailbox.org>
 <c5e0e61b-a8ab-4186-9460-84221d843542@ti.com>
 <f19e58ad-58ed-4d5b-a348-6d2270e546f0@mailbox.org>
 <992e9023-48dd-460e-a783-9caf58f5e944@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <992e9023-48dd-460e-a783-9caf58f5e944@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 83d327700ffc819c71c
X-MBO-RS-META: zhrs7ahp7xabw8m6snepc9bsu1racg9g
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

On 3/1/26 6:25 AM, Siddharth Vadapalli wrote:

>>> There are two users of cdns3_bind() which have registered their 
>>> own .bind() callback as cdns3_bind():
>>> 1. cdns3-starfive.c driver
>>> 2. cdns3-ti.c driver
>>> Since .bind() is called before .probe()
>>
>> .bind callback is meant to BIND the driver instance (to a DT node), it 
>> is not meant to initialize the hardware. .probe callback is meant to 
> 
> I agree. But that's exactly where the issue lies. When 'dr_mode' is set 
> to OTG, cdns3_bind() is unable to determine if the driver to bind to the 
> DT node is "cdns-usb3-host" or "cdns-usb3-peripheral".
> 
> Since [0], we attempt to identify if OTG should imply 'peripheral' or 
> 'host'. But to do that, [0] needs to read the VBUS Valid field of the 
> OTG Status register. And register access requires the USB Controller to 
> be powered ON.

Correct, so bind is the wrong place to do any HW access .

> [0]: bfb530e06ca6 ("usb: cdns3: use VBUS Valid to determine role for 
> dr_mode OTG")
> 
>> initialize the hardware. This is fundamental part of the U-Boot DM 
>> lazy initialization scheme. If something does initialize hardware 
>> in .bind, then it is very likely wrong.
>>
>>> , and, since cdns3_bind() is also the .bind() callback of the above 
>>> drivers, device_probe() has to be added here itself. Moreover, it is 
>>> only due to the register accesses being performed by the recently 
>>> introduced cdns3_get_otg_mode() function that we need the USB 
>>> Controller to be powered ON at this stage.
>> So, can we fix this so the HW initialization won't be happening in 
>> bind, but instead in .probe ?
> 
> That isn't possible

Can you investigate how to make that possible ? Maybe by having some 
common .probe implementation that would determine the OTG state, or by 
having some stub driver which handles the OTG selection ?
