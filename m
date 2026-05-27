Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136D5CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AEAD846AA;
	Wed, 27 May 2026 14:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iLYvnYEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A6E846AA; Wed, 27 May 2026 14:31:14 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8E1846AE
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 14:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gQTW170Kdz9v9c;
 Wed, 27 May 2026 14:31:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779885070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vK3mfHnjXeZQAsFBxdGh2vTMJBzeLmxKx9zMJvTJvA=;
 b=iLYvnYEVhcVgLvy8aeorM156shoEK0k2woH9+Xsl7/wUDE05odAeS+9bqOTtVNizEGIYWh
 /i/08cdf3nuFvRgK09HR0fgP+Kv8NaHQ65AA2dlE1LBanuOkFkHghLZBe0beqPyMsBHZ23
 PXKwRvgLXedZHhB5DplcF8+udRR8pJ0nXAMTgT6nMxdcj7CVQ3liEhCzaoNtPKlSjuJVUj
 cADiiiNV+xtQsG8o+Tinh0Ya5JsZMagF/k5IlaeYtvQzN5DvgzzbSUCKNOrr/uX9dN0kR4
 nPB3qM0wF0NrhCwshyep0sYa0OJu0tL5iQ+9FXUed8tFy3nrv2zFgJ+E8HHeWw==
Message-ID: <415f9427-e0ab-4f97-81dd-a1abd3dda732@mailbox.org>
Date: Wed, 27 May 2026 14:31:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] mmc: cv1800b_sdhci: Use dev_read_addr_ptr()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Hiago De Franco <hfranco@baylibre.com>, Peng Fan <peng.fan@nxp.com>
References: <20260525-devfdt-mmc-v1-0-018e94f1c87a@nxp.com>
 <20260525-devfdt-mmc-v1-2-018e94f1c87a@nxp.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260525-devfdt-mmc-v1-2-018e94f1c87a@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cb840908fbdb36c90c9
X-MBO-RS-META: 1xtneozxykoqq71r9bpoirkkmw88pice
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

On 5/25/26 05:58, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use dev_read_addr_ptr() which supports both live device tree and flat
> DT backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/mmc/cv1800b_sdhci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
> index 72c5bfc6f35..b756649f90f 100644
> --- a/drivers/mmc/cv1800b_sdhci.c
> +++ b/drivers/mmc/cv1800b_sdhci.c
> @@ -85,7 +85,7 @@ static int cv1800b_sdhci_probe(struct udevice *dev)
>   	int ret;
>   
>   	host->name = dev->name;
> -	host->ioaddr = devfdt_get_addr_ptr(dev);
> +	host->ioaddr = dev_read_addr_ptr(dev);
>   
>   	upriv->mmc = &plat->mmc;
>   	host->mmc = &plat->mmc;
> 

