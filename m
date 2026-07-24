Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4331AC531D0
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 02:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A084409F0;
	Fri, 24 Jul 2026 02:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OaZY87bKBIhD; Fri, 24 Jul 2026 02:53:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8BFB409EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784861585;
	bh=H3hJT61iuRtF7hyMOvQWZKXl2o81xLQRjfsbrQZgn8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oHzAozbs84i9ON/hFxHYySbuybHEG8fLMfh6Hgs5bldWHEpEMpCF5/C4qrifc1vpU
	 juC1RVn5Y7bItHxT1EmCj19xGJ4q04RE4DUY11vNOXKfRikusrugJvNBPKfLdJVuUi
	 bL04cni4CTOm6bpNcK3Uj4WhUgPp5xd3AVRYcGOHmLvbMbBpQq7hqGLdZZMxCLbIOP
	 P9JZYqRN63QoJ1IfGA1NGPNbYR41HSE3Vn3NkyGx5u17qTWacq/K4lJJyLJTuLqw7u
	 qlAnNu9xzSHdv9MMoiiwGNOgDxPAK8Hw+scuJSiws+lK2AwyM3pvhtBA65uOn9IzpK
	 S6AaDdWTWKFcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8BFB409EB;
	Fri, 24 Jul 2026 02:53:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F1AFF3B1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 02:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E400E60AB6
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 02:53:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pL6QYbl8WQpu for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 02:53:04 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ACFD76073D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACFD76073D
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACFD76073D
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 02:53:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5EF1803F6; Fri, 24 Jul 2026 04:53:00 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60DE2800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 04:52:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; t=1784861573; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TqDL6Xp5mInMGiJA1yxqtw/+9B9uO8MesV1xVcQQ4SJD26QdMFvBcw0Sc35WYF0dy9orm02Dz4l9XtTtnLs0nkUypGu/HHnmIwivB50rtFnIT3eU8Mzk9d8GYqk6BV8OpfiYZIbE+pb2jgRnht8OGHqWCQsI4xiWJv/rzNl/2kg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784861573;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=H3hJT61iuRtF7hyMOvQWZKXl2o81xLQRjfsbrQZgn8k=; 
 b=HI/7n9FIUNtS08+CdsNDsBC73pdLqBWuvHlHI6mdGvBM/aINUNIWihAZql2VBsdD+ioWEqT+lN9HXgewTGHw9BMlkhnkN0IWXX3sj5vaLyPZtxMPiYOrvuLRp6gmafK7ea6LGqd2vnUs8Uwo67Ns/HxAzCqG0nsOGlmkEgj0wsA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 178486156959488.27876170758464;
 Thu, 23 Jul 2026 19:52:49 -0700 (PDT)
Date: Fri, 24 Jul 2026 02:52:39 +0000
From: Yao Zi <me@ziyao.cc>
To: hehongbo918@gmail.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] sysreset: esp32: add driver for esp32 series chips
Message-ID: <amLTd8Mau6tsV7o4@pie>
References: <20260712074817.18856-1-hehongbo918@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712074817.18856-1-hehongbo918@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.849.17
X-ZohoMailClient: External
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1784861573; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=H3hJT61iuRtF7hyMOvQWZKXl2o81xLQRjfsbrQZgn8k=;
 b=kZ7JJVnUU6dbBcUQZF06uwwtyg+1CdUBbOTX/ZooRHFdrvC+uQck3deIWnAC1+fH
 UMIqTwh/nH94yE4TXSMDpsJJMzS4z2N4ZGtF15PZC6Kay6Sdsf6KW3NrPFYee60AWyl
 pFfokjY57zqxuZQwfv/97l3KLkNIC1/J3BPEeAFI=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=kZ7JJVnU
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=me@ziyao.cc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="kZ7JJVnU"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sun, Jul 12, 2026 at 03:48:16PM +0800, hehongbo918@gmail.com wrote:
> From: Honbo He <hehongbo918@gmail.com>
> 
> Add system reset driver for Espressif Gen3 and Gen4 RISC-V SoCs.
> The reset register base address, offset, and bit mask are read
> from the device tree to support different chip variants without
> code changes.
> 
> Signed-off-by: Honbo He <hehongbo918@gmail.com>
> ---
>  drivers/sysreset/Kconfig          |  9 ++++
>  drivers/sysreset/Makefile         |  1 +
>  drivers/sysreset/sysreset_esp32.c | 72 +++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 drivers/sysreset/sysreset_esp32.c

...

> diff --git a/drivers/sysreset/sysreset_esp32.c b/drivers/sysreset/sysreset_esp32.c
> new file mode 100644
> index 00000000000..3d4c619f44f
> --- /dev/null
> +++ b/drivers/sysreset/sysreset_esp32.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026, Honbo He <hehongbo918@gmail.com>
> + *
> + * System reset driver for Espressif SoCs.
> + *
> + * Supported SoCs (Gen3/4):
> + *  ESP32-C5, ESP32-C6, ESP32-C61, ESP32-H2, ESP32-H21, ESP32-H4,
> + *  ESP32-P4, ESP32-S31
> + *
> + * On the unsupported chips(Gen1/2), the system reset logic resides inside the
> + * RTC_CNTL peripheral and is only accessible through the boot ROM function
> + * software_reset_cpu(). The register definitions are not exposed in the SoC headers,
> + * making it impractical to implement a direct register-based reset
> + * in U-Boot without reverse-engineering the ROM code.
> + */
> +
> +#include <dm.h>
> +#include <stdbool.h>

But you make no use of bool, so I guess this could be ommitted

> +#include <sysreset.h>
> +#include <wait_bit.h>

Not used, either.

> +#include <linux/io.h>
> +#include <linux/errno.h>

Could you please sort the headers, too?

> +
> +struct esp32_sysreset_priv {
> +	void __iomem *base;
> +	u32 offset;
> +	u32 mask;
> +};
> +
> +static int esp32_sysreset_request(struct udevice *dev, enum sysreset_t type)
> +{
> +	struct esp32_sysreset_priv *priv = dev_get_priv(dev);
> +
> +	setbits_le32(priv->base + priv->offset, priv->mask);

And this looks quite compatible with the generic syscon-reboot binding.
Why not re-use this driver instead?

> +
> +	return -EINPROGRESS;
> +}
> +
> +static struct sysreset_ops esp32_sysreset = {
> +	.request = esp32_sysreset_request,
> +};
> +
> +static int esp32_sysreset_probe(struct udevice *dev)
> +{
> +	struct esp32_sysreset_priv *priv = dev_get_priv(dev);
> +
> +	priv->base = dev_read_addr_ptr(dev);
> +	if (!priv->base)
> +		return -EINVAL;
> +
> +	priv->offset = dev_read_u32_default(dev, "offset", 0);
> +	priv->mask = dev_read_u32_default(dev, "mask", 0);
> +	if (priv->mask == 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id esp32s31_sysreset_ids[] = {
> +	{ .compatible = "esp,esp32-sysreset", },

Is the compatible documented anywhere so we could have a stable dt ABI
as reference? I searched current Linux master but got no luck.

Best regards,
Yao Zi
