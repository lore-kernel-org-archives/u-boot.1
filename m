Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC31FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE5B84119;
	Tue, 28 Apr 2026 10:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0w+bmY5W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C42842A2; Tue, 28 Apr 2026 10:41:49 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F7E983693
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 7C87EC5CD52;
 Tue, 28 Apr 2026 08:42:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C32F8601D0;
 Tue, 28 Apr 2026 08:41:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 609721072854E; 
 Tue, 28 Apr 2026 10:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777365704; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=v/vGUSiLmuKy2QndOfpkPEJ3JZZHTgREcPb5Mw5nw3E=;
 b=0w+bmY5WGYFIDSiSDwR+CHrZvRdTp71XPkx2ReEJnyL3gFFBureK1BglQOjTu7BUqXusbH
 4D5v2XwSPvXPjpPA8Ay97cE6+FWoPfeoUuBGkh2lrVk/5Khfy9mw6w6zC0zOBglc6qxUNc
 DAMasibiPXlHS7BFOmcRh/0frGC4p94Bc2CmwlLuadQCVXm2RW3n/VoxgoZyT89fzTWkRt
 zf7HDm/2+OoxjVw8PHBLVH0LX61P40S9Te13e0Kw4+KtDmVqA9QE9mrUNVz7lEVonABqdO
 RP1h6ocZXnQ/LzlwosgP5phYQ2VZipbGAacr2W5sOycAsfFWZjshqaLcI11QWw==
Date: Tue, 28 Apr 2026 10:41:33 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Tien
 Fong Chee <tien.fong.chee@altera.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Johan Jonker <jbx6244@gmail.com>, Brian Sune
 <briansune@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, Bernhard
 Messerklinger <bernhard.messerklinger@at.abb.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi
 <parth.pancholi@toradex.com>, Jonas =?UTF-8?B?U2Nod8O2YmVs?=
 <jonasschwoebel@yahoo.de>, Paul Kocialkowski <contact@paulk.fr>, Andre
 Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, Ion
 Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 13/14] arm: dts: am335x: Remove unused uboot devicetrees
Message-ID: <20260428104133.5b437e99@kmaincent-XPS-13-7390>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-13-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
 <20260427-topic-am33-evm-oftree-v2026-01-v7-13-7e6cd1a805a1@baylibre.com>
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

On Mon, 27 Apr 2026 11:01:29 +0200
"Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:

> These devicetrees are not used anymore because the boards are using
> upstream devicetrees now.
>=20
> Acked-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---
>  arch/arm/dts/Makefile                              |  11 -
>  arch/arm/dts/am335x-bone.dts                       |  23 -
>  arch/arm/dts/am335x-boneblack.dts                  | 174 -----
>  arch/arm/dts/am335x-bonegreen-eco.dts              |  53 --
>  arch/arm/dts/am335x-bonegreen.dts                  |  14 -
>  arch/arm/dts/am335x-evm.dts                        | 767
> --------------------- arch/arm/dts/am335x-evmsk.dts                      |
> 730 -------------------- arch/arm/dts/am335x-icev2.dts                   =
   |
> 486 ------------- arch/arm/dts/am335x-pocketbeagle.dts               | 237
> ------- arch/arm/dts/am335x-sancloud-bbe-common.dtsi       |  67 --
>  arch/arm/dts/am335x-sancloud-bbe-extended-wifi.dts | 113 ---
>  arch/arm/dts/am335x-sancloud-bbe-lite.dts          |  50 --
>  arch/arm/dts/am335x-sancloud-bbe.dts               |  53 --
>  13 files changed, 2778 deletions(-)
>=20
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index
> d90e02ca4e5c73534ce4c5f41173c897780bc6fe..35145d7e01176e320ebbf5e4004a465=
40f8933f1
> 100644 --- a/arch/arm/dts/Makefile +++ b/arch/arm/dts/Makefile
> @@ -403,26 +403,15 @@ dtb-$(CONFIG_ARCH_ZYNQMP_R5) +=3D \
>  	zynqmp-r5.dtb
>  dtb-$(CONFIG_AM33XX) +=3D \
>  	am335x-baltos.dtb \
> -	am335x-bone.dtb \
> -	am335x-boneblack.dtb \
>  	am335x-boneblack-wireless.dtb \
>  	am335x-boneblue.dtb \

I think you can also remove these ones.
IMHO all of the devicetree described here
https://elixir.bootlin.com/u-boot/v2026.04/source/include/configs/am335x_ev=
m.h#L117
could be removed. Even if they are missing from CONFIG_OF_LIST, which could=
 also
be corrected.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
