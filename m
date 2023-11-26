Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44346C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 12:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1208387215;
	Sun, 26 Nov 2023 13:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=electricworry.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD72E87214; Sun, 26 Nov 2023 12:46:01 +0100 (CET)
Received: from work.electricworry.net (unknown
 [IPv6:2a02:c7c:b287:fe42:b9b:104:f505:b4db])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1ACE86F40
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 12:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=electricworry.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bob@electricworry.net
Received: from BOB1 (localhost [127.0.0.1])
 by work.electricworry.net (Postfix) with ESMTPS id 7D433D8932C;
 Sun, 26 Nov 2023 11:45:58 +0000 (GMT)
Date: Sun, 26 Nov 2023 11:45:55 +0000
From: Bob McChesney <bob@electricworry.net>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/3] sunxi: H616: Add OrangePi Zero 3 board support
Message-ID: <ZWMv816r8YxPwsJO@BOB1>
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
X-Mailman-Approved-At: Sun, 26 Nov 2023 13:18:51 +0100
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

On Sat, Nov 25, 2023 at 08:43:12PM +0300, Mikhail Kalashnikov wrote:
> Tested-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> On 14.11.2023 04:31, Andre Przywara wrote:
> > The OrangePi Zero 3 is a small development board featuring the Allwinner
> > H618 SoC, shipping with up to 4GB of DRAM, Gigabit Ethernet, a micro-HDMI
> > connector and two USB sockets.
> > The board uses LPDDR4 DRAM and an X-Powers AXP313a PMIC, support for
> > which was recently added to U-Boot.
> > 
> > Add a defconfig file selecting the right drivers and DRAM options.
> > Since the .dts file was synced from the Linux kernel repo already, we
> > just need to add one line to the Makefile to actually build the .dtb.
> > 
> > The DRAM parameters were derived from the values found in the BSP DRAM
> > drivers on the SPI NOR flash.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >   arch/arm/dts/Makefile            |  1 +
> >   board/sunxi/MAINTAINERS          |  5 +++++
> >   configs/orangepi_zero3_defconfig | 30 ++++++++++++++++++++++++++++++
> >   3 files changed, 36 insertions(+)
> >   create mode 100644 configs/orangepi_zero3_defconfig

Tested-by: Bob McChesney <bob@electricworry.net>

Am I ok to just tag onto Mikhail's email to add my tested tag? I've got
a 4GB Orange Pi Zero 3 and can confirm that it works, despite any
limitations that may be present.

Regards,
Bob

