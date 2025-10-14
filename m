Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B29CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F4980422;
	Tue, 14 Oct 2025 13:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="K7yLlyGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A558809A5; Tue, 14 Oct 2025 13:26:46 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 323FA802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cmBkV263Qz9tKH;
 Tue, 14 Oct 2025 13:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760441202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkFfKvX4mXLbkznT21uVn0DXenJKYdKnWcfvZbfGvos=;
 b=K7yLlyGuaga6EvOyV9oGdUU+1j9GjMU51mIExbY4aHrQ/ipuBQXsxHCKiHtj+poowEQEsT
 h+dWWV0/bUYqmpyJlWqgOBtu9Or6dyUKEj+P6ivfUsT0WCU5Jwd0s39FFEnE0fRNmdKSp6
 hKUbWCr5SyFSNh3v0jf0CEkJX+b7oorAcdt4m3Rove24NzDzdOLM6rcKyDmgA9v566pzZO
 F0zQwBtUxhVLi/PJJDz30X4UtdSvXMIgh4pDaZc1+oQTQV5IzqUwOwB4ZDrdf9RdQ5seLc
 /QQ0P0HeH9YYU4Bj7BitXzlfpSymq3SM+XLs83+zNmMROzU1mOokj3hXkU+NlA==
Message-ID: <88093ae4-a18f-434b-b0a3-a362133871cc@mailbox.org>
Date: Tue, 14 Oct 2025 13:26:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/4] spi: nxp_xspi: Add new driver for NXP XSPI
 controller
To: alice.guo@oss.nxp.com, u-boot@lists.denx.de, uboot-imx@nxp.com,
 trini@konsulko.com, sbabic@nabladev.com, festevam@gmail.com,
 jagan@amarulasolutions.com
Cc: ye.li@nxp.com, alice.guo@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
 sjg@chromium.org, mkorpershoek@kernel.org
References: <20251014111756.446456-1-alice.guo@oss.nxp.com>
 <20251014111756.446456-2-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251014111756.446456-2-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: aw8efob8qo7annsi4ywg4jd3xq67ray9
X-MBO-RS-ID: f97aca480459da9c9cd
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

On 10/14/25 1:17 PM, alice.guo@oss.nxp.com wrote:

Hi,

> +++ b/drivers/spi/nxp_xspi.c
> @@ -0,0 +1,889 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <asm/arch/clock.h>
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitops.h>
> +#include <linux/bug.h>
> +#include <linux/err.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/sizes.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <spi.h>
> +#include <spi-mem.h>
> +
> +#include "nxp_xspi.h"
> +
> +static inline void xspi_writel(struct nxp_xspi *x, u32 val, u32 addr)
> +{
> +	void __iomem *_addr = (void __iomem *)(uintptr_t)addr;
> +
> +	if (x->devtype_data->little_endian)
> +		out_le32(_addr, val);
> +	else
> +		out_be32(_addr, val);
> +};
Is the BE mode ever used ?
