Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF17C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 14:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA1087947;
	Mon,  5 Feb 2024 15:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VoPr3/m8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505CE8798F; Mon,  5 Feb 2024 15:54:20 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2916878CB
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 15:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6EE3460F8B;
 Mon,  5 Feb 2024 14:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD84C433C7;
 Mon,  5 Feb 2024 14:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707144856;
 bh=aMfqAuihV/buwtwb/U6mDuME5HsEK/CV4uuQZlc8+B0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VoPr3/m8aF1Tju4vMZw3bkNVJAzIMB46qXyd51hPrQV72h7Dn7rNypvSsGzkUmUGV
 7DC+FKiHLT19m9enUuF+Td3pu11p1/tKn3jMxj90ak+/ouY7NOL88SQRVFNXZdWma8
 9HCKmmW3gkMtArWhJ6KTeJOVj4q2+/rNYQKMpTzuEM8FUIY1hCJ7memsCY8XGn9S/q
 NKvXcEpD4vVm7wOcYDWWFOTeDhnX6oD7D4XWmKuToBZo4YwHfPbXQZ4ICgkCCCV3dV
 XZauIDorScJwCwxE4+Dm/XOB70hT3eucmh0MAqWJTVSx9oYEnm5bLqD2aCGHK4G4jN
 eR9T71wy9l9sw==
Date: Mon, 5 Feb 2024 15:54:12 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: resch.max@gmail.com, u-boot@lists.denx.de, sr@denx.de
Subject: Re: [PATCH v2] rng: Add Turris Mox rWTM RNG driver
Message-ID: <20240205155412.63482336@dellmb>
In-Reply-To: <874jenqb0v.fsf@bloch.sibelius.xs4all.nl>
References: <20240121201737.671340-1-resch.max@gmail.com>
 <20240205124014.6f7b1957@dellmb>
 <874jenqb0v.fsf@bloch.sibelius.xs4all.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
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

So you're using A3720 with OpenBSD? Can I ask which A3720 boards do you
use?

Marek

On Mon, 05 Feb 2024 14:46:24 +0100
Mark Kettenis <mark.kettenis@xs4all.nl> wrote:

> > Date: Mon, 5 Feb 2024 12:40:14 +0100
> > From: Marek Beh=C3=BAn <kabel@kernel.org>
> >=20
> > Hello Max,
> >=20
> > Out of curiousity, what is your use case for having these random
> > numbers on this platform in U-Boot? =20
>=20
> It means that U-Boot will implement the EFI RNG protocol.  The OpenBSD
> bootloader will use that to fill an initial pool of random numbers for
> the kernel.  And the Linux kernel EFI stub uses it to do kernel
> address space randomization.
>=20
> Cheers,
>=20
> Mark
>=20
> > Below are a few more things to change and then you I'll give my
> > Reviewed-by tag.
> >=20
> > On Sun, 21 Jan 2024 21:17:16 +0100
> > Max Resch <resch.max@gmail.com> wrote:
> >  =20
> > > A RNG driver for Armada 3720 boards running the Turris Mox rWTM firmw=
are
> > > from CZ.NIC in the secure processor.
> > >=20
> > > Signed-off-by: Max Resch <resch.max@gmail.com>
> > > ---
> > >=20
> > > Changes in v2:
> > >  - Removed ring buffer implementation
> > >=20
> > >  drivers/rng/Kconfig           |   8 +++
> > >  drivers/rng/Makefile          |   1 +
> > >  drivers/rng/turris_rwtm_rng.c | 122 ++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 131 insertions(+)
> > >  create mode 100644 drivers/rng/turris_rwtm_rng.c
> > >=20
> > > diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> > > index a89c899568..cd72852a47 100644
> > > --- a/drivers/rng/Kconfig
> > > +++ b/drivers/rng/Kconfig
> > > @@ -105,4 +105,12 @@ config RNG_JH7110
> > >  	help
> > >  	  Enable True Random Number Generator in StarFive JH7110 SoCs.
> > > =20
> > > +config RNG_TURRIS_RWTM
> > > +	bool "Turris Mox TRNG in Secure Processor"
> > > +	depends on DM_RNG && ARMADA_3700
> > > +	help
> > > +	  Use TRNG in Turris Mox Secure Processor Firmware. Can be used
> > > +	  on other Armada-3700 devices (like EspressoBin) if Secure
> > > +	  Firmware from CZ.NIC is used.
> > > +
> > >  endif
> > > diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> > > index 7e64c4cdfc..ecae1a3da3 100644
> > > --- a/drivers/rng/Makefile
> > > +++ b/drivers/rng/Makefile
> > > @@ -17,3 +17,4 @@ obj-$(CONFIG_RNG_SMCCC_TRNG) +=3D smccc_trng.o
> > >  obj-$(CONFIG_RNG_ARM_RNDR) +=3D arm_rndr.o
> > >  obj-$(CONFIG_TPM_RNG) +=3D tpm_rng.o
> > >  obj-$(CONFIG_RNG_JH7110) +=3D jh7110_rng.o
> > > +obj-$(CONFIG_RNG_TURRIS_RWTM) +=3D turris_rwtm_rng.o
> > > diff --git a/drivers/rng/turris_rwtm_rng.c b/drivers/rng/turris_rwtm_=
rng.c
> > > new file mode 100644
> > > index 0000000000..143fe0b47f
> > > --- /dev/null
> > > +++ b/drivers/rng/turris_rwtm_rng.c
> > > @@ -0,0 +1,122 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> > > +/*
> > > + * Copyright (c) 2024, Max Resch
> > > + */
> > > +
> > > +#include <dm.h>
> > > +#include <malloc.h>
> > > +#include <rng.h>
> > > +#include <asm/dma-mapping.h>
> > > +#include <asm/types.h>
> > > +#include <mach/mbox.h>
> > > +
> > > +/* size of entropy buffer */
> > > +#define RNG_BUFFER_SIZE	128U
> > > +
> > > +struct turris_rwtm_rng_priv {
> > > +	phys_addr_t buffer;
> > > +};
> > > +
> > > +static int turris_rwtm_rng_fill_entropy(phys_addr_t entropy, size_t =
size)
> > > +{
> > > +	u32 args[3] =3D { 1, (u32)entropy, size };
> > > +	int ret;
> > > +
> > > +	/* flush data cache */
> > > +	flush_dcache_range(entropy, entropy + size);
> > > +
> > > +	/*
> > > +	 * get entropy
> > > +	 * args[0] =3D 1 copies BYTES array in args[1] of length args[2]
> > > +	 */
> > > +	ret =3D mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, 3, NULL, 0);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	/* invalidate data cache */
> > > +	invalidate_dcache_range(entropy, entropy + size);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int turris_rwtm_rng_random_read(struct udevice *dev, void *da=
ta, size_t count)
> > > +{
> > > +	phys_addr_t p;
> > > +	size_t size;
> > > +	int ret;
> > > +
> > > +	p =3D ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer; =
=20
> >=20
> > Please declare
> >=20
> >   struct turris_rwtm_rng_priv *priv =3D dev_get_priv(dev);
> >   phys_addr_t phys;
> >   size_t size;
> >   int ret;
> >=20
> > and then do=20
> >=20
> >   phys =3D priv->buffer;
> >  =20
> > > +	while (count) {
> > > +		size =3D min_t(size_t, RNG_BUFFER_SIZE, count);
> > > +
> > > +		ret =3D turris_rwtm_rng_fill_entropy(p, size);
> > > +
> > > +		memcpy(data, (void *)p, size);
> > > +		count -=3D size;
> > > +		data =3D (u8 *)data + size;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int turris_rwtm_rng_probe(struct udevice *dev)
> > > +{
> > > +	struct turris_rwtm_rng_priv *priv; =20
> >=20
> >   =3D dev_get_priv(dev);
> >  =20
> > > +	u32 args[] =3D { 0 };
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * check if the random command is supported
> > > +	 * args[0] =3D 0 would copy 16 DWORDS entropy to out but we ignore =
them
> > > +	 */
> > > +	ret =3D mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, ARRAY_SIZE(args), NU=
LL, 0);
> > > +
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	/* entropy buffer */
> > > +	priv =3D (struct turris_rwtm_rng_priv *)dev_get_priv(dev); =20
> > no need here, do it at the beginning
> >=20
> >  =20
> > > +	priv->buffer =3D 0;
> > > +
> > > +	/* buffer address need to be aligned */
> > > +	dma_alloc_coherent(RNG_BUFFER_SIZE, (unsigned long *)&priv->buffer);
> > > +	if (!priv->buffer)
> > > +		return -ENOMEM;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int turris_rwtm_rng_remove(struct udevice *dev)
> > > +{
> > > +	phys_addr_t p; =20
> > rename this to phys, and please do it as I described above.
> >  =20
> > > +
> > > +	p =3D ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
> > > +	dma_free_coherent((void *)p);
> > > +
> > > +	return 0; =20
> >=20
> > Marek
> >  =20

