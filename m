Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D5BD711D3
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 03:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE3A800AB;
	Fri, 19 Dec 2025 04:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.b="RT74lOzT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DECA580433; Fri, 19 Dec 2025 04:14:17 +0100 (CET)
Received: from mail40.out.titan.email (mail40.out.titan.email [209.209.25.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A66680050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 04:14:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dXXgp2RJMz9rw9;
 Fri, 19 Dec 2025 03:14:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=d4cm6tf2Olp8qbztRYNo9wxWTcgAmmVE1F15alOLLoU=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=to:cc:subject:in-reply-to:message-id:references:mime-version:date:from:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1766114054; v=1;
 b=RT74lOzTVSy61onjPJ7cBqyZnq5NO1BoIrM09zDC2J8jXHDsxF57H8Mdhgb60zVPJIPn/cCD
 9tdPuptH2VipFZA6mMcfZfD/3BxmYIwT80vUjIhaJ64ZcTNGS2bj2+JqA93kTu3qguc1Kdh261V
 S8QCHVo6vYmn9RlKyXVlZLZc=
Received: from pie (unknown [117.171.66.90])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dXXgl3Mh7z9rxD;
 Fri, 19 Dec 2025 03:14:11 +0000 (UTC)
Date: Fri, 19 Dec 2025 03:14:03 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 angelo@kernel-space.org
Cc: trini@konsulko.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] serial: Add Goldfish TTY driver
Message-ID: <aUTC-8hYsPDVFOly@pie>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-2-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218185252.957388-2-visitorckw@gmail.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766114054176596490.21635.7631289243084903368@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=6944c306
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=AF-Q3FBzzPdzohsBK4oA:9 a=CjuIK1q_8ugA:10
 a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22
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

On Thu, Dec 18, 2025 at 06:52:50PM +0000, Kuan-Wei Chiu wrote:
> Add support for the Google Goldfish TTY serial device. This virtual
> device is commonly used in QEMU virtual machines (such as the m68k
> virt machine) and Android emulators.
> 
> The driver implements basic console output and input polling using the
> Goldfish MMIO interface.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  MAINTAINERS                      |   6 ++
>  drivers/serial/Kconfig           |   8 +++
>  drivers/serial/Makefile          |   1 +
>  drivers/serial/serial_goldfish.c | 112 +++++++++++++++++++++++++++++++
>  include/goldfish_tty.h           |  18 +++++
>  5 files changed, 145 insertions(+)
>  create mode 100644 drivers/serial/serial_goldfish.c
>  create mode 100644 include/goldfish_tty.h

...

> diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
> new file mode 100644
> index 00000000000..85d2a93b6ff
> --- /dev/null
> +++ b/drivers/serial/serial_goldfish.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0+ has been deprecated as a SPDX license identifier.
GPL-2.0-or-later should probably be used instead[1].

> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + * Goldfish TTY driver for U-Boot
> + */
> +
> +#include <dm.h>
> +#include <serial.h>
> +#include <goldfish_tty.h>
> +#include <asm/io.h>
> +#include <linux/types.h>

It looks better if you sort the headers :)

...

> +static int goldfish_serial_getc(struct udevice *dev)
> +{
> +	static u8 rx_buf[4];
> +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +	unsigned long base = (unsigned long)priv->base;
> +	unsigned long paddr;
> +	u32 count;
> +
> +	count = __raw_readl((void *)(base + GOLDFISH_TTY_BYTES_READY));
> +	if (count == 0)
> +		return -EAGAIN;
> +
> +	if (count > sizeof(rx_buf))
> +		count = sizeof(rx_buf);
> +
> +	paddr = virt_to_phys((void *)rx_buf);
> +
> +	rx_buf[0] = 0xAA;
> +
> +	__raw_writel(0, (void *)(base + GOLDFISH_TTY_DATA_PTR_HIGH));
> +	__raw_writel(paddr, (void *)(base + GOLDFISH_TTY_DATA_PTR));
> +	__raw_writel(count, (void *)(base + GOLDFISH_TTY_DATA_LEN));

You send a command that reads count bytes, where count represents the
maximum of bytes available in the buffer and sizeof(rx_buf), so it's
possible to read more than one character...

> +	__raw_writel(CMD_READ_BUFFER, (void *)(base + GOLDFISH_TTY_CMD));
> +
> +	if (rx_buf[0] == 0xAA)
> +		return -EAGAIN;
> +
> +	return rx_buf[0];

But only the first character in the buffer is finally returned. Isn't
the following characters (if present) are incorrectly discarded?

rx_buf is declared as static in this case. Are you originally intended
to do some type of buffering here?

Additionally, I don't get the point of setting rx_buf[0] to 0xaa then
checks whether it changes after sending CMD_READ_BUFFER. Is there a case
that CMD_READ_BUFFER would fail even when reading TTY_BYTES_READY
returns non-zero? I had a brief look at qemu's goldfish tty
implementation, but didn't find such situation.

> +}

Best regards,
Yao Zi

[1]: https://lore.kernel.org/u-boot/20251212142859.GQ303283@bill-the-cat
