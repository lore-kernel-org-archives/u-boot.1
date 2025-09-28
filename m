Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289A2CAC5B5
	for <u-boot@archiver.kernel.org>; Sun, 28 Sep 2025 18:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 514DD809A5;
	Sun, 28 Sep 2025 20:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GWdd/fAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B496D80FA1; Sun, 28 Sep 2025 20:54:54 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6597F80819
 for <u-boot@lists.denx.de>; Sun, 28 Sep 2025 20:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cZYQy14KTz9tGj;
 Sun, 28 Sep 2025 20:54:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759085690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdGtarixgfc2WngFvloqxEQ16kfU946hSooqyaD33sE=;
 b=GWdd/fAq2QezxXgh/VTgAyvI/rZQUaO+ZSb7Br1cZgTpp//sMAqthmf+53l9OihGHhw+Kg
 zw/tUOMCYXr8z6e+aehUqB13dHwbAoJENKl4jADFz5OEjv93Fp/1AHZ4Z33n3DKu6uNU5S
 6HdzSKjSASYe1GAdRflE+ZVNFhwzOJKzwWroGX8ryr2Guq1ZOYyKApe4k5kn7bJhucihEs
 owz+I+3fhRcSyaK6dicHxTdLcKSfMXCiiAbM16RNz8o8zUiAjPSpVitMY0fvhiqP9pEaaT
 isY52HJ9dflweUsaCFyPg+hNqEcOurZb+TT66lY8H8KC/EpBz6KT7WJMD9RIog==
Message-ID: <f5d9836b-2b88-4903-938c-fb72b317bd0d@mailbox.org>
Date: Sun, 28 Sep 2025 20:54:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: sdhci-cadence6: Fix DT property value endianness
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 kuanlim.lee@starfivetech.com, weiliang.lim@starfivetech.com,
 yuklin.soo@starfivetech.com, e@freeshell.de, marex@denx.de,
 tien.fong.chee@altera.com
References: <20250928183816.25623-1-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250928183816.25623-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7903ed2abfcfcabb0f3
X-MBO-RS-META: b4661rc975akdnb9rrgwdxw5c6dhinwd
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

On 9/28/25 8:38 PM, Tanmay Kathpalia wrote:
> Convert device tree property value to CPU endianness using
> fdt32_to_cpu(). This prevents incorrect values on platforms
> with differing endianness.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>   drivers/mmc/sdhci-cadence6.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
> index 9a92b8437a6..6f60fee6df4 100644
> --- a/drivers/mmc/sdhci-cadence6.c
> +++ b/drivers/mmc/sdhci-cadence6.c
> @@ -220,14 +220,14 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
>   		prop = fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
>   				   sdhci_cdns6_phy_cfgs[i].property, NULL);
Use dev_read_u32_default() or some such function from 
drivers/core/read.c , that should greatly simplify this code.
