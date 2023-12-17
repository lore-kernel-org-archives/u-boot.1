Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A79BC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 13:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9670B87713;
	Sun, 17 Dec 2023 14:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ixypsilon.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ixypsilon.net header.i=@ixypsilon.net header.b="mNsMK5YQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C59E487727; Sun, 17 Dec 2023 12:40:58 +0100 (CET)
Received: from uvw.ixypsilon.net (uvw.ixypsilon.net [81.223.58.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7971F87702
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 12:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ixypsilon.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.nagy@ixypsilon.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ixypsilon.net; s=20210903; h=Content-Transfer-Encoding:MIME-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o7+jyzuP9R0qdA/35pcL5ajv29csKgaHgXwA05p/Mq4=; t=1702813256; x=1704022856; 
 b=mNsMK5YQJWdtcQXWMjXR05Ylbmdzgi0Me0hZ5tgl0oFjZgVZLpJk/2G6kTsPfDuMfDN/pWlSWGG
 aVvVPGewu8tw9qBNWjJgVcF8dPy4kr4RhzEgMqJ33PUUY/y+ZaxG1XwYHIiHR0V9NP7Ko+w8fc/2d
 gsZMMi7ZtCOP+4kkvqaZNpRuJSTlLyLHWdnHTMJSIbkZeIP+hJBfQEWweaxLsdSqt9185WXFT38hl
 5SPWpHotMz8OLUv62J/TaONB/snaurizadM/SPr84GCvKsVM80N+eoDmi+xtYUPXHoIjHJRAcREE8
 06LSe95ipfRhGnRxdK48+4i36InYNhw7Za6A==;
Received: from [192.168.0.1] (helo=[192.168.0.12])
 by uvw.ixypsilon.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <stefan.nagy@ixypsilon.net>) id 1rEpVs-0001Ni-2e;
 Sun, 17 Dec 2023 12:40:54 +0100
Message-ID: <00759158bcb2b4fa3cb037d571949459bfc3487a.camel@ixypsilon.net>
Subject: Re: [PATCH] rock-pi-4: Enable SPI flash
From: Stefan Nagy <stefan.nagy@ixypsilon.net>
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Date: Sun, 17 Dec 2023 12:40:53 +0100
In-Reply-To: <8bf532f00e9713b410ebb0d80d765357@manjaro.org>
References: <20231215140015.13671-1-stefan.nagy@ixypsilon.net>
 <8bf532f00e9713b410ebb0d80d765357@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Mailman-Approved-At: Sun, 17 Dec 2023 14:02:58 +0100
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

Am Freitag, dem 15.12.2023 um 19:26 +0100 schrieb Dragan Simic:
> On 2023-12-15 15:00, Stefan Nagy wrote:
> > The ROCK Pi 4A/B/C boards come with a 32 Mbit SPI NOR flash chip
> > (XTX Technology Limited XT25F32).
> > 
> > Sync the devicetrees from Linux to enable spi1 and add a device
> > node for the NOR flash chip. In the board's defconfig files enable
> > the Rockchip SPI driver, add XTX SPI flash support and set the
> > SPI flash default bus identifier.
> > 
> > This patch has been tested on ROCK Pi 4A.
> > 
> > Signed-off-by: Stefan Nagy <stefan.nagy@ixypsilon.net>
> > ---
> >  arch/arm/dts/rk3399-rock-pi-4a.dts  | 10 ++++++++++
> >  arch/arm/dts/rk3399-rock-pi-4c.dts  | 10 ++++++++++
> >  configs/rock-pi-4-rk3399_defconfig  |  3 +++
> >  configs/rock-pi-4c-rk3399_defconfig |  3 +++
> >  4 files changed, 26 insertions(+)
> > 
> > diff --git a/arch/arm/dts/rk3399-rock-pi-4a.dts
> > b/arch/arm/dts/rk3399-rock-pi-4a.dts
> > index 931334aa..d5df8939 100644
> > --- a/arch/arm/dts/rk3399-rock-pi-4a.dts
> > +++ b/arch/arm/dts/rk3399-rock-pi-4a.dts
> > @@ -12,3 +12,13 @@
> >         model = "Radxa ROCK Pi 4A";
> >         compatible = "radxa,rockpi4a", "radxa,rockpi4",
> > "rockchip,rk3399";
> >  };
> > +
> > +&spi1 {
> > +       status = "okay";
> > +
> > +       flash@0 {
> > +               compatible = "jedec,spi-nor";
> > +               reg = <0>;
> > +               spi-max-frequency = <10000000>;
> > +       };
> > +};
> > diff --git a/arch/arm/dts/rk3399-rock-pi-4c.dts
> > b/arch/arm/dts/rk3399-rock-pi-4c.dts
> > index d32efab7..de2ebe4c 100644
> > --- a/arch/arm/dts/rk3399-rock-pi-4c.dts
> > +++ b/arch/arm/dts/rk3399-rock-pi-4c.dts
> > @@ -43,6 +43,16 @@
> >         hp-det-gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> >  };
> > 
> > +&spi1 {
> > +       status = "okay";
> > +
> > +       flash@0 {
> > +               compatible = "jedec,spi-nor";
> > +               reg = <0>;
> > +               spi-max-frequency = <10000000>;
> > +       };
> > +};
> > +
> >  &uart0 {
> >         status = "okay";
> > 
> > diff --git a/configs/rock-pi-4-rk3399_defconfig
> > b/configs/rock-pi-4-rk3399_defconfig
> > index 84e0dcf0..c45a8c04 100644
> > --- a/configs/rock-pi-4-rk3399_defconfig
> > +++ b/configs/rock-pi-4-rk3399_defconfig
> > @@ -61,6 +61,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
> >  CONFIG_MMC_SDHCI=y
> >  CONFIG_MMC_SDHCI_SDMA=y
> >  CONFIG_MMC_SDHCI_ROCKCHIP=y
> > +CONFIG_SF_DEFAULT_BUS=1
> > +CONFIG_SPI_FLASH_XTX=y
> >  CONFIG_ETH_DESIGNWARE=y
> >  CONFIG_GMAC_ROCKCHIP=y
> >  CONFIG_NVME_PCI=y
> > @@ -74,6 +76,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
> >  CONFIG_BAUDRATE=1500000
> >  CONFIG_DEBUG_UART_SHIFT=2
> >  CONFIG_SYS_NS16550_MEM32=y
> > +CONFIG_ROCKCHIP_SPI=y
> >  CONFIG_SYSRESET=y
> >  CONFIG_USB=y
> >  CONFIG_USB_XHCI_HCD=y
> > diff --git a/configs/rock-pi-4c-rk3399_defconfig
> > b/configs/rock-pi-4c-rk3399_defconfig
> > index 5c9fb147..1ca19b4e 100644
> > --- a/configs/rock-pi-4c-rk3399_defconfig
> > +++ b/configs/rock-pi-4c-rk3399_defconfig
> > @@ -58,6 +58,8 @@ CONFIG_MMC_DW=y
> >  CONFIG_MMC_DW_ROCKCHIP=y
> >  CONFIG_MMC_SDHCI=y
> >  CONFIG_MMC_SDHCI_ROCKCHIP=y
> > +CONFIG_SF_DEFAULT_BUS=1
> > +CONFIG_SPI_FLASH_XTX=y
> >  CONFIG_ETH_DESIGNWARE=y
> >  CONFIG_GMAC_ROCKCHIP=y
> >  CONFIG_NVME_PCI=y
> > @@ -71,6 +73,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
> >  CONFIG_BAUDRATE=1500000
> >  CONFIG_DEBUG_UART_SHIFT=2
> >  CONFIG_SYS_NS16550_MEM32=y
> > +CONFIG_ROCKCHIP_SPI=y
> >  CONFIG_SYSRESET=y
> >  CONFIG_USB=y
> >  CONFIG_USB_XHCI_HCD=y
> 
> Perhaps it would be better to wait a bit until your patch for the
> Linux 
> kernel [1] is accepted, and then have the updated spi-max-frequency 
> values synced back to U-Boot in the v2 of this patch.
> 
> [1] 
> https://lore.kernel.org/linux-rockchip/4fce0de996d6cc3056d972cd3fc3fb93@manjaro.org/T/#m0621f671c597a4c0138b27bfc6fa3a16f82b721f

Yes, you are right. I'll try to be a bit more patient and send a v2 of
this as soon as my patch for the kernel is accepted.

