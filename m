Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EEFC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 20:34:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7094D808A2;
	Wed,  5 Mar 2025 21:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CNOBELGN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e027q4Nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0137F80FE2; Wed,  5 Mar 2025 21:34:32 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA368083E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 21:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z7PRT48pZz9t9S;
 Wed,  5 Mar 2025 21:34:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741206869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhJvokwzuzkzOjnbuJIaUu3pS5+ZjNn1dr4FyaVSt+8=;
 b=CNOBELGN1NYcxKWzsDkSAY350gUMvGhzZgLZMm97mYDIZgyNZNiAI1AMzaNrUjHBAXvwpr
 kiVoVpgQPK0KP1D8VNb6pU9gTkLCVhMyPVnY6d7P2BmRMmkGROT4dJSBwmoxEpgXgQ8ZgP
 IhUy3TVa6M9u+NHx+hd/nSvDJHKhh6vmpcSDiy5gupObG0njvqJsLKUTM9ic/T74kOYOQi
 1TzpQ7oiiPdgFQ+zKau5w/RIiQLArhYJM0MCO394ndWdk8bHcHd+F0PbGEcumKCmzY3reE
 JAjo76Gc+cnZbTuE//7p9n6xSaP3mAzsESfaITZLDlnobaOo2/HwVVyo5pXZ7w==
Message-ID: <7ca4a573-c3b5-47b4-b5ee-76288ab6ec0c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741206867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhJvokwzuzkzOjnbuJIaUu3pS5+ZjNn1dr4FyaVSt+8=;
 b=e027q4NxI3Ew2xMKkc6gJzhvQzdIWJyKcUUtn2AaDIbotah6sRmSpbR/zsvfBqTRqVEXJe
 3InWvhP5nQ6d6QQlD5L3NUUfAXw8gjY7iMkwvS5KHOsna7kOc1G7cRbUWPoZ+nAEtg9ViK
 UpJof8NqkHn6YB6kNpQ3jpVJyT9W2HPGlxqxnUVUrw9wZdM3ZzTo9ocdQGFEJKdd+7sf1e
 YAlAq3ff6+Ax0l6mUYHQphkoipOe0di1DLX3wr4TmDRaF6RbeyIWGZPsaYv92WtqDW+gMQ
 ucgrxS4BCEPLp3jAaJweJZvKdScON6vbVSXevPRkXGRCa1xrTDEwqEovqVm1aw==
Date: Wed, 5 Mar 2025 21:05:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
 <20250304163736.89326-2-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250304163736.89326-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: baa4ae7dd86f719d658
X-MBO-RS-META: ac67s89pb1jug5cqb5ottdnm75tpu57n
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

On 3/4/25 5:37 PM, Paul Barker wrote:

[...]

> +static int rzg2l_usbphy_ctrl_assert(struct reset_ctl *reset_ctl)
> +{
> +	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(reset_ctl->dev);
> +	u32 val;
> +
> +	val = readl(priv->regs + RESET);
> +	val |= reset_ctl->id ? PHY_RESET_PORT2 : PHY_RESET_PORT1;

u32 val = reset_ctl->id ? PHY_RESET_PORT2 : PHY_RESET_PORT1;

> +	/* If both ports are in reset, we can also place the PLL into reset. */
> +	if ((val & PHY_RESET_MASK) == PHY_RESET_MASK)
> +		val |= RESET_PLLRESET;

setbits_le32(priv->regs + RESET, val);

> +	writel(val, priv->regs + RESET);
> +	return 0;
> +}
> +
> +static int rzg2l_usbphy_ctrl_deassert(struct reset_ctl *reset_ctl)
> +{
> +	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(reset_ctl->dev);
> +	u32 val;
> +
> +	val = readl(priv->regs + RESET);
> +	val &= ~(reset_ctl->id ? PHY_RESET_PORT2 : PHY_RESET_PORT1);
> +
> +	/* If either port is out of reset, the PLL must also be out of reset. */
> +	val |= RESET_SEL_PLLRESET;
> +	val &= ~RESET_PLLRESET;
> +
> +	writel(val, priv->regs + RESET);

clrsetbits_le32() please

> +	return 0;
> +}
> +
> +static int rzg2l_usbphy_ctrl_of_xlate(struct reset_ctl *reset_ctl,
> +				      struct ofnode_phandle_args *args)
> +{
> +	if (args->args[0] >= NUM_PORTS)
> +		return -EINVAL;
> +
> +	reset_ctl->id = args->args[0];
> +	return 0;
> +}
> +
> +struct reset_ops rzg2l_usbphy_ctrl_ops = {
> +	.rst_assert = rzg2l_usbphy_ctrl_assert,
> +	.rst_deassert = rzg2l_usbphy_ctrl_deassert,
> +	.of_xlate = rzg2l_usbphy_ctrl_of_xlate,
> +};
> +
> +static int rzg2l_usbphy_ctrl_probe(struct udevice *dev)
> +{
> +	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(dev);
> +	struct reset_ctl rst;
> +	int ret;
> +
> +	priv->regs = dev_read_addr(dev);
> +
> +	ret = reset_get_by_index(dev, 0, &rst);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get reset line\n");

It generally helps to include 'ret' value in the error messages, so 
users can immediately look up the error code and find out what is wrong, 
without recompiling U-Boot.

> +		return ret;
> +	}
> +
> +	ret = reset_deassert(&rst);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to de-assert reset line\n");

DTTO

> +		return ret;
> +	}
> +
> +	/* put pll and phy into reset state */
> +	setbits_le32(priv->regs + RESET,
> +		     RESET_SEL_PLLRESET | RESET_PLLRESET | PHY_RESET_MASK);
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id rzg2l_usbphy_ctrl_ids[] = {
> +	{ .compatible = "renesas,rzg2l-usbphy-ctrl", },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(rzg2l_usbphy_ctrl) = {
> +	.name           = "rzg2l_usbphy_ctrl",
> +	.id             = UCLASS_RESET,
> +	.of_match       = rzg2l_usbphy_ctrl_ids,
> +	.probe          = rzg2l_usbphy_ctrl_probe,
> +	.ops            = &rzg2l_usbphy_ctrl_ops,
> +	.priv_auto      = sizeof(struct rzg2l_usbphy_ctrl_priv),
> +};
> diff --git a/include/renesas/rzg2l-usbphy.h b/include/renesas/rzg2l-usbphy.h
> new file mode 100644
> index 000000000000..1a46b585f170
> --- /dev/null
> +++ b/include/renesas/rzg2l-usbphy.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RZ/G2L USB PHY common definitions
> + *
> + * Copyright (C) 2021-2023 Renesas Electronics Corp.
> + */
> +
> +#ifndef RENESAS_RZG2L_USBPHY_H
> +#define RENESAS_RZG2L_USBPHY_H
> +
> +#include <fdtdec.h>
> +
> +struct rzg2l_usbphy_ctrl_priv {
> +	fdt_addr_t regs;
> +};
If this structure isn't shared with any other drivers, inline it into 
drivers/reset/reset-rzg2l-usbphy-ctrl.c and drop the header file.
