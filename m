Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B528BC5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 14:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E35908144A;
	Sun,  8 Jun 2025 16:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qX8qxSDu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VCL6tiG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E1A81E06; Sun,  8 Jun 2025 16:48:46 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 325A18129F
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 16:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bFdGg5Nxtz9smP;
 Sun,  8 Jun 2025 16:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749394124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EL8M9z8Y6P98kkvCfsOABEOxDnMZgTZnmom914Z6Pa4=;
 b=qX8qxSDuN3aEJxxibuEEUh4QNhBMQ4/1kupLqWfwll6J2+83LnuxSFGMR6wsCos4g7qQTx
 UFnZbsd/jYkDHrygqsOFTeouVW58u2s23txN3WYlYshKhO0SJDu+vaDbkyix41DANLYWsR
 gzgyO7SAAW48ngM5DYo5MrTtOBiGMS9LI1B1Fc/9u6t6MxatzUURiD3SHYRj/i99CffHd+
 XP9U+O1ewR5JGej2winLPs2c0Zjh0eukbLhb+y8E2YGQo6UXPKwnyU4cuYSstwThdakfrI
 48/fGObpF/vWW+D+MbcsWmPR826qPjEPd8fPkpwFbmPQfWBWuKoXcSspVn19Gw==
Message-ID: <c97be126-45a2-4bd5-8125-c9029b9ceb64@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749394121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EL8M9z8Y6P98kkvCfsOABEOxDnMZgTZnmom914Z6Pa4=;
 b=VCL6tiG4dyFVg3YmkL06MNBmuIV9BrHd/2KnG1mpGpTkflYU+UfGjHP9NGkpnum/j2eMEI
 QnR/nGmqGn8sdKWRRq3KPI4QCiIaGVquQ+4oO1vxRAeaIjQl+xbJrf/PVulmyJVVxHUz1Y
 9QIABWCllif4c/0gV72Agz93Tc1+ndCypzmsUjB+KjfRGvT4ybqvlurvt2sYAtLyFrN8O/
 oo5dlFIb3IOtQJg4xAUgUPJIdhMIfbv7fO/XPu097nLdStsEYcpafHzxL2dBQnrXurd3nT
 dkjQRMfkc2OqOcuB/W1EiijldqolQU8VreLrEcjN3ywBU8J5za/RnxQ2jYedDg==
Date: Sun, 8 Jun 2025 16:48:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] renesas: Renesas R-Car Gen4 watchdog driver
To: smelamud@redhat.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
References: <20250603-us-renesas-watchdog-v3-0-af3a65afd03e@redhat.com>
 <20250603-us-renesas-watchdog-v3-2-af3a65afd03e@redhat.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250603-us-renesas-watchdog-v3-2-af3a65afd03e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fujj367sxstnw14u1xofkjbutsxntn75
X-MBO-RS-ID: 3c36d83eaa228aa8efd
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

On 6/3/25 5:06 AM, Shmuel Leib Melamud via B4 Relay wrote:

[...]

> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2025 Red Hat, Inc., Shmuel Leib Melamud <smelamud@redhat.com>
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <wdt.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>

Nitpick, keep the list sorted.

> +#define usleep_range(a, b) udelay((b))

Shouldn't this be udelay((a)) , the shorter (a) delay should be 
sufficient in all cases, shouldn't it ?

[...]

> +static int rwdt_probe(struct udevice *dev)
> +{
> +	struct rwdt_priv *priv = dev_get_priv(dev);
> +	unsigned long clks_per_sec;
> +	int ret, i;
> +
> +	priv->wdt = dev_remap_addr(dev);
> +	if (!priv->wdt)
> +		return -EINVAL;
> +
> +	ret = clk_get_by_index(dev, 0, &priv->clk);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_enable(&priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	priv->clk_rate = clk_get_rate(&priv->clk);
> +	if (!priv->clk_rate) {
> +		ret = -ENOENT;
> +		goto err_clk_disable;
> +	}

This loop below could use a code comment clarifying what this does.

> +	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
> +		clks_per_sec = priv->clk_rate / clk_divs[i];
> +		if (clks_per_sec && clks_per_sec < 65536) {
> +			priv->cks = i;
> +			break;
> +		}
> +	}

A few basic nitpicks, very nice otherwise, thanks !
