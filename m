Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44645C282EC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 02:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B4781101;
	Wed, 19 Mar 2025 03:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="v3bUawq3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RlYRocSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF978129F; Wed, 19 Mar 2025 03:13:46 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E862A81026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 03:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZHXLv46dFz9snN;
 Wed, 19 Mar 2025 03:13:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742350423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4bd3ouxiJLXgNOuzl1QtC5P0qG8TuZCJHxGkrokRjE=;
 b=v3bUawq3psqzWCxpRJAuucT4UfzbonOd4/2l4fAGm51OXKZDLsi2CBITlNKUQ0vPhlf6/I
 lMWwDcWH0lvv73Aa98M9cmfBhNyiV6okUsoPWqd5WNXYSyTWmEHMSeWfIJdV7oBwfK/Oop
 bStYFTRATdz4ruqIZaAW3YNlSniuLmtTZKKiChnoptLnDYYRNkRI00l1j5zbdzboKpyypB
 LuYnVCPNxmE4t0f/9Yfdt3ufjwR73Y6+38NscngqWHXO69/xrXNs46whVYlz6Q97A8Q3EJ
 ufw/+2Rg8KFyUSeAcSQjgMzp4Fh5Tg40n47ZyVcI8V0mUB4TCU1ejRt9pI8l0w==
Message-ID: <b32475f3-d7a4-4eda-841e-1014201d61d3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742350421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4bd3ouxiJLXgNOuzl1QtC5P0qG8TuZCJHxGkrokRjE=;
 b=RlYRocSsQUJPBSDW7eO/SYxna6TAHkGmuALO3YzEu/am7CN+xSBjpDKE4MKw4oa0FyuvOm
 CCXJDmk5dKks6MVdki6+Hg+QcWuyPlFhLtSoVSmm/96SJ9GXRDhU5qrKZCMbHreOObsCzX
 OTsOn6LJjSCxwFSQXYdj/Z7q+sj4uch9Ihw8MvkzXarG6Rhx2onAqKdKWhyjW0bU4B/k8A
 uVtvvI8uG7LZIJWsg0LsoTLphdIf4lmSpoCiRJJfTagTZ0K9zGOYVybrxaHBM6g6G3R/ag
 uU/X4xDm9E4AiVOjkfH7JfCfHQvILzP8KkSMin5q4/FXh3xpLLXY7oJ875zMpA==
Date: Wed, 19 Mar 2025 03:13:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] cpu: imx8_cpu: Print Speed grade if IMX_THERMAL or
 IMX_TMU
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250319014240.592189-1-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250319014240.592189-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9f8e640e8775f1d9141
X-MBO-RS-META: zf45azruzuajgy5z7oq9ixcaygyh3w3x
X-Rspamd-Queue-Id: 4ZHXLv46dFz9snN
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

On 3/19/25 2:42 AM, Adam Ford wrote:
> Much of the data that is display by imx8_cpu.c is also
> displayed from arch/arm/mach-imx/cpu.c, except the
> speed grade and temperature unless the SoC is an i.MX9.
> Expand this to include checks for IMX_THERMAL or IMX_TMU
> in the same way it's done for mach-imx/cpu.c.
> 
> Before:
> CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
> Model: Beacon EmbeddedWorks i.MX8MPlus Development kit
> 
> After:
> CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
> CPU:   Industrial temperature grade  (-40C to 105C) at 28C
> Model: Beacon EmbeddedWorks i.MX8MPlus Development kit
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
> index 53d31b3c0bf..facd561022f 100644
> --- a/drivers/cpu/imx8_cpu.c
> +++ b/drivers/cpu/imx8_cpu.c
> @@ -177,7 +177,9 @@ static int cpu_imx_get_desc(const struct udevice *dev, char *buf, int size)
>   	ret = snprintf(buf, size, "NXP i.MX%s Rev%s %s at %u MHz",
>   		       plat->type, plat->rev, plat->name, plat->freq_mhz);
>   
> -	if (IS_ENABLED(CONFIG_IMX9)) {
> +	if (IS_ENABLED(CONFIG_IMX9) ||
> +	    IS_ENABLED(CONFIG_IMX_THERMAL) ||
> +	    IS_ENABLED(CONFIG_IMX_TMU)) {

Can CONFIG_IMX9 instead select CONFIG_IMX_THERMAL or CONFIG_IMX_TMU , so 
the SoC specific check could be removed from here ?
