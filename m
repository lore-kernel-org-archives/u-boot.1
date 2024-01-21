Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CDEC47258
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 01:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE4E87831;
	Sun, 21 Jan 2024 02:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140848783D; Sun, 21 Jan 2024 02:16:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F3FA48782C
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 02:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17DD0DA7;
 Sat, 20 Jan 2024 17:17:01 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C819E3F73F;
 Sat, 20 Jan 2024 17:16:14 -0800 (PST)
Date: Sun, 21 Jan 2024 01:15:28 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Chuanhong Guo <gch981213@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] sunxi: add defconfig for nanopi_duo2
Message-ID: <20240121011528.3fb06011@minigeek.lan>
In-Reply-To: <20231228052915.121433-1-gch981213@gmail.com>
References: <20231228052915.121433-1-gch981213@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Thu, 28 Dec 2023 13:29:15 +0800
Chuanhong Guo <gch981213@gmail.com> wrote:

Hi,

thanks for taking care and sending a patch!

> FriendlyElec NanoPi Duo2 is a tiny SBC with Allwinner H3 and
> Ampak AP6212 WiFi module. The device-tree for it is already
> available in u-boot source tree. Add a default config for it.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  configs/nanopi_duo2_defconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 configs/nanopi_duo2_defconfig
> 
> diff --git a/configs/nanopi_duo2_defconfig b/configs/nanopi_duo2_defconfig
> new file mode 100644
> index 0000000000..5a2069789f
> --- /dev/null
> +++ b/configs/nanopi_duo2_defconfig
> @@ -0,0 +1,11 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-nanopi-duo2"
> +CONFIG_SPL=y
> +CONFIG_MACH_SUN8I_H3=y
> +CONFIG_DRAM_CLK=408
> +# CONFIG_VIDEO_DE2 is not set
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_CONSOLE_MUX=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OHCI_HCD=y

Judging by the DT, this board has USB-OTG wired up correctly, so we
should enable it, by adding:
CONFIG_USB_MUSB_GADGET=y
This would allow access to USB Ethernet, fastboot or UMS devices, which
prove to be quite useful for U-Boot.

Cheers,
Andre
