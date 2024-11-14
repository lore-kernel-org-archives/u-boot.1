Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03407D41C00
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF0388E31;
	Thu, 14 Nov 2024 04:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bwK6aHh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 650A0895A9; Thu, 14 Nov 2024 04:53:46 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDCE88E31
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9ec86a67feso24536366b.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731556424; x=1732161224; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uR+3nSkGy8+C1gPoeoR8KRkLBotswQhCOAj9PuJPwnI=;
 b=bwK6aHh696nsGTcMf5E+yVvcSklrXGg7bsQ9NQttMC18DVoKWZSc2/aZsnTZzl8mwg
 fNGz8L07HNL5unYVlfROfBgQvglkn1hUMtpnDx7THQr4uCTTWEYfKgZFoesXy4LsYTUB
 O5kvvnUxg0k5EkhIsHROoDRJf96lpSza8klyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731556424; x=1732161224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uR+3nSkGy8+C1gPoeoR8KRkLBotswQhCOAj9PuJPwnI=;
 b=OLGx9HRc5vbGo4b1zmJBXEMx356xUluEQ+TRbr3pupzUvnJlIw2NlGoX6bmsITSmHD
 wMKSaqXWYsJcPTnKG+1jtQemfjxVhFGeHViXxc0Tsfz59CuEnMvW/H4KhRJjn5fZdxX5
 Xt//dGCBxkjoRNK2JdgFaDbwie2Ur/RKlara120EXsm3dhX/uim7N8juNGMZTybUi3zb
 KEvNEHBQIYC7bZshteyOUSpnfLvCruvYkOgKBnQstlqvsCWnY8HXPLYlEpBChjRDhpDm
 IRqlL2yBitGL9AI2U28gakBRQs6sp32N7rPtKEv1cH9hrKrRQRNnGfq6EwX/LiMNSC3U
 zg+Q==
X-Gm-Message-State: AOJu0YxEVIiGn9duGmURTzcgDMFcDDm1/Wl7MhpJWIxPRiQdaK91alTi
 MtyAf/DgBPn7K06jTTStLD9wV9gaLuUnTSmifMPfp7CWPZfuN1gh8KZEYZb6F1nBsXI0o8TYhfS
 4x+WJo3JoGlp44FZ+9rDYQuniSF1H11v2ckGB
X-Google-Smtp-Source: AGHT+IGKVWWs0KJBU8hsI1QkxE4t5oMiV3VkvMC1FtHoYIvYiKjJtFqjbJCqAPkRwfYCNKZuLMAb/Vq2AobsJRgNlSc=
X-Received: by 2002:a17:907:3e27:b0:a9a:129a:1862 with SMTP id
 a640c23a62f3a-a9ef0058013mr2096512366b.60.1731556423333; Wed, 13 Nov 2024
 19:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-2-sjg@chromium.org>
 <20241113174707.GR3600562@bill-the-cat>
In-Reply-To: <20241113174707.GR3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 20:53:31 -0700
Message-ID: <CAFLszTjW2bGPRvUQC9pxvhKixpov8u2GxzzeUYeKo1FNFyuHug@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] bootstd: Avoid depending on BLK
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Wed, 13 Nov 2024 at 10:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 13, 2024 at 08:09:31AM -0700, Simon Glass wrote:
>
> > In principle bootstd can work without block devices, even if it does
> > require driver model to be enabled in that case.
> >
> > The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
> > is now defined, producing recursive errors through multiple different
> > paths, one of which is this (with Linksprite_pcDuino3 and
> > BOOTSTD_DEFAULTS enabled):
> >
> >   arch/arm/Kconfig:7:error: recursive dependency detected!
> >   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MULTI
> >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> >      part of choice <choice>
> >   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
> >      ARCH_UNIPHIER_V8_MULTI
> >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> >      part of choice SPL
> >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
> >   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2600
> >   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
> >      choice <choice>
> >   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
> >      ASPEED_AST2500
> >   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
> >      choice DM_RESET
> >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
> >      by CLK_RCAR_GEN3
> >   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
> >      CLK_RENESAS
> >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
> >   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
> >   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends on
> >      POWER_DOMAIN
> >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
> >      BCM6318_USBH_PHY
> >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
> >   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
> >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
> >   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
> >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
> >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> >   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
> >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> >   Kconfig:176: symbol XEN depends on ARM64
> >
> > We don't want to revert the change to BLK, which has been in place for
> > a year now. We don't want to select BLK in BOOTSTD since it should
> > support booting without block devices. The only realistic option is to
> > remove BOOTSTD's dependency on BLK.
> >
> > Disable standard boot on the one board which fails.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - Drop wip (work-in-progress) comment in commit
> >
> > Changes in v2:
> > - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> >
> >  boot/Kconfig                                   | 2 +-
> >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 7dd30a030e3..b5433e88f10 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -393,7 +393,7 @@ config BOOT_DEFAULTS
> >  menuconfig BOOTSTD
> >       bool "Standard boot"
> >       default y
> > -     depends on DM && OF_CONTROL && BLK
> > +     depends on DM && OF_CONTROL
> >       help
> >         U-Boot supports a standard way of locating something to boot,
> >         typically an Operating System such as Linux, provided by a distro such
>
> This ends up being a massive size bloat on all of the boards which did
> not use BOOTSTD before, and still can't (because there's no appropriate
> methods). You need to not just disable it on the one board that fails
> but on everything not currently enabling it, which now does enable it.

Looking through the list it is hard to know which boards can't use
bootstd, nor what the missing methods are. See [1]. I could perhaps
disable bootstd for all of the boards?

>
> Or you need to better explain what's going on here, exactly and why
> depending on BLK here is wrong, for what you're doing.

I tried that already. We had quite a long thread about it.

Regards,
Simon

[1]
10m50
3c120
CMPC885
CMPCPRO
M5208EVBE
M5235EVB_Flash32
M5235EVB
M5249EVB
M5272C3
M5275EVB
M5282EVB
M53017EVB
M5329AFEE
M5329BFEE
M5373EVB
MCR3000
MPC8548CDS_36BIT
MPC8548CDS
MPC8548CDS_legacy
SBx81LIFKW
SBx81LIFXCAT
amcore
amd_versal2_mini
amd_versal2_mini_ospi
amd_versal2_mini_qspi
ap121
ap143
ap152
astro_mcf5373l
axm
bcm968380gerg_ram
bcmns
boston32r2
boston32r2el
boston32r6
boston32r6el
boston64r2
boston64r2el
boston64r6
boston64r6el
cobra5272
cortina_presidio-asic-base
cortina_presidio-asic-pnand
crs305-1g-4s-bit
crs305-1g-4s
crs326-24g-2s-bit
crs326-24g-2s
crs328-4c-20s-4s-bit
crs328-4c-20s-4s
eb_cpu5282
eb_cpu5282_internal
efi-x86_app32
efi-x86_app64
evb-ast2500
gardena-smart-gateway-at91sam
gardena-smart-gateway-mt7688
gxp
ibex-ast2700
imgtec_xilfpga
integratorap_cm720t
integratorap_cm920t
integratorap_cm926ejs
integratorap_cm946es
integratorcp_cm1136
integratorcp_cm920t
integratorcp_cm926ejs
integratorcp_cm946es
inteno_xg6846_ram
kmcoge5ne
kmeter1
kmopti2
kmsupx5
kmtepr2
lschlv2
lsxhl
maxbcm
meesc_dataflash
meesc
microblaze-generic
mscc_jr2
mscc_luton
mscc_ocelot
mscc_serval
mscc_servalt
mt7620_mt7530_rfb
mt7628_rfb
mt7981_rfb
mt7986_rfb
mx6memcal
netgear_cg3100d_ram
nsim_700
nsim_700be
nsim_hs38be
pg_wcom_expu1
pg_wcom_expu1_update
pg_wcom_seli8
pg_wcom_seli8_update
r8a77970_eagle
rcar3_salvator-x
sagem_f@st1704_ram
sama5d29_curiosity_mmc1
sama5d29_curiosity_mmc
sama5d29_curiosity_qspiflash
sama7g54_curiosity_mmc
sama7g54_curiosity_nandflash
sama7g54_curiosity_qspiflash
smdkc100
smegw01
socfpga_is1
stm32f429-discovery
stm32mp25
stmark2
tb100
tbs2910
th1520_lpi4a
thunderx_88xx
tuge1
tuxx1
usb_a9263_dataflash
work_92105
xilinx_versal_mini
xilinx_versal_mini_ospi
xilinx_versal_mini_qspi
xilinx_versal_net_mini
xilinx_versal_net_mini_ospi
xilinx_versal_net_mini_qspi
xilinx_zynqmp_mini
xilinx_zynqmp_mini_nand
xilinx_zynqmp_mini_nand_single
xilinx_zynqmp_mini_qspi
xtfpga
zynq_cse_nand
zynq_cse_nor
zynq_cse_qspi
