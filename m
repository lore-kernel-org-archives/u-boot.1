Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65532D49211
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 12:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC33D8945C;
	Mon, 18 Nov 2024 13:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="rBRJR8My";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 966E08945C; Mon, 18 Nov 2024 13:31:46 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F21893E3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 1C1B51F901;
 Mon, 18 Nov 2024 13:31:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1731933103;
 bh=ptTntjRhmmhJkXwFEclYMn7XjWBv9gmb1gJwc5jFtqA=; h=From:To:Subject;
 b=rBRJR8My4SHwcplotmDffy5U5s10+ykUIesuyFHJ6+ol+KANAQfkQtPQF/TuZJw8w
 2wupHkiJQHyAHC1+lSgFWyb3bvnqnTZ8NO/NYbMUC0KzbSNH5Wvm7pSJCQ+OEt9qUu
 1xF1OLVlbJWzsYubZd5Q3hNk/+gNIuEwNyCu5idWH86sOmsMYLLBG+UcIbzhTErJ6E
 XDXjb4/OvODhHbQuKacWATkhKMJCeMc3F/DRow2JSMvdVxZwqLSzi8fl5SbcnjtuV/
 pPJwjIVeCDDnquq79jJfn1d5w6HzreVlMUobgEzc1eGiVpzNZXtwhuDfwBynfzfhwC
 7O0XZ1uCi6XKw==
Date: Mon, 18 Nov 2024 13:31:39 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andrej Valek <andrej.valek@siemens.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 CL Wang <cl634@andestech.com>, Chanho Park <chanho61.park@samsung.com>,
 Fabio Estevam <festevam@denx.de>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Randolph <randolph@andestech.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 01/20] wdt: imx8qxp: add option to control external
 PMIC wdt via IMX8 SCU
Message-ID: <20241118123139.GA42367@francesco-nb>
References: <20241118062715.32989-1-hs@denx.de>
 <20241118062715.32989-2-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118062715.32989-2-hs@denx.de>
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

On Mon, Nov 18, 2024 at 07:26:55AM +0100, Heiko Schocher wrote:
> Driver for a PMIC watchdog timer controlled via Siemens SCU firmware
> extensions. Only useful on some Siemens i.MX8-based platforms as
> special SCFW is needed which provides the needed SCU API.
> 
> Signed-off-by: Andrej Valek <andrej.valek@siemens.com>
> Signed-off-by: Heiko Schocher <hs@denx.de>

...

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0e45f0a0922..f317d0922cb 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -428,6 +428,13 @@ config WDT_ARM_SMC
>  	  Select this to enable Arm SMC watchdog timer. This watchdog will manage
>  	  a watchdog based on ARM SMCCC communication.
>  
> +config WDT_SCU_PMIC
Isn't this a too generic name for something the is platform specific?
Or this is not Siemens specific? One or the other, I would say.


> +	bool "Enable PMIC Watchdog Timer support for siemens platforms"
                                                     ^ Siemens? You are
						     using appropriate
						     uppercase
						     everywhere ...

Francesco

