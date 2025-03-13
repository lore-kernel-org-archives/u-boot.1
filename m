Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9640C28B28
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 03:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B6A80756;
	Thu, 13 Mar 2025 04:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qYqdctE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F5B80F9C; Thu, 13 Mar 2025 04:03:22 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D8180548
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52D33GL91701850
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 12 Mar 2025 22:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741834996;
 bh=C7XSjeZ4jna7RBQrsn+FbbAZEhfUI1jBjEtahk/QCxs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qYqdctE0J1gzaO1FV7jKR0SAXlbEYvhgQMHZV8JaV3f6xThgY38Hfzq3kSOSYDTeO
 NWUQ9pmATVdV4uGZA4TD5LRImHUu1jD8ObK5/SlHSqGKrnpWcC5cXS8/ApUGf/c5e7
 nTV5Dz2O5x9Z9g99X2Il3BULICJdlcPSWWkfpJic=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52D33GfF062364;
 Wed, 12 Mar 2025 22:03:16 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 22:03:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 22:03:16 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.196])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52D33FIp072282;
 Wed, 12 Mar 2025 22:03:16 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Mar 2025 08:33:15 +0530
Message-ID: <D8ESZ20HJO3J.1JXL7WK6PRKR4@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: Re: [PATCH v3] spl: remove usage of CMD_BOOT[IZ] from image parsing
X-Mailer: aerc 0.17.0
References: <20250312124757.789013-1-anshuld@ti.com>
 <20250312182316.GX2640854@bill-the-cat>
In-Reply-To: <20250312182316.GX2640854@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed Mar 12, 2025 at 11:53 PM IST, Tom Rini wrote:
> On Wed, Mar 12, 2025 at 06:17:56PM +0530, Anshul Dalal wrote:
>
> > Using CMD_* configs from spl doesn't make logical sense. Therefore this
> > patch replaces the checks for CMD_BOOT[IZ] with newly added configs
> > SPL_HAS_BOOT[IZ].
> >=20
> > An imply clause has been added for CMD_BOOTZ to avoid breaking configs
> > that rely on CMD_BOOTZ in falcon boot. There is no such need for
> > CMD_BOOTI since it's already enabled by default for the platforms that
> > support the image format.
> >=20
> > More info:
> > https://lore.kernel.org/u-boot/20250310135544.GV2640854@bill-the-cat/
> >=20
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > ---
> > Changes in v3:
> >  * Add imply clause for CMD_BOOTZ to enable SPL_HAS_BOOTZ
> >  * Fix broken check for bootz_setup
> > v2: https://lore.kernel.org/u-boot/20250312094241.629707-1-anshuld@ti.c=
om/
> > Changes in v2:
> >  * Add SPL_HAS_BOOT[IZ] configs
> > v1: https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.=
com/
> > ---
> >  arch/arm/lib/Makefile |  4 ++--
> >  cmd/Kconfig           |  1 +
> >  common/spl/Kconfig    | 13 +++++++++++++
> >  common/spl/spl.c      |  5 +++--
> >  4 files changed, 19 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> > index 1c95dd6fed2..e857adddd03 100644
> > --- a/arch/arm/lib/Makefile
> > +++ b/arch/arm/lib/Makefile
> > @@ -36,8 +36,8 @@ obj-$(CONFIG_CMD_BOOTZ) +=3D bootm.o zimage.o
> >  else
> >  obj-$(CONFIG_$(PHASE_)FRAMEWORK) +=3D spl.o
> >  ifdef CONFIG_SPL_FRAMEWORK
> > -obj-$(CONFIG_CMD_BOOTI) +=3D image.o
> > -obj-$(CONFIG_CMD_BOOTZ) +=3D zimage.o
> > +obj-$(CONFIG_SPL_HAS_BOOTI) +=3D image.o
> > +obj-$(CONFIG_SPL_HAS_BOOTZ) +=3D zimage.o
> >  endif
>
> This Makefile hunk is weird and not quite correct today, and this change
> makes it more odd. We should drop the CONFIG_SPL_FRAMEWORK check because
> we're already in an CONFIG_XPL_BUILD check, and since we're making
> needing these objects explicit now the very rare case of
> ARM+SPL+!SPL_FRAMEWORK won't try and include these when not required.
>
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index a04fcaa0e08..9f2ba4d02f8 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -352,6 +352,7 @@ config BOOTM_ELF
> > =20
> >  config CMD_BOOTZ
> >  	bool "bootz"
> > +	imply SPL_HAS_BOOTZ
> >  	help
> >  	  Boot the Linux zImage
> > =20
>
> We don't need this hunk at all, we already (should) be getting the right
> file via the current logic in arch/arm/lib/Makefile
>

That's correct but we also need to take into account the modified check
in common/spl/spl.c, earlier it would pass on CMD_BOOTZ and allow
booting a zImage, now it checks for SPL_HAS_BOOTZ instead.

This would fail for configs that relied on CMD_BOOTZ during falcon boot
such as display5_defconfig. This imply ensures we enable SPL_HAS_BOOTZ
in such cases.

> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index 21a5cefee7a..e0e804ae8dc 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -1153,6 +1153,19 @@ config SPL_OS_BOOT
> >  	  Enable booting directly to an OS from SPL.
> >  	  for more info read doc/README.falcon
> > =20
> > +config SPL_HAS_BOOTZ
> > +	bool "Allow booting to kernel zimage from SPL"
>
> How about:
> "Allow booting a zImage style Linux kernel from SPL"
>
> > +	depends on SPL_OS_BOOT
> > +	help
> > +	  Boot a linux zimage from memory in falcon boot.
> > +
> > +config SPL_HAS_BOOTI
> > +	bool "Allow booting to kernel image from SPL"
>
> How about:
> "Allow booting an Image style Linux kernel from SPL"
>

Sounds good would be addressed in v4 :)

> > +	depends on SPL_OS_BOOT
> > +	default y if ARM64 || RISCV || SANDBOX
>
> Do we need SANDBOX here?

No, having SPL_OS_BOOT on SANDBOX doesn't make sense anyway.

Anshul

