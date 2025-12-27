Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C3FE8FDB1
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 02:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6385E83AC5;
	Sat, 27 Dec 2025 03:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.b="HcOOH6GT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EB0F83B21; Sat, 27 Dec 2025 03:08:02 +0100 (CET)
Received: from mail98.out.titan.email (mail98.out.titan.email [54.147.227.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C6A83AB0
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 03:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4ddQqf2hFPz9rwc;
 Sat, 27 Dec 2025 02:07:58 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=cu3Bjkts6tt+86E3qLqReA3hFGqwIBDWYFPLkElAPw0=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=from:to:cc:subject:message-id:date:references:mime-version:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1766801278; v=1;
 b=HcOOH6GTmK3G8hmYNRyg19yMTlZPETo2TjUe9T0lxcT7w5I0R0IzZq+RUFCsvUcU6Lj2W3Sx
 hoDmGJcemdtPqHUQBmGHkR4e+miQFpekilyxm3dqW0C7zt6/4Aya17800tEt2o7Ywjo1TNeRFvW
 sen+KhKhVeQbQUJYuAKNzhUU=
Received: from pie (unknown [117.171.66.90])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4ddQqb1J26z9rvf;
 Sat, 27 Dec 2025 02:07:54 +0000 (UTC)
Date: Sat, 27 Dec 2025 02:07:47 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 angelo@kernel-space.org
Cc: trini@konsulko.com, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/4] serial: Add Goldfish TTY driver
Message-ID: <aU8_VIK_oTHY2RTF@pie>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-2-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226175400.1154417-2-visitorckw@gmail.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766801278196824877.21635.2732056382527454645@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=694f3f7e
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=pGLkceISAAAA:8
 a=NYmWw8xXgvd3pRJF6_MA:9 a=CjuIK1q_8ugA:10 a=dF-1CEOklZHAHjuG_jZJ:22
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

On Fri, Dec 26, 2025 at 05:53:57PM +0000, Kuan-Wei Chiu wrote:
> Add support for the Google Goldfish TTY serial device. This virtual
> device is commonly used in QEMU virtual machines (such as the m68k
> virt machine) and Android emulators.
> 
> The driver implements basic console output and input polling using the
> Goldfish MMIO interface.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v2:
> - Update SPDX license identifier to GPL-2.0-or-later.
> - Sort header inclusions alphabetically.
> - Move RX buffer into goldfish_tty_priv instead of using a static buffer.
> - Make sure getc only read a single byte at a time.
> 
>  MAINTAINERS                      |   6 ++
>  drivers/serial/Kconfig           |   8 +++
>  drivers/serial/Makefile          |   1 +
>  drivers/serial/serial_goldfish.c | 104 +++++++++++++++++++++++++++++++
>  include/goldfish_tty.h           |  18 ++++++
>  5 files changed, 137 insertions(+)
>  create mode 100644 drivers/serial/serial_goldfish.c
>  create mode 100644 include/goldfish_tty.h

...

> diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
> new file mode 100644
> index 00000000000..ce5bff6bf4c
> --- /dev/null
> +++ b/drivers/serial/serial_goldfish.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + * Goldfish TTY driver for U-Boot
> + */
> +
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <goldfish_tty.h>
> +#include <linux/types.h>
> +#include <serial.h>
> +
> +/* Goldfish TTY Register Offsets */
> +#define GOLDFISH_TTY_PUT_CHAR       0x00
> +#define GOLDFISH_TTY_BYTES_READY    0x04
> +#define GOLDFISH_TTY_CMD            0x08
> +#define GOLDFISH_TTY_DATA_PTR       0x10
> +#define GOLDFISH_TTY_DATA_LEN       0x14
> +#define GOLDFISH_TTY_DATA_PTR_HIGH  0x18
> +#define GOLDFISH_TTY_VERSION        0x20
> +
> +/* Commands */
> +#define CMD_WRITE_BUFFER   2
> +#define CMD_READ_BUFFER    3
> +
> +struct goldfish_tty_priv {
> +	void __iomem *base;
> +	u8 rx_buf;
> +};
> +
> +static int goldfish_serial_getc(struct udevice *dev)
> +{
> +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +	unsigned long base = (unsigned long)priv->base;
> +	unsigned long paddr;
> +	u32 count;
> +
> +	count = __raw_readl((void *)(base + GOLDFISH_TTY_BYTES_READY));

I think it's okay to do pointer arithmetic directly against priv->base
in GNU C, right? In which case void * is treated like char *.

If I'm correct, variable base could be dropped, and we could avoid some
casts here and below.

> +	if (count == 0)
> +		return -EAGAIN;
> +
> +	paddr = virt_to_phys((void *)&priv->rx_buf);
> +
> +	__raw_writel(0, (void *)(base + GOLDFISH_TTY_DATA_PTR_HIGH));
> +	__raw_writel(paddr, (void *)(base + GOLDFISH_TTY_DATA_PTR));
> +	__raw_writel(1, (void *)(base + GOLDFISH_TTY_DATA_LEN));
> +
> +	__raw_writel(CMD_READ_BUFFER, (void *)(base + GOLDFISH_TTY_CMD));
> +
> +	return priv->rx_buf;
> +}

Regards,
Yao Zi
