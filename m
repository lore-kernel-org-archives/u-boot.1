Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C620C369C2
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 02:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C497780F6B;
	Wed, 23 Apr 2025 04:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=paulsajna.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paulsajna.com header.i=@paulsajna.com header.b="NN2+sCp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D9580F9C; Wed, 23 Apr 2025 04:04:09 +0200 (CEST)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF8880F03
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 04:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=paulsajna.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@paulsajna.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paulsajna.com;
 s=protonmail; t=1745373846; x=1745633046;
 bh=6COQ5ZgOVnBtm2t/KG5tXTL8OAJw6F29eh3y1PFlRl8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=NN2+sCp69hfjMkM64JzDLdEM8SydRIpbZugYsVl+PLhZV7C2MUrFOwY9VDFFtb5Dd
 593wU48jzMJ7OWmk2zg04znugCdFR76166k05gA5RGYf247Z1wOGiOgoh/yxP34dLy
 IoW/fVzD3BXK1sb5Wcf4N1hC8WAjd3g/0pgvLNwHgzWoHCkNZnAwYoZYwOY+eZWE3Z
 52NoDj5QkY+JEwZmPL8cxNcNdrd7zZRXx0jNJDs4mRh+Q5YP+0a5s0bJUmQ1qDa/kZ
 GbkrUcgXV3GqZUfBc/hy81je1MThAD7TAzoBiUG5IjHYAF9UdbUydpuCSgxU77scvs
 Zjnd06GjvJcAA==
Date: Wed, 23 Apr 2025 02:04:03 +0000
To: Casey Connolly <casey.connolly@linaro.org>
From: Paul Sajna <hello@paulsajna.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: Re: [PATCH v2 2/2] watchdog: qcom: improve driver with more
 functionality
Message-ID: <9IIfbR8-zwvCgMLLLEPmUQokw-LrsKXoqD859mitNycZfqbs6bLJDoAI1SYDI_dIvbBvcguPR5_fmnVCWUR5zTBUYrADscQk5u0eYVupsCQ=@paulsajna.com>
In-Reply-To: <w2nlv9FzBv_7cz1on576OdWuPItzYrbZP3o5tu8fnurwSBojeSEHitBNbxKX3PmJCRW7P4bbyl_7_yQz4xVhM1j8tG0ymgVgcjQbii-3Tr0=@paulsajna.com>
References: <20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com>
 <20250421-b4-qcom-wdt-v2-2-b2250efa0f39@paulsajna.com>
 <9eb12f16-2af5-49eb-bd09-c809c0debf59@linaro.org>
 <w2nlv9FzBv_7cz1on576OdWuPItzYrbZP3o5tu8fnurwSBojeSEHitBNbxKX3PmJCRW7P4bbyl_7_yQz4xVhM1j8tG0ymgVgcjQbii-3Tr0=@paulsajna.com>
Feedback-ID: 29073965:user:proton
X-Pm-Message-ID: 375702ca67ca0eada11638d6e6c111427ac54063
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Tested stop and start in the console with reset (service watchdog) commente=
d out and ensured start eventually reset from the watchdog. All seems good.=
 Squashed and preparing to push v3.

On Tuesday, April 22nd, 2025 at 3:46 PM, Paul Sajna <hello@paulsajna.com> w=
rote:

>=20
>=20
> I tested reset and stop pretty thoroughly. I suppose "start" could use so=
me more checking. I'll squash and fix a line of code I noticed I accidental=
ly duplicated, then retest that this evening (Pacific Time)
>=20
> On Tuesday, April 22nd, 2025 at 12:50 PM, Casey Connolly casey.connolly@l=
inaro.org wrote:
>=20
> > Hi Paul,
> >=20
> > Please squash this patch into the first one, otherwise this looks good.
> > Did you test start/stop/reset?
> >=20
> > Kind regards,
> >=20
> > On 4/22/25 01:20, Paul Sajna wrote:
> >=20
> > > - add the ability to start the watchdog
> > > - add the ability to reset the watchdog
> > > - remove the automatic disable in the probe function
> > > - use log macros for errors
> > >=20
> > > Signed-off-by: Paul Sajna hello@paulsajna.com
> > > ---
> > > drivers/watchdog/qcom-wdt.c | 32 +++++++++++++++++++++++++-------
> > > 1 file changed, 25 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.=
c
> > > index a7ce31ef811c717fd16700aa7d984a000763a93e..88e5fc7906825ac258393=
495682a75a5010473b0 100644
> > > --- a/drivers/watchdog/qcom-wdt.c
> > > +++ b/drivers/watchdog/qcom-wdt.c
> > > @@ -4,12 +4,14 @@
> > > * Copyright (c) Linaro Ltd. 2024
> > > *
> > > * Authors:
> > > - * Caleb Connolly caleb.connolly@linaro.org
> > > + * Casey Connolly casey.connolly@linaro.org
> > > + * Paul Sajna hello@paulsajna.com
> > > *
> > > * Derived from linux/drivers/watchdog/qcom-wdt.c
> > > */
> > >=20
> > > #include <dm.h>
> > > +#include <dm/device_compat.h>
> > > #include <wdt.h>
> > >=20
> > > #include <asm/io.h>
> > > @@ -50,7 +52,16 @@ static void __iomem *wdt_addr(struct qcom_wdt *wdt=
, enum wdt_reg reg)
> > >=20
> > > int qcom_wdt_start(struct udevice dev, u64 timeout_ms, ulong flags)
> > > {
> > > - / unimplemented */
> > > + struct qcom_wdt *wdt =3D dev_get_priv(dev);
> > > +
> > > + writel(0, wdt_addr(wdt, WDT_EN));
> > > + writel(1, wdt_addr(wdt, WDT_RST));
> > > + writel(1, wdt_addr(wdt, WDT_EN));
> > > + writel(1, wdt_addr(wdt, WDT_EN));
> > > + if (readl(wdt_addr(wdt, WDT_EN)) !=3D 1) {
> > > + dev_err(dev, "Failed to enable Qualcomm watchdog!\n");
> > > + return -EIO;
> > > + }
> > > return 0;
> > > }
> > >=20
> > > @@ -60,29 +71,36 @@ int qcom_wdt_stop(struct udevice *dev)
> > >=20
> > > writel(0, wdt_addr(wdt, WDT_EN));
> > > if (readl(wdt_addr(wdt, WDT_EN))) {
> > > - printf("Failed to disable Qualcomm watchdog!\n");
> > > + dev_err(dev, "Failed to disable Qualcomm watchdog!\n");
> > > return -EIO;
> > > }
> > >=20
> > > return 0;
> > > }
> > >=20
> > > +int qcom_wdt_reset(struct udevice *dev)
> > > +{
> > > + struct qcom_wdt *wdt =3D dev_get_priv(dev);
> > > +
> > > + writel(1, wdt_addr(wdt, WDT_RST));
> > > + return 0;
> > > +}
> > > +
> > > static int qcom_wdt_probe(struct udevice *dev)
> > > {
> > > struct qcom_wdt *wdt =3D dev_get_priv(dev);
> > > struct qcom_wdt_match_data *data =3D (void *)dev_get_driver_data(dev)=
;
> > > - int ret;
> > >=20
> > > wdt->base =3D dev_read_addr_ptr(dev);
> > > wdt->layout =3D data->offset;
> > >=20
> > > - ret =3D qcom_wdt_stop(dev);
> > > -
> > > - return ret;
> > > + return 0;
> > > }
> > >=20
> > > static const struct wdt_ops qcom_wdt_ops =3D {
> > > + .start =3D qcom_wdt_start,
> > > .stop =3D qcom_wdt_stop,
> > > + .reset =3D qcom_wdt_reset,
> > > };
> > >=20
> > > static const struct udevice_id qcom_wdt_ids[] =3D {
> >=20
> > --
> > Casey (she/they)
