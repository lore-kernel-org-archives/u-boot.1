Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE33CCD1BF
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 01:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E61C82A9E;
	Wed, 29 Oct 2025 02:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rm6zduXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EFE832AD; Wed, 29 Oct 2025 02:07:14 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B48080422
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 02:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cx8Gj2WRNz9sWs;
 Wed, 29 Oct 2025 02:07:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761700029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGPH4AOyB69k7u2+dnq772TocAcEQdi/+6pppWRQgyY=;
 b=rm6zduXBbLHpqbQwbOQlU/M01BiRswCWNQzCzVF4NwPdcU86bFUBXLe2uj99ejyDw7Ogmm
 f1oWbHXPpf2nhFDAOpJmyqJ3adb5YJVObSIlodypcDvLzdQs63xxjTodCKTLygcxouKu7B
 m3r4gnpcw/OmyeS2AoJYOkr8cdWuop+R2Z1sHvDT90QYUWCyQAw+2s5C2yoIAHkterAz16
 /ea+AfYm0y7SPxVeZYETLnqvXD8y2vJw8LICMUKc4PunFbj/K2elO4VHZMTCpoWc9OZBoy
 VAwO2wlotRjTYFu54Q4COOyA0uxtwO1/ohWmvvt3J+S1NCUequK1iiysseyxGA==
Message-ID: <1f163d6d-bd46-4dcf-afa3-2cc246461bfe@mailbox.org>
Date: Wed, 29 Oct 2025 02:07:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor-ids: Reformat the table
To: Vlim <vlim@gigadevice.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, "havish.mutya" <havish.mutya@amd.com>
References: <20251028004729.119349-1-marek.vasut+renesas@mailbox.org>
 <SI6PR06MB7813347A75CE48B5924DF36EBBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
 <20ee9a4e-9d66-4507-9c88-6efacef85297@mailbox.org>
 <SI6PR06MB7813BEE2045C178C32397BCABBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <SI6PR06MB7813BEE2045C178C32397BCABBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: t7c4byp7p3kkdsji3qmgfzqr81dch5u7
X-MBO-RS-ID: 8b6d8b8dd02c5a52e37
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

On 10/28/25 9:33 PM, Vlim wrote:
> Hi, Marek,

Hello Vlim,

>    1.
> reformat the table to follow this format.
> 
>       {
>             INFO("gd25q32", 0xc84016, 0, 64 * 1024,  64,
>                   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>                   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>       },

Why this way ? Does it bring any improvement, aside from being less 
concise ?

>    1.
> Re-arrange the order of the table based on the ID, so that I can group the part #s by product family.

Sure. I'll just wait for the maintainer and whichever patch they pick 
first, the other will be rebased and resent.

>    2.
> I have a few more part numbers to add to the table, can I add them with this update?

Sure.

>    3.
> Do I submit as a new patch?

Yes, but please, let's wait for maintainer input first.

-- 
Best regards,
Marek Vasut
