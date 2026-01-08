Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FCFD232C1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 23:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 934E384206;
	Fri,  9 Jan 2026 00:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OvKFDhwB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC946842DB; Fri,  9 Jan 2026 00:21:14 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB72841C8
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 00:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dnLWB4yPwz9v7T;
 Fri,  9 Jan 2026 00:21:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767914470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8QpqVqfblI1XtK4Pt9pnqAjrQXFz0yIiFgwBgINIATs=;
 b=OvKFDhwBNqPOmTM4+f5AYkr6igTGAfLCR0E9A6dGP1CxTK7nQOvWG/Pvyp4PKTcAC5Oeu9
 Jrw4pYUmlNz4KzheiJhoaDtasHqdWzcWqcJwAE0lf6CQuJprCJIyH9FqzQJNoCMM/b3rQL
 1dJTnEi+AyPChjWnwwcwEfUoNzpWZ2snkULosm1P4tg3b/UBnVNgr3dpicB+b051PUM14O
 3YjUqgARFezWJP9WkaS+feQWtETrinmiN3AMisGQJMzJJKLSu6sU70rtajIcrjoV09ZsLT
 bBFR6w8v/FdufuZqOVwZqwOqRdFS+kPHyI+EsbClozzUKLnwll8QhBLBaKJxtQ==
Message-ID: <f6ebd731-cc2c-47b1-98d4-961abd40ef85@mailbox.org>
Date: Fri, 9 Jan 2026 00:21:07 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v1] Revert "mmc: mmc-uclass: Use max-frequency from device
 tree with default handling"
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, festevam@gmail.com,
 ivitro@gmail.com, max.merchel@ew.tq-group.com
References: <20260108114002.1612-1-tanmay.kathpalia@altera.com>
Content-Language: en-US
In-Reply-To: <20260108114002.1612-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6c710d8147ede677ebc
X-MBO-RS-META: ogxghwx9n8y5sua71x5g4tsjxtfz1saq
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

On 1/8/26 12:40 PM, Tanmay Kathpalia wrote:
> This reverts commit aebb523a23818a8ee4199c9532b51e3d4020696f.
> 
> The change to use dev_read_u32_default() with a default value of 0
> causes regression for host controller drivers that hardcode f_max
> before calling mmc_of_parse().
> 
> When the "max-frequency" property is not specified in the device tree,
> dev_read_u32_default() returns 0, which overwrites the previously
> configured f_max value set by the driver. This effectively resets
> the maximum frequency to 0, breaking MMC functionality for those
> controllers.
> 
> Revert to the original dev_read_u32() behavior which only updates
> cfg->f_max when the "max-frequency" property is explicitly present
> in the device tree, preserving driver-configured values otherwise.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>   drivers/mmc/mmc-uclass.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index bf0bea93853..2f4dc5bd887 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -243,13 +243,8 @@ int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg)
>   		return -EINVAL;
>   	}
>   
> -	/*
> -	 * Maximum frequency is obtained from the optional "max-frequency" property.
> -	 * If not specified in device tree, defaults to 0 and sdhci_setup_cfg()
> -	 * will set the MMC configuration maximum frequency to the host controller's
> -	 * maximum base clock frequency from capabilities register.
> -	 */
> -	cfg->f_max = dev_read_u32_default(dev, "max-frequency", 0);
> +	/* f_max is obtained from the optional "max-frequency" property */
> +	dev_read_u32(dev, "max-frequency", &cfg->f_max);

Why not do this then ?

cfg->f_max = dev_read_u32_default(dev, "max-frequency", cfg->f_max);
