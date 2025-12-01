Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF0BD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 13:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B4E883B4B;
	Mon,  1 Dec 2025 14:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nmb2WJ7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C358A83B4B; Mon,  1 Dec 2025 14:28:14 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5540183B0B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 14:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A63B0C17B4B;
 Mon,  1 Dec 2025 13:27:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C84A2606BB;
 Mon,  1 Dec 2025 13:28:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 43D1F1191817C; Mon,  1 Dec 2025 14:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764595691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=baEhjhJs8CKvQEmegBwoP/XcqiAR/MM2WTn6T5VUJVQ=;
 b=nmb2WJ7hDZ+/y5VjYa9NVaqB1Zyw7RIch07QzFekYzHxkxPJ5XXRkJCKShA4dtfqT0d5ua
 +ZBTLfP/TI/wM9cWOxNiywiEvqL1iMfJOYhEdSnsIri0LjMtOLSsLeggKoVOGau3oCsDaL
 YHFNTbGXoHS1o0br3AKoAXyN0J81oVHcGONFWsl7Cqyp+3l3nxrUfUjc0qvD1/vB21eY7x
 ZZeWfAOKzNOWJ6VICBhpPhPrwxtLtNJW+i5czFnKITyID1NPcUQ8ItCVJ1gcijmmQC/pz3
 6Pk0mLt7GVvGOEWtZrTxQMFNf7QKCj6widzCJGVfStRnUvj50w1VNbKGFpWgAA==
Date: Mon, 1 Dec 2025 14:28:08 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>
Subject: Re: [PATCH v2 7/7] configs: am335x_evm_defconfig: Switch to
 upstream devicetree
Message-ID: <20251201142808.0847e635@kmaincent-XPS-13-7390>
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-7-42a863304498@baylibre.com>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
 <20251128-topic-am33-evm-oftree-v2026-01-v2-7-42a863304498@baylibre.com>
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

On Fri, 28 Nov 2025 21:46:37 +0100
"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
> required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
> power domain driver is requierd as well now.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Seems ok to me.
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> ---
>  configs/am335x_evm_defconfig | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
> index
> bd188c252780fb541afbbe61a243bddaab79be93..5826562988c674cc05f45e3d8ee8e13=
1adcba069
> 100644 --- a/configs/am335x_evm_defconfig +++ b/configs/am335x_evm_defcon=
fig
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
>  CONFIG_AM335X_USB0=3Dy
> @@ -50,7 +53,8 @@ CONFIG_MTDIDS_DEFAULT=3D"nand0=3Dnand.0"
>  CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dnand.0:128k(NAND.SPL),128k(NAND.SP=
L.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-s=
pl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),=
8m(NAND.kernel),-(NAND.file-system)"
>  # CONFIG_SPL_EFI_PARTITION is not set
>  CONFIG_OF_CONTROL=3Dy
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
> +CONFIG_OF_UPSTREAM=3Dy CONFIG_ENV_OVERWRITE=3Dy CONFIG_ENV_RELOC_GD_ENV_=
ADDR=3Dy
> CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
>=20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
