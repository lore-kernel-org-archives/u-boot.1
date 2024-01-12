Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03BCC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 10:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 946368792D;
	Fri, 12 Jan 2024 11:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="deaPXx1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C939A879D3; Fri, 12 Jan 2024 11:47:19 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9552F8764D
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 11:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705056437;
 bh=T3QbnKcGXTpYLpzSwOj77HDW13IL2a9ojeNQ9kLvFw8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=deaPXx1evShx2XZpMe61JVW45+6W0agAzJ7+MQLg2NBC6OQBfgzth4dkm2pJLtX8q
 fW4RpAms2Rp+BnkTiZtMwlLXjKcpZTTVkYrhIHtfevQGmRA1nrh9NY+vj1TE5VpZ/L
 R4bZSb9b4TzMVTtXXpgSF37stT+YiDQABn4Zcim+oXBvVZ50jZAc1uS6ZYW4hTfuFR
 X2531zuTrtr7+w33m7NUr+eweFB6r1aJNLeRlaBY1kNE9SsfvvqHH0VqlC4MieuVOT
 N1gg7pPYRALM9LQA2Ri2i3p69HBiVi5y58prmluRN15/rDXG7ZByZ5GAla+hkjmKuG
 y2zxf8Y0YdHtg==
Received: from beast.luon.net (cola.collaboradmins.com
 [IPv6:2a01:4f8:1c1c:5717::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id DDF063781FED;
 Fri, 12 Jan 2024 10:47:16 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id 670AC9F06FA0; Fri, 12 Jan 2024 11:47:16 +0100 (CET)
Message-ID: <bb0ef3e2da9e4cafb074e2752548d9348f9b3c3c.camel@collabora.com>
Subject: Re: [PATCH v4 6/7] beagleplay: Add DFU support
From: Sjoerd Simons <sjoerd@collabora.com>
To: Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Nishanth Menon <nm@ti.com>, 
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Date: Fri, 12 Jan 2024 11:47:16 +0100
In-Reply-To: <f43b81c8-1886-4560-b8fe-dfa6a88ea726@kernel.org>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-7-sjoerd@collabora.com>
 <f43b81c8-1886-4560-b8fe-dfa6a88ea726@kernel.org>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
MIME-Version: 1.0
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

On Fri, 2024-01-12 at 12:41 +0200, Roger Quadros wrote:
>=20
>=20
> On 12/01/2024 10:52, Sjoerd Simons wrote:
> > DFU mode on a beagleplay can be used via the Type-C connector by
> > holding
> > the USR switch while powering on.
> >=20
> > Configuration is only added for the A53 u-boot parts, for R5 the
> > am62x_r5_usbdfu.config fragment should be used.
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> >=20
> > ---
> >=20
> > Changes in v4:
> > - New patch
> >=20
> > =C2=A0arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |=C2=A0 8 ++++++
> > =C2=A0board/beagle/beagleplay/beagleplay.env=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0configs/am62x_beagleplay_a53_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 30
> > ++++++++++++++++++++
> > =C2=A03 files changed, 39 insertions(+)
> >=20
> > diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> > b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> > index a723caa5805..0b1e5e70fe2 100644
> > --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> > @@ -61,6 +61,14 @@
> > =C2=A0	>;
> > =C2=A0};
> > =C2=A0
> > +&usbss0 {
> > +	bootph-all;
> > +};
> > +
> > +&usb0 {
> > +	bootph-all;
> > +};
> > +
> > =C2=A0#ifdef CONFIG_TARGET_AM625_A53_BEAGLEPLAY
> > =C2=A0
> > =C2=A0#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
> > diff --git a/board/beagle/beagleplay/beagleplay.env
> > b/board/beagle/beagleplay/beagleplay.env
> > index 4f0a94a8113..85c94856017 100644
> > --- a/board/beagle/beagleplay/beagleplay.env
> > +++ b/board/beagle/beagleplay/beagleplay.env
> > @@ -1,6 +1,7 @@
> > =C2=A0#include <env/ti/ti_common.env>
> > =C2=A0#include <env/ti/default_findfdt.env>
> > =C2=A0#include <env/ti/mmc.env>
> > +#include <env/ti/k3_dfu.env>
> > =C2=A0
> > =C2=A0name_kern=3DImage
> > =C2=A0console=3DttyS2,115200n8
> > diff --git a/configs/am62x_beagleplay_a53_defconfig
> > b/configs/am62x_beagleplay_a53_defconfig
> > index 0be20045a97..dfe04b71810 100644
> > --- a/configs/am62x_beagleplay_a53_defconfig
> > +++ b/configs/am62x_beagleplay_a53_defconfig
> > @@ -1,5 +1,6 @@
> > =C2=A0CONFIG_ARM=3Dy
> > =C2=A0CONFIG_ARCH_K3=3Dy
> > +CONFIG_SYS_MALLOC_LEN=3D0x2000000
> > =C2=A0CONFIG_SYS_MALLOC_F_LEN=3D0x8000
> > =C2=A0CONFIG_SPL_GPIO=3Dy
> > =C2=A0CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> > @@ -43,15 +44,20 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> > =C2=A0CONFIG_SPL_STACK_R=3Dy
> > =C2=A0CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
> > =C2=A0CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x1400
> > +CONFIG_SPL_ENV_SUPPORT=3Dy
> > =C2=A0CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot.img"
> > =C2=A0CONFIG_SPL_I2C=3Dy
> > =C2=A0CONFIG_SPL_DM_MAILBOX=3Dy
> > =C2=A0CONFIG_SPL_POWER_DOMAIN=3Dy
> > +CONFIG_SPL_RAM_SUPPORT=3Dy
> > +CONFIG_SPL_RAM_DEVICE=3Dy
> > =C2=A0CONFIG_SPL_YMODEM_SUPPORT=3Dy
> > +CONFIG_CMD_DFU=3Dy
> > =C2=A0CONFIG_CMD_GPIO=3Dy
> > =C2=A0CONFIG_CMD_GPIO_READ=3Dy
> > =C2=A0CONFIG_CMD_I2C=3Dy
> > =C2=A0CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_USB=3Dy
> > =C2=A0CONFIG_CMD_PMIC=3Dy
> > =C2=A0CONFIG_CMD_REGULATOR=3Dy
> > =C2=A0CONFIG_OF_CONTROL=3Dy
> > @@ -68,6 +74,10 @@ CONFIG_SPL_OF_TRANSLATE=3Dy
> > =C2=A0CONFIG_CLK=3Dy
> > =C2=A0CONFIG_SPL_CLK=3Dy
> > =C2=A0CONFIG_CLK_TI_SCI=3Dy
> > +CONFIG_DFU_MMC=3Dy
> > +CONFIG_DFU_RAM=3Dy
> > +CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x5000
> > +CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x800000
> > =C2=A0CONFIG_DMA_CHANNELS=3Dy
> > =C2=A0CONFIG_TI_K3_NAVSS_UDMA=3Dy
> > =C2=A0CONFIG_TI_SCI_PROTOCOL=3Dy
> > @@ -113,6 +123,26 @@ CONFIG_SOC_TI=3Dy
> > =C2=A0CONFIG_SYSRESET=3Dy
> > =C2=A0CONFIG_SPL_SYSRESET=3Dy
> > =C2=A0CONFIG_SYSRESET_TI_SCI=3Dy
> > +CONFIG_USB=3Dy
> > +CONFIG_DM_USB_GADGET=3Dy
> > +CONFIG_SPL_DM_USB_GADGET=3Dy
> > +CONFIG_USB_XHCI_HCD=3Dy
> > +CONFIG_USB_XHCI_DWC3=3Dy
>=20
> XHCI features are really not required for DFU
> but now I see that we depend on XHCI driver to get
> probed even for device mode. lol.

Right yeah i should have made it more clear in the commit message; This
also adds USB host support in the full u-boot in principle (i admit i
didn't actually test that on beagleplay). Which we can do now as the
usb glue is there.

Fwiw in the R5 SPL i've disable XHCI support now based on your comments
last time as USB host support there is not needed ofcourse



--=20
Sjoerd Simons
Collabora Ltd.
