Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBF3C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 10:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2242D87BF4;
	Tue, 11 Jun 2024 12:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E9288623; Tue, 11 Jun 2024 12:59:04 +0200 (CEST)
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by phobos.denx.de (Postfix) with ESMTP id B5B938752A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 12:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@arachsys.com
Received: from [31.94.10.207] (helo=smtpclient.apple)
 by delta.arachsys.com with esmtpa (Exim 4.80)
 (envelope-from <chris@arachsys.com>) id 1sGzDO-0000AO-AX
 for u-boot@lists.denx.de; Tue, 11 Jun 2024 11:58:58 +0100
From: Chris Webb <chris@arachsys.com>
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Debugging gpio-hogs which don't get probed
Message-Id: <CE13B0FF-EE3C-44C6-A17C-65C8A945713A@arachsys.com>
Date: Tue, 11 Jun 2024 11:59:00 +0100
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3654.120.0.1.15)
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

I'm building u-boot for a mt7981a board, very similar to the in-tree  
mt7981-emmc-rfb. For reference, my device tree and output of make  
savedefconfig are here:

   https://gist.github.com/arachsys/98048980728c652bea641b42cfd41a40

Everything boots fine, but I have a handful of gpios which need to be set  
to fixed values before booting the kernel to enable a 5g modem. I can do  
this with

   gpio clear 10; gpio set 5; gpio set 9; gpio 11

which works fine, but I think the 'official' solution for this might be  
using u-boot's gpio-hog support?

With that in mind, I added


   &gpio {
   	hub_power {
   		gpio-hog;
   		gpios = <5 GPIO_ACTIVE_HIGH>;
   		output-high;
   	};

   	modem_control {
   		gpio-hog;
   		gpios = <9 GPIO_ACTIVE_HIGH>;
   		output-high;
   	};

   	modem_reset {
   		gpio-hog;
   		gpios = <10 GPIO_ACTIVE_HIGH>;
   		output-low;
   	};

   	modem_power {
   		gpio-hog;
   		gpios = <11 GPIO_ACTIVE_HIGH>;
   		output-high;
   	};
   };

with CONFIG_GPIO_HOG=y, but this doesn't seem to work on either u-boot.git  
HEAD or 2024.07-rc.

To try to see what was going on better, I added some debug printfs:

   --- a/u-boot/drivers/gpio/gpio-uclass.c
   +++ b/u-boot/drivers/gpio/gpio-uclass.c
   @@ -328,6 +330,8 @@ static int gpio_hog_of_to_plat(struct udevice *dev)

    static int gpio_hog_probe(struct udevice *dev)
    {
   +	printf("gpio_hog_probe called\n");
   +
    	struct gpio_hog_data *plat = dev_get_plat(dev);
    	struct gpio_hog_priv *priv = dev_get_priv(dev);
    	int ret;
   @@ -1518,6 +1523,8 @@ void devm_gpiod_put(struct udevice *dev, struct gpio_desc *desc)

    static int gpio_post_bind(struct udevice *dev)
    {
   +	printf("gpio_post_bind called\n");
   +
    	if (CONFIG_IS_ENABLED(GPIO_HOG) && dev_has_ofnode(dev)) {
    		struct udevice *child;
    		ofnode node;
   @@ -1539,6 +1546,7 @@ static int gpio_post_bind(struct udevice *dev)
    				 * since hogs can be essential to the hardware
    				 * system.
    				 */
   +				printf("found a gpio-hog\n");
    				dev_or_flags(child, DM_FLAG_PROBE_AFTER_BIND);
    			}
    		}

This shows gpio_post_bind being called, then the four gpio-hogs found and  
set to probe after bind, but the gpio_hog_probe function is never actually  
called. Presumably this is the problem - if they're not probed then  
they'll never take effect?

I enabled CONFIG_DM_WARN and CONFIG_DM_DEBUG, which confirm that nothing  
ever seems to be probing the gpio-hog children, but there aren't obviously  
any errors or warnings related to them either. Nothing relevant happens  
after gpio_post_bind is called.

Is this a bug or is there some basic config/dts mistake on my part here?  
Is there some other debug info I can get that might shed light on what's  
going on, or some config prerequisite for DM_FLAG_PROBE_AFTER_BIND to work  
that I'm likely to be missing?

Best wishes,

Chris.
