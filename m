Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB288CE79AD
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 06:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D303A86BE8;
	Wed, 20 Sep 2023 08:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="D4uZ+RdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A624686BF6; Wed, 20 Sep 2023 08:13:40 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E47186BAC
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 08:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Wed, 20 Sep 2023 08:12:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1695190416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LhOBTjiRwM0S6vysf6NPDV8UK5ju/6K9CE9r2iqv4c=;
 b=D4uZ+RdZtA8hzuMn0VfO8xnAq/mFF4VgCRfz/BHqhvHoonYdbUjfpWbFzjIyBEjzY3/ORj
 clfNFkGhleopmX8o/iUOprWA9CcDijFtNkBJfZuc1Z9V+IZYKT8RCm3plB7EKsTVy1vuh6
 0YUhU+HrJmWyE9IeAl25GXBW7nt6Qc2DIwT48s0UtRCX70JyEkmwqWG5ilpIg/W2sTTccw
 vQYbXCj4X1xancaJ5GZcTl/WLaG0AjegNyv/p6rIBw3ToNNGHnthzLtEa9woE6Nt8DvTry
 QYJF80FbvzWBe4VE+ycO9PtWhgUhVNVQhCHJEusuDYkj7UF8QnGelpgb23naWw==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
Subject: Re: [PATCH 2/2] mtd: nand: raw: atmel: Add error handling when
 rb-gpios missing
Message-ID: <20230920-renewed-lantern-717bbbd48120@ifak-system.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@collabora.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
References: <20230808130250.188588-1-ada@thorsis.com>
 <20230808130250.188588-3-ada@thorsis.com>
 <CAOf5uwkgaoGyB3kS7Kf4GZyvAcGDJMTRPajXa4SQVy7LU6BJDA@mail.gmail.com>
 <20230808-elusive-apple-4e3ce1331b5a@ifak-system.com>
 <e913d8c6-3daf-0a58-3813-253cb5dee79c@collabora.com>
 <CAOf5uwkzJXU6XU-3gaSAkApzjv0Yf_C7iqjwrVptsyWyfRTm8g@mail.gmail.com>
 <e05bf619-0d9b-2b56-9b50-41b1e24b5500@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e05bf619-0d9b-2b56-9b50-41b1e24b5500@collabora.com>
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

Hello Eugen, hello Michael,

Am Wed, Aug 23, 2023 at 01:59:58PM +0300 schrieb Eugen Hristev:
> On 8/23/23 09:54, Michael Nazzareno Trimarchi wrote:
> > Hi
> > 
> > On Wed, Aug 23, 2023 at 8:28 AM Eugen Hristev
> > <eugen.hristev@collabora.com> wrote:
> > > 
> > > Hi,
> > > 
> > > On 8/8/23 18:03, Alexander Dahl wrote:
> > > > Hello Michael,
> > > > 
> > > > Am Tue, Aug 08, 2023 at 03:49:45PM +0200 schrieb Michael Nazzareno Trimarchi:
> > > > > Hi
> > > > > 
> > > > > On Tue, Aug 8, 2023 at 3:03 PM Alexander Dahl <ada@thorsis.com> wrote:
> > > > > > 
> > > > > > Adapt behaviour to Linux kernel driver.
> > > > > > 
> > > > > > The return value of gpio_request_by_name_nodev() was not checked before,
> > > > > > and thus in case 'rb-gpios' was missing in DT, rb.type was set to
> > > > > > ATMEL_NAND_GPIO_RB nevertheless, leading to output like this for
> > > > > > example (on sam9x60-curiosity with the line removed from dts):
> > > > > > 
> > > > > >       NAND:  Could not find valid ONFI parameter page; aborting
> > > > > >       device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
> > > > > >       Macronix NAND 512MiB 3,3V 8-bit
> > > > > >       512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 64
> > > > > >       atmel-nand-controller nand-controller: NAND scan failed: -22
> > > > > >       Failed to probe nand driver (err = -22)
> > > > > >       Failed to initialize NAND controller. (error -22)
> > > > > >       0 MiB
> > > > > > 
> > > > > > Note: not having that gpio assigned in dts is fine, the driver does not
> > > > > > override nand_chip->dev_ready() then and a generic solution is used.
> > > > > > 
> > > > > > Fixes: 6a8dfd57220d ("nand: atmel: Add DM based NAND driver")
> > > > > > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > > > > > ---
> > > > > >    drivers/mtd/nand/raw/atmel/nand-controller.c | 11 +++++++----
> > > > > >    1 file changed, 7 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > > > > > index 2b29c8def6..8e745a5111 100644
> > > > > > --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > > > > > +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > > > > > @@ -1600,10 +1600,13 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
> > > > > >                           nand->cs[i].rb.type = ATMEL_NAND_NATIVE_RB;
> > > > > >                           nand->cs[i].rb.id = val;
> > > > > >                   } else {
> > > > > > -                       gpio_request_by_name_nodev(np, "rb-gpios", 0,
> > > > > > -                                                  &nand->cs[i].rb.gpio,
> > > > > > -                                                  GPIOD_IS_IN);
> > > > > > -                       nand->cs[i].rb.type = ATMEL_NAND_GPIO_RB;
> > > > > > +                       ret = gpio_request_by_name_nodev(np, "rb-gpios", 0,
> > > > > > +                                                        &nand->cs[i].rb.gpio,
> > > > > > +                                                        GPIOD_IS_IN);
> > > > > > +                       if (ret)
> > > > > > +                               dev_err(nc->dev, "Failed to get R/B gpio (err = %d)\n", ret);
> > > > > 
> > > > > Should not then an error here
> > > > 
> > > > Different log level or no message at all?
> > > > 
> > > > Note: Linux prints the same message with error level in that case.
> > > > 
> > > > Greets
> > > > Alex
> > > > 
> > > 
> > > Since the rb-gpios is optional, we can continue probing without it.
> > > Throwing an error message is optional and pure informative. So I am fine
> > > with it
> > > 
> > 
> > Yes ok, but I'm not sure linux give an error if the gpio is get as
> > optional and condition
> > is IS_ERR. Am I right?
> 
> 
> 			if (IS_ERR(gpio) && PTR_ERR(gpio) != -ENOENT) {
> 				dev_err(nc->dev,
> 					"Failed to get R/B gpio (err = %ld)\n",
> 					PTR_ERR(gpio));
> 				return ERR_CAST(gpio);
> 			}
> 
> So Linux throws the message if IS_ERR . If the property is missing (ENOENT)
> it moves on.
> 
> Can we replicate the same behavior or this behavior does not suit us in
> U-boot ?
> 
> Basically I think it should be :
> 		
> 		if (ret && ret != -ENOENT)
> 			dev_err(...)
> 		if (!ret)
> 			rb.type = ATMEL_NAND_GPIO_RB;
> 
> Is this what you had in mind Michael ?

The discussion between you guys somehow got stuck.  I still have this
patch on my TODO list, but I'm not sure how to proceed.  Please advice
in which direction to go forward, there's still an error condition
(described in the initial commit message) here, which needs to be
handled, otherwise the NAND flash might not be usable.

Greets
Alex

> 
> Eugen
> 
> > 
> > For the rest is fine
> > 
> > Michael
> > 
> > > What I wanted to ask is what happens with nand->cs[i].rb.type , is it 0
> > > by default ?
> > > 
> > > Other than that, I can apply this patch, Michael, do you have any more
> > > comments on it ?
> > > 
> > > Thanks,
> > > Eugen
> > > > > 
> > > > > Michael
> > > > > 
> > > > > > +                       else
> > > > > > +                               nand->cs[i].rb.type = ATMEL_NAND_GPIO_RB;
> > > > > >                   }
> > > > > > 
> > > > > >                   gpio_request_by_name_nodev(np, "cs-gpios", 0,
> > > > > > --
> > > > > > 2.30.2
> > > > > > 
> > > > > 
> > > > > 
> > > > > --
> > > > > Michael Nazzareno Trimarchi
> > > > > Co-Founder & Chief Executive Officer
> > > > > M. +39 347 913 2170
> > > > > michael@amarulasolutions.com
> > > > > __________________________________
> > > > > 
> > > > > Amarula Solutions BV
> > > > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > > > > T. +31 (0)85 111 9172
> > > > > info@amarulasolutions.com
> > > > > www.amarulasolutions.com
> > > 
> > 
> > 
> 
