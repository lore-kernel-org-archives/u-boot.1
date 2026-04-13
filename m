Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B214F34C40
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 12:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5C2D839DF;
	Mon, 13 Apr 2026 14:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TXf0ChQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7CC484181; Mon, 13 Apr 2026 14:01:24 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA86F839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 14:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4182A1A31C5;
 Mon, 13 Apr 2026 12:01:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0E2B45FFB9;
 Mon, 13 Apr 2026 12:01:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 37A34104500A2; 
 Mon, 13 Apr 2026 14:01:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776081673; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=p5AYzRXdQhAPVagOxWvrNjcpeosUX/ECVGprE1hrH4w=;
 b=TXf0ChQkl9yOnA6vrrsc2V7pt1ngEWvfPgTbZ4EcZvHBuvYBSdeIPBt8nl+5illenDZeBe
 4BBr4BIakjVRQcU5Y5z2RrMVrYAIutY3oyaAUx1VHVyamom2F+r9DzoJedU1bB3iRVmIk6
 FQuYdvUmKw44pqm1k9BgLKgmxJQ8m2n+5+8m7c4ouFjaR+qAau+V7kPcu9TRQ1e5HSRpPY
 Mgs0Fgfa6AHVMO3PI5iua0hn6eHt2MW2CCYF058L8V7SoTIXtzRQZVAiMZQPIcE3XuZX3a
 /h4JN/iKV5DHj2MGtZ+nRsb0GHsv6Ex4f9172ouRBLtxcG9eU3/XYm2KuKa6/Q==
Date: Mon, 13 Apr 2026 14:01:10 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
Subject: Re: [PATCH v5 12/12] configs: am335x_evm_defconfig: Switch to
 upstream devicetree
Message-ID: <20260413140029.798645ad@kmaincent-XPS-13-7390>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-12-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
 <20260410-topic-am33-evm-oftree-v2026-01-v5-12-4b9c7aca0e3e@baylibre.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 10 Apr 2026 15:31:52 +0200
"Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:

> The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
> required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
> power domain driver is requierd as well now.
>=20
> This switches all evm defconfig variants to use the upstream devicetree.

Hello,

This patch breaks the BeagleBone Green Eco boot.

U-Boot SPL 2026.04-00765-g42087b117172 (Apr 13 2026 - 11:59:01 +0200)
Trying to boot from MMC1

U-Boot 2026.04-00765-g42087b117172 (Apr 13 2026 - 11:59:01 +0200)

CPU  : AM335X-GP rev 2.1
Model: Seeed Studio BeagleBone Green Eco
DRAM:  512 MiB
Core:  201 devices, 17 uclasses, devicetree: separate
Could not initialize timer (err -19)

resetting ...

>=20
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---
>  configs/am335x_evm.config            | 6 +++++-
>  configs/am335x_evm_defconfig         | 2 +-
>  configs/am335x_evm_spiboot_defconfig | 2 +-
>  configs/am335x_hs_evm.config         | 2 +-
>  4 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/configs/am335x_evm.config b/configs/am335x_evm.config
> index
> 9c12771a3299bcd0b1c5c14bb4c2306d7b02aae5..fbc070c930e4d2d85739c9e428c4b13=
0490cd6bc
> 100644 --- a/configs/am335x_evm.config +++ b/configs/am335x_evm.config
> @@ -3,7 +3,10 @@ CONFIG_ARCH_CPU_INIT=3Dy
>  CONFIG_ARCH_OMAP2PLUS=3Dy
>  CONFIG_TI_COMMON_CMD_OPTIONS=3Dy
>  CONFIG_SF_DEFAULT_SPEED=3D24000000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"am335x-evm"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/am335x-evm"
> +CONFIG_POWER_DOMAIN=3Dy
> +CONFIG_TI_OMAP_PRM_POWER_DOMAIN=3Dy
> +CONFIG_SIMPLE_PM_BUS=3Dy
>  CONFIG_AM33XX=3Dy
>  CONFIG_CLOCK_SYNTHESIZER=3Dy
>  CONFIG_SYS_BOOTM_LEN=3D0x1000000
> @@ -12,6 +15,7 @@ CONFIG_TIMESTAMP=3Dy
>  CONFIG_SPL_LOAD_FIT=3Dy
>  CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_OF_BOARD_SETUP=3Dy
> +CONFIG_OF_UPSTREAM=3Dy
>  CONFIG_BOOTCOMMAND=3D"run findfdt; run init_console; run finduuid; run
> distro_bootcmd" CONFIG_LOGLEVEL=3D3
>  CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
> diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
> index
> 448b0a8308fcca04732b81313c72f7fd2247d1ca..9281178f914085b199e3d35e95d0ce1=
f3c0faaa5
> 100644 --- a/configs/am335x_evm_defconfig +++ b/configs/am335x_evm_defcon=
fig
> @@ -24,7 +24,7 @@ CONFIG_CMD_SPL_NAND_OFS=3D0x00080000
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_MTDIDS_DEFAULT=3D"nand0=3Dnand.0"
>  CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dnand.0:128k(NAND.SPL),128k(NAND.SP=
L.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-s=
pl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),=
8m(NAND.kernel),-(NAND.file-system)"
> -CONFIG_OF_LIST=3D"am335x-evm am335x-bone am335x-sancloud-bbe
> am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-bonebla=
ck
> am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle
> am335x-bonegreen-eco" +CONFIG_OF_LIST=3D"ti/omap/am335x-evm ti/omap/am335=
x-bone
> ti/omap/am335x-sancloud-bbe ti/omap/am335x-sancloud-bbe-lite
> ti/omap/am335x-sancloud-bbe-extended-wifi ti/omap/am335x-boneblack
> ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2
> ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
> CONFIG_SPL_ENV_IS_NOWHERE=3Dy CONFIG_CLK=3Dy CONFIG_CLK_CCF=3Dy diff --git
> a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defco=
nfig
> index
> eebd916c02a2cad0d01ab738aab37b11dd3a9645..bbaca6c8800baf19377a457e49db446=
159e338a8
> 100644 --- a/configs/am335x_evm_spiboot_defconfig +++
> b/configs/am335x_evm_spiboot_defconfig @@ -12,7 +12,7 @@
> CONFIG_SPL_SPI_LOAD=3Dy CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x20000 # CONFIG_CMD=
_SETEXPR
> is not set CONFIG_SPL_OF_CONTROL=3Dy -CONFIG_OF_LIST=3D"am335x-evm am335x=
-bone
> am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2
> am335x-pocketbeagle am335x-bonegreen-eco" +CONFIG_OF_LIST=3D"ti/omap/am33=
5x-evm
> ti/omap/am335x-bone ti/omap/am335x-boneblack ti/omap/am335x-evmsk
> ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle
> ti/omap/am335x-bonegreen-eco" # CONFIG_ENV_IS_IN_FAT is not set
> CONFIG_ENV_IS_IN_SPI_FLASH=3Dy CONFIG_SPL_ENV_IS_NOWHERE=3Dy diff --git
> a/configs/am335x_hs_evm.config b/configs/am335x_hs_evm.config index
> 7ade2fb163b204ad8bcc9554455fdd3e81657890..0bc8556b1d4b18a413ecd6879ab85be=
54f2730ef
> 100644 --- a/configs/am335x_hs_evm.config +++ b/configs/am335x_hs_evm.con=
fig
> @@ -8,7 +8,7 @@ CONFIG_SPL_NAND_DRIVERS=3Dy CONFIG_SPL_NAND_ECC=3Dy
> CONFIG_MTDIDS_DEFAULT=3D"nand0=3Dnand.0"
> CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dnand.0:128k(NAND.SPL),128k(NAND.SPL=
.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-sp=
l-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8=
m(NAND.kernel),-(NAND.file-system)"
> -CONFIG_OF_LIST=3D"am335x-evm am335x-bone am335x-boneblack am335x-evmsk
> am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
> +CONFIG_OF_LIST=3D"ti/omap/am335x-evm ti/omap/am335x-bone
> ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen
> ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle
> ti/omap/am335x-bonegreen-eco" CONFIG_SPL_DM_USB_GADGET=3Dy
> CONFIG_SPL_TINY_MEMSET=3Dy CONFIG_RSA=3Dy
>=20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
