Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFFAE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B9C880381;
	Fri,  3 Jan 2025 07:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD5D8042A; Fri,  3 Jan 2025 07:48:00 +0100 (CET)
Received: from lisa.dawes.za.net (lisa.dawes.za.net [178.63.77.189])
 by phobos.denx.de (Postfix) with ESMTP id AE1BD8036D
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lists@dawes.za.net
Received: by lisa.dawes.za.net (Postfix, from userid 1000)
 id 5E8C314023F; Fri,  3 Jan 2025 08:47:57 +0200 (SAST)
Date: Fri, 3 Jan 2025 08:47:57 +0200
From: Rogan Dawes <lists@dawes.za.net>
To: u-boot@lists.denx.de
Subject: Re: MUSB compile failure for imx28
Message-ID: <20250103064757.GA22475@lisa.dawes.za.net>
References: <20250102092305.GA18027@lisa.dawes.za.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102092305.GA18027@lisa.dawes.za.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Thu, Jan 02, 2025 at 11:23:05AM +0200, Rogan Dawes wrote:
> Hi folks,
> 
> I am trying to get a modern u-boot running on my Wink Hub v1 (Hi Fabio!
> :-)
> 
> One of the features I am trying to enable is ultimately usbacm console,
> but in the process of trying to get there, I first tried enabling MUSB.
> 
> diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
> index fdab7ef73e5..8185c7e0d5a 100644
> --- a/configs/mx28evk_defconfig
> +++ b/configs/mx28evk_defconfig
> @@ -70,3 +70,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
>  CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
>  CONFIG_CI_UDC=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_MUSB_GADGET=y

* snipped compile errors *

> Any ideas on how to fix this?

Turns out the problem was failure to include:

CONFIG_USB_MUSB_PIO_ONLY=y

in the defconfig file. Would it make sense for this to be a
configuration error with a suitable error message when enabled without
this option?

I also had to remove the CONFIG_CI_UDC option, as it was the incorrect
UDC driver, and resulted in duplicate symbols being defined.

> P.S. For what it is worth, I seem to have destroyed the console UART on
> my hardware, which is why I am trying to enable USB Gadget console. It
> also means that I am unable to provide any console logs from an actual
> running device. I do have another on the way, but right now, I'm
> actually trying to use the flash chip on my Hub 1 to hold an image read
> from the Hub 2, mount the various filesystems, and create a file that
> will enable a console on the Hub 2, which is otherwise locked down with
> HABv4!

Unfortunately, while I can get it to compile now, I still don't get any
new USB activity once I load it with snagrecover:

$ cat wink.yaml
flash-bin:
  path: u-boot.sb
$ snagrecover -s imx28 -f wink.yaml
2025-01-02 14:04:50,577 [INFO] Starting recovery of imx28 board
2025-01-02 14:04:50,637 [INFO] HID device 1-2 has hidraw dev /dev/hidraw1
2025-01-02 14:04:50,637 [INFO] Finished initializing HID device {pretty_addr}
2025-01-02 14:04:50,638 [INFO] Installing firmware flash-bin
2025-01-02 14:04:50,638 [INFO] Subfirmware: spl-sdps
2025-01-02 14:04:50,639 [INFO] SDPS write with parameters size:0xa3910 offset:0x00
2025-01-02 14:04:50,830 [INFO] Done installing firmware flash-bin
2025-01-02 14:04:50,830 [INFO] Done recovering imx28 board
2025-01-02 14:04:50,830 [INFO] Done recovering imx28 board

I did add the following entries, trying to match a similar config that
worked for an OrangePi R1 I was using to confirm the concept:

CONFIG_USB_FUNCTION_ACM=y
CONFIG_USB_TTY=y
CONFIG_CONSOLE_MUX=y
CONFIG_USE_PREBOOT=y
CONFIG_PREBOOT="setenv stderr serial,usbacm; setenv stdout serial,usbacm; setenv stdin serial,usbacm"

This results in the OrangePi R1 enumerating as a new CDC-ACM device once
it has booted and executed the PREBOOT command. Unfortunately, I don't
get a similar result from the Wink Hub. And without the console UART,
it's really difficult to debug what is going wrong :-(

Does anyone have an i.MX28 target that they might be able to use to
confirm the basic configuration works? Many thanks!

Regards,

Rogan

