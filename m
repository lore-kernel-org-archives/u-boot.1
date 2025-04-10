Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F4BC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED15B83B3C;
	Thu, 10 Apr 2025 11:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A380483B47; Thu, 10 Apr 2025 11:23:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 421D883B32
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BB2D106F;
 Thu, 10 Apr 2025 02:23:22 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E45D43F6A8;
 Thu, 10 Apr 2025 02:23:17 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:23:15 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Samuel Holland
 <samuel@sholland.org>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Hans de Goede <hdegoede@redhat.com>, Olliver Schinagl
 <oliver@schinagl.nl>, Iain Paton <ipaton0@gmail.com>, Marcus Cooper
 <codekipper@gmail.com>, Stefan Mavrodiev <stefan@olimex.com>, Paul
 Kocialkowski <contact@paulk.fr>, Chen-Yu Tsai <wens@csie.org>, Maxime
 Ripard <mripard@kernel.org>, Ian Campbell <ijc@hellion.org.uk>, Adam
 Sampson <ats@offog.org>, Zoltan Herpai <wigyori@uid0.hu>, Siarhei Siamashka
 <siarhei.siamashka@gmail.com>, VishnuPatekar <vishnupatekar0510@gmail.com>,
 Rask Ingemann Lambertsen <rask@formelder.dk>, Aleksei Mamlin
 <mamlinav@gmail.com>, Peter Korsgaard <peter@korsgaard.com>, Michal
 Suchanek <hramrach@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>, Stefan
 Roese <sr@denx.de>, Phil Han <pengphei@sina.com>, Quentin Schulz
 <quentin.schulz@free-electrons.com>, Jonas Smedegaard <dr@jones.dk>,
 Jaehoon Chung <jh80.chung@samsung.com>, Heiko Schocher <hs@denx.de>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/8] power: regulator: Add a driver for the AXP PMIC
 drivevbus
Message-ID: <20250410102315.6e080dbd@donnerap.manchester.arm.com>
In-Reply-To: <4971028.GXAFRqVoOG@jernej-laptop>
References: <20250409002036.12212-1-andre.przywara@arm.com>
 <20250409002036.12212-2-andre.przywara@arm.com>
 <4971028.GXAFRqVoOG@jernej-laptop>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 10 Apr 2025 09:04:35 +0200
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

> Dne sreda, 9. april 2025 ob 02:20:29 Srednjeevropski poletni =C4=8Das je =
Andre Przywara napisal(a):
> > From: Samuel Holland <samuel@sholland.org>
> >=20
> > AXP PMICs have a pin which can either report the USB VBUS state, or
> > driving a regulator that supplies USB VBUS. Add a regulator driver for
> > controlling this pin. The selection between input and output is done via
> > the x-powers,drive-vbus-en pin on the PMIC (parent) node.
> >=20
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com> =20
>=20
> Would it be less error prone to auto enable Kconfig option when compatible
> AXP device is enabled? That way defconfigs could be smaller. Driver is pr=
etty
> small anyway.

Yes, but the whole PMIC config is quite a mess at the moment. Those
AXPxxx_POWER symbols are really for the SPL part only, and do nothing
in U-Boot proper, where everything is guarded by CONFIG_REGULATOR_AXP and
properly detected at runtime through the DT.
I tried to enable this driver for all 64-bit boards, to be able to drop
the TF-A code, but ran into problems with the H616 RSB boards, because of
this overlap and this "PMIC bus" feature.

So I have patches to enable this more universally, and will look at this
in the next days and weeks, but first wanted to get the non-controversial
parts in, like the driver itself.

> In any case:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Many thanks for that!

Cheers,
Andre

>=20
> Best regards,
> Jernej
>=20
>=20

