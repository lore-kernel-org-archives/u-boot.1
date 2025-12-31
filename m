Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A310DEE57D4
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 06:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B31F8400F;
	Wed, 31 Dec 2025 07:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.b="SmuybGuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0840184019; Wed, 31 Dec 2025 07:28:05 +0100 (CET)
Received: from mail83.out.titan.email (mail83.out.titan.email [3.216.99.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B4F483FC6
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 07:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dh0Pr57ssz2xCD;
 Wed, 31 Dec 2025 06:28:00 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=KhhD80n8FTAfuoC4x+dAUDzt/gZMnlX3op3q/aQejTU=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=date:cc:subject:message-id:references:to:from:mime-version:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1767162480; v=1;
 b=SmuybGuFx0d0eVDzH0LLfWiEKO7+wR6F4bPKi02f93FyAbC7Oo1pKiKCZOyiEaW4fso37NU4
 nmlUXWnJSYDMHOecwHdGvxveNxEMUWvga1YpxPcIWfXzPuPDy8yzn+mfwJH1wmdWMhC4mPWS5bw
 rhwNMt6wUEtzp/lpglYgvVM4=
Received: from pie (unknown [117.171.66.56])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dh0Pn5m0Vz2xCF;
 Wed, 31 Dec 2025 06:27:57 +0000 (UTC)
Date: Wed, 31 Dec 2025 06:27:49 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
Cc: daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/6] timer: Add Goldfish timer driver
Message-ID: <aVTCZUacn68Nbg10@pie>
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-3-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230160112.3045527-3-visitorckw@gmail.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1767162480553345287.27573.7036086943176600945@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=6954c270
 a=ILiXPvH1yGBXwyP4YTaA5g==:117 a=ILiXPvH1yGBXwyP4YTaA5g==:17
 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=SiDOj0ITAAAA:20
 a=pGLkceISAAAA:8 a=mSHt_5hXqyHCMaRuYUEA:9 a=CjuIK1q_8ugA:10
 a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22
 a=bA3UWDv6hWIuX7UZL3qL:22
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

On Tue, Dec 30, 2025 at 04:01:08PM +0000, Kuan-Wei Chiu wrote:
> Add support for the Goldfish timer driver. This driver utilizes the
> Goldfish RTC hardware to provide a nanosecond-resolution timer. This
> virtual device is commonly found in QEMU virtual machines (such as the
> m68k virt machine) and Android emulators.
> 
> The driver implements the standard U-Boot timer UCLASS interface,
> exposing a 64-bit monotonically increasing counter with a 1GHz clock
> rate derived from the RTC registers.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v3:
> - New patch.
> 
> The link provided by Daniel [1] returned a 404 error.
> Since the implementation is straightforward, I wrote this driver from
> scratch.
> 
> [1]: https://github.com/fifteenhex/u-boot/blob/mc68000/drivers/rtc/goldfish_timer.c

...

> diff --git a/drivers/timer/goldfish_timer.c b/drivers/timer/goldfish_timer.c
> new file mode 100644
> index 00000000000..8205ac77853
> --- /dev/null
> +++ b/drivers/timer/goldfish_timer.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + *
> + * Goldfish Timer driver
> + */
> +
> +#include <dm.h>
> +#include <timer.h>
> +#include <asm/io.h>
> +#include <linux/errno.h>
> +#include <goldfish_timer.h>

Sort the headers?

> +/* Goldfish RTC registers used as Timer */
> +#define TIMER_TIME_LOW	0x00
> +#define TIMER_TIME_HIGH	0x04
> +
> +static u64 goldfish_timer_get_count(struct udevice *dev)
> +{
> +	struct goldfish_timer_plat *plat = dev_get_plat(dev);
> +	u32 low, high;
> +	u64 time;
> +
> +	/*
> +	 * Goldfish RTC provides time in nanoseconds.
> +	 * We read the high 32-bits and low 32-bits to construct the 64-bit value.
> +	 */
> +	low = readl(plat->base + TIMER_TIME_LOW);
> +	high = readl(plat->base + TIMER_TIME_HIGH);

It may be worth a comment to point out that the value of TIMER_TIME_HIGH
only updates when TIMER_TIME_LOW is read, so it's impossible to read out
teared values (higher half has been updated after lower half is read).

> +	time = ((u64)high << 32) | low;
> +
> +	return time;
> +}

With the header sorted,

Reviewed-by: Yao Zi <me@ziyao.cc>

Regards,
Yao Zi
