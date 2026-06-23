Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD7ACD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 16:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947BF849CE;
	Tue, 23 Jun 2026 18:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VQWjoXJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51924849D2; Tue, 23 Jun 2026 18:50:28 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC859849BB
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 18:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43bfe209e45so108134fac.0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782233424; x=1782838224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w0SoaNZ3G/FgNe2K5mzQH8lDqILRoWwxQ+WUUKQvBM4=;
 b=VQWjoXJifnRl2aPihUe0NeNEaCkNzkZ/uHZvJxv0qcijby5QUnuNOzKGcgneo0GmtI
 PIZiJ8JJSMskHnrg5r/EXCL73+FfgJXosrgzHNvGrMZImSvcUSF0k0oOz6QbzfWLmtiD
 o2jy2mLqWfqf604u2ZI+jrouWmKpMHyO6pd1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782233424; x=1782838224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0SoaNZ3G/FgNe2K5mzQH8lDqILRoWwxQ+WUUKQvBM4=;
 b=Txc78A8kN7Rir4+TlWeAZ9v7qi8FLYqxHl1WeyXOmEZpnvQw30XYR4r54DNKlM27ES
 i144HffjozQq8rfzb5V0g2D7EGA6/LbGOG7iOqE3UA8ry7Hm0PLPi26GM65vk5a7FUXS
 zh1TYuYaJC4mz+/O9WO8YlGhm/klDKc/1tpNBgUgR/8ITrFhn54pN22G9nADVN/TP1dM
 tY3vIcwz+uY+hbR0SQ16vVstQWu3EzMOuL3SZ3NRVVMUzlLyCsKYvEOMRHVkuu9zCVxs
 34JB8svxAoJWI9R9pM9mWSeq1JhOzjVqarUXFZNz+mbwpaJ4o1RNDLMm6xH8XE01wDsJ
 1THg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ASpUe6Ga1R4nMeEdZGn2w+IdTXdmjVoPnLwDjmXBjXmFYXKDAc8W8DWFmxGB7gKMtXBm3vrY=@lists.denx.de
X-Gm-Message-State: AOJu0YxZsxMA1wpQDAaqE43a/c7repIHp6Sfwa1zzzFvMkvANPmNNzPJ
 kqLGIjOfgDWo5w79cJWS24tp2BJP7BT6s2bgTZkdOTf4GDYIemUNhC4tSZnLBXL3J0nkg5Mmk89
 tbrxVCwk=
X-Gm-Gg: AfdE7cm2PToImbvDFsLqhLIM3vDyl9yC3XueRx0c1ye+s8M7Z26WoMystMVkwKkthzC
 oReSmR0/PlhFVyJq3re7mTFUxsBDsk/RaqmN3Q6pIvIBsaX90Gc74tuAta+W1J4aBDwpWap4E57
 hTRckmA8wGHTO5tgoMK39DleRGslUr5h/svGzc/WemhGagz0dhus5K79Ku5aixNMc42/d5/pIN1
 afxqIAl9RvYvvU1QWo1QO7NWth9i1FUZlPovYCdXqOLg+GFNWoUlkLvfUB9DGhwFFk9K3k4aDdW
 lC4ZHkIDnAp8U9MDLOohkDT4Edt5guNpOhZ6yYcYV+P3eX43GkE1FHYCPAPsFAG/uBR8i4PPuGq
 bYO/5EXFKTAkBsshV9Z1pqiFIBnvnPLAET9hVVias5kmBqLgAzfFwlpNY/VrHG1+RyzMgbQSUz/
 mzY/eifuvPvpunr/FpXozbpHB5alTmFjvEdG5yz9vXTFNcqWzdeHb274tBHEtF0voGxu0Dz9k16
 HXnA8IAiElgqVx9NU+BGUpalP6FWesvuck=
X-Received: by 2002:a05:6820:20b:b0:69b:7ac2:5abc with SMTP id
 006d021491bc7-6a0d9027105mr14763516eaf.30.1782233424532; 
 Tue, 23 Jun 2026 09:50:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-245.totalplay.net.
 [187.191.8.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472efb371esm9014689fac.12.2026.06.23.09.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 09:50:23 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:50:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Cc: jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 ilias.apalodimas@linaro.org, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de
Subject: Re: [PATCH v6 3/5] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
Message-ID: <20260623165021.GJ382693@bill-the-cat>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-4-varadarajan.narayanan@oss.qualcomm.com>
 <667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de>
 <4fc15188-3de9-4345-85e9-d594efe9bdd5@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BAP8019nbuv9o0el"
Content-Disposition: inline
In-Reply-To: <4fc15188-3de9-4345-85e9-d594efe9bdd5@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--BAP8019nbuv9o0el
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 04:53:23PM +0200, Quentin Schulz wrote:
> Hi all,
>=20
> Gentle ping. It'd be nice if we can fix this new API before we have a
> release made with it?
>=20
> On 5/26/26 3:32 PM, Quentin Schulz wrote:
> > Hi Varadarajan, Casey,
> >=20
> > On 1/21/26 7:39 AM, Varadarajan Narayanan wrote:
> > > Implement request_arg() sysreset_op for QCOM SoCs that use
> > > PSCI to reset to EDL (Emergency Download) mode.
> > >=20
> > > Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > Signed-off-by: Varadarajan Narayanan
> > > <varadarajan.narayanan@oss.qualcomm.com>
> > > ---
> > > v4: * Check if ARM_PSCI_1_1_FN64_SYSTEM_RESET2 is supported before
> > > =A0=A0=A0=A0=A0=A0 issuing it
> > >=20
> > > v3: * Move argument handling to a separate function and pass the
> > > =A0=A0=A0=A0=A0=A0 arguments to the actual handler to process
> > > =A0=A0=A0=A0 * Drop Qcom specific SYSRESET_EDL from the common enum
> > >=20
> > > v2: * Update commit message
> > > =A0=A0=A0=A0 * Elaborate Kconfig help text
> > > =A0=A0=A0=A0 * Use '-edl' instead of 'edl' for consistency with other
> > > arguments of reset
> > > =A0=A0=A0=A0=A0=A0 command
> > > =A0=A0=A0=A0 * Remove 'weak' for qcom_psci_sysreset_get_status() and =
make it
> > > static
> > > =A0=A0=A0=A0 * Mention 'SYSRESET_EDL' is Qcom specific in the enum's =
comments
> > > ---
> > > =A0 drivers/firmware/psci.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 |=A0 4 +++
> > > =A0 drivers/sysreset/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0 6 ++++
> > > =A0 drivers/sysreset/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0 1 +
> > > =A0 drivers/sysreset/sysreset_qcom-psci.c | 45 ++++++++++++++++++++++=
+++++
> > > =A0 4 files changed, 56 insertions(+)
> > > =A0 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> > >=20
> > > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > > index 2e3223e1c32..b6838a244d2 100644
> > > --- a/drivers/firmware/psci.c
> > > +++ b/drivers/firmware/psci.c
> > > @@ -186,6 +186,10 @@ static int psci_bind(struct udevice *dev)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NU=
LL);
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_debug("PSCI System Reset w=
as not bound.\n");
> > > +=A0=A0=A0=A0=A0=A0=A0 if (IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI) &&
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_bind_driver(dev, "qcom_psci=
-sysreset",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "=
qcom_psci-sysreset", NULL))
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_debug("QCOM PSCI System Reset w=
as not bound.\n");
> > > =A0=A0=A0=A0=A0 }
> > > =A0=A0=A0=A0=A0 /* From PSCI v1.0 onward we can discover services thr=
ough
> > > ARM_SMCCC_FEATURE */
> > > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > > index 6fb0ca81dc6..905ad2a7769 100644
> > > --- a/drivers/sysreset/Kconfig
> > > +++ b/drivers/sysreset/Kconfig
> > > @@ -301,6 +301,12 @@ config SYSRESET_RAA215300
> > > =A0=A0=A0=A0=A0 help
> > > =A0=A0=A0=A0=A0=A0=A0 Add support for the system reboot via the Renes=
as RAA215300 PMIC.
> > > +config SYSRESET_QCOM_PSCI
> > > +=A0=A0=A0 bool "Support reset to EDL for Qualcomm SoCs via PSCI"
> > > +=A0=A0=A0 help
> > > +=A0=A0=A0=A0=A0 Add support for the reset to EDL (Emergency Download=
) on Qualcomm
> > > +=A0=A0=A0=A0=A0 SoCs via PSCI.
> > > +
> > > =A0 config SYSRESET_QCOM_PSHOLD
> > > =A0=A0=A0=A0=A0 bool "Support sysreset for Qualcomm SoCs via PSHOLD"
> > > =A0=A0=A0=A0=A0 help
> > > diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> > > index f5c78b25896..8bb1eabd48e 100644
> > > --- a/drivers/sysreset/Makefile
> > > +++ b/drivers/sysreset/Makefile
> > > @@ -30,5 +30,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) +=3D sysreset_reset=
ctl.o
> > > =A0 obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) +=3D sysreset_at91.o
> > > =A0 obj-$(CONFIG_$(PHASE_)SYSRESET_X86) +=3D sysreset_x86.o
> > > =A0 obj-$(CONFIG_SYSRESET_RAA215300) +=3D sysreset_raa215300.o
> > > +obj-$(CONFIG_SYSRESET_QCOM_PSCI) +=3D sysreset_qcom-psci.o
> > > =A0 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) +=3D sysreset_qcom-pshold.o
> > > =A0 obj-$(CONFIG_TARGET_XTFPGA) +=3D sysreset_xtfpga.o
> > > diff --git a/drivers/sysreset/sysreset_qcom-psci.c
> > > b/drivers/sysreset/ sysreset_qcom-psci.c
> > > new file mode 100644
> > > index 00000000000..3627bbf5c82
> > > --- /dev/null
> > > +++ b/drivers/sysreset/sysreset_qcom-psci.c
> > > @@ -0,0 +1,45 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
> > > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > > + */
> > > +
> > > +#include <dm.h>
> > > +#include <sysreset.h>
> > > +#include <asm/system.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/psci.h>
> > > +#include <asm/psci.h>
> > > +
> > > +static int qcom_psci_sysreset_get_status(struct udevice *dev, char
> > > *buf, int size)
> > > +{
> > > +=A0=A0=A0 return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static int qcom_psci_sysreset_request_arg(struct udevice *dev, int a=
rgc,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char=
 * const argv[])
> > > +{
> > > +=A0=A0=A0 if (!strncasecmp(argv[1], "-edl", 4)) {
> > > +=A0=A0=A0=A0=A0=A0=A0 /* Supported in qcs9100, qcs8300, sc7280, qcs6=
15 */
> > > +=A0=A0=A0=A0=A0=A0=A0 if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM_RES=
ET2) =3D=3D
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 ARM_PSCI_RET_SUCCESS) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psci_system_reset2(0, 1);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINPROGRESS;
> > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > +=A0=A0=A0=A0=A0=A0=A0 printf("PSCI SYSTEM_RESET2 not supported\n");
> > > +=A0=A0=A0 }
> > > +
> > > +=A0=A0=A0 return -EPROTONOSUPPORT;
> >=20
> > I think this is a logic bug.
> >=20
> > For reference, what calls this function:
> >=20
> >  =A0 int sysreset_walk_arg(int argc, char * const argv[])
> >  =A0 {
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 struct udevice *dev;
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret =3D -ENOSYS;
> >=20
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 while (ret !=3D -EINPROGRESS && ret !=3D -=
EPROTONOSUPPORT) {
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (uclass_first_=
device(UCLASS_SYSRESET, &dev);
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev;
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ucl=
ass_next_device(&dev)) {
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ret =3D sysreset_request_arg(dev, argc, argv);
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 if (ret =3D=3D -EINPROGRESS || ret =3D=3D -
> > EPROTONOSUPPORT)
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >=20
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> >  =A0 }
> >=20
> > The issue is that the first sysreset device implementing the request_arg
> > callback will consume the args and return EPROTONOSUPPORT which will
> > stop the loop.
> >=20
> > Think about multiple sysreset devices, and let's say we have a new '-
> > dummy' argument to the reset CLI command, then it'll depend on the
> > registration order of the sysreset driver whether the dummy argument
> > will be handled by the qcom driver which will return -
> > EPROTONOSUPPORT since it isn't '-edl', or by the dummy sysreset driver.
> >=20
> > I think we should have a fourth possible return code which is "I don't
> > know how to handle this argument", e.g. =E0-la IRQ_NONE in Linux kernel
> > for interrupts that aren't for the device this IRQ handler was triggered
> > for. Or maybe we should really be using -EPROTONOSUPPORT for that
> > meaning and not exit the loop if that's the return code?
> >=20
> > Or maybe I misread or misunderstood the code?

Following up here.

--=20
Tom

--BAP8019nbuv9o0el
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajq5TQAKCRAr4qD1Cr/k
CjZiAQCkznfDEdcj1wLI9nHCHvIxuoGVB8dwlgywp8PNOoH9fAD/XPqvlLQVu/U0
TRCvE3cr4Fa2+kItZj7SJtYN0uyLAwU=
=xLUw
-----END PGP SIGNATURE-----

--BAP8019nbuv9o0el--
