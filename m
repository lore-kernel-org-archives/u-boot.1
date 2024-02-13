Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75789C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 10:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81BB87D13;
	Tue, 13 Feb 2024 11:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="rZWPMx8H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B7D287D51; Tue, 13 Feb 2024 11:08:31 +0100 (CET)
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C9B87D12
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 11:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.behun@nic.cz
Received: from dellmb (unknown [IPv6:2001:1488:fffe:6:8747:7254:5571:3010])
 by mail.nic.cz (Postfix) with ESMTPSA id 2F0731C1911;
 Tue, 13 Feb 2024 11:08:27 +0100 (CET)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.behun@nic.cz smtp.mailfrom=marek.behun@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1707818907; bh=twb9Ry7KgdTOBCkm73IVjmys2YzyQDMKjJ+BXMeLJG0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From:Reply-To:
 Subject:To:Cc;
 b=rZWPMx8H3dUfghJ5rWkNVN4T4EytkMCMz4ou6ORvbwUfaj/icOHqLfQzisX6wrCRu
 V13aYNV8EZ8gjuPPSduB4uQuLDKDE6BGCrOlI4kWeY9BEX7Au8Mbg9lkVHOraBWon3
 30P5jNJyJXElclpWvkc/iqwjPeQkD4SbIHcSMnF0=
Date: Tue, 13 Feb 2024 11:08:26 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Max Resch <resch.max@gmail.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4] rng: Add Turris Mox rTWM RNG driver
Message-ID: <20240213110826.030e1363@dellmb>
In-Reply-To: <c00f48a7-ef7b-4f82-aa6f-f7cadc6eb496@gmx.de>
References: <20240211130436.698777-1-resch.max@gmail.com>
 <3b7ffd4d-251a-4b2a-bed3-e324e6c4086f@denx.de>
 <c00f48a7-ef7b-4f82-aa6f-f7cadc6eb496@gmx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 20.00]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmx.de,gmail.com];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:8747:7254:5571:3010];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; TAGGED_RCPT(0.00)[];
 FROM_HAS_DN(0.00)[]; FREEMAIL_TO(0.00)[gmx.de]
X-Rspamd-Server: mail
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Queue-Id: 2F0731C1911
X-Spamd-Bar: /
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

On Tue, 13 Feb 2024 10:49:43 +0100
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> On 2/13/24 10:16, Stefan Roese wrote:
> > Hi Max,
> >
> > mostly some nitpicking comments below.
> >
> > On 2/11/24 14:04, Max Resch wrote: =20
> >> A RNG driver for Armada 3720 boards running the Turris Mox rWTM firmwa=
re
> >> from CZ.NIC in the secure processor.
> >>
> >> Signed-off-by: Max Resch <resch.max@gmail.com>
> >> ---
> >>
> >> Changes in v4:
> >> =C2=A0 - wrongful/missing git rebase
> >>
> >> Changes in v3:
> >> =C2=A0 - More meaningful variable names in accordance with review
> >>
> >> Changes in v2:
> >> =C2=A0 - Removed ring buffer implementation
> >>
> >> =C2=A0 drivers/rng/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +++
> >> =C2=A0 drivers/rng/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> >> =C2=A0 drivers/rng/turris_rwtm_rng.c | 122 +++++++++++++++++++++++++++=
+++++++
> >> =C2=A0 3 files changed, 131 insertions(+)
> >> =C2=A0 create mode 100644 drivers/rng/turris_rwtm_rng.c
> >>
> >> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> >> index a89c899568..cd72852a47 100644
> >> --- a/drivers/rng/Kconfig
> >> +++ b/drivers/rng/Kconfig
> >> @@ -105,4 +105,12 @@ config RNG_JH7110
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable True Random Number G=
enerator in StarFive JH7110 SoCs.
> >> +config RNG_TURRIS_RWTM
> >> +=C2=A0=C2=A0=C2=A0 bool "Turris Mox TRNG in Secure Processor"
> >> +=C2=A0=C2=A0=C2=A0 depends on DM_RNG && ARMADA_3700
> >> +=C2=A0=C2=A0=C2=A0 help
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Use TRNG in Turris Mox Secure Processo=
r Firmware. Can be used
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on other Armada-3700 devices (like Esp=
ressoBin) if Secure
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Firmware from CZ.NIC is used.
> >> +
> >> =C2=A0 endif
> >> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> >> index 7e64c4cdfc..ecae1a3da3 100644
> >> --- a/drivers/rng/Makefile
> >> +++ b/drivers/rng/Makefile
> >> @@ -17,3 +17,4 @@ obj-$(CONFIG_RNG_SMCCC_TRNG) +=3D smccc_trng.o
> >> =C2=A0 obj-$(CONFIG_RNG_ARM_RNDR) +=3D arm_rndr.o
> >> =C2=A0 obj-$(CONFIG_TPM_RNG) +=3D tpm_rng.o
> >> =C2=A0 obj-$(CONFIG_RNG_JH7110) +=3D jh7110_rng.o
> >> +obj-$(CONFIG_RNG_TURRIS_RWTM) +=3D turris_rwtm_rng.o
> >> diff --git a/drivers/rng/turris_rwtm_rng.c
> >> b/drivers/rng/turris_rwtm_rng.c
> >> new file mode 100644
> >> index 0000000000..ec2cb0bca3
> >> --- /dev/null
> >> +++ b/drivers/rng/turris_rwtm_rng.c
> >> @@ -0,0 +1,122 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> >> +/*
> >> + * Copyright (c) 2024, Max Resch
> >> + */
> >> +
> >> +#include <dm.h>
> >> +#include <malloc.h>
> >> +#include <rng.h>
> >> +#include <asm/dma-mapping.h>
> >> +#include <asm/types.h>
> >> +#include <mach/mbox.h>
> >> +
> >> +/* size of entropy buffer */
> >> +#define RNG_BUFFER_SIZE=C2=A0=C2=A0=C2=A0 128U
> >> +
> >> +struct turris_rwtm_rng_priv {
> >> +=C2=A0=C2=A0=C2=A0 phys_addr_t buffer;
> >> +};
> >> +
> >> +static int turris_rwtm_rng_fill_entropy(phys_addr_t entropy, size_t
> >> size)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 u32 args[3] =3D { 1, (u32)entropy, size }; =20
>=20
> On a device with memory above 4 GiB this (u32) conversion may point to a
> different location than rwtm_rng_priv.
>=20
> Is the Armada 3700 family restricted to below 4 GiB?

Indeed it is. Only virtual memory can be mapped to higher locations,
all physical resources (DDR, registers, PCIe, DMA, rWTM) can only be
confiured with 32 bits.

> Should we add a check in the probe function?

No need.
