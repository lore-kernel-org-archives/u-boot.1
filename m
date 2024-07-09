Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9B1C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 12:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A73A88609;
	Tue,  9 Jul 2024 14:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ne0H1bhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BCA987EEE; Tue,  9 Jul 2024 13:27:19 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F3F787666
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 13:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-kochidanadu@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 469BQs3w044800;
 Tue, 9 Jul 2024 06:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720524414;
 bh=DJPtcVHpU0bV8V9InCEaMie4OKkuH+fVUrQnNcCqmhg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ne0H1bhlxGNdDQYKPKS13BjtWOujC1QIdbwr992gBmAuJ0Yx3rWzBc5AYzfSQ2uzg
 xQF78Pv88OndOVLGEt0d8iXr4Uzkm9aGQQF6VFT5zJkqG1ctj0CxftJIxm+rWT289n
 xuEw/FTkXPWGbSBJPtEhoQXmw2u98Legf1bcsHkU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 469BQsfY022718
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jul 2024 06:26:54 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jul 2024 06:26:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jul 2024 06:26:53 -0500
Received: from [172.24.31.134] (scaria-hp-zbook-15-g5.dhcp.ti.com
 [172.24.31.134])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 469BQkgw071702;
 Tue, 9 Jul 2024 06:26:47 -0500
Message-ID: <16c5d0dc-145c-4d59-bdfb-5a5df170f090@ti.com>
Date: Tue, 9 Jul 2024 16:56:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 1/6] sound: ti: Add sound support for am625
 board in Uboot
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <abdellatif.elkhlifi@arm.com>, <sumit.garg@linaro.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <semen.protsenko@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <nathan.morrison@timesys.com>, <devarsht@ti.com>, <j-luthra@ti.com>,
 <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <khasim@ti.com>,
 <rogerq@kernel.org>, <francesco.dolcini@toradex.com>, <afd@ti.com>,
 <jan.kiszka@siemens.com>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
 <20240708075207.37207-2-s-kochidanadu@ti.com>
 <20240708154656.GE38804@bill-the-cat>
Content-Language: en-US
From: Scaria Kochidanadu <s-kochidanadu@ti.com>
In-Reply-To: <20240708154656.GE38804@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Jul 2024 14:51:36 +0200
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



On 08/07/24 21:16, Tom Rini wrote:
> On Mon, Jul 08, 2024 at 01:22:02PM +0530, Scaria Kochidanadu wrote:
> 
>> Add a UCLASS_SOUND driver for Texas Instruments SoCs which ties together
>> the tlv320aic3106 audio codec and MCASP I2S controller. Enable audio
>> playback functionality by taking a data pointer and data size as the
>> sound data. The uboot sound play command takes time and frequency as
>> input and creates the data for a beep sound with the given parameters,
>> which is then passed to the sound play function.
> [snip]
>> +++ b/drivers/sound/ti_sound.c
>> @@ -0,0 +1,119 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * (C) Copyright 2024 Texas Instruments Incorporated - https://www.ti.com/
>> + * Scaria M Kochidanadu, s-kochidanadu@ti.com
>> + *
>> + * based on the uboot samsung sound driver, which is
>> + *
>> + * Copyright 2018 Google, LLC
>> + * Written by Simon Glass <sjg@chromium.org>
>> + */
>> +
>> +#include <asm/u-boot.h> /* boot information for Linux kernel */
>> +/* Pull in stuff for the build system */
>> +#ifdef DO_DEPS_ONLY
>> +#include <env_internal.h>
>> +#endif
>> +#include <audio_codec.h>
>> +#include <dm.h>
>> +#include <i2s.h>
>> +#include <log.h>
>> +#include <sound.h>
>> +#include <asm/gpio.h>
> 
> Please audit this list. I really am confused by <env_internal.h>.
> 

I will be removing this in v2 as it is not required.

>> +static int ti_sound_stop_play(struct udevice *dev)
>> +{
>> +	/* This function is necassary to satisfy the function calls
>> +	 * in the Uboot command: sound play
>> +	 */
>> +	return 0;
> 
> /*
>  * Like this...
>  */
> 
> [snip]
>> +static const struct udevice_id ti_sound_ids[] = {
>> +	{ .compatible = "simple-audio-card" },
>> +	{ }
>> +};
> 
> Adding an actual simple-audio-card framework for U-Boot would be great.
> This driver implies (and is?) TI-centric, instead. So lets rework this
> to be split appropriately? Thanks.
> 

I wanted to reuse the sound card DT node in the upstream kernel
device-tree. The U-boot upstrem repo does not have the node as it is
using an older version of DT.
But if using the simple-audio-card node is not preferred, then can we
create TI specific compatible and a separate DT node?
