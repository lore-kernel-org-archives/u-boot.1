Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CB3C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 17:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24B0087FDD;
	Sun, 17 Mar 2024 18:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FXpqoxwu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Pj8tvTYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55B687916; Sun, 17 Mar 2024 18:10:43 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012F187F0A
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 18:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TyPdF5tpxz9scR;
 Sun, 17 Mar 2024 18:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710695441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YieCJGdq0/CUp9fNGpA+umR3LIzUVVrlXSdpRMWwUaA=;
 b=FXpqoxwu133qnBQ4TN+outYXIZKKkHjasF4+38SU8YwA5mrsMLGYr7UUb12ets+p8t+Hu+
 CgtnRsmAK9lpQof/K93Ae8LL2GmRMu8RVWYqKVZqtUxRC8zSfu70HRlg3KAPgQY0qv9RCk
 mDkuqKUqD+jbS5ovPijk8xNmOPIN87yVrfdgTtRccqEP+mmjeMzXcxW4/5lf/woZ0qO8V+
 WFDGoyKBS+BWSt1Lra+dTh1WwVoc0Lym8dMq2wxefCmOE1bGnZF+HiELeybP2AoiKezkWn
 8623sID8t+9kg+zqumE+91Kib2Q1NwNXe3YTQGTIzFUJ4doqnFbqzNgM1glbkA==
Message-ID: <fc7d8527-59c6-495e-9e87-d9a4a0b78b31@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710695440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YieCJGdq0/CUp9fNGpA+umR3LIzUVVrlXSdpRMWwUaA=;
 b=Pj8tvTYcyAb0dIeh7b09Z3ub5NY90X9xZqoyI73lkMBLgVts3t1VqImEZt+HXL7gHJhgpd
 lnvZ+FMwjsJG+9PDiweJW442hf8oVj905wmLLLHTDia0Zbyu5dM1IfnsM1HTg91j0ruuNL
 qOlKg8dMp9y6Mko3rtBGIhT3kR4ud8sp7O5+mWqEjkGe9/oPdbEim6n8Sdh3d4qpqKfVyY
 FQhgqhuETVXGlgvHxydv3f3d0nEC1GGbs8D+BA8dZJtjq6tg66Dwuc7N8Ye/XU3EmcTq6c
 rHx80wS2hEUrFn83MGzagN5tusmR5/hO+SIn2/xoposQYWLxQhOGoOZcwCOXuw==
Date: Sun, 17 Mar 2024 18:09:33 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH 2/3] boot: fdt: Drop lmb_alloc*() typecasts
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
 <20240317061730.654893-2-marek.vasut+renesas@mailbox.org>
 <e4a6620d-fe51-43c7-b2ef-7d5be287c5c4@gmx.de>
Content-Language: en-US
In-Reply-To: <e4a6620d-fe51-43c7-b2ef-7d5be287c5c4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8c6ydyk7dm6widkwzxzgpnhpep74bduq
X-MBO-RS-ID: 4482651f3700a7eca1e
X-Rspamd-Queue-Id: 4TyPdF5tpxz9scR
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

On 3/17/24 10:16 AM, Heinrich Schuchardt wrote:
> On 3/17/24 07:16, Marek Vasut wrote:
>> The lmb_alloc_base() returns phys_addr_t , map_sysmem() accepts
>> phys_addr_t as first parameter. Declare $addr as phys_addr_t and
> 
> %s/$addr/addr/

I'm not sure this helps readability, I want to delimit the variable name 
somehow, so I switched this to 'addr' here and for 'usable' in 3/3.

>> get rid of the casts.
>>
>> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>>   boot/image-fdt.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> index c2571b22244..c37442c9130 100644
>> --- a/boot/image-fdt.c
>> +++ b/boot/image-fdt.c
>> @@ -162,6 +162,7 @@ int boot_relocate_fdt(struct lmb *lmb, char 
>> **of_flat_tree, ulong *of_size)
>>       void    *of_start = NULL;
>>       phys_addr_t start, size, usable;
>>       char    *fdt_high;
>> +    phys_addr_t addr;
> 
> Please, keep variables in the narrowest scope where they are used.

Have a look at the entire function, this is the narrowest scope, $addr 
is used in both branches of the conditional now, in the same way too.
