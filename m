Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4173ECD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D284D8469D;
	Wed, 27 May 2026 14:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yFZ5moc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE6FD846AA; Wed, 27 May 2026 14:31:42 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D687183FB0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 14:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gQTWb56V3z9ty2;
 Wed, 27 May 2026 14:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779885099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WomepsEaHd86O6rf0aRrEFjR/q8ZlDuI5n0W/495gmQ=;
 b=yFZ5moc5G2ZG5V7o2dojHO/Gk90Qb/wjCpq4umnobCC1Ihgu4HVsr8Pwb8jTgbC5SMhUJC
 Vy1Otw2PUOB76+xbQ7jx9debyMatSYRwgimARjwWG+8Nrszv0SeB/lUgI4ElCIa5FiIsEK
 lwp9zXinyISaDWXlgwtjm+icRebCQS8auPLFYWLV2T4HtIWE/nnZWWLCsrDizNhQt1Bg1O
 vg+Dv8EclX7CpjTiXWMhSITbSVcG68/EHW8ob3S/AMeRJRERWSpoqRWgQVZUuh5SraZDpt
 Bkp3ZU3BEGqMiGkdlo3IggOnjF6Qmh5p8Sff1t+CYpYC+nNOHzgJOIHmR1tpWw==
Message-ID: <85be43b7-dd2e-419e-8f4f-534098ee6c29@mailbox.org>
Date: Wed, 27 May 2026 14:31:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] watchdog: orion_wdt: use dev_read_addr_size_index()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>
References: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
 <20260525-devfdt-wdog-v1-1-d8142b674ba0@nxp.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260525-devfdt-wdog-v1-1-d8142b674ba0@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ca7ffb4ea20b2465c79
X-MBO-RS-META: a3aso64jf6u7yhkwqc4foefu87umnnhd
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

On 5/25/26 05:51, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace devfdt_read_addr_size_index() with dev_read_addr_size_index() when
> retrieving the register base address.
> 
> dev_read_addr_size_index() supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/watchdog/orion_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index a2000b968c9..c9bd40c8d8f 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -119,7 +119,7 @@ static inline bool save_reg_from_ofdata(struct udevice *dev, int index,
>   	fdt_addr_t addr;
>   	fdt_size_t off;
>   
> -	addr = devfdt_get_addr_size_index(dev, index, &off);
> +	addr = dev_read_addr_size_index(dev, index, &off);
>   	if (addr == FDT_ADDR_T_NONE)
>   		return false;
>   
> 

