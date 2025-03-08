Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8835C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 22:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABF58058A;
	Sat,  8 Mar 2025 23:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NAssbkpg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="T0tOo/g5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2722A808A2; Sat,  8 Mar 2025 23:29:57 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFB980050
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 23:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z9HsG5zKCz9spH;
 Sat,  8 Mar 2025 23:29:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741472994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzBJAh30SRiUUSnQ/S8Mm9WG0xyd5L69j5gv1K0ktvg=;
 b=NAssbkpgvdl9re780Tqiw+EtSOnVh4OQl5ws+I01GhtCPwcKVg6Bf2lWwYEOJ8jOigrsw8
 0XWVdpL3cq0CrnIhkbshgC+zLCIEEkHNQvXRfgyGgTGP6vGN8PMQ6nxwZ4u2KvzXUP3yxC
 dEkYcmAF/6zXK/IE5oNCXdUxJvpT0eQAjNw8M0NsPTlhUM1/Np1gD33aM8fahhwFviCBEo
 5fLw0vBpU4GOesiQvDwE140xa2b5eYM3bCT1pa5jXwjXcwBmfJE9qq9ip48PtpqqtWrXAT
 XBTGrUhQ4BR0tr3kwUwj/BM8FvA5RRApx4xraGNhXJJr1RE4mhBk6vO9tmDFzQ==
Message-ID: <7fc6c77b-dc8f-4983-9d9c-ee85dc8da028@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741472993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzBJAh30SRiUUSnQ/S8Mm9WG0xyd5L69j5gv1K0ktvg=;
 b=T0tOo/g5j95FQd6S85LsQRXGqzJrIOpSM6WIIOKjv6lPamqhc/B6KRdS80tGfAUWkLUyYc
 3JAc2LleKzKFxynMBwJZjth90GyI7MftCNPmr+kzTMZ9/hNe5dPSO1eW67+akVXrHJV7GJ
 SQjwL8x79BQ5OMhRzHfJwwLHOc2IlJqdxP8SHnMx/Y1eLpnMsGvNv3nrSpH8HADe+HhOlj
 fjLtafX7sqtGO9aRIi6AEYXzB16Y92ZRURb1/BNnzzqREdaiwasxSdecvfLUxoLx/HU6ft
 sf9zIv9t5gyP1tabMBfZxJEIu/gPf0v3nMvwjqVq7wKgOTQTNxGn6RASgNR9EQ==
Date: Sat, 8 Mar 2025 23:29:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: miiphybb: Update documentation
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250306221304.136257-1-marek.vasut+renesas@mailbox.org>
 <20de7a62-8bda-467d-92eb-34e92f0aa2ab@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20de7a62-8bda-467d-92eb-34e92f0aa2ab@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 59191f9cf49c1947f17
X-MBO-RS-META: ih4sbz5z15um557xb3cwm8nf7b71n79o
X-Rspamd-Queue-Id: 4Z9HsG5zKCz9spH
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

On 3/8/25 3:50 PM, Paul Barker wrote:
> On 06/03/2025 22:12, Marek Vasut wrote:
>> Update the miiphybb documentation to match current implementation.
>> The static struct bb_miiphy_bus bb_miiphy_buses[] array is removed.
>> The example is updated to match current Renesas RAVB driver, which
>> is one of the miiphybb users.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> I have a couple of minor improvements to the sentences below, you can
> fix these up while applying.
> 
>> -The board code needs to fill the bb_miiphy_buses[] array with a record for
>> -each required bus and declare the bb_miiphy_buses_num variable with the
>> -number of mii buses. The record (struct bb_miiphy_bus) has the following
>> -fields/callbacks (see miiphy.h for details):
>> +The driver code needs to allocate regular MDIO device using mdio_alloc()
> 
> "... allocate a regular MDIO device ..."
> 
>> +and assign .read and .write accessors which wrap bb_miiphy_read() and
>> +bb_miiphy_write() functions respectively. The bb_miiphy_read() and
>> +bb_miiphy_write() functions have to be passed a point to a callback
> 
> "... functions take a pointer to a callback ..."
Both fixed in V2, thanks !
