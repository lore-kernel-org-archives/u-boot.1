Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D0DD1A61A
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 13:08:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE56C8430F;
	Fri,  9 Jan 2026 14:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE185841A2; Fri,  9 Jan 2026 05:07:35 +0100 (CET)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF7184132
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 05:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gcbu-u-boot-users@m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <gcbu-u-boot-users@m.gmane-mx.org>)
 id 1ve3me-0008Tn-8j
 for u-boot@lists.denx.de; Fri, 09 Jan 2026 05:07:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: u-boot@lists.denx.de
From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH v6 00/12] Rockchip VOP2 support
Date: Thu, 08 Jan 2026 23:07:25 -0500
Message-ID: <jwv1pjz30sm.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
 <jwvwm1rep4n.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 <CALeDE9Oe-JG_cbVRNS=oe9x-SVxx9K-L31nmnyUDoJzvUqaO=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:YcYmqb+7YECJawJjx+2D2hykLD4=
X-Mailman-Approved-At: Fri, 09 Jan 2026 14:07:59 +0100
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

Peter Robinson [2026-01-09 01:41:41] wrote:
> I suspect you have two problems.
>
> For the lack of text being displayed can you check if you have
> CONFIG_SPLASH_SCREEN=y in your .config? That will suppress all the
> text. Try a '# CONFIG_SPLASH_SCREEN is not set' line in the config to
> see if that helps.

Hmm... that doesn't seem to be it:

    % grep -i splash .config
    CONFIG_MTDPARTS_DEFAULT="nor0:0x100000(reserved),0x200000(uboot),0x100000(splash),0xc00000(Firmware)"
    # CONFIG_SPLASH_SCREEN is not set
    %

> For the USB I have seen issues on and off with rockchips devices.
> Adding the following might be a good debug to ensure it runs and scans
> the USB bus:
>
> CONFIG_USE_PREBOOT=y
> CONFIG_PREBOOT="usb start;"

Interesting.  I have now enabled USE_PREBOOT (which set CONFIG_PREBOOT
for me):

    % grep -i preboot .config
    CONFIG_USE_PREBOOT=y
    CONFIG_PREBOOT="usb start"
    CONFIG_PREBOOT_DEFINED=y
    %

[ I notice the absence of ";" compared to your suggestion, but since that
  came from U-Boot's own config rather than from me, I assume it's OK.  ]

But that didn't seem to make any difference.

> If you have a USB TTL you should be able to see it all on serial
> console no matter what gets displayed on HDMI.

I have now tried it on my Odroid-M1 (using a similar patch for `configs/odroid-m1-rk3568_defconfig`), where I do have a serial connection
which lets me see what's going on (I'm specifically after the VOP2 code
for my NanoPi because that one doesn't have a ready-to-use connector for
the serial and I'd rather not have to take out my old soldering iron for
that).

I don't see the U-Boot logo on my Odroid-M1, and the screen just turns
off saying "no signal" (until it turns back on when the Linux kernel
finally loads the rockchip drm module), so the HDMI code/config doesn't
seem right.  On the serial console I see:

    U-Boot 2026.01-00518-g664b0ba1dcde (Jan 08 2026 - 22:33:46 -0500)
     
    Model: Hardkernel ODROID-M1
    SoC:   RK3568B2
    DRAM:  4 GiB
    PMIC:  RK809 (on=0x02, off=0x00)
    Core:  629 devices, 35 uclasses, devicetree: separate
    MMC:   mmc@fe2b0000: 1, mmc@fe310000: 0
    Loading Environment from nowhere... OK
    In:    serial
    Out:   serial
    Err:   serial
    Model: Hardkernel ODROID-M1
    SoC:   RK3568B2
    Net:   eth0: ethernet@fe2a0000
     
    starting USB...
    Starting the controller
    USB XHCI 1.10
    Starting the controller
    USB XHCI 1.10
    USB EHCI 1.00
    USB OHCI 1.0
    USB EHCI 1.00
    USB OHCI 1.0
    Bus usb@fcc00000: 1 USB Device(s) found
    Bus usb@fd000000: 1 USB Device(s) found
    Bus usb@fd800000: 1 USB Device(s) found
    Bus usb@fd840000: 4 USB Device(s) found
    Bus usb@fd880000: 2 USB Device(s) found
    Bus usb@fd8c0000: 1 USB Device(s) found
           scanning usb for storage devices... 0 Storage Device(s) found
    Hit any key to stop autoboot: 1

so the USB code seems to do something, but for some reason it doesn't
see the keyboard.


        Stefan

