Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404AACD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 17:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC8A8484A;
	Fri, 12 Jun 2026 19:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="dnQAawhu";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="kgIF9QNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 567C6839A8; Fri, 12 Jun 2026 16:29:33 +0200 (CEST)
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFAD484704
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 16:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=agx@sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1781274568; bh=nbxdza4RAO8hfn8mIsLNrenzm8Bkl6Q/haKZLmbhVhc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dnQAawhuot3knnfaaRztACa2wMqDJWt+DRCy+GCJUBNWQfNwsw7v0Lmhnjv/aX6k0
 zxGKtyn0ke4kx0yGyYoguegtMyDWjkJxjjaXD3UiTRMgtnVMy1Ex+DVDT03Zll0qLV
 VJkIxxsjHBl5leQejysL82q8ERH6vEI7HGguZWxn1j5QRJccEIsrcihzfLVzvmCQAP
 Yn4Lo/hfAAkMWp7x6i/IEN2a+lnmeHsYDXn0vFgUT6NqneL+ZXs3n7c6NimQs+39jG
 7Et53yObbgcLP0vq2N99yTqvOLhNvGkkRfnDtKcYtFVWj1KmzGH8tDYyUjdvGHgna5
 vZIScriQSPwOA==
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 2BA8CFB03;
 Fri, 12 Jun 2026 16:29:28 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2q4XxbAEd4hY; Fri, 12 Jun 2026 16:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1781274565; bh=nbxdza4RAO8hfn8mIsLNrenzm8Bkl6Q/haKZLmbhVhc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kgIF9QNBZArTwudJRYFoxu8fjs8gw8EfUOPI5v/t6+eOQrOSHinbjZFmEMrfCy4jA
 u5c2hw8lVPT6cm0btWB943XnHxc757DaYYzWqJG6YQnMu3mh36t4VCtP8qgnpPYnXA
 rN4KB56Nj4Meqxw03EY6pMTUoNHuC5RQUzl3iWv8+mgZvAPXk+pkzuy6f6oJEDRx6+
 Kpj/0TrxWFDdHXcC/Yx/DkBLOQodbrfrCyftHQhTrmqc6yA1VuCEJL8cw7VoBUFM60
 e1VccYFEm7MUE6+6XpIL6mo5w70WMx0tJDKjNB3nfAaQMafsb1vAzwfzM6KfZKV7DA
 Cxr5h6IyxD+IQ==
Date: Fri, 12 Jun 2026 16:29:23 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: team@phosh.mobi, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Angus Ainslie <angus@akkea.ca>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Paul Kocialkowski <contact@paulk.fr>,
 Manuel Traut <manut@mecka.net>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Alice Guo <alice.guo@nxp.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paresh Bhagat <p-bhagat@ti.com>
Subject: Re: [PATCH] board: purism: Add support for the Librem5 devkit
Message-ID: <aiwXw66lHTiMZvEL@quark2.heme.sigxcpu.org>
References: <20260525-devkit-v1-1-2d3e7549ee9e@sigxcpu.org>
 <CAOMZO5DE19HBVk=L35doV0DshnkYZ38Zh0g_N30fHKKAdB1C9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5DE19HBVk=L35doV0DshnkYZ38Zh0g_N30fHKKAdB1C9A@mail.gmail.com>
X-Mailman-Approved-At: Fri, 12 Jun 2026 19:22:35 +0200
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

Hi Fabio,

On Tue, Jun 09, 2026 at 09:53:08AM -0300, Fabio Estevam wrote:
> Hi Guido,
> 
> On Mon, May 25, 2026 at 12:57 PM Guido Günther <agx@sigxcpu.org> wrote:
> 
> > +#define UART_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_FSEL1)
> > +
> > +#define WDOG_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
> > +
> > +#define UART1_TX IMX_GPIO_NR(5, 23)
> > +#define UART1_RX IMX_GPIO_NR(5, 22)
> > +
> > +static const iomux_v3_cfg_t wdog_pads[] = {
> > +       IMX8MQ_PAD_GPIO1_IO02__WDOG1_WDOG_B | MUX_PAD_CTRL(WDOG_PAD_CTRL),
> > +};
> > +
> > +static const iomux_v3_cfg_t uart_pads[] = {
> > +       IMX8MQ_PAD_UART1_RXD__UART1_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
> > +       IMX8MQ_PAD_UART1_TXD__UART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
> > +};
> > +
> > +int board_early_init_f(void)
> > +{
> > +       struct wdog_regs *wdog = (struct wdog_regs *)WDOG1_BASE_ADDR;
> > +
> > +       imx_iomux_v3_setup_multiple_pads(wdog_pads, ARRAY_SIZE(wdog_pads));
> > +       set_wdog_reset(wdog);
> > +
> > +       imx_iomux_v3_setup_multiple_pads(uart_pads, ARRAY_SIZE(uart_pads));
> > +
> > +       return 0;
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_FEC_MXC)
> > +#define FEC_RST_PAD IMX_GPIO_NR(1, 9)
> > +static const iomux_v3_cfg_t fec1_rst_pads[] = {
> > +       IMX8MQ_PAD_GPIO1_IO09__GPIO1_IO9 | MUX_PAD_CTRL(NO_PAD_CTRL),
> > +       IMX8MQ_PAD_GPIO1_IO15__CCM_CLKO2 | MUX_PAD_CTRL(0x1F),
> > +};
> > +
> > +static void setup_iomux_fec(void)
> > +{
> > +       imx_iomux_v3_setup_multiple_pads(fec1_rst_pads,
> > +                                        ARRAY_SIZE(fec1_rst_pads));
> > +
> > +       gpio_request(FEC_RST_PAD, "fec1_rst");
> > +       gpio_direction_output(FEC_RST_PAD, 0);
> > +       udelay(500);
> > +       gpio_direction_output(FEC_RST_PAD, 1);
> > +}
> > +
> > +static int setup_fec(void)
> > +{
> > +       setup_iomux_fec();
> > +
> > +       /* Use 125M anatop REF_CLK1 for ENET1, not from external */
> > +       clrsetbits_le32(IOMUXC_GPR_BASE_ADDR + 0x04, BIT(13) | BIT(17), 0);
> > +       return set_clk_enet(ENET_125MHZ);
> > +}
> > +
> > +int board_phy_config(struct phy_device *phydev)
> > +{
> > +       /* enable rgmii rxc skew and phy mode select to RGMII copper */
> > +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x1f);
> > +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x8);
> > +
> > +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x05);
> > +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x100);
> > +
> > +       if (phydev->drv->config)
> > +               phydev->drv->config(phydev);
> > +       return 0;
> > +}
> > +#endif
> 
> The UART, watchdog, and Ethernet PHY C code above could be removed,
> since we're using DM, right?

Dropped most of it. I needed to keep the board_phy_config to keep
ethernet working. I'm still fuzzy what exactly is needed with DT
and what not so happy to fix up things where needed.

> 
> > +int board_init(void)
> > +{
> > +       if (IS_ENABLED(CONFIG_USB_DWC3) || IS_ENABLED(CONFIG_USB_XHCI_DWC3))
> > +               init_usb_clk();
> > +
> > +       if (IS_ENABLED(CONFIG_FEC_MXC))
> > +               setup_fec();
> > +
> > +       return 0;
> 
> Can board_init() be removed?

It's an empty function now.

> 
> > --- /dev/null
> > +++ b/board/purism/librem5-devkit/librem5-devkit.env
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > +
> > +boot_fdt=try
> 
> boot_fdt was used long ago, when we supported both DT and non-DT cases.
> 
> boot_fdt is no longer needed, as we always boot DT, so it can be
> removed.

Dropped.

> 
> > +boot_targets=mmc0 dhcp
> > +bootm_size=0x10000000
> > +console=ttymxc0,115200
> > +fdt_addr_r=0x43000000
> > +fdtfile=DEFAULT_FDT_FILE
> > +initrd_addr=0x43800000
> > +image=Image
> > +kernel_addr_r=CONFIG_SYS_LOAD_ADDR
> > +loadaddr=CONFIG_SYS_LOAD_ADDR
> > +mmcautodetect=yes
> > +mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
> > +mmcpart=1
> > +mmcroot=/dev/mmcblk0p1
> > +scriptaddr=CONFIG_SYS_LOAD_ADDR
> > +mmcargs=setenv bootargs console=${console} root=${mmcroot} rootwait rw
> > +loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
> > +loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
> 
> Use the generic load command instead of fatload.

Changed and also switched to standard bootflow as mostly we want to use
efibootmgr anyway.

> 
> > diff --git a/doc/board/purism/index.rst b/doc/board/purism/index.rst
> > index a9cdc312d46..0225aa7f3aa 100644
> > --- a/doc/board/purism/index.rst
> > +++ b/doc/board/purism/index.rst
> 
> > +Get and Build the ARM Trusted firmware
> > +--------------------------------------
> > +
> > +Note: srctree is U-Boot source directory
> > +Get ATF from: https://source.puri.sm/Librem5/arm-trusted-firmware
> 
> Can't the mainline ATF be used instead?

I believe so. The devkit has the B0 revision which wasn't handled in ATF
back then but that seems to be there now. I wanted to switch to manline
ATF later (and we want to add OP-TEE too) once I'm sure things are
stable. So maybe that can be updated in a follow up?

Thanks for the review
 -- Guido
