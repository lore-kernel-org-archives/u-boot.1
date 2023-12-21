Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC39C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 13:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8918783B;
	Thu, 21 Dec 2023 14:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=agner.ch header.i=@agner.ch header.b="ydbs4iYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7044876B4; Thu, 21 Dec 2023 14:42:30 +0100 (CET)
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B45E8784F
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 14:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=stefan@agner.ch
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id C62745CA23F;
 Thu, 21 Dec 2023 14:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1703166147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MMvlsXdkX3y2Asa4O+hbjN0X2Ggxcl4QEyMTWmgWrU=;
 b=ydbs4iYKxbeE3DA/t55golB5kvwGIXZux6ek+MPsYPQoJe8qjVi/zSaxgfj9cVl4Du1FxJ
 6xGqGzkYBDAqb7+dCtnDoWfrrdvA9Ewxzhg73AT6McJMcBVWAujBw2t1rWYHRrBLduZnsc
 tbUSlC98NrxWaLjx3uPqIqUQe8f64k8=
MIME-Version: 1.0
Date: Thu, 21 Dec 2023 14:42:27 +0100
From: Stefan Agner <stefan@agner.ch>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson
 <pbrobinson@gmail.com>, Dmitry Malkin <dmitry@bedrocksystems.com>, Thomas
 Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/7] rpi5: initial support
In-Reply-To: <20231218210341.30073-1-iivanov@suse.de>
References: <20231218210341.30073-1-iivanov@suse.de>
Message-ID: <1cfe50401b3c4fe72064b9bd611e2347@agner.ch>
X-Sender: stefan@agner.ch
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

Hi Ivan,

On 2023-12-18 22:03, Ivan T. Ivanov wrote:
> Hi,
> 
> These patches are adding basic support for RPi5.
> They are based on v2 series from Dmitry Malkin[1].
> 
> With them I am able to _start_ current openSUSE
> Tumbleweed without modification. They are still
> a lot of things to be added to the upstream Linux
> before it runs flawlessly on this device, but at
> least in U-Booot SD controller used for uSD card
> and Frameboffer and HDMI0 devices are working fine
> now. It seems that PCIe controller is working fine
> too, but I have not tested it too much.

Thank you very much for this work!

> 
> Serial console and reset are also functional.

I've applied the patchset to v2024.01-rc5 and built the
rpi_arm64_defconfig target. I added enable_uart=1 and kernel=u-boot.bin
to config.txt. While I see a brief U-Boot logo on HDMI, I haven't gotten
anything on the serial console on pin 8/10 of the Raspberry Pi pin
header. Is there anything specific needed to get the console going?

--
Stefan

> 
> Hopefully this will help others add missing pieces
> more easily.
> 
> Happy hacking!
> 
> Regards,
> Ivan
> 
> [1] https://lore.kernel.org/all/CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com/
> 
> Dmitry Malkin (2):
>   rpi5: add initial memory map for bcm2712
>   rpi5: Use devicetree as alternative way to read IO base addresses
> 
> Ivan T. Ivanov (5):
>   rpi5: Use devicetree to retrieve board revision
>   bcm2835: brcm,bcm2708-fb device is using r5g6b5 format
>   mmc: bcmstb: Add support for bcm2712 SD controller
>   configs: rpi_arm64: enable SDHCI BCMSTB driver
>   pci: pcie-brcmstb: Add bcm2712 PCIe controller support
> 
>  arch/arm/mach-bcm283x/include/mach/base.h  |   5 +-
>  arch/arm/mach-bcm283x/include/mach/mbox.h  |   3 +-
>  arch/arm/mach-bcm283x/include/mach/sdhci.h |   3 +-
>  arch/arm/mach-bcm283x/include/mach/timer.h |   3 +-
>  arch/arm/mach-bcm283x/include/mach/wdog.h  |   3 +-
>  arch/arm/mach-bcm283x/init.c               |  81 ++++++++--
>  board/raspberrypi/rpi/rpi.c                |  22 ++-
>  configs/rpi_arm64_defconfig                |   1 +
>  drivers/mmc/bcmstb_sdhci.c                 | 173 ++++++++++++++++++++-
>  drivers/pci/pcie_brcmstb.c                 |  23 ++-
>  drivers/video/bcm2835.c                    |  10 +-
>  11 files changed, 296 insertions(+), 31 deletions(-)
