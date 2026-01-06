Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69888CEFD1D
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 23:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9FA83C62;
	Wed,  7 Jan 2026 00:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dlGaxzFB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PHnaJuzx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BC383FC0; Wed,  7 Jan 2026 00:14:43 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B8A83A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 00:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dm6Sd43DCz9sXk;
 Wed,  7 Jan 2026 00:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767741281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16N5bFwhffkhaUI7XsK9wxEMiW0rV4WbE0RLUQCObH0=;
 b=dlGaxzFBiv8FbRJ99P/KBjoSXxeHZ5two+DpqDzXKu5cN62RdWaadI6ONBWXgQxOQrtk8B
 n5ZMeKBBktaM3v00bB19365HncaoFlTVTT6nRFb7kQ0Fxwt83N8HVSDKrAl9qF1RlpcFQ4
 b8kdNOv6bVP4757Iy4OaFJi2QCqWO6NsVTidTx/OtU+ht7KOPXwL+tDKTGjFyKIs5RBEhx
 /BQELOyIZ4o3eVoTTqlkaLMRuH2KkkU15P1q1YZ2rYAUYTDMv5CKEcy+xk55inly7whXIa
 1NLlwtCe+erazpISr43xWATFD5/B7lqpGVMRLkbZHIcPNRwQla6FEd+Kb24vCw==
Message-ID: <bafc0b79-9126-4cdc-92d1-dd6fe2f884ac@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767741279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16N5bFwhffkhaUI7XsK9wxEMiW0rV4WbE0RLUQCObH0=;
 b=PHnaJuzxR/ucNSOjTw17p1zVwKWqBOrnXxSRyE3xXh0H8jAUXXW2Rd18eJKoyNgXkOnfdF
 zb4yn17a1+GWzfIIlj8JfqSW420GLmzw1a9fRybNjZPTdajH3PfM5joO0S1r4FEZfzd3tu
 lR3ut/YHEaLUdWAskqVTqho7rrHlAxCU2bnjqCVBmh/aNk/2FDjS/sLYDygAw3NfD3wCcm
 nSl+L9XCEbn/NCrTdTx2ABuSuZY5iLIZGzDXKfjiUGbDL7LRiWasyID27+U32WcWIvQmlJ
 uWq0xs+/6tp8eTHkEsHOdGjKEnhesCZB2A7t6+ezEnwLIctwDZ2IckHNBBSiFw==
Date: Wed, 7 Jan 2026 00:14:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: Add power sequencing driver for PCI slots
To: Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260106223409.748335-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260106223409.748335-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: baoo6u9ok1e6fox9t4pn6m9ujp59jm8q
X-MBO-RS-ID: 3733fe802d1b0153521
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

On 1/6/26 11:34 PM, Sean Anderson wrote:
> Extend the PCI bridge driver to enable resources associated with PCI
> slots like clocks, power rails, and resets. This is modeled off of the
> PCI power control subsystem in Linux. The traditional compatible for PCI
> slots in U-Boot is pci-bridge, but Linux uses the more-systematic
> pciclass,0604 so add that as an option.

Oh, nice :)

> +static int __maybe_unused pci_bridge_probe(struct udevice *dev)
> +{
> +	struct clk clk;
> +	struct gpio_desc perst;
> +
> +	if (!clk_get_by_index(dev, 0, &clk)) {
> +		int ret = clk_enable(&clk);
> +
> +		if (ret)
> +			return log_msg_ret("clk", ret);

Should we use dev_err() instead ?

> +		/* Delay for T_PERST-CLK (100 us for all slot types) */
> +		udelay(100);
> +	}
> +
> +	if (!gpio_request_by_name(dev, "reset-gpios", 0, &perst, 0)) {

Invert conditional, reduce indent.

> +		unsigned long delay = 0;
> +		int ret;
> +
> +		/*
> +		 * If PERST is inactive, the following call to dm_gpio_clrset_flags
> +		 * will be the first time we assert it and we will need to
> +		 * delay for T_PERST.
> +		 */
> +		if (dm_gpio_get_value(&perst) != 1)
> +			delay = 100;
> +
> +		ret = dm_gpio_clrset_flags(&perst, GPIOD_MASK_DIR,
> +					   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +		if (ret)
> +			return log_msg_ret("set", ret);
> +		mdelay(delay);

Maybe set a flag and avoid calling mdelay() altogether ?

> +		ret = dm_gpio_set_value(&perst, 0);
> +		if (ret)
> +			return log_msg_ret("clr", ret);
> +
> +		/*
> +		 * PCIe section 6.6.1:
> +		 * > ... software must wait a minimum of 100 ms before sending a
> +		 * > Configuration Request to the device immediately below that
> +		 * > Port.
> +		 */
> +		mdelay(100);
> +	}
> +
> +	return 0;
> +}
> +
>   U_BOOT_DRIVER(pci_bridge_drv) = {
>   	.name		= "pci_bridge_drv",
>   	.id		= UCLASS_PCI,
>   	.of_match	= pci_bridge_ids,
> +#if CONFIG_IS_ENABLED(PCI_PWRCTRL_SLOT)
> +	.probe		= pci_bridge_probe,

.probe = CONFIG_IS_ENABLED(PCI_PWRCTRL_SLOT, pci_bridge_probe, NULL),

Thanks !
