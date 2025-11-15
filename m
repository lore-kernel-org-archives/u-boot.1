Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560E1CEB2D2
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 21:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8423883A1B;
	Sat, 15 Nov 2025 22:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jui4Mx6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C836283A1E; Sat, 15 Nov 2025 22:23:01 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF34D839E8
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 22:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=62e4=5Y=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1763241777;
 bh=5ill1OvyNQgQ3FpaBD5VZ4R73pvP2tiVi6EV7mOCFI0=;
 b=jui4Mx6w91h8c/HDzTpwATZGDwrZ+PiLrIrrwCJbLZvlsx72Oly9CBVIaVMfFlxD5RjshT1tK
 DHGHCw1uYWGIYJLUV0lLfe3HlmU9nXf+XbNSoolgORwpR7cvpkbTTLisfghaEkt4JepcXDwMzI8
 4WjBCg9M3voJySjlxdIe+uWOduQpMj2kbKkKafDqCxcG23OHqGctbm3CT+GNISE4ctyVS1ZPgzR
 RMrnICzSsst10u6iv+UXUhqFfjkj0LDOeGf7WyORIEGamlNbfgFgJmCh2c6AQvs7QhnVnGjjlEG
 YiPXwmYXzRoAsE0zP9shYJacXpd5Ia89WA5x47N6FCHA==
X-Forward-Email-ID: 6918ef2d424f0934667be53c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.4.5
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <eed6bd9d-c2f7-4003-af51-152c905c9532@kwiboo.se>
Date: Sat, 15 Nov 2025 22:22:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `usb start` freezes friendlyelec CM3588 Plus NAS board
To: Krumelmonster <krumelmonster@zoho.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <0cbfcfd3-c0e1-432f-92f2-d7bc349bdf57@zoho.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0cbfcfd3-c0e1-432f-92f2-d7bc349bdf57@zoho.com>
Content-Type: text/plain; charset=UTF-8
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

Hi,

On 11/15/2025 5:30 PM, Krumelmonster wrote:
> Hello everyone,
> 
> Using the cm3588-nas-rk355_defconfig, running `usb start` in u-boot 
> freezes my cm3588 nas in all commits I checked:
> v2024.10, v2025.10, v2026.01-rc, and the current `rockchip` branch 
> (commit a81c91446a1) on collaboras rk3588 repo at
> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot
> 
> It doesn't freeze if I disable PHY_ROCKCHIP_INNO_USB2.
> 
> This is the 32GB RAM, 64GB eMMC variant of the CM3588 Plus NAS Kit as 
> sold by friendlyelec.
> 
> I don't intend to use usb support there, just happened to stumble upon 
> this. USB gadget and host are supposedly working on the CM3588 according 
> to commit 5bc8209e1ba ("board: rockchip: Add FriendlyElec CM3588 NAS").
> 
> => usb start
> starting USB...
> USB EHCI 1.00
> 
> No further output follows.

I am not able to reproduce this issue on a CM3588 NAS Kit, and looking
at the schematics the only diff seem to be LPDDR4X vs LPDDR5.

  DDR b8ce94f14b cym 25/08/25-14:29:26,fwver: v1.20
  ...
  LPDDR4X, 1848MHz
  ...
  out
  
  U-Boot SPL 2026.01-rc2 (Nov 15 2025 - 20:57:41 +0000)
  Trying to boot from MMC2
  ## Checking hash(es) for config config-1 ... OK
  ## Checking hash(es) for Image atf-1 ... sha256+ OK
  ## Checking hash(es) for Image u-boot ... sha256+ OK
  ## Checking hash(es) for Image fdt-1 ... sha256+ OK
  ## Checking hash(es) for Image atf-2 ... sha256+ OK
  ## Checking hash(es) for Image atf-3 ... sha256+ OK
  INFO:    Preloader serial: 2
  NOTICE:  BL31: v2.3():v2.3-942-g98eaeb2f3:derrick.huang, fwver: v1.53
  NOTICE:  BL31: Built : 12:10:56, Aug 25 2025
  INFO:    spec: 0x1
  INFO:    code: 0x88
  INFO:    customer demand: 0x0
  INFO:    ext 32k is not valid
  INFO:    ddr: stride-en 4CH
  INFO:    GICv3 without legacy support detected.
  INFO:    ARM GICv3 driver initialized in EL3
  INFO:    valid_cpu_msk=0xff bcore0_rst = 0x0, bcore1_rst = 0x0
  INFO:    l3 cache partition cfg-0
  INFO:    system boots from cpu-hwid-0
  INFO:    disable memory repair
  INFO:    idle_st=0x21fff, pd_st=0x11fff9, repair_st=0xfff70001
  INFO:    dfs DDR fsp_params[0].freq_mhz= 1848MHz
  INFO:    dfs DDR fsp_params[1].freq_mhz= 528MHz
  INFO:    dfs DDR fsp_params[2].freq_mhz= 1068MHz
  INFO:    dfs DDR fsp_params[3].freq_mhz= 1560MHz
  INFO:    BL31: Initialising Exception Handling Framework
  INFO:    BL31: Initializing runtime services
  WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
  ERROR:   Error initializing runtime service opteed_fast
  INFO:    BL31: Preparing for EL3 exit to normal world
  INFO:    Entry point address = 0xa00000
  INFO:    SPSR = 0x3c9
  
  
  U-Boot 2026.01-rc2 (Nov 15 2025 - 20:57:41 +0000)
  
  Model: FriendlyElec CM3588 NAS
  SoC:   RK3588
  DRAM:  8 GiB
  PMIC:  RK806 (on=0x10, off=0x00)
  Core:  422 devices, 34 uclasses, devicetree: separate
  MMC:   mmc@fe2c0000: 1, mmc@fe2e0000: 0
  Loading Environment from nowhere... OK
  In:    serial@feb50000
  Out:   serial@feb50000
  Err:   serial@feb50000
  Model: FriendlyElec CM3588 NAS
  SoC:   RK3588
  Net:   No ethernet found.
  Hit any key to stop autoboot: 0
  => usb start
  starting USB...
  USB EHCI 1.00
  USB OHCI 1.0
  USB EHCI 1.00
  USB OHCI 1.0
  Register 2000140 NbrPorts 2
  Starting the controller
  USB XHCI 1.10
  Register 2000140 NbrPorts 2
  Starting the controller
  USB XHCI 1.10
  cannot reset port 1!?
  Bus usb@fc800000: 1 USB Device(s) found
  Bus usb@fc840000: 1 USB Device(s) found
  Bus usb@fc880000: 1 USB Device(s) found
  Bus usb@fc8c0000: 1 USB Device(s) found
  Bus usb@fcd00000: 2 USB Device(s) found
  Bus usb@fc400000: 1 USB Device(s) found
         scanning usb for storage devices... 1 Storage Device(s) found
  => usb tree
  USB device tree:
    1  Hub (480 Mb/s, 0mA)
       u-boot EHCI Host Controller
  
    1  Hub (12 Mb/s, 0mA)
        U-Boot Root Hub
  
    1  Hub (480 Mb/s, 0mA)
       u-boot EHCI Host Controller
  
    1  Hub (12 Mb/s, 0mA)
        U-Boot Root Hub
  
    1  Hub (5 Gb/s, 0mA)
    |  U-Boot XHCI Host Controller
    |
    +-2  Mass Storage (5 Gb/s, 126mA)
         Corsair Voyager VEGA 070894224D1DDF08
  
    1  Hub (5 Gb/s, 0mA)
       U-Boot XHCI Host Controller
  
  =>

Above is from using tag v2026.01-rc2 with only a single USB stick
connected to one of the 3 USB-A ports on the board, using the reset
button between each test to ensure a clean state.

> I will happily provide further information upon request.

Do you have any other peripherals attached to your board when you test?
E.g. PCIe/NVMe, HDMI, Ethernet or similar?

For my test run above I only had 12V power-in, SD-card (with u-boot) and
Debug UART connected to my CM3588 NAS Kit board.

Also what DDR-init fwver and TF-A (BL31) are you using?

Regards,
Jonas

> 
> Regards,
> krumelmonster

