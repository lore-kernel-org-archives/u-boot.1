Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A842C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99EDA86433;
	Thu, 24 Aug 2023 15:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D07D86504; Thu, 24 Aug 2023 15:57:27 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 58D86863F6
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B8211007;
 Thu, 24 Aug 2023 06:58:04 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A6B3F762;
 Thu, 24 Aug 2023 06:57:23 -0700 (PDT)
Date: Thu, 24 Aug 2023 14:56:21 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Iota Hydrae <writeforever@foxmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] pinctrl: sunxi: add SPI1 pinmuxes for f1c100s
Message-ID: <20230824145621.33370e53@slackpad.lan>
In-Reply-To: <tencent_807B704C8CF66453A9723C0E19D28E962607@qq.com>
References: <tencent_807B704C8CF66453A9723C0E19D28E962607@qq.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 23 Aug 2023 14:47:16 +0800
Iota Hydrae <writeforever@foxmail.com> wrote:

Hi,

> SPI1 is also usable on port A.
> 
> But there's nothing about SPI1 pinmux there for now.
> 
> This should be set when you are using SPI1.
> 
> According to the manual, the mux value would be 6.

So technically that looks alright, but what do you need that for? We
try to not add pinmux values to that table unless they are used
somewhere, especially if there are potential conflicting values: SPI1
on PE is on pinmux 4.
So do you have a board that needs that? Any chance you could upstream
the DT (to the kernel list!) and defconfig for that board? That would
it make it a no-brainer to merge this patch.

Cheers,
Andre

> Signed-off-by: Iota Hydrae <writeforever@foxmail.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index e5102180902..c448e40ab07 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -240,6 +240,7 @@ static const struct sunxi_pinctrl_function suniv_f1c100s_pinctrl_functions[] = {
>  	{ "mmc0",	2 },	/* PF0-PF5 */
>  	{ "mmc1",	3 },	/* PC0-PC2 */
>  	{ "spi0",	2 },	/* PC0-PC3 */
> +	{ "spi1",	6 },	/* PA0-PA3 */
>  #if IS_ENABLED(CONFIG_UART0_PORT_F)
>  	{ "uart0",	3 },	/* PF2-PF4 */
>  #else

