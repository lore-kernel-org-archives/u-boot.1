Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748C3C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 15:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2BA8865F;
	Tue, 11 Jun 2024 17:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9FC886D5; Tue, 11 Jun 2024 17:25:31 +0200 (CEST)
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by phobos.denx.de (Postfix) with ESMTP id B88E1882C5
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 17:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@arachsys.com
Received: from [31.94.10.207] (helo=smtpclient.apple)
 by delta.arachsys.com with esmtpa (Exim 4.80)
 (envelope-from <chris@arachsys.com>) id 1sH3NG-0004td-CY
 for u-boot@lists.denx.de; Tue, 11 Jun 2024 16:25:26 +0100
From: Chris Webb <chris@arachsys.com>
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: Debugging gpio-hogs which don't get probed
Date: Tue, 11 Jun 2024 16:25:28 +0100
References: <CE13B0FF-EE3C-44C6-A17C-65C8A945713A@arachsys.com>
To: u-boot@lists.denx.de
In-Reply-To: <CE13B0FF-EE3C-44C6-A17C-65C8A945713A@arachsys.com>
Message-Id: <969C7F7F-E989-44D2-9E96-181813455928@arachsys.com>
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

Chris Webb <chris@arachsys.com> wrote:

> This shows gpio_post_bind being called, then the four gpio-hogs found  
> and set to probe after bind, but the gpio_hog_probe function is never  
> actually called. Presumably this is the problem - if they're not probed  
> then they'll never take effect?
>
> I enabled CONFIG_DM_WARN and CONFIG_DM_DEBUG, which confirm that nothing  
> ever seems to be probing the gpio-hog children, but there aren't  
> obviously any errors or warnings related to them either. Nothing  
> relevant happens after gpio_post_bind is called.

Following up to myself here, I enabled CONFIG_CMD_DM which seems to  
confirm they aren't getting probed:

   boot> dm tree
    Class     Index  Probed  Driver                Name
   -----------------------------------------------------------
    root          0  [ + ]   root_driver           root_driver
    clk           0  [   ]   fixed_clock           |-- gpt_dummy20m
    syscon        0  [   ]   syscon                |-- hwver
    clk           1  [ + ]   mt7981-clock-fixed-p  |-- apmixedsys@1001e000
    clk           2  [ + ]   mt7981-clock-topckge  |-- topckgen@1001b000
    clk           3  [ + ]   mt7981-clock-infracf  |-- infracfg_ao@10001000
    clk           4  [ + ]   mt7981-clock-infracf  |-- infracfg@10001000
    pinctrl       0  [ + ]   mt7981_pinctrl        |-- pinctrl@11d00000
    pinconfig     0  [ + ]   pinconfig             |   |-- mmc0-pins-default
    pinconfig     1  [   ]   pinconfig             |   |   |-- mux
    pinconfig     2  [   ]   pinconfig             |   |   |-- conf-cmd-dat
    pinconfig     3  [   ]   pinconfig             |   |   |-- conf-clk
    pinconfig     4  [   ]   pinconfig             |   |   `-- conf-rst
    gpio          0  [   ]   mediatek_gpio         |   `-- mediatek_gpio
    nop           1  [   ]   gpio_hog              |       |-- hub_power
    nop           2  [   ]   gpio_hog              |       |-- modem_control
    nop           3  [   ]   gpio_hog              |       |-- modem_reset
    nop           4  [   ]   gpio_hog              |       `-- modem_power
    serial        0  [ + ]   serial_mtk            |-- serial@11002000
    clk           5  [ + ]   mt7981-clock-ethsys   |-- syscon@15000000
    reset         0  [ + ]   mediatek_reset        |   |-- reset
    syscon        4  [ + ]   syscon                |   `-- syscon@15000000
    ethernet      0  [ + ]   mtk-eth               |-- ethernet@15100000
    syscon        1  [   ]   syscon                |-- syscon@10060000
    syscon        2  [   ]   syscon                |-- syscon@10070000
    syscon        3  [ + ]   syscon                |-- topmisc@11d10000
    mmc           0  [ + ]   mtk_sd                |-- mmc@11230000
    blk           0  [   ]   mmc_blk               |   `-- mmc@11230000.blk
    regulator     0  [   ]   regulator_fixed       |-- regulator-3p3v
    button        0  [   ]   button_gpio           |-- keys
    button        1  [   ]   button_gpio           |   `-- reset
    nop           0  [   ]   gpio_led_wrap         `-- leds
    led           0  [   ]   gpio_led                  |-- power
    led           1  [   ]   gpio_led                  |-- internet
    led           2  [   ]   gpio_led                  |-- wifi_2g
    led           3  [   ]   gpio_led                  |-- wifi_5g
    led           4  [   ]   gpio_led                  |-- signal_1
    led           5  [   ]   gpio_led                  |-- signal_2
    led           6  [   ]   gpio_led                  |-- signal_3
    led           7  [   ]   gpio_led                  `-- signal_4

on power up.

I noted that the parent gpio-controller wasn't getting probed either, so  
tried this:

   --- a/u-boot/drivers/pinctrl/mediatek/pinctrl-mt7981.c
   +++ b/u-boot/drivers/pinctrl/mediatek/pinctrl-mt7981.c
   @@ -1038,6 +1038,12 @@ static int mtk_pinctrl_mt7981_probe(struct udevice *dev)
           return mtk_pinctrl_common_probe(dev, &mt7981_data);
    }

   +static int mtk_pinctrl_mt7981_bind(struct udevice *dev)
   +{
   +       dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
   +       return 0;
   +}
   +
    static const struct udevice_id mt7981_pctrl_match[] = {
           {.compatible = "mediatek,mt7981-pinctrl"},
           { /* sentinel */ }
   @@ -1048,6 +1054,7 @@ U_BOOT_DRIVER(mt7981_pinctrl) = {
           .id = UCLASS_PINCTRL,
           .of_match = mt7981_pctrl_match,
           .ops = &mtk_pinctrl_ops,
   +       .bind = mtk_pinctrl_mt7981_bind,
           .probe = mtk_pinctrl_mt7981_probe,
           .priv_auto = sizeof(struct mtk_pinctrl_priv),
    };

This does indeed fix the problem: the hogs get probed and the gpios show  
as active outputs on gpio status -a on boot.

But presumably this is all supposed to work without patching that?

Best wishes,

Chris.
