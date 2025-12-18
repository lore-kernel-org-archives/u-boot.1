Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8F7D6D22A
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 14:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E533C83DE0;
	Thu, 18 Dec 2025 15:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="UVmIzhPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CD7883DEE; Thu, 18 Dec 2025 15:11:35 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA6883C2B
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id BC125C1A5AF;
 Thu, 18 Dec 2025 14:11:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3E15E606B6;
 Thu, 18 Dec 2025 14:11:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 594C2102F0B2D; Thu, 18 Dec 2025 15:11:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1766067087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=E8Z8/XF6pB4JqVePhR339DrZcrbDLGbVqeUExgXqmis=;
 b=UVmIzhPftbpy8dYhKU7I/imDBuHYr4aJy4cAAaexbP3Nq8x+HD8SjHTmq4dFIHd/M/FKZQ
 FBM/tT+S2JjHWtuMfaelKbXT73iAfEzQFEKGTO7YmcKdELwwEZhJDGVaa5v5fatLh3B9pL
 NIE2L9HDBYCeLQfXfTQpfZqkYCFod/EUJWLYOr6YmFVxIvWI4hNDc9InxhXWJrPv/tjZo3
 52f3uc35Uux9gSYGwxl/t4RMI1NO961F37H1NXBQ0QiWOOnlkkMPxrR8Il/NwG2lNhCYto
 tCgL+GFbm2uDVrgfJAPld3+UUiawEsMalEYKuCR17nZd3Y9yucl3kaA9cG/zFg==
Date: Thu, 18 Dec 2025 15:11:21 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Julien Masson <jmasson@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, Tom
 Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Wolfgang Wallner
 <wolfgang.wallner@at.abb.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] boot: fix missing dependency for BOOTMETH_ANDROID
Message-ID: <20251218151121.7a4a3d32@kmaincent-XPS-13-7390>
In-Reply-To: <20251218-bootmeth_android-deps-v1-1-0113c804f951@cherry.de>
References: <20251218-bootmeth_android-deps-v1-1-0113c804f951@cherry.de>
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

On Thu, 18 Dec 2025 13:19:07 +0100
Quentin Schulz <foss+uboot@0leil.net> wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> The code depends on set_avendor_bootimg_addr and set_abootimg_addr
> functions which are only defined in cmd/abootimg.c, only built when
> CMD_ABOOTIMG=3Dy so let's add a dependency.
>=20
> It should be "depends on" to be properly implemented, but we get a
> circular dependency otherwise:
> boot/Kconfig:566:error: recursive dependency detected!
> boot/Kconfig:566:	symbol BOOTMETH_ANDROID depends on CMD_ABOOTIMG
> cmd/Kconfig:504:	symbol CMD_ABOOTIMG depends on ANDROID_BOOT_IMAGE
> boot/Kconfig:7:	symbol ANDROID_BOOT_IMAGE is selected by
> BOOTMETH_ANDROID
>=20
> so instead we do a select. It is safe because CMD_ABOOTIMG depends on
> ANDROID_BOOT_IMAGE which we select here as well.
>=20
> Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
