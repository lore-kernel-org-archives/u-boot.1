Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1473AC02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 22:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C1A780085;
	Sun, 19 Jan 2025 23:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE9C801CF; Sun, 19 Jan 2025 23:27:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 36CC28007D
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 23:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDB771063;
 Sun, 19 Jan 2025 14:27:32 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256EC3F5A1;
 Sun, 19 Jan 2025 14:27:03 -0800 (PST)
Date: Sun, 19 Jan 2025 22:25:30 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini
 <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>, Simon Glass
 <sjg@chromium.org>, linux-sunxi@lists.linux.dev, Parthiban
 <parthiban@linumiz.com>
Subject: Re: [PATCH 2/8] sunxi: pmic_bus: support alternative I2C address
Message-ID: <20250119222530.1fd97018@minigeek.lan>
In-Reply-To: <2352334.ElGaqSPkdT@jernej-laptop>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <20250117014537.22513-3-andre.przywara@arm.com>
 <2352334.ElGaqSPkdT@jernej-laptop>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Sat, 18 Jan 2025 08:21:31 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

many thanks for the review and your opinion.

> Dne petek, 17. januar 2025 ob 02:45:31 Srednjeevropski standardni =C4=8Da=
s je Andre Przywara napisal(a):
> > Some of the X-Power AXP PMICs can be ordered with an alternative I2C
> > address, for instance an AXP717 could be shipped with address 0x34 or
> > with address 0x35.
> > The datasheets for the AXP717 and AXP803 list two possible addresses,
> > and they are always consecutive. For DM (DT) based drivers this is no
> > problem, but the Allwinner SPL code relies on a hardcoded address.
> >=20
> > Add a Kconfig variable that will add "1" to the existing address if it
> > is set.
> > This enables to use the AXP717 as used on boards with the new Allwinner
> > A523 chip.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com> =20
>=20
> This works until some board vendor start mixing one or another address
> PMIC. Note that BSP boot0 does address autodetection, so it's not entirely
> out of the question. Anyway, let's hope we don't see anything like that.

I looked at the datasheets for all supported PMICs, and they either
state one or two supported addresses, in the latter case both
consecutive. Autodetection sounds nice, but also unnecessary: we surely
know what address it is for a certain board? And with those A523 boards
having two PMICs, autodetection might become sketchy, as we don't know
for sure which PMIC we got?

But that got me thinking: what about putting the I2C address in Kconfig
directly, with defaults depending on the PMIC type?

config AXP_I2C_ADDR
	hex "AXP PMIC I2C address"
	depends on ARCH_SUNXI && !SUNXI_NO_PMIC
	default 0x36 if AXP305_POWER
	....

That's should work seamlessly for all supported PMICs, and we just need
one line for the Avaota, same as with this patch here.

What do you think?

Cheers,
Andre



>=20
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> Best regards,
> Jernej
>=20
>=20
>=20

