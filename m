Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4792FC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 07:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E5384A49;
	Mon, 13 Jul 2026 09:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="dnvkSZar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D36FF84A4A; Mon, 13 Jul 2026 09:07:56 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3C7B84A48
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 09:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id D2CED1FD35;
 Mon, 13 Jul 2026 09:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1783926474;
 bh=YRO1wAgy/JoR8s9+N6Hi8Sx/cboxS/rOS9ndugw2cCg=; h=From:To:Subject;
 b=dnvkSZar8aEtIn4peIOFG9tomwPFsfgKkDd8jStgs866enivWwcuBbjQWZyfcQi+Y
 u5+7sNsdOYPxQlhNvewKzoKAqDFz+q9tNLtlvD27HnPAf+FRngPTss/5SBal0guyyK
 EAKh6nnnQw1JQ5Opc/RGhu8H9QMuyfgSZuxGaAzBOVJh+fMlgoi6gmLwq12uU8FAxb
 ZvPAbUByGRc3b6q5bk8HF6e4QYMbB8EDB6bvT4sEERhBIpwO0k2RAGNj7fs0fpM5r4
 0QnJ8VZunfxKsLTeza5r/7OaKwQlB4Tonxg/nRBIxSSFXVUT1sCxp0p0ChbjP9mvjd
 iK/trMpszR3lA==
Date: Mon, 13 Jul 2026 09:07:52 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH] gpio: pca953x: Add GPIO settle delay
Message-ID: <20260713070752.GC13102@francesco-nb>
References: <20260710230409.147210-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710230409.147210-1-jm@ti.com>
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

Hello Judith,

On Fri, Jul 10, 2026 at 06:04:09PM -0500, Judith Mendez wrote:
> Some board designs have slow RC circuits on GPIO outputs controlled by
> PCA953X I2C expanders. On some board designs, pin voltage transitions
> can take significant time after I2C write command completes.
> 
> Add an optional "gpio-settle-delay-ms" device tree property for the
> pca953x driver to add a delay after I2C write if specified, allowing to
> compensate for slow RC circuits.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/gpio/pca953x_gpio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
> index 965a5fcf30b..54b957069c9 100644
> --- a/drivers/gpio/pca953x_gpio.c
> +++ b/drivers/gpio/pca953x_gpio.c
> @@ -333,6 +339,8 @@ static int pca953x_probe(struct udevice *dev)
>  
>  	info->bank_count = DIV_ROUND_UP(info->gpio_count, BANK_SZ);
>  
> +	info->settle_delay_ms = dev_read_u32_default(dev, "gpio-settle-delay-ms", 0);

Is this property supported also in Linux and defined in the Linux
binding? I do not think we should have U-Boot specific DT properties.

Francesco

