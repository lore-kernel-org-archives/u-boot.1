Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB21CCFA00
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 21:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35CE83642;
	Sat,  1 Nov 2025 22:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="AT4HR+VH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4103836D1; Sat,  1 Nov 2025 22:17:33 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4DB68331F
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 22:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 93968553-b768-11f0-b0b9-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 93968553-b768-11f0-b0b9-00505699b430;
 Sat, 01 Nov 2025 22:20:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=nd6Ui8/Pro3+NiMj3XcWh992hjUzCTEQocvdpKsqnt0=;
 b=AT4HR+VHXOXgV/M0iHdfOW+JjNkTR5QhbU5PxG20W6Ntxb0sZO6qkgi2QSZ21Zua0N6y1zi5IzFlY
 lRithdKQEyfbvhC37YWJskYbg/o61k042pCLBxLE7tU853frRhxcowqrA/kZPzagNuY709Ft5C7o5V
 GBHdTY6vg5MH7TSKUiN0vJbUoYWFqf7W12ZwlU5Tv0Wf4YpMKpktVs9L3f/EgYejsleTnZFXKUYR6o
 P9vw1RGG2k8E4492V/iXumxkk9w1kk+8FF6uuxZhTiQJhXX1GCxaemSy5a8nSQhKmXdrRVJJO1EfzZ
 3aKVwHpO71qXt2OO37xq53HtI0xPvrw==
X-KPN-MID: 33|PNE3soOfmw91OyPGu271pHp1NOYglIwq3qqRN9ro8yK5yHsdRNZrH4jwgkM7nTa
 K7iS4UukCzRxOWXNhBO9Nt4nSjXRyjGqF3pt5PBVW7/A=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|j+YJthDR6+NHmhWfkz/98ew/eO9OasuHnaiN4bo57covxRqwjs+Eb8z1vAa872O
 NONRGginzpUvhzT35W3BzEg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 2c768624-b768-11f0-86bd-005056998788;
 Sat, 01 Nov 2025 22:17:30 +0100 (CET)
Date: Sat, 01 Nov 2025 22:17:29 +0100
Message-Id: <878qgpqwpi.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: trini@konsulko.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 ye.li@nxp.com, festevam@gmail.com, jonas@kwiboo.se,
 danct12@riseup.net, u-boot@lists.denx.de
In-Reply-To: <20251101203429.1603832-1-jonas@kwiboo.se> (message from Jonas
 Karlman on Sat, 1 Nov 2025 20:34:26 +0000)
Subject: Re: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and
 Fixed regulators"
References: <20251101203429.1603832-1-jonas@kwiboo.se>
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

> From: Jonas Karlman <jonas@kwiboo.se>
> 
> Rockchip boards may depend on a working MMC regulator in SPL to
> successfully load FIT payload from MMC. Typically, these boards only
> include the vmmc-supply regulator and not its vin-supply in SPL control
> FDT.
> 
> The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO and
> Fixed regulators") breaks loading FIT from MMC in SPL on some of these
> boards due to now requiring the vin-supply to be included in the SPL
> control FDT.

I ran into this issue a few days ago.  Unfortunately that means U-Boot
2025.10 is broken on several Rockchip boards :(.

> The commit also strangely enables any found vin-supply in
> regulator_common_of_to_plat() and not when a regulator is enabled or as
> part of regulator_autoset().
> 
> Revert the commit to fix FIT loading in SPL on broken boards.
> 
> If a board needs to have its vin-supply enabled, two options come to
> mind:
> 
> - Add regulator-always-on prop to the regulator in the -u-boot.dtsi for
>   any board.
> 
> - Implement full support for reference counting of regulators and then
>   update the regulator-uclass to enable any found vin-supply when a
>   regulator is enabled.

I fixed the issue with the diff below instead.  But I don't claim to
fully understand how this all is supposed to work...


diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index c80f10c3aa3..f43879a4353 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -48,7 +48,7 @@ int regulator_common_of_to_plat(struct udevice *dev,
 	ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
 	if (ret) {
 		debug("Regulator vin regulator not defined: %d\n", ret);
-		if (ret != -ENOENT)
+		if (ret != -ENOENT && ret != -ENODEV)
 			return ret;
 	}
 
