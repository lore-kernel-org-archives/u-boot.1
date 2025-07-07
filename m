Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA341C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC1583189;
	Mon,  7 Jul 2025 17:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kbPiR2dy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TC2tsvRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718098319C; Mon,  7 Jul 2025 17:30:00 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA1A830E4
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 17:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bbSpt32NCz9sqy;
 Mon,  7 Jul 2025 17:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751902198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABaNSX+3PVwZRdXq4JGr62lCy1X/XGYOwn7JukTbnjQ=;
 b=kbPiR2dyzGl+eifBFlT9gHR+bWQBgTJHXLPWeKYvfE/T6E4oFpLtF4toLKT7lPAdB9bDf1
 ZHGHaedbsOEJLB+lOVydp6P/1Xj/aO/byB2iGrA+CekrRUtTywkd/KNXNZM/vJA4O0kG9k
 BqEawm8wgVWmw+WJ60DvCBlPUJoolyMrnQzgaexpdH3cmJIcJfuvl8evfYG+nmc63AZebt
 pR8fJgdhJiIWfonSPWfEjQHlYkkaIeHHQF+TXso5ZrCpihvZQH1BWjBZ2roto920D0da02
 qrpVap+cvMiKjHnNtWs/+MYkwozs9sIgt9LbY0skxlat7J5VlaapAtM8U+rTlg==
Message-ID: <f6e431b3-33f6-4dcf-8458-7f96c834fe43@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751902196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABaNSX+3PVwZRdXq4JGr62lCy1X/XGYOwn7JukTbnjQ=;
 b=TC2tsvRJ5XtRheEQC+utdz+pn5ehbvMDaLXNOkOmcDSuVwLPKH+FY03DIrBnrJhWnMhOVf
 AEkj3pPpPyoYXH8uyJPZ4HywKr7n4p8uAem9h3IgIHCIfOj1eoJ+B3tkqVvz2pce2UUje3
 RkuqFICcLjaqazQ+ssqFADbfamktFb9+9JpmFvVq2vs+Mjr0WDNDhM1x410FJPym69Pwer
 eliCyklDBjyG5x1w2jOTjw/gnR4kbDRghf6BglLHbL7MHW5Vydt5Jx8q859aeS6VbdCIiX
 ojNK3b5lCd2bqT7KExcPMBFA1PNWJqvNlWFiwwE3kD0WmzgXV+flYAB+FfvOig==
Date: Mon, 7 Jul 2025 17:29:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] pinctrl: renesas: Initial RZ/A2 R7S9210 support
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, marek.vasut+renesas@mailbox.org
References: <175135063036.63099.10267366987503829859.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175135063036.63099.10267366987503829859.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ebaf02482ecd1609b2c
X-MBO-RS-META: 9bq7y3dsdug8cphbqzmmsy37amypaznf
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

> +DECLARE_GLOBAL_DATA_PTR;

See comment in r7s9210_pfc_set_state() below.

> +struct r7s9210_pfc_plat {
> +	void __iomem	*base;
> +};
> +
> +static void r7s9210_pfc_set_function(struct udevice *dev, u8 port, u8 pin, u8 func)
> +{
> +	struct r7s9210_pfc_plat *plat = dev_get_plat(dev);
> +	u16 reg16, mask16;
> +
> +	/* Set pin to 'Non-use (Hi-z input protection)' */
> +	reg16 = readw(plat->base + PDR_BASE + (port * 2));
> +	mask16 = 0x03 << (pin * 2);
> +	reg16 &= ~mask16;
> +	writew(reg16, plat->base + PDR_BASE + (port * 2));

Use clrsetbits_le16().

> +	/* Temporary switch to GPIO */
> +	clrbits_8(plat->base + PMR_BASE + port, BIT(pin));
> +
> +	/* PFS Register Write Protect : OFF */
> +	writeb(0x00, plat->base + PWPR); /* B0WI=0, PFSWE=0 */
> +	writeb(0x40, plat->base + PWPR); /* B0WI=0, PFSWE=1 */
> +
> +	/* Set Pin function (interrupt disabled, ISEL=0) */
> +	writeb(func, plat->base + PFS_BASE + (port * 8) + pin);
> +
> +	/* PFS Register Write Protect : ON */
> +	writeb(0x00, plat->base + PWPR); /* B0WI=0, PFSWE=0 */
> +	writeb(0x80, plat->base + PWPR); /* B0WI=1, PFSWE=0 */
> +
> +	/* Port Mode : Peripheral module pin functions */
> +	setbits_8(plat->base + PMR_BASE + port, BIT(pin));
> +}
> +
> +static int r7s9210_pfc_set_state(struct udevice *dev, struct udevice *config)
> +{
> +	const void *blob = gd->fdt_blob;
> +	int node = dev_of_offset(config);
> +	u32 cells[32];
> +	u16 bank, line, func;
> +	int i, count;
> +
> +	count = fdtdec_get_int_array_count(blob, node, "pinmux",
> +					   cells, ARRAY_SIZE(cells));

Use dev_read_u32_array() and then you won't need the gd->fdt_blob 
reference at all, and you can also drop DECLARE_GLOBAL_DATA_PTR; from 
this driver.

> +	if (count < 0) {
> +		printf("%s: bad pinmux array %d\n", __func__, count);
> +		return -EINVAL;
> +	}
[...]
