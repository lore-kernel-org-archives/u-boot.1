Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EA7CD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 22:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DF1184901;
	Sat, 20 Jun 2026 00:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D81CF849A4; Sat, 20 Jun 2026 00:30:45 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6791584873
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 00:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.124.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 10CEA342EC1;
 Fri, 19 Jun 2026 22:30:40 +0000 (UTC)
Date: Fri, 19 Jun 2026 22:30:30 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Denis Burkov <hitechshell@mail.ru>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] gpio: axp: Add support for devicetree
Message-ID: <20260619223030-GYA3523907@gentoo.org>
References: <20260121115437.31406-1-hitechshell@mail.ru>
 <2e9b4819-de5c-49ca-a42a-241cf11ef62b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e9b4819-de5c-49ca-a42a-241cf11ef62b@arm.com>
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

Hi Denis,

On 15:50 Fri 19 Jun     , Andre Przywara wrote:
> Hi Denis,
> 
> thanks for sending this patch!
> 
> On 1/21/26 12:54, Denis Burkov wrote:
> 
> I am afraid you need to put some commit message in here. You can refer 
> to the comment you are removing, so that there *is* now DT support for 
> the AXP GPIOs. But also please mention what this fixes - why do we need 
> this patch? If you can provide an example usage, it would be easier to 
> take this patch.
> 
I agree, describe what's problem to solve.. mainly I think this patch
coverting the driver into device tree aware, so it will probe axp-gpio
based on if the target dts support it or not..

> > Signed-off-by: Denis Burkov <hitechshell@mail.ru>
> > ---
> >   board/sunxi/board.c     |  4 ----
> >   drivers/gpio/axp_gpio.c | 28 +++++++++++-----------------
> >   2 files changed, 11 insertions(+), 21 deletions(-)
> > 
> > diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> > index 2929bc17f08..3c61bfb8822 100644
> > --- a/board/sunxi/board.c
> > +++ b/board/sunxi/board.c
> > @@ -226,10 +226,6 @@ int board_init(void)
> >   	}
> >   #endif /* !CONFIG_ARM64 && !CONFIG_MACH_SUNIV */
> >   
> > -	ret = axp_gpio_init();
> > -	if (ret)
> > -		return ret;
> > -
> >   	eth_init_board();
> >   
> >   	return 0;
> > diff --git a/drivers/gpio/axp_gpio.c b/drivers/gpio/axp_gpio.c
> > index 181c53bfe72..1c5882a25d4 100644
> > --- a/drivers/gpio/axp_gpio.c
> > +++ b/drivers/gpio/axp_gpio.c
> > @@ -98,35 +98,29 @@ static const struct dm_gpio_ops gpio_axp_ops = {
> >   
> >   static int gpio_axp_probe(struct udevice *dev)
> >   {
> > +	int ret;
> >   	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> >   
> >   	/* Tell the uclass how many GPIOs we have */
> >   	uc_priv->bank_name = AXP_GPIO_PREFIX;
> >   	uc_priv->gpio_count = AXP_GPIO_COUNT;
> >   
> > +	ret = pmic_bus_init();
> > +	if (ret)
> > +		return ret;
> > +
> >   	return 0;
> >   }
> >   
> > +static const struct udevice_id gpio_axp_match[] = {
> > +	{ .compatible = "x-powers,axp209-gpio" },
> 
> Why is it only this compatible string? What about the others? I guess 
> the driver was just not enabled on newer AXPs before?
> Can you maybe look what it takes to support the other PMICs? If you look 
> at the Linux driver, that's mostly about what pins each AXP supports.
> 
For Linux driver, I think Andre refer to the AXP209 GPIO driver [1]
and two more compatibles "x-powers,axp221-gpio", "x-powers,axp813-gpio" are needed

Please also check the ".gpio_status_offset" which differ in device data

Link: https://elixir.bootlin.com/linux/v7.1/source/drivers/pinctrl/pinctrl-axp209.c#L429 [1]
> And peeking into the driver here, there are some #ifdef's in there 
> (AXP_GPIO[23]_CTRL), I think now collides with the DT description, and 
> whatever this was doing should be detected at runtime, potentially by 
> supporting multiple compatible strings.
> 
Agree, should fold these info into compatible data with multiple compatible

-- 
Yixun Lan (dlan)
