Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9361ECD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED7A846E2;
	Wed, 27 May 2026 14:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fPWfTy4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A467846E6; Wed, 27 May 2026 14:32:04 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E600F83FB0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 14:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gQTWw1D4hz9tZv;
 Wed, 27 May 2026 14:31:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779885116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHMj53O7SOPYrxkwpv4KG8pBI1Ocm4FGM89BNV4oOZ4=;
 b=fPWfTy4faqvCguQrW0t9DlT9HgiCsyQRW/VWBupwlAbOOcbMJQjYEBzCmJgDocU7Fp7Qq2
 SKYhzDYz9k97A+ZScDgapoiXkVih+nssDplxjZD1h24oBp0BEdo97VuJQO8NeOb9a7xOR/
 Jzywt84G9tRFn5lw+X+c9mVzoTxsQp+KvEFpJC2KY/qSzSghuWiAYViKiPOrEjUt2wKp1C
 cGIQkqQ+Beiso+HDejzQDPcK06mMqupfCqQbl85UFjwKt28r1N7cfMy3ttMOoEG6etFHzR
 o9AIOJwiyabEvZV49Gtrtlk3jlfJhhkP05y+SazzW069F1jH3GjIUjdBCM7OYA==
Message-ID: <4f3f924d-430b-46c5-9e94-334f7f69391f@mailbox.org>
Date: Wed, 27 May 2026 14:31:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] watchdog: rti: Use dev_read_addr_ptr()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>
References: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
 <20260525-devfdt-wdog-v1-2-d8142b674ba0@nxp.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260525-devfdt-wdog-v1-2-d8142b674ba0@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rhw8gaipke3nhbbxo7wa4ahr6rrwa6wy
X-MBO-RS-ID: 69bfd1c2b7716e0d109
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

On 5/25/26 05:51, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> devfdt_get_addr() returns FDT_ADDR_T_NONE(-1UL) when fail, using
> "!priv->regs" to check return value is wrong.
> 
> Replace devfdt_read_addr() with dev_read_addr_ptr() when retrieving the
> register base address.
> 
> dev_read_addr_ptr() supports both live device tree and flat DT backends,
> avoiding direct dependency on devfdt_* helpers.
> 
> Also use "void __iomem *" to replace "phys_addr_t" to avoid type
> casting.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/watchdog/rti_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 7b387266b99..866f555789c 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -39,7 +39,7 @@
>   #define WDT_PRELOAD_MAX		0xfff
>   
>   struct rti_wdt_priv {
> -	phys_addr_t regs;
> +	void __iomem *regs;
>   	unsigned int clk_hz;
>   };
>   
> @@ -177,7 +177,7 @@ static int rti_wdt_probe(struct udevice *dev)
>   	struct clk clk;
>   	int ret;
>   
> -	priv->regs = devfdt_get_addr(dev);
> +	priv->regs = dev_read_addr_ptr(dev);
>   	if (!priv->regs)
>   		return -EINVAL;
>   
> 

