Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F043C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6442831C8;
	Mon,  7 Jul 2025 17:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AgvPDfZ5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e6X8kKaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B59ED831C6; Mon,  7 Jul 2025 17:52:24 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9999830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 17:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bbTJk3bZKz9sl7;
 Mon,  7 Jul 2025 17:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75VO3hVDU+G0HFpVy85045mErmFwLHQc9p1qeYvfJZ0=;
 b=AgvPDfZ5c+CMln3iEzeNBLdFid0VdS/cNvfBYJc/3WJDJW6B7icfhexXAOPYIlSxIXCshD
 KDJIcj38vXltVEFZ2wmElCKm9PPLqZT8XyLhuVoedv8/a9TEvbqge6vTJHXtrPAIoMwKCs
 s1lvxczBz2NPZxyOVq3eqxSsJgA2Mh8DWVOarwKnmBRQo1bTS2B62bn/H+IaZU2uneXiH9
 ysUHj4kRe/Z+qvi1dWO1Tpxdr/tVqbAj0qYWUBrNmkAekPUDNoR6vRWk0R3/K6s56OYXWl
 5g0tLmAuDjVTaQDIgqo+s42fVrn/y7u6lRGRZn/qVMTtk++1jlmLp505AhQnCg==
Message-ID: <0e525790-79f7-4653-808d-137c1e55ed09@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75VO3hVDU+G0HFpVy85045mErmFwLHQc9p1qeYvfJZ0=;
 b=e6X8kKaG2M4hepq/Hcb9DfL9iAOUBCEFnv2e9U9yjgBi8mjGQbKwubVMQZ3rw1X3Fh42Nt
 IIhFyti6iML3Z/u5vKBrzIpWuJEMDvQmunpwmoSp7Nk/43k7LtjfLJC+Ke9tDAo/LkFyST
 8j2D4nVbh5l4j+bybOEaSGwarsuKEsCQofjALgOXDjuSElFsrLU5pk+4c1xM1TNXdGWDxb
 dOa5UKgTUd//Z/mIw3qJ/G3LSBS9F71O88uz1Xbl1nWD7h/nKcVlO7kBxqCdAbF/hpLzHh
 nkZ278Q/s0i95x0B0cCB/nOOfUzP9kp2RdH6wNg0p/NamJAC5VIPX3tv5Q0CEw==
Date: Mon, 7 Jul 2025 17:47:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 7/9] net: sh_eth: Adjust RZ/A1, add RZ/A2 support
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, Chris.Brandt@renesas.com,
 geert+renesas@glider.be
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
 <175180136965.86839.10195243856147148306.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175180136965.86839.10195243856147148306.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 651ee34178ed1d1f004
X-MBO-RS-META: qhotrt33d1rd3qbisgj1uqi1myzbzu4r
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

On 7/6/25 1:29 PM, Magnus Damm wrote:

> +++ work/drivers/net/sh_eth.c	2025-07-05 17:45:07.333754799 +0900
> @@ -144,10 +144,10 @@ static int sh_eth_reset(struct sh_eth_in
>   {
>   #if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
>   	int ret = 0, i;
> -

Does something like this ...

if (!device_is_compatible(dev, "..."))

... work instead of the ifdef ?

If yes, it might be even improved into dedicated function:

static bool device_is_rza2(struct udevice *dev)
{
   if (!IS_ENABLED(CONFIG_RZA2))
     return false;
   else
     return device_is_compatible(dev, "...");
}

That should be compile-time checked and then optimized out, and in case 
of non-RZA2, this should be optimized out entirely.

> +#if !defined(CONFIG_RZA2)
>   	/* Start e-dmac transmitter and receiver */
>   	sh_eth_write(port_info, EDSR_ENALL, EDSR);
> -

[...]

> @@ -722,8 +726,11 @@ static int sh_ether_probe(struct udevice
>   		goto err_mdio_register;
>   
>   	priv->bus = mdiodev;
> -
> +#ifdef BASE_IO_ADDR
>   	port_info->iobase = (void __iomem *)(uintptr_t)BASE_IO_ADDR;
> +#else
> +	port_info->iobase = (void __iomem *)pdata->iobase;
> +#endif

Can the base address be pulled from DT?

[...]
