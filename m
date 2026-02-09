Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24FBE94603
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 20:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1296C805D7;
	Mon,  9 Feb 2026 21:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eDbbkh92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E51C8341A; Mon,  9 Feb 2026 21:44:37 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F07580325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 21:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f8xWh32z0z9tDY;
 Mon,  9 Feb 2026 21:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770669872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6D7RAjViUht+tTY53xFuzM8OyqTm4BNrQpsVVXgapiI=;
 b=eDbbkh92+voUZZ1conXZj6s4vzifEUqIqBYcdkrh92aJRMBA8qkVXTKZY6bSi45hR3P3Dy
 RybMKll4OOLwJaI8b436O29AYUaRgvPIpCjVxpwNpGRTLLyKniDtVeJA2zJ9llKGftl13T
 pvC2a9aRBo2DDgvnWn4CEeayBvh1XresEdJFqN+3cLLtv471nZ5koJ4ccy1cChMWvIRluP
 ZJVMkoHuZY1EGkWDzefympgXt57iOOlnwrggKwP5icObFX5zOdkJvABZNHzGCJ1tA4VtRc
 xGBghQMwVcBWbh1IPJXynUdXC4jPY1pE6ABRp2rhcRuMoOIcrTn9UzBNw1FMjQ==
Message-ID: <6e74bf04-c05a-4628-8f50-b6d55a2af285@mailbox.org>
Date: Mon, 9 Feb 2026 21:44:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
 <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
 <6f12cae7-1dd3-4367-83d0-d35624dbfa4d@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6f12cae7-1dd3-4367-83d0-d35624dbfa4d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 681hs16e31tfyx4q36ejafwkdc1jjycu
X-MBO-RS-ID: 901bc04b8b8642a9fe4
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

On 2/9/26 7:45 PM, Casey Connolly wrote:

Hello Casey,

>> Which means, before we can really start switching boards to relocate to
>> 64bit space, we need to find all these remaining 32bit limitation sites
>> and fix them first. And to do that, we would need some way to force
>> allocation from 32bit space for drivers which need that ... do we
>> already have such a thing ? I couldn't find anything.
> 
> For some (non-upstream) Qualcomm drivers we have just used lmb with
> LMB_ALLOC_MAX and passed in 4GB as the max address, it would be nice to
> have a wrapper function for this.
> 
> Maybe this would just cause a whole bunch of other issues but perhaps it
> would be easiest to have a config option to place the malloc arena in
> 32-bit memory rather than always directly below U-Boot? Then again I
> imagine this is something that has been bikeshed in the past...

Are those qualcomm devices suffering from 32bit DMA limitation too ?

> *casey grumbles something about making relocation optional and merging
> the f/r init sequences for most boards*

Can you try CONFIG_SKIP_RELOCATE for your use case ?
