Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AA6CD8C92
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC23484881;
	Tue,  9 Jun 2026 14:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q3XSvcno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A71848BC; Tue,  9 Jun 2026 14:53:24 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B938486D
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5aa68cd8dd3so5101286e87.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781009602; cv=none;
 d=google.com; s=arc-20240605;
 b=EV7/15HLbtn7MmuOvRD5cT5BB5ZFNFWjyCmgKA5Ur3qTpiUbvexAU0ifFCluKvXqMG
 qwzJux9+uIJsMfFQ2tWi3FKn/ccwZLHkpAuE6RQH5jNInUhe85qvZi4ssW6q9JReWk8x
 v+HXcwpF2XWxiDUBcgPbdvxoqfG/RbpWtXEVA5psgMr7R5XKasF1Xy4TvgSS9cqvb0L3
 bAcq3qgbWDdFmjRXM5RFi/SCfdrGOojKOrnp2Dr5oKlBB5xuZGx4Q/FbvCtZvmb3qGfJ
 pUQW0Qo+OR6u4UAGwA3O37KaI1kN5OjUHwcfVShbLzAkGw8vGC7uNTL8p8laNlI8KVHr
 b6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eziOUvVLKslsFubLs+IG6bVo/w3Fq5oK8PMi7IcRfy0=;
 fh=v2Ibus8PKyVYMnWPbfR2yFy/XfSUhw8LmLjhrRKpF88=;
 b=TK/fV7GUrmwUCkp6SvZiZGQOq5ZlZgOjJy4RWq5Sez5sT/R+8QFMEGfztO8jAm1sDf
 ytfGTHPc9Aci+lsqBz5RSpzi0glRVPCKBwNzn+cjIJAzYHRdUJlQSzWm6WveWOUfROU+
 p4OEtA2/DfRalTyZqMbODw0rZbfJJYAT/A5H3fdBHFowhVQEe2mzOjbYI6P3W31qphx2
 0/NQDmciSTJ6jzbXf8V3XmWBmQJHEHdL0wHSDhUD5iqvL0WM3JZD1O4YGI5SYN/9PTsH
 hyQbSnKN0nRTcMiAgnC+YCeWEGt9CQsvJcddXW3rY9+8tZuH4ZxmmvgrEMBhkSOmupFV
 +Y+w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781009602; x=1781614402; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eziOUvVLKslsFubLs+IG6bVo/w3Fq5oK8PMi7IcRfy0=;
 b=q3XSvcnoz0AzdyVpFio4El0nUarJYcxSD9WQS+ZWb5f8CMCJxh0CCI/mcSaqBXI8aZ
 FRh+Igohrpv9zcpMoWyANCtjw/+CIiXeLKGDuB5XgM6pv9/V55oG5tAFPb6C8A4f/nvu
 LmaamDhzWlZDi/a2Jajm19Ux1q21RPyxlOjCyOxTs+zRoQjtwZQzv0mCSQbUaelPaA3t
 m0+qojV6BBjzJVAVE09c4OlfCKT9ZbytGPPCx5EUs1NQQ+VOupCvZ3mbXdW0hpsNi46W
 o15n6D9G/7Bu0mResU2/iFpdcOZQGhZ0nhtUatJO0xxgt1uhZpA50/Zs5+2ObPTKtYXm
 omlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009602; x=1781614402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eziOUvVLKslsFubLs+IG6bVo/w3Fq5oK8PMi7IcRfy0=;
 b=M1TMwjbXWaBpFAhMtsv6woJU33UIZSzY6hUm372fDs8SpYWF/yoE5seZulyYd/Z8oL
 41iGCwkqqs8MFaV8vnLm85Rm7X/IGPMY7D6vFDTubn9Px1kzKG8dkKFvIS2MMk2lzQ8T
 sUXtBjQr/WO5yLjp8AEcc7Yud3PyIAyTxC/Iyaj68hsvvxu9mFvm3i419bVnUhAxzTyS
 uErM2nVa8M/AmqDdiAWVuA8H2pThZO6+l+BP/Qsee0d/2QvECzNYt9iS1yjxgBu5gkEG
 CW/GlI7bwq07nOYMJBvRdqO6YG4JW478Gb2ICSLr37BxL82a/SDs4cvC2ETYEfC1192i
 qd4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Z3wtho12mrDdIQTUKHWtL2GJtzkA2noRClYW041j+sm/GiPY5nh4rLBqU7Y8s+ddokM5JNDA=@lists.denx.de
X-Gm-Message-State: AOJu0YyY4ei9DpnHXe0A1nkzbk0cj5QmNCLvhYerKHTlhWTeBGRNHjgw
 A+tuTsAFulMTkkaVc+a00AE9gt+LSYjuke8NzYmzk3EVXhf7ZNIOYsMo8+/eVYkezoBljCms4DL
 22YfW73fgrPtItnmE7/cgSebojNJi9OY=
X-Gm-Gg: Acq92OH7KY+HEXAnMw/AjYvO82T6Jve1yokmTrK6dhmqLH38GMXYco+35VLBlR9sn+K
 7DTHbB8uMZxqZiYzsvZsGBB/0ao4Kem+o7WeCVtMZpPAF3BZQuXRFQ9CAtdcjihC3ehWdUaWwVp
 4ad6dru8O7x8knudV/WwYtSGPfHb2nxF1h2Gq724XGEESXDNP42BEEuP0si9YrdOk/LuotrtuTk
 i434IaaRtEuVmDDaZNX2t8EcU1bXI8ZnQTQoSExkZ+bykrKc3GVpx7nvKeB99lu9gScu+pIvkUU
 CEPxTcBmrtFE1fHR33tC3vzEWvs4qbn3XotKwKxf4vm/oAqErS2OCXNcQFBccw0viKtRDUoCZ3Y
 eODWJXVdL2XlyDLLk
X-Received: by 2002:a05:6512:3404:b0:5aa:6e86:55e1 with SMTP id
 2adb3069b0e04-5aa87b51ed7mr6619307e87.16.1781009601294; Tue, 09 Jun 2026
 05:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260525-devkit-v1-1-2d3e7549ee9e@sigxcpu.org>
In-Reply-To: <20260525-devkit-v1-1-2d3e7549ee9e@sigxcpu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 9 Jun 2026 09:53:08 -0300
X-Gm-Features: AVVi8Ccjb4t-7rUX90B-ymm9GvGR0AbRAzhwbZNnAcrVH-gMjiBQUtGSepb8CU4
Message-ID: <CAOMZO5DE19HBVk=L35doV0DshnkYZ38Zh0g_N30fHKKAdB1C9A@mail.gmail.com>
Subject: Re: [PATCH] board: purism: Add support for the Librem5 devkit
To: =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc: team@phosh.mobi, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Johan Jonker <jbx6244@gmail.com>, 
 Brian Sune <briansune@gmail.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, Manuel Traut <manut@mecka.net>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Alice Guo <alice.guo@nxp.com>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Paresh Bhagat <p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Guido,

On Mon, May 25, 2026 at 12:57=E2=80=AFPM Guido G=C3=BCnther <agx@sigxcpu.or=
g> wrote:

> +#define UART_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_FSEL1)
> +
> +#define WDOG_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
> +
> +#define UART1_TX IMX_GPIO_NR(5, 23)
> +#define UART1_RX IMX_GPIO_NR(5, 22)
> +
> +static const iomux_v3_cfg_t wdog_pads[] =3D {
> +       IMX8MQ_PAD_GPIO1_IO02__WDOG1_WDOG_B | MUX_PAD_CTRL(WDOG_PAD_CTRL)=
,
> +};
> +
> +static const iomux_v3_cfg_t uart_pads[] =3D {
> +       IMX8MQ_PAD_UART1_RXD__UART1_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
> +       IMX8MQ_PAD_UART1_TXD__UART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
> +};
> +
> +int board_early_init_f(void)
> +{
> +       struct wdog_regs *wdog =3D (struct wdog_regs *)WDOG1_BASE_ADDR;
> +
> +       imx_iomux_v3_setup_multiple_pads(wdog_pads, ARRAY_SIZE(wdog_pads)=
);
> +       set_wdog_reset(wdog);
> +
> +       imx_iomux_v3_setup_multiple_pads(uart_pads, ARRAY_SIZE(uart_pads)=
);
> +
> +       return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_FEC_MXC)
> +#define FEC_RST_PAD IMX_GPIO_NR(1, 9)
> +static const iomux_v3_cfg_t fec1_rst_pads[] =3D {
> +       IMX8MQ_PAD_GPIO1_IO09__GPIO1_IO9 | MUX_PAD_CTRL(NO_PAD_CTRL),
> +       IMX8MQ_PAD_GPIO1_IO15__CCM_CLKO2 | MUX_PAD_CTRL(0x1F),
> +};
> +
> +static void setup_iomux_fec(void)
> +{
> +       imx_iomux_v3_setup_multiple_pads(fec1_rst_pads,
> +                                        ARRAY_SIZE(fec1_rst_pads));
> +
> +       gpio_request(FEC_RST_PAD, "fec1_rst");
> +       gpio_direction_output(FEC_RST_PAD, 0);
> +       udelay(500);
> +       gpio_direction_output(FEC_RST_PAD, 1);
> +}
> +
> +static int setup_fec(void)
> +{
> +       setup_iomux_fec();
> +
> +       /* Use 125M anatop REF_CLK1 for ENET1, not from external */
> +       clrsetbits_le32(IOMUXC_GPR_BASE_ADDR + 0x04, BIT(13) | BIT(17), 0=
);
> +       return set_clk_enet(ENET_125MHZ);
> +}
> +
> +int board_phy_config(struct phy_device *phydev)
> +{
> +       /* enable rgmii rxc skew and phy mode select to RGMII copper */
> +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x1f);
> +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x8);
> +
> +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x05);
> +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x100);
> +
> +       if (phydev->drv->config)
> +               phydev->drv->config(phydev);
> +       return 0;
> +}
> +#endif

The UART, watchdog, and Ethernet PHY C code above could be removed,
since we're using DM, right?

> +int board_init(void)
> +{
> +       if (IS_ENABLED(CONFIG_USB_DWC3) || IS_ENABLED(CONFIG_USB_XHCI_DWC=
3))
> +               init_usb_clk();
> +
> +       if (IS_ENABLED(CONFIG_FEC_MXC))
> +               setup_fec();
> +
> +       return 0;

Can board_init() be removed?

> --- /dev/null
> +++ b/board/purism/librem5-devkit/librem5-devkit.env
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +
> +boot_fdt=3Dtry

boot_fdt was used long ago, when we supported both DT and non-DT cases.

boot_fdt is no longer needed, as we always boot DT, so it can be removed.

> +boot_targets=3Dmmc0 dhcp
> +bootm_size=3D0x10000000
> +console=3Dttymxc0,115200
> +fdt_addr_r=3D0x43000000
> +fdtfile=3DDEFAULT_FDT_FILE
> +initrd_addr=3D0x43800000
> +image=3DImage
> +kernel_addr_r=3DCONFIG_SYS_LOAD_ADDR
> +loadaddr=3DCONFIG_SYS_LOAD_ADDR
> +mmcautodetect=3Dyes
> +mmcdev=3DCONFIG_ENV_MMC_DEVICE_INDEX
> +mmcpart=3D1
> +mmcroot=3D/dev/mmcblk0p1
> +scriptaddr=3DCONFIG_SYS_LOAD_ADDR
> +mmcargs=3Dsetenv bootargs console=3D${console} root=3D${mmcroot} rootwai=
t rw
> +loadimage=3Dfatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
> +loadfdt=3Dfatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}

Use the generic load command instead of fatload.

> diff --git a/doc/board/purism/index.rst b/doc/board/purism/index.rst
> index a9cdc312d46..0225aa7f3aa 100644
> --- a/doc/board/purism/index.rst
> +++ b/doc/board/purism/index.rst

> +Get and Build the ARM Trusted firmware
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get ATF from: https://source.puri.sm/Librem5/arm-trusted-firmware

Can't the mainline ATF be used instead?
