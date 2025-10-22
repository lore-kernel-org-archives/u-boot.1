Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB845CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 877D28323A;
	Wed, 22 Oct 2025 17:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YfjJO7/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9186D80422; Wed, 22 Oct 2025 17:24:19 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6830783303
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 17:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 171814E4127B;
 Wed, 22 Oct 2025 15:24:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E3D02606DC;
 Wed, 22 Oct 2025 15:24:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 880C0102F23AD; 
 Wed, 22 Oct 2025 17:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761146655; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=BZSfESkm7fH3MYrQefsPietKo7JwUIGqGaTGuxCG/OA=;
 b=YfjJO7/EGB4tU7EF5A3eBz8Ya/3eNUCrEFOtUb/MLORG8gFrxbnp/LWN9f9ky1CI4wrHZs
 QWErlFz9dLX2AhWo0dekj3uo/iUVJlOpGOsB2aFg7H/54w1niAcflIWvhH9gc/0arE//xy
 bZ83wUBY3K9PmTQiyu2IGEjwEJMaYOEXJVQlBi16mprrJpztv6Z/y32xVos1VnWOD+b50t
 /1USGlv8pW/UlD2h6FQ9BoiZfTR8LOlYSY0EhGjqRbDfz0L2md4Ce+GBn3XFu2uWURCCbM
 UjPjbCyyGxMbRqXq/69ZJjoJ3MJUqKKQ2ecvA9Z7wVM/GU4TKr7y1NcO9ay46w==
Date: Wed, 22 Oct 2025 17:24:11 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Jagan
 Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 08/20] boot: Add UCLASS support for extension boards
Message-ID: <20251022172411.04b156d2@kmaincent-XPS-13-7390>
In-Reply-To: <20251022-feature_sysboot_extension_board-v4-8-d24b5ef7b468@bootlin.com>
References: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
 <20251022-feature_sysboot_extension_board-v4-8-d24b5ef7b468@bootlin.com>
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

On Wed, 22 Oct 2025 17:20:19 +0200
"Kory Maincent (TI.com)" <kory.maincent@bootlin.com> wrote:

> Introduce UCLASS-based extension board support to enable more
> standardized and automatic loading of extension board device tree
> overlays in preparation for integration with bootstd and pxe_utils.
>=20
> Several #if CONFIG_IS_ENABLED are used in cmd/extension_board.c to ease t=
he
> development but don't worry they are removed later in the series.
>=20
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>

Forgot to add:
Reviewed-by: Simon Glass <sjg@chromium.org>
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
