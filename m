Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E177CC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 09:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E38387D82;
	Mon, 18 Mar 2024 10:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ciEz/hrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D1B87D1D; Mon, 18 Mar 2024 10:54:06 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F28F87E0A
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 10:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710755643;
 bh=L2TWzVfVfzglb0k5Fog2x07/G0byiu3KOIe3gKBf+y8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ciEz/hrX3r39yeb/sR/4Nh7F8jS11iBp+fCxq9H06jDgOa0uVR1eFcdiNL5SNpe9U
 FPt5WMZd7YGZhLyjIffS6Bi0ThkZzJ3o2mtf/qCJ1AvDi3Q3a6vjyJaDEpD6nKOC/O
 NiXjWFBW/qWtrsNtzOvcgDdeRQmDNOpwve/6QF8YsylmEgwa77W+USE02Pzg6jYZVp
 /14eorsX+l8AuCez1EwmLeApNUPoiliI76DR0kNCmZ6YMYMQzSwHwnBdNtHMjhgK+4
 5qUWXib9YTdpWqZTpYouD9Vr0Xo3Ax2pdMzQ5rDipWo5qHzHQjVeMy8ZUY4SLl+BYa
 9TywhzHzZAxpg==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 28E123781FCD;
 Mon, 18 Mar 2024 09:54:02 +0000 (UTC)
Message-ID: <8cbcfa9a-3286-4352-ad01-93433276b3e4@collabora.com>
Date: Mon, 18 Mar 2024 11:54:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] mtd: nand: raw: atmel: Using dm driver for older
 sam9 SoCs
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>
References: <20240311152306.2358845-1-ada@thorsis.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240311152306.2358845-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/11/24 17:23, Alexander Dahl wrote:
> Hello raw NAND fans,
> 

Hello Alexander,

Thank you for your efforts

> today I thought it would be interesting to have all that automatic NAND
> flash timings setting usable with an old board featuring a at91sam9g20
> SoC, which would pave the way to get rid of the old atmel raw nand
> driver eventually.  My "let's try this quickly" ended up in "damn this
> took hours and now I'm stuck".
> 
> Those older SoCs have no hardware ecc engine like the sama5d2 or sam9x60
> have, which the Linux driver can work with.  (The U-Boot driver was
> ported from Linux back then.)
> 
> The problem is NAND flash detection fails because the atmel nand
> controller drivers fails on probing.  In fact
> `atmel_nand_controller_init()` tries to set the pointer `nc->pmecc` by
> calling `devm_atmel_pmecc_get()`.  That one probably gets a
> -EPROBE_DEFER returned by `atmel_pmecc_get_by_node()` and then
> `atmel_nand_controller_init()` returns -EPROBE_DEFER too and probing the
> driver fails.  I suspect it should work fine if `nc->pmecc` would be
> NULL, but I have no idea what would be the right place to implement
> this.  I also suspect that -EPROBE_DEFER contradicts the U-Boot driver
> model somehow?  The raw/atmel/nand-controller driver was adapted (quite
> a bit) to work with U-Boot, but maybe some aspects of U-Boot driver
> model where not considered correctly?

I added Simon, to give us a hint on how to approach this.
How I see it, is that the probing of the NAND should pause, and then the DM should
look for the dependency, and probe it. if that dependency fails, then NAND probe
fails. But returning DEFER would not be good since I do not believe there is
another probe attempt unless manually done so (and it would be weird to get some
error on first probe and success on the next, at least in u-boot state of mind)
Maybe Simon can give us some ideas

> 
> The attached patches are what I have so far, marked them as RFC because
> my actual goal of using the new dm based driver for the old SoC was not
> completed.

Patches look good, but I am not sure whether they bring any additional value as you
claim it's not working. Maybe they could be picked up and worked more to get it
into the state you want ?
From my knowledge, investing effort into these old SoCs is not a priority for the
at91 people.

Eugen
> 
> Greets
> Alex
> 
> P.S.: Patch stack based on next.
> 
> Alexander Dahl (3):
>   ARM: dts: at91sam9260: Add modern NAND controller nodes
>   memory: atmel-ebi: Add compatible for older 9260 cores
>   mtd: nand: raw: atmel: Remove redundant PMECC probe
> 
>  arch/arm/dts/at91sam9260.dtsi                | 47 ++++++++++++++++++++
>  drivers/memory/atmel_ebi.c                   |  1 +
>  drivers/mtd/nand/raw/atmel/nand-controller.c |  7 ---
>  drivers/mtd/nand/raw/atmel/pmecc.c           |  1 +
>  4 files changed, 49 insertions(+), 7 deletions(-)
> 
> 
> base-commit: beedf675b36841ce1e077779157a87a6505317e6

