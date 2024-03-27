Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD114C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385CE8804C;
	Thu, 28 Mar 2024 00:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mlKueNSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C7F788060; Thu, 28 Mar 2024 00:37:12 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1644B83348
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi
 [81.175.209.231])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B2E33505;
 Thu, 28 Mar 2024 00:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1711582596;
 bh=ABLEQY7j398eU7ZTN2zEdxUEbepi1sBVMazP28fEj1U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mlKueNSopfQUMgLW6LzLPKzi/EERI8EJynhKYcFO3futWs8EpbYvwOhVgc/7ndxln
 INYaRPnr2oC2M2T7AF7RmSmsPa63gb6P5GWow0RtYlkEY0ScGg1+GXW9CpvdWsOGCW
 xdRUYitwRb7sKJ27Dbqvi/8KfGgUQtCz5Ryhu3C8=
Date: Thu, 28 Mar 2024 01:37:00 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Peter Robinson <pbrobinson@gmail.com>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Naushir Patuck <naush@raspberrypi.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Ray Jui <rjui@broadcom.com>, Rob Herring <robh@kernel.org>,
 Scott Branden <sbranden@broadcom.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 0/3] dt-bindings: arm: bcm:
 raspberrypi,bcm2835-firmware: Drive-by fixes
Message-ID: <20240327233700.GA21080@pendragon.ideasonboard.com>
References: <20240326195807.15163-1-laurent.pinchart@ideasonboard.com>
 <b044eec1-ae64-4de7-9ab0-e3fe756131ef@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b044eec1-ae64-4de7-9ab0-e3fe756131ef@gmx.net>
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

On Wed, Mar 27, 2024 at 07:49:38AM +0100, Stefan Wahren wrote:
> Hi,
> 
> [add Peter and Ivan]
> 
> Am 26.03.24 um 20:58 schrieb Laurent Pinchart:
> > Hello,
> >
> > This small series includes a few drive-by fixes for DT validation
> > errors.
> >
> > The first patch has been posted previously in v1 ([1], and now addresses
> > a small review comment. I think it's good to go.
> >
> > The next two patches address the same issue as "[PATCH 1/2] dt-bindings:
> > arm: bcm: raspberrypi,bcm2835-firmware: Add missing properties" ([2]),
> > but this time with a (hopefully) correct approach. Patch 2/3 starts by
> > fixing the raspberrypi-bcm2835-firmware driver, removing the need for DT
> > properties that are specified in bcm2835-rpi.dtsi but not documented in
> > the corresponding bindings. Patch 3/3 can then drop those properties,
> > getting rid of the warnings.
>
> since this series drops properties from the device tree, does anyone
> have the chance to test it with a recent U-Boot?

I don't have U-Boot running with my RPi, so I would appreciate if
someone could help :-)

> > [1] https://lore.kernel.org/linux-arm-kernel/20240326004902.17054-3-laurent.pinchart@ideasonboard.com/
> > [2] https://lore.kernel.org/linux-arm-kernel/20240326004902.17054-2-laurent.pinchart@ideasonboard.com/
> >
> > Laurent Pinchart (3):
> >    dt-bindings: arm: bcm: raspberrypi,bcm2835-firmware: Add gpio child
> >      node
> >    firmware: raspberrypi: Use correct device for DMA mappings
> >    ARM: dts: bcm283x: Drop unneeded properties in the bcm2835-firmware
> >      node
> >
> >   .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 30 +++++++++++++++++++
> >   .../gpio/raspberrypi,firmware-gpio.txt        | 30 -------------------
> >   arch/arm/boot/dts/broadcom/bcm2835-rpi.dtsi   |  4 ---
> >   drivers/firmware/raspberrypi.c                |  7 +++--
> >   4 files changed, 34 insertions(+), 37 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt
> >

-- 
Regards,

Laurent Pinchart
