Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95D3CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 08:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC358460E;
	Fri, 26 Jun 2026 10:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nKqdQait";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dG0s5oRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F79E8495B; Fri, 26 Jun 2026 10:29:17 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 942828404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 10:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gmpk22Jv5z9trm;
 Fri, 26 Jun 2026 10:29:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782462554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0sDnuHkQCzZy7PJxrbPjk7PmcM2n9KrhygO8Gu5Dp4=;
 b=nKqdQaitG2KjFPAOq60XpR3wuCQiwAsm2XMnV4sUpGLWx/wnGhOMl+ODZx3Mw8LmGH00W5
 LLeUhnbyxzsDXXBHn1JmqU+YADV+zXuD128RvGJw8qx7HdFajkURLhAA9msAOeZ+vFJ32x
 bFUSA/9kUecWxJXDm7vZImic29Btrtaew7PZlhXiv4OFih3yg3RVBZ5qtEOusRrVZZGKjz
 q6YfNkZdTLfxCP6GE7tyJlNwIvRAg6uFXoe2D0uq2LlV6YV2Xaa4gXhDvOEHTGFId/AT4u
 qopUyW7U8sp/R2Sm8z7KC7gj4zVYu401OnXJcTcYdOkiuJsDoe6BUrrgpl02bA==
Message-ID: <a0fc7450-cb3c-4a32-b3cc-cc2feec78f8a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782462552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0sDnuHkQCzZy7PJxrbPjk7PmcM2n9KrhygO8Gu5Dp4=;
 b=dG0s5oRuWPILaBsL3glTY6BOD41JihgA1OxD3eRxMH41uiCaKU7f74Rnd5LNJ8p/nLAWOq
 9x8vjLrOughh205eP3xhRN5O9mhODvYjp19WTQAdbxUoa5OhUVDmeUI3kER56PfkdbIuK9
 BJemIabuQlUKHj0enguchgzDlqyW4e078lCobdivb7vnZ7mzePyvw6gu8p/yNp5TJtEY1z
 wrvhfchLiar+873CgutEmyK42IJANjWdyA7lX4k6ACCr6kmIluPeb8A7HNK+vU2Q7AoIbd
 2s/acHQSRx+HmBGU1koQys+kDGYD7Cz5T1nEd5QjBlqKBO0KVQuNDLRM/ZzAZw==
Date: Fri, 26 Jun 2026 10:29:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: a37xx: pinctrl: fix info->dev used but never set
To: Quentin Schulz <foss+uboot@0leil.net>,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Ben Schneider <ben@bens.haus>
References: <20260625-pinctrl-armada-37xx-devm-v1-1-6850a91dd02a@cherry.de>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260625-pinctrl-armada-37xx-devm-v1-1-6850a91dd02a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a26b75f471b9d3c3c38
X-MBO-RS-META: u3ubwk6gz6qz95dwm44u8mhg4c96ekyn
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

On 6/25/26 11:45, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> A bunch of code calls info->dev, mostly dev_* messages and devm_kzalloc.
> 
> The former can be passed a NULL device and _dev_printk handles this just
> fine.
> The latter ignores the dev argument whenever !CONFIG_IS_ENABLED(DEVRES)
> which was true in most cases until we made CONFIG_DEVRES mandatory for
> U-Boot proper in commit 217cf656e249 ("dm: core: Default to using DEVRES
> outside of xPL"). Failing to set info->dev before it's used by
> devm_kzalloc results in crashes, therefore let's set info->dev before it
> can be used.
> 
> Reported-by: Ben Schneider <ben@bens.haus>
> Closes: https://lore.kernel.org/u-boot/IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus/
> Fixes: 0871806629b5 ("pinctrl: armada-37xx: Add pin controller support for Armada 37xx")
> Fixes: 217cf656e249 ("dm: core: Default to using DEVRES outside of xPL")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
> This was apparently tested by Ben[1] but it'd be nice if you could test
> again and give your Tested-by as I do not own any board with such
> pinctrl device.
> 
> [1] https://lore.kernel.org/u-boot/kaJS2I2TlB5214mKzY5xXgpgeJRX1riXHuO0FSKHKdxcmBCJrnYmp7s-ebQd7mIbJBd1_yubQEd2bxBUMcUK02KgDudVPXcBIdlIZRMTxF8=@bens.haus/
> ---
>   drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> index 884ed258d17..ea726b96f61 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> @@ -720,6 +720,8 @@ static int armada_37xx_pinctrl_probe(struct udevice *dev)
>   		return -ENODEV;
>   	}
>   
> +	info->dev = dev;
> +
>   	/*
>   	 * we allocate functions for number of pins and hope there are
>   	 * fewer unique functions than pins available
> 
> ---
> base-commit: 77a48fa272161df9b778ffc09af814eec11cddd2
> change-id: 20260625-pinctrl-armada-37xx-devm-556d34da70a7
> 
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
> 

