Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B980BC83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 16:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09716831D8;
	Mon, 21 Jul 2025 18:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="STCBJs8b";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f5HdNkqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C112831EA; Mon, 21 Jul 2025 18:17:57 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B21831B5
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 18:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bm5Ch5JBXz9tJN;
 Mon, 21 Jul 2025 18:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753114672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5s0wXRjpTtpqfO5wgfdK9kEGzBB66x88QgyBhA/XZkg=;
 b=STCBJs8bzRdKsJdQRZeNNC2sujzw9BTVHmsSwHhw/K0AZsRYJkmhp2jXJwuBbh05mwihNH
 aEgfG203eVnESKi+eNH2P1us4EWusMHV7Ad+r7R+LH0wzhT1bU29PdlFxxW7iG7JbM+6qa
 7VyUQP97d5sed1J9TN3NK4eKY5MO0KCKE0QiHhKaPw6gTHOf0m5Mxvo6UIH2J22swGNQ5e
 PCNZ6BLaXxRaXTJCRd3als6NmPtZSS6YRcgf0RJRWRJoGvpqKEK073v+dxQDKNwC9aTtgH
 sVvEH5Wlr52MHyE9S63ADjCBXLgEJWcUauKjECUp7USNmKT+ZWCdLha2W4vpzw==
Message-ID: <15ad286d-dd84-4594-b7d7-2d79fcda4dc2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753114670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5s0wXRjpTtpqfO5wgfdK9kEGzBB66x88QgyBhA/XZkg=;
 b=f5HdNkqP3KcKsnCRn8eRold5qaUdHy7VVqoexc4PflAmY6egKbKDhqhOS/+l1SLCsyPD/0
 /SDN+rVs43+RPg2pondzsojybtH/Tx0n3HemvnPB766LdS7cK0Ahv1u/BMj9H93FZdv5aL
 mEE4RzA5rQe4TXb/4bipc/7UcKI0bbs77KDUTmWnmoQFb0BK0RldtENYq7zx4h3vUyrUnE
 8sSror6uT2a2n+1nD+5cufYOBST3PheM+NIOGyYrIMnoXuazkfzP4eJNE0HAHtBz2gNmaS
 rSZTnKZOnk8GSP4SiTVeVunJKYqpxLZJ4ySJsz7RewN+YZGrt8dh3+e6H0ay2A==
Date: Mon, 21 Jul 2025 18:17:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77Q51NW
To: Prasanth Mantena <p-mantena@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
References: <20250720195901.414083-1-marek.vasut+renesas@mailbox.org>
 <20250721120312.5kxfgbkpsn7336yf@prasanth-server>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250721120312.5kxfgbkpsn7336yf@prasanth-server>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bz4u6nbabd4duzwstg9whp5optz3szjr
X-MBO-RS-ID: 83360c80e26a5c517a3
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

On 7/21/25 2:03 PM, Prasanth Mantena wrote:

Hi,

>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
>> index e7e97780d7c..0383175beb5 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -591,6 +591,7 @@ const struct flash_info spi_nor_ids[] = {
>>   	{ INFO("w25m512jw", 0xef6119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>   	{ INFO("w25m512jv", 0xef7119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>   	{ INFO("w25h02jv", 0xef9022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> +	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> 
> Hi Marek,
> 
> Is there a place where we can refer to the datasheet.

Please ask Winbond .

> According to commit message, Its similar flash part W25Q512NWM seems
> to have 4Byte address mode but capability is not seen in the code [0].
> Is this some limitation that goes with this flash as well.
> 
> [0] https://elixir.bootlin.com/u-boot/v2025.07/source/drivers/mtd/spi/spi-nor-ids.c#L553
W25Q512NWM should be updated with SPI_NOR_4B_OPCODES too, that's for 
separate patch, but someone would have to test such patch on that flash.
