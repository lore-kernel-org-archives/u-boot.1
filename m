Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7060C282EC
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 00:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E443808A2;
	Fri,  7 Mar 2025 01:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OoDWKKvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD7EE80EB1; Fri,  7 Mar 2025 01:19:47 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0532805D7
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 01:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z86Nt5XNPz9swK;
 Fri,  7 Mar 2025 01:19:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741306782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IfYKcEMOsa+FOj2b0lytVAcbO2fXyntxm1PgXwZiys=;
 b=OoDWKKvNpuPXBuA7Wz4Cy4Tnzx7ODn++l1m1OanLoWZU4fk1KlUWeBDIq57Ivr9aBQrRiV
 DFPK+BqlIHLWrpklR9RaBgUK5uCdqrZWdWj/lsYGosP0NmTXY48uXmcGWDCxPaoDXTnZZL
 dM4a4AB9CP4rQe3+Yks7k4mbCJJjYQFgkbAAZiCL9LV+Jj61cA7HJJD9fM2VeLWsWQctsu
 9USRPsxOGhTo2vmPpTeSFJZBnWU55MWQyZ1cmJW8d5TAPv0K/7acR56HrBE+RJshvlbULU
 pnwRv8EFFXJePq1Vxc7en9j6gmr/TBRi5o6Tbuxr1oIynZrLbaHqLUrs2v/zcg==
Message-ID: <aa8b33bd-501c-4e35-8027-d583791d2f9e@mailbox.org>
Date: Fri, 7 Mar 2025 01:19:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 01/11] net: miiphybb: Split off struct bb_miiphy_bus_ops
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de
Cc: Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
 <e4c44d9e-cc95-4f87-be9c-746c21a7103e@bp.renesas.com>
 <81b02e3a-3fe1-4b52-a646-194ca003b82e@mailbox.org>
 <00d6eef6-7880-4ad7-b634-e89f88e7d8e4@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <00d6eef6-7880-4ad7-b634-e89f88e7d8e4@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7266bbf51fc8ccdfabc
X-MBO-RS-META: wyn66ou6hqnmwfc9ow58ognn3d6auitp
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

On 3/4/25 11:32 AM, Paul Barker wrote:
> On 03/03/2025 23:16, Marek Vasut wrote:
>> On 3/3/25 8:29 PM, Paul Barker wrote:
>>> On 02/03/2025 01:24, Marek Vasut wrote:
>>>> Move miiphybb operations into separate struct bb_miiphy_bus_ops
>>>> structure, add pointer to struct bb_miiphy_bus_ops into the base
>>>> struct bb_miiphy_bus and access the ops through this pointer in
>>>> miiphybb generic code. The variable reshuffling in miiphybb.c
>>>> cannot be easily avoided.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>
>>> Hi Marek,
>>>
>>> I'm a bit lost trying to review this series. Could you include a cover
>>> letter summarising the change to the bitbangmii API? We also need to
>>> update `doc/README.bitbangMII`.
>>
>> In short, this splits ops from the bbmiiphy structure, which is entirely
>> removed in the course of this series, and so are all the bbmiiphy
>> alloc/free functions again. That in turn fixes the missed mdio_free()
>> update, which no longer has to be fixed, as the drivers go back to
>> mdio_alloc() to allocate the MDIO bus.
> 
> Ok, I've given this another look and it all looks ok. I'll send tags
> shortly.
> 
> I do think we should update the documentation to match the new API.
Documentation update is now posted at:

[PATCH] net: miiphybb: Update documentation

Thanks !
