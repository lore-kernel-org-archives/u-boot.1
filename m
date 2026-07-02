Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CDFC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C270848DC;
	Thu,  2 Jul 2026 19:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XFTpapVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC9A84994; Thu,  2 Jul 2026 19:46:20 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8355183FEE
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 19:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-448479e0eb6so1262651fac.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783014377; x=1783619177; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P9AQDHBgMLCGAjkO5EE9UiW6gHKV+StaKzdApf4MTu8=;
 b=XFTpapVqoIi9PNF+0sgi1xisbb7BSjJL/83i3E5DCaTimuj2ZLfGW/ZSojqtUlBvmd
 Xz+aeJz2kuBpz7Tt2vFdsSYjOQRuKKzGU5NHiGuFcRyVjfiJYnR1evWjK71+BGKJAimb
 f2xKr8LVRbDzczjwhNn9NCLeWnvCqZwr6SKRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783014377; x=1783619177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9AQDHBgMLCGAjkO5EE9UiW6gHKV+StaKzdApf4MTu8=;
 b=PH2YVedHE7zlsQfIHcxvIoYlhDx0LAYud8Wv4on07zygWkQ3oyFwSCj6wkW2UjMC43
 ICeJ5FFuItIoiGirT4CKzsjuWnd4roR/oa4+k6W1Jvgo/IY0Gjq57HQBTCXurUzPHxwh
 unFVKP/E1I8Fkzw/TEP1TUH1uKUGMFg/1KC6Oh4FIbSF6zaEDSw2QqDV0LeVsHCxyZb2
 quoxt4irf8kh9O4Lm9XDX3x3X7G6sJ4/wY/yNd8zLh7p8X8tGzG4ao9veXnLAESEMhMp
 spvlRXzOke/0wE9bKVRcwXFkk4YRgDM1OuPLQKBbNxMvru7SRgwCT9mKop6Yavj29tAo
 TnfA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ron9BXliuWP+IyizlWtEnBCdq63P5qFe0CCxWTQak2CJPvdanlabZtyM720S3AQJFOp9yw51z4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxgpmow4S49WSGD4mV36Ui7iAvvbXspUjRnRcCG+Ten5pe1N8O3
 jIlfdfB+X2PURJ49LBsvMDRePW/wnb9jiXKoBVg1O7Yg+gxfd22yv27BMo61wXvF2gI=
X-Gm-Gg: AfdE7cnPNBS/y9+c9WErLYs06QLGK8ae6D6I6A4rHeudH09XB5gnKyly8b78fOPBax+
 Lft/zZFJEMvzfLonAPy4fLqjjyizaaOPgZXCUJjbml4uMN1Bx3LZguQCXfEEM9+/5ym6nZB24M1
 lC3Qux4XZzvvitPgZl2DLPFB0D7xskV9aGfSZkJ54o5stE0sQ2yB05kXZ79DcysL8E01rF/f9+o
 YObsZLDGHDnaH5Yu7kT06eEsKAuK4TaS7V2KrdtIvw7CZDRfyhhS5W+FMxHVkhujYWEIuS90mQ3
 +hXMjt9YnV/Yrt77zYhtFXosMCBTRWczPtOOicclSUwXih/C2olD9uXc6UqzVR8obJIZWd1VTzW
 4Xe6W8X6EJkwHarS3qEuCwoti7QDwVmTYC885eJEHGPWQvLOqN3W4nhPOssK6yp72qpGaPEJhCm
 lYKjx3jl7RfAhS599rLa9VWgPLwjjm/YYN8/PHDGhGLf15zEKdLoji9ygwKceysW1TzcZhUUkCu
 25AxzmdGB2ZXl4Fy2bXi2IfNcIGZfrxPiro+g==
X-Received: by 2002:a05:6870:891a:b0:448:558e:84e8 with SMTP id
 586e51a60fabf-44cb4656addmr4033876fac.34.1783014376938; 
 Thu, 02 Jul 2026 10:46:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbec92bbbsm3542354fac.10.2026.07.02.10.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 10:46:16 -0700 (PDT)
Date: Thu, 2 Jul 2026 11:46:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 clamor95@gmail.com, michal.simek@amd.com, u-boot@lists.denx.de
Subject: Re: [PATCH v6 3/5] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
Message-ID: <20260702174613.GC749385@bill-the-cat>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-4-varadarajan.narayanan@oss.qualcomm.com>
 <667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de>
 <4fc15188-3de9-4345-85e9-d594efe9bdd5@cherry.de>
 <20260623165021.GJ382693@bill-the-cat>
 <0a0af22c-ce8f-4c41-84bb-32d1b949c1f0@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ziKQhT2qgVrppv9f"
Content-Disposition: inline
In-Reply-To: <0a0af22c-ce8f-4c41-84bb-32d1b949c1f0@cherry.de>
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


--ziKQhT2qgVrppv9f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 07:43:06PM +0200, Quentin Schulz wrote:
> On 6/23/26 6:50 PM, Tom Rini wrote:
> > On Mon, Jun 08, 2026 at 04:53:23PM +0200, Quentin Schulz wrote:
> > > Hi all,
> > >=20
> > > Gentle ping. It'd be nice if we can fix this new API before we have a
> > > release made with it?
> > >=20
> > > On 5/26/26 3:32 PM, Quentin Schulz wrote:
> > > > Hi Varadarajan, Casey,
> > > >=20
> > > > On 1/21/26 7:39 AM, Varadarajan Narayanan wrote:
> > > > > Implement request_arg() sysreset_op for QCOM SoCs that use
> > > > > PSCI to reset to EDL (Emergency Download) mode.
> > > > >=20
> > > > > Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> > > > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > > Signed-off-by: Varadarajan Narayanan
> > > > > <varadarajan.narayanan@oss.qualcomm.com>
> > > > > ---
> > > > > v4: * Check if ARM_PSCI_1_1_FN64_SYSTEM_RESET2 is supported before
> > > > >  =A0=A0=A0=A0=A0=A0 issuing it
> > > > >=20
> > > > > v3: * Move argument handling to a separate function and pass the
> > > > >  =A0=A0=A0=A0=A0=A0 arguments to the actual handler to process
> > > > >  =A0=A0=A0=A0 * Drop Qcom specific SYSRESET_EDL from the common e=
num
> > > > >=20
> > > > > v2: * Update commit message
> > > > >  =A0=A0=A0=A0 * Elaborate Kconfig help text
> > > > >  =A0=A0=A0=A0 * Use '-edl' instead of 'edl' for consistency with =
other
> > > > > arguments of reset
> > > > >  =A0=A0=A0=A0=A0=A0 command
> > > > >  =A0=A0=A0=A0 * Remove 'weak' for qcom_psci_sysreset_get_status()=
 and make it
> > > > > static
> > > > >  =A0=A0=A0=A0 * Mention 'SYSRESET_EDL' is Qcom specific in the en=
um's comments
> > > > > ---
> > > > >  =A0 drivers/firmware/psci.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0 4 +++
> > > > >  =A0 drivers/sysreset/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 6 ++++
> > > > >  =A0 drivers/sysreset/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 1 +
> > > > >  =A0 drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++=
++++++++++
> > > > >  =A0 4 files changed, 56 insertions(+)
> > > > >  =A0 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> > > > >=20
> > > > > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > > > > index 2e3223e1c32..b6838a244d2 100644
> > > > > --- a/drivers/firmware/psci.c
> > > > > +++ b/drivers/firmware/psci.c
> > > > > @@ -186,6 +186,10 @@ static int psci_bind(struct udevice *dev)
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 NULL);
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_debug("PSCI System Re=
set was not bound.\n");
> > > > > +=A0=A0=A0=A0=A0=A0=A0 if (IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI) =
&&
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_bind_driver(dev, "qcom_=
psci-sysreset",
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 "qcom_psci-sysreset", NULL))
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_debug("QCOM PSCI System Res=
et was not bound.\n");
> > > > >  =A0=A0=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0 /* From PSCI v1.0 onward we can discover service=
s through
> > > > > ARM_SMCCC_FEATURE */
> > > > > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > > > > index 6fb0ca81dc6..905ad2a7769 100644
> > > > > --- a/drivers/sysreset/Kconfig
> > > > > +++ b/drivers/sysreset/Kconfig
> > > > > @@ -301,6 +301,12 @@ config SYSRESET_RAA215300
> > > > >  =A0=A0=A0=A0=A0 help
> > > > >  =A0=A0=A0=A0=A0=A0=A0 Add support for the system reboot via the =
Renesas RAA215300 PMIC.
> > > > > +config SYSRESET_QCOM_PSCI
> > > > > +=A0=A0=A0 bool "Support reset to EDL for Qualcomm SoCs via PSCI"
> > > > > +=A0=A0=A0 help
> > > > > +=A0=A0=A0=A0=A0 Add support for the reset to EDL (Emergency Down=
load) on Qualcomm
> > > > > +=A0=A0=A0=A0=A0 SoCs via PSCI.
> > > > > +
> > > > >  =A0 config SYSRESET_QCOM_PSHOLD
> > > > >  =A0=A0=A0=A0=A0 bool "Support sysreset for Qualcomm SoCs via PSH=
OLD"
> > > > >  =A0=A0=A0=A0=A0 help
> > > > > diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> > > > > index f5c78b25896..8bb1eabd48e 100644
> > > > > --- a/drivers/sysreset/Makefile
> > > > > +++ b/drivers/sysreset/Makefile
> > > > > @@ -30,5 +30,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) +=3D sysreset_r=
esetctl.o
> > > > >  =A0 obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) +=3D sysreset_at91.o
> > > > >  =A0 obj-$(CONFIG_$(PHASE_)SYSRESET_X86) +=3D sysreset_x86.o
> > > > >  =A0 obj-$(CONFIG_SYSRESET_RAA215300) +=3D sysreset_raa215300.o
> > > > > +obj-$(CONFIG_SYSRESET_QCOM_PSCI) +=3D sysreset_qcom-psci.o
> > > > >  =A0 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) +=3D sysreset_qcom-pshold=
=2Eo
> > > > >  =A0 obj-$(CONFIG_TARGET_XTFPGA) +=3D sysreset_xtfpga.o
> > > > > diff --git a/drivers/sysreset/sysreset_qcom-psci.c
> > > > > b/drivers/sysreset/ sysreset_qcom-psci.c
> > > > > new file mode 100644
> > > > > index 00000000000..3627bbf5c82
> > > > > --- /dev/null
> > > > > +++ b/drivers/sysreset/sysreset_qcom-psci.c
> > > > > @@ -0,0 +1,45 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext=
=2Ecom>
> > > > > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidia=
ries.
> > > > > + */
> > > > > +
> > > > > +#include <dm.h>
> > > > > +#include <sysreset.h>
> > > > > +#include <asm/system.h>
> > > > > +#include <linux/errno.h>
> > > > > +#include <linux/psci.h>
> > > > > +#include <asm/psci.h>
> > > > > +
> > > > > +static int qcom_psci_sysreset_get_status(struct udevice *dev, ch=
ar
> > > > > *buf, int size)
> > > > > +{
> > > > > +=A0=A0=A0 return -EOPNOTSUPP;
> > > > > +}
> > > > > +
> > > > > +static int qcom_psci_sysreset_request_arg(struct udevice *dev, i=
nt argc,
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
char * const argv[])
> > > > > +{
> > > > > +=A0=A0=A0 if (!strncasecmp(argv[1], "-edl", 4)) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0 /* Supported in qcs9100, qcs8300, sc7280, =
qcs615 */
> > > > > +=A0=A0=A0=A0=A0=A0=A0 if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM=
_RESET2) =3D=3D
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ARM_PSCI_RET_SUCCESS) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psci_system_reset2(0, 1);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINPROGRESS;
> > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > +=A0=A0=A0=A0=A0=A0=A0 printf("PSCI SYSTEM_RESET2 not supported\n=
");
> > > > > +=A0=A0=A0 }
> > > > > +
> > > > > +=A0=A0=A0 return -EPROTONOSUPPORT;
> > > >=20
> > > > I think this is a logic bug.
> > > >=20
> > > > For reference, what calls this function:
> > > >=20
> > > >   =A0 int sysreset_walk_arg(int argc, char * const argv[])
> > > >   =A0 {
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0 struct udevice *dev;
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret =3D -ENOSYS;
> > > >=20
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0 while (ret !=3D -EINPROGRESS && ret !=
=3D -EPROTONOSUPPORT) {
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (uclass_f=
irst_device(UCLASS_SYSRESET, &dev);
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 dev;
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 uclass_next_device(&dev)) {
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 ret =3D sysreset_request_arg(dev, argc, argv);
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 if (ret =3D=3D -EINPROGRESS || ret =3D=3D -
> > > > EPROTONOSUPPORT)
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > >=20
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > >   =A0 }
> > > >=20
> > > > The issue is that the first sysreset device implementing the reques=
t_arg
> > > > callback will consume the args and return EPROTONOSUPPORT which will
> > > > stop the loop.
> > > >=20
> > > > Think about multiple sysreset devices, and let's say we have a new =
'-
> > > > dummy' argument to the reset CLI command, then it'll depend on the
> > > > registration order of the sysreset driver whether the dummy argument
> > > > will be handled by the qcom driver which will return -
> > > > EPROTONOSUPPORT since it isn't '-edl', or by the dummy sysreset dri=
ver.
> > > >=20
> > > > I think we should have a fourth possible return code which is "I do=
n't
> > > > know how to handle this argument", e.g. =E0-la IRQ_NONE in Linux ke=
rnel
> > > > for interrupts that aren't for the device this IRQ handler was trig=
gered
> > > > for. Or maybe we should really be using -EPROTONOSUPPORT for that
> > > > meaning and not exit the loop if that's the return code?
> > > >=20
> > > > Or maybe I misread or misunderstood the code?
> >=20
> > Following up here.
> >=20
>=20
> Do we end up reverting just before the release then?

Please send it out, cc everyone, and see if that gets some response?

--=20
Tom

--ziKQhT2qgVrppv9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakaj4gAKCRAr4qD1Cr/k
CkqqAPwIxVV9ewEIi1hAY6lwJECPHSRqUB2Kzg07prfYvtv3OwEAowMzWe+p7+9e
slkEpjceSGk21U4Y+fzTjUhYPb76dAA=
=meBE
-----END PGP SIGNATURE-----

--ziKQhT2qgVrppv9f--
