Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABAAC47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2AB687C74;
	Fri,  2 Feb 2024 14:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="gKTZb4iF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4940387C7D; Fri,  2 Feb 2024 14:11:15 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB3087061
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1706879471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbb8X+q3a3iZmtGWGirntMq4jG++7F61/AGeyTtQ84M=;
 b=gKTZb4iF6uHrHUZ7EMro/nkDj2DDNaSOC9eK/8H9srMAjFavSkDXOvQLdTRDmd3fHdiQ1o
 NP8Xm0z27mZ5Z8QomNY18U9EU541NJketoHHe6wRnGki8VJ/k2gSN38tr53GqSv7AZQaxY
 zHg7aj8t3Jnx4ablDgw1SOCGarKKlktdS5Y1m1fw0hxD8gxfyx9HjowpXL9UoflmFbPi35
 vhXXX3t7GoWm6PXGBBVr+eeM7AOeFYUKTHXnfNwTg0cJETGlQqaTcCXFwMbKiM2mWOc63s
 OYfjVfwAxllhC+rCIeah+EYSYP5CjN7xxRd4clnWeDJmmWpk7px7uCcsbrdE/g==
Date: Fri, 02 Feb 2024 14:11:08 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Eugen Hristev
 <eugen.hristev@collabora.com>, u-boot@lists.denx.de, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Andy Yan <andyshrk@163.com>, Tianling Shen
 <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>, Joshua Riek
 <jjriek@verizon.net>
Subject: Re: [PATCH 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
In-Reply-To: <344d6560-46ef-47d2-a498-0011c63dddbf@theobroma-systems.com>
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-2-jonas@kwiboo.se>
 <515157a9-8d19-42f9-ae6d-914aaea8a3ba@collabora.com>
 <e1417a87-15ee-4e1b-9513-c101a02118d4@kwiboo.se>
 <23d7337a-88b7-4dcb-be08-c42b21e9dbd1@theobroma-systems.com>
 <e9d6883b-4331-4237-be19-5df6126a3962@kwiboo.se>
 <ab9af16d-37f5-43a1-9dc6-9d1ba93c1689@theobroma-systems.com>
 <54ad872d-c47a-46ea-a4a5-c9776ae6213f@kwiboo.se>
 <10f0b268-0a9d-41a8-ba4e-d02abb62e418@theobroma-systems.com>
 <344d6560-46ef-47d2-a498-0011c63dddbf@theobroma-systems.com>
Message-ID: <3d006d9bb9d12427238387fdf74e576e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-02-02 13:44, Quentin Schulz wrote:
> OK so just tested this in Linux kernel 5.10 from Rockchip and v6.6.7
> with some patches for rk3588 (and the jaguar dts). I ran the following
> tests:
> 
> $ fio --filename=/dev/mmcblk0 --rw=read --direct=1 --name=fioBench
> --bs=1M --ioengine=libaio --cmdprio_percentage=100
> --output-format=json --allow_file_create=0 --time_based=1 --runtime=60
> --ioscheduler=none
> 
> $ fio --filename=/dev/mmcblk0 --rw=write --direct=1 --name=fioBench
> --bs=1M --ioengine=libaio --cmdprio_percentage=100
> --output-format=json --allow_file_create=0 --time_based=1 --runtime=60
> --ioscheduler=none;
> 
> It worked in HS200, HS400, HS400ES without any issue. It worked in 
> high-speed.
> 
> It was a bit "difficult" to get the kernel to switch to DDR52 because
> even with the property gone from the DTB it would detect the card as
> HS200. I had to comment out
> https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/sdhci.c#L4558
> to force it into DDR52 (or what I assume to be DDR52 :) the kernel
> prints: "mmc0: new DDR MMC card at address 0001" ).

As a note, the mode selection has been buggy like that for a while.
Fixing that in the kernel drivers is already on my TODO list.

> It failed reads in
> that mode so didn't even test writes, but not sure if it's a fair test
> with the aforementioned line commented out. I see it's also there in
> the SDHCI implementation in U-Boot, so maybe it's just that mmc rescan
> 4 doesn't actually make much sense to test since I would assume it
> would just detect it as HS200 even without the DT property? (or maybe
> something really is missing there in the SDHCI logic?).
> 
> I couldn't quickly find out how to put the eMMC into non high-speed
> mode so gave up on that.
