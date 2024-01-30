Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332BAC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C80D87D7A;
	Tue, 30 Jan 2024 15:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67CDB87DB3; Tue, 30 Jan 2024 15:01:33 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0E90F87D7A
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CC34DA7;
 Tue, 30 Jan 2024 06:02:14 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20EC23F762;
 Tue, 30 Jan 2024 06:01:29 -0800 (PST)
Date: Tue, 30 Jan 2024 14:01:23 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Shantur Rathore <i@shantur.com>, marex@denx.de
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Hector Martin
 <marcan@marcan.st>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon
 Glass <sjg@chromium.org>, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
Message-ID: <20240130140123.445f368a@donnerap.manchester.arm.com>
In-Reply-To: <20231209181057.331815-1-i@shantur.com>
References: <20231209181057.331815-1-i@shantur.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/hH9=d=rTq_=c4u/V_ZJIwlB"
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

--MP_/hH9=d=rTq_=c4u/V_ZJIwlB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat,  9 Dec 2023 18:10:56 +0000
Shantur Rathore <i@shantur.com> wrote:

Hi,

> Currently when a hub is turned on, all the ports are powered on.
> This works well for hubs which have individual power control.
> 
> For the hubs without individual power control this has no effect.
> Mostly in these scenarios the hub port is powered before the USB
> controller is enabled, this can lead to some devices in unexpected
> state.
> 
> With this patch, we explicitly reset the port while powering up hub
> This resets the port for hubs without port power control and has
> no effect on hubs with port power control as the port is still off.
> 
> Before this patch AMicro AM8180 based NVME to USB adapter won't be
> detected as a USB3.0 Mass Storage device but with this it works as
> expected.
> 
> Tested working after this patch:
> 1. AMicro AM8180 based NVME to USB Adapter
> 2. Kingston DataTraveler 3.0
> 3. GenesysLogic USB3.0 Hub
> 
> The drives were tested while connected directly and via the hub.

so this broke USB operation on some Allwinner boards. The ports still
enumerate correctly, but no devices are detected. With mainline
(containing this patch), and a USB stick connected:
starting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... 1 USB Device(s) found
scanning bus usb@5200400 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found

With this patch here reverted:
starting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... 2 USB Device(s) found
scanning bus usb@5200400 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found

I have no clue why this happens, there is no discrete hub anywhere in this
setup, so I guess the code runs for the root hub here?
I am attaching a log with DEBUG enabled for common/usb_hub.c, for both
cases.

Any clues, debug suggestions, or even a fix are warmly welcome.

Cheers,
Andre


> ---
> 
> Changes in v3:
> - Split up patches as seperate series
> 
> Changes in v2:
> - As requested, added fix for regulator-always-on in RockPro64
> 
>  common/usb_hub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_hub.c b/common/usb_hub.c
> index 70279f301d..3fb7e14d10 100644
> --- a/common/usb_hub.c
> +++ b/common/usb_hub.c
> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device *hub)
>  
>  	debug("enabling power on all ports\n");
>  	for (i = 0; i < dev->maxchild; i++) {
> +		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> +		debug("Reset : port %d returns %lX\n", i + 1, dev->status);
>  		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
> -		debug("port %d returns %lX\n", i + 1, dev->status);
> +		debug("PowerOn : port %d returns %lX\n", i + 1, dev->status);
>  	}
>  
>  #ifdef CONFIG_SANDBOX


--MP_/hH9=d=rTq_=c4u/V_ZJIwlB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=opi_zero3_usb_reverted.txt

U-Boot 2024.04-rc1 (Jan 30 2024 - 13:32:13 +0000) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  4 GiB
Core:  56 devices, 24 uclasses, devicetree: separate
WDT:   Not starting watchdog@30090a0
MMC:   mmc@4020000: 0
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1... 
In:    serial@5000000
Out:   serial@5000000
Err:   serial@5000000
Net:   eth0: ethernet@5020000
starting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... usb_hub_post_probe
1 ports detected
ganged power switching
standalone hub
global over-current protection
Single TT
TT requires at most 8 FS bit times (666 ns)
power on to power good time: 20ms
hub controller current requirement: 0mA
port 1 is removable
get_hub_status returned status 1, change 1
local power source is lost (inactive)
no over-current condition exists
enabling power on all ports
port 1 returns 0
pgood_delay=20ms
devnum=1 poweron: query_delay=100 connect_timeout=1100
Port 1 Status 500 Change 0
<repeated 469 times>
Port 1 Status 100 Change 0
devnum=1 port=1: timeout
1 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found
Hit any key to stop autoboot:  2

--MP_/hH9=d=rTq_=c4u/V_ZJIwlB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=opi_zero3_usb_mainline.txt

U-Boot 2024.04-rc1 (Jan 30 2024 - 13:24:42 +0000) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  4 GiB
Core:  56 devices, 24 uclasses, devicetree: separate
WDT:   Not starting watchdog@30090a0
MMC:   mmc@4020000: 0
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1... 
In:    serial@5000000
Out:   serial@5000000
Err:   serial@5000000
Net:   eth0: ethernet@5020000
starting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... usb_hub_post_probe
1 ports detected
ganged power switching
standalone hub
global over-current protection
Single TT
TT requires at most 8 FS bit times (666 ns)
power on to power good time: 20ms
hub controller current requirement: 0mA
port 1 is removable
get_hub_status returned status 1, change 1
local power source is lost (inactive)
no over-current condition exists
enabling power on all ports
Reset : port 1 returns 0
PowerOn : port 1 returns 0
pgood_delay=20ms
devnum=1 poweron: query_delay=100 connect_timeout=1100
Port 1 Status 500 Change 11
port 1 reset change
devnum=1 port=1: USB dev found
portstatus 500, change 1, 480 Mb/s
usb_disconnect(&hub->children[port]);
1 USB Device(s) found
scanning bus usb@5200400 for devices... usb_hub_post_probe
1 ports detected
ganged power switching
standalone hub
no over-current protection
power on to power good time: 4ms
hub controller current requirement: 0mA
port 1 is removable
get_hub_status returned status 0, change 0
local power source is good
no over-current condition exists
enabling power on all ports
Reset : port 1 returns 0
PowerOn : port 1 returns 0
pgood_delay=4ms
devnum=1 poweron: query_delay=100 connect_timeout=1100
Port 1 Status 100 Change 0
<repeated 411 times>
Port 1 Status 100 Change 0
devnum=1 port=1: timeout
1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  2

--MP_/hH9=d=rTq_=c4u/V_ZJIwlB--
