Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E79C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 09:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49EE087D1A;
	Tue, 13 Feb 2024 10:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZIVmeygW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D681C87D37; Tue, 13 Feb 2024 10:49:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C562187CDC
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 10:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707817781; x=1708422581; i=xypron.glpk@gmx.de;
 bh=kyUJjtWeEW1O7eB6P+kE/nDZkdUmz6YWp2fV+lpgCx8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=ZIVmeygWVNWZerGIPU5stmaWKbPHfrihwzPJWWnxwqIYPhIWexEAQeh/A3jnS7K/
 MFVmtiFBuj+p7VvJCmjKvawGXLTI+ftPbqP7EGhWzG5sQCtBzuoSLNLAUbi63cg52
 lKdJPrXyD+xHCqOyko9sBYKI9UEqiSVNk2sFjG0qiX8WZc9ICVFtyC9ykOq5f3bds
 0NxMMURyZRliCWAacgXS3UP2UvN7nbf8G/PXLnUgaxldzjUiKU33IdxBVSZyyFptb
 9qrR+uLlP5zxX8jbZN6bOah7E3CyjBciqIqEYICByWS7IRUadMpbMobuBzqAA5nGo
 3RObCblknOpW7fktTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1rLZov3LXY-00PLri; Tue, 13
 Feb 2024 10:49:41 +0100
Message-ID: <c00f48a7-ef7b-4f82-aa6f-f7cadc6eb496@gmx.de>
Date: Tue, 13 Feb 2024 10:49:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rng: Add Turris Mox rTWM RNG driver
Content-Language: en-US
To: Max Resch <resch.max@gmail.com>
References: <20240211130436.698777-1-resch.max@gmail.com>
 <3b7ffd4d-251a-4b2a-bed3-e324e6c4086f@denx.de>
Cc: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <3b7ffd4d-251a-4b2a-bed3-e324e6c4086f@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q5sqNtolNnKfodyjdyGrtnYMkJh33YSYxJIfXRgI9C3z14D6loY
 Yro3qI1ZwMgkK/cUbAzoBdVvIY1Jgt69HayhX48KJdqmKJnH5UCDLAMCbJ7hInR4UQIRQrF
 8R//Q/33nsTCuVFeYivKok2GqNaeBKiMOPAK/YuA8+0IC7NrVFo6+EmHDibzsmD3Hh4t+X7
 0ter1/d0frZ69ZwHKex1g==
UI-OutboundReport: notjunk:1;M01:P0:AhW64pcCDSk=;H2GiunyME7HQCeT96ZyTK8Zhysd
 80QygRfdKqK8Q6S83dBrmY4sSUlpzUyv+Fi3iC+2RlrqJgdf8XNhjL9G3uMdngmPfuCLJn50H
 +vfUC8J/xanIA53DhTq74zL1U659yoCOkbTiDhBTQHw8Esn7Je5767G7U4JJ92Z9oKFjcMMxq
 u/OsQQvrg2pPW4dpA8GZsEvWJ+xMP+UujTCnxt61X4GgLMCj+Q2TCcF1nJEeMcKIyiD1tzDAY
 uaCUjvUPMLMsJWO5sI3gbxRLZQAocwsYoTMR5un8uVTeqoAXHuyKoHSwFgeRFPh3GDrqIRjs9
 6BpjgtJKnO0fXZ/vGeZVP8b6XGSLuzgETHzSkFShTjDTi6qOS5mqBBrkAsTrg/ejWYcOXmAcb
 /KmFqJwPja+a7gFWdmsQ0L4spQSHoDkcMmBA8IFB3X2ZJ7oubgXSnABd7yEfCY7qxqcBbuXpg
 A46DKAeEbXqApe4vC5ZpbmRsraPwHk7TPI5K8/MVJxnsCfIMsJb4NfkenvSi5M5kccaQWpV2n
 /8sEZK7AWldyWwkmKJPI0Du/D71w3tdS6HS7sk6quhDJXt4Bd4BodZLV4vTkNZwJIdkm0LdNZ
 Y4Yw6vriC1Gkj0YVbjXeK4ZK5pC6lOHtARXYrpoDI/yid7HFB6ZDrGpaF7FNRlRwRL+tIojiV
 5p4GDaJARVPBeW5O4RgXUXTK/6LY5M8czuc/fQGxKJSgsFJWnKPg6irZ1FwgkOT6ljA3W6eFS
 w/0vIsGXid0F1HpxWZIenySyacgp0BM3cm3/KG8HZNPSiPaLtbcNyudhNqADRCvF89IDY2mlh
 oPHx/NmJtVIthLZoh7bTavcAG/LB47cRsUeuZ5OejCDOg=
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

On 2/13/24 10:16, Stefan Roese wrote:
> Hi Max,
>
> mostly some nitpicking comments below.
>
> On 2/11/24 14:04, Max Resch wrote:
>> A RNG driver for Armada 3720 boards running the Turris Mox rWTM firmwar=
e
>> from CZ.NIC in the secure processor.
>>
>> Signed-off-by: Max Resch <resch.max@gmail.com>
>> ---
>>
>> Changes in v4:
>> =C2=A0 - wrongful/missing git rebase
>>
>> Changes in v3:
>> =C2=A0 - More meaningful variable names in accordance with review
>>
>> Changes in v2:
>> =C2=A0 - Removed ring buffer implementation
>>
>> =C2=A0 drivers/rng/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +++
>> =C2=A0 drivers/rng/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 drivers/rng/turris_rwtm_rng.c | 122 ++++++++++++++++++++++++++++=
++++++
>> =C2=A0 3 files changed, 131 insertions(+)
>> =C2=A0 create mode 100644 drivers/rng/turris_rwtm_rng.c
>>
>> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
>> index a89c899568..cd72852a47 100644
>> --- a/drivers/rng/Kconfig
>> +++ b/drivers/rng/Kconfig
>> @@ -105,4 +105,12 @@ config RNG_JH7110
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable True Random Number Ge=
nerator in StarFive JH7110 SoCs.
>> +config RNG_TURRIS_RWTM
>> +=C2=A0=C2=A0=C2=A0 bool "Turris Mox TRNG in Secure Processor"
>> +=C2=A0=C2=A0=C2=A0 depends on DM_RNG && ARMADA_3700
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Use TRNG in Turris Mox Secure Processor=
 Firmware. Can be used
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on other Armada-3700 devices (like Espr=
essoBin) if Secure
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Firmware from CZ.NIC is used.
>> +
>> =C2=A0 endif
>> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
>> index 7e64c4cdfc..ecae1a3da3 100644
>> --- a/drivers/rng/Makefile
>> +++ b/drivers/rng/Makefile
>> @@ -17,3 +17,4 @@ obj-$(CONFIG_RNG_SMCCC_TRNG) +=3D smccc_trng.o
>> =C2=A0 obj-$(CONFIG_RNG_ARM_RNDR) +=3D arm_rndr.o
>> =C2=A0 obj-$(CONFIG_TPM_RNG) +=3D tpm_rng.o
>> =C2=A0 obj-$(CONFIG_RNG_JH7110) +=3D jh7110_rng.o
>> +obj-$(CONFIG_RNG_TURRIS_RWTM) +=3D turris_rwtm_rng.o
>> diff --git a/drivers/rng/turris_rwtm_rng.c
>> b/drivers/rng/turris_rwtm_rng.c
>> new file mode 100644
>> index 0000000000..ec2cb0bca3
>> --- /dev/null
>> +++ b/drivers/rng/turris_rwtm_rng.c
>> @@ -0,0 +1,122 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
>> +/*
>> + * Copyright (c) 2024, Max Resch
>> + */
>> +
>> +#include <dm.h>
>> +#include <malloc.h>
>> +#include <rng.h>
>> +#include <asm/dma-mapping.h>
>> +#include <asm/types.h>
>> +#include <mach/mbox.h>
>> +
>> +/* size of entropy buffer */
>> +#define RNG_BUFFER_SIZE=C2=A0=C2=A0=C2=A0 128U
>> +
>> +struct turris_rwtm_rng_priv {
>> +=C2=A0=C2=A0=C2=A0 phys_addr_t buffer;
>> +};
>> +
>> +static int turris_rwtm_rng_fill_entropy(phys_addr_t entropy, size_t
>> size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 u32 args[3] =3D { 1, (u32)entropy, size };

On a device with memory above 4 GiB this (u32) conversion may point to a
different location than rwtm_rng_priv.

Is the Armada 3700 family restricted to below 4 GiB?

Should we add a check in the probe function?

Best regards

Heinrich

>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* flush data cache */
>> +=C2=A0=C2=A0=C2=A0 flush_dcache_range(entropy, entropy + size);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * get entropy
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * args[0] =3D 1 copies BYTES array in args[1]=
 of length args[2]
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 ret =3D mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, 3, N=
ULL, 0);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* invalidate data cache */
>> +=C2=A0=C2=A0=C2=A0 invalidate_dcache_range(entropy, entropy + size);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static int turris_rwtm_rng_random_read(struct udevice *dev, void
>> *data, size_t count)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct turris_rwtm_rng_priv *priv =3D dev_get_priv(=
dev);
>> +=C2=A0=C2=A0=C2=A0 phys_addr_t phys;
>> +=C2=A0=C2=A0=C2=A0 size_t size;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 phys =3D priv->buffer;
>> +
>> +=C2=A0=C2=A0=C2=A0 while (count) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D min_t(size_t, RNG_=
BUFFER_SIZE, count);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D turris_rwtm_rng_fil=
l_entropy(phys, size);
>
> Return code check missing here.
>
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(data, (void *)phys, =
size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count -=3D size;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D (u8 *)data + size;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static int turris_rwtm_rng_probe(struct udevice *dev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct turris_rwtm_rng_priv *priv =3D dev_get_priv(=
dev);
>> +=C2=A0=C2=A0=C2=A0 u32 args[] =3D { 0 };
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * check if the random command is supported
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * args[0] =3D 0 would copy 16 DWORDS entropy =
to out but we ignore
>> them
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 ret =3D mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, ARRA=
Y_SIZE(args),
>> NULL, 0);
>> +
>
> Please drop this empty line before the ret check.
>
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* entropy buffer */
>> +=C2=A0=C2=A0=C2=A0 priv->buffer =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* buffer address need to be aligned */
>> +=C2=A0=C2=A0=C2=A0 dma_alloc_coherent(RNG_BUFFER_SIZE, (unsigned long =
*)&priv->buffer);
>> +=C2=A0=C2=A0=C2=A0 if (!priv->buffer)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static int turris_rwtm_rng_remove(struct udevice *dev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct turris_rwtm_rng_priv *priv =3D dev_get_priv(=
dev);
>> +=C2=A0=C2=A0=C2=A0 phys_addr_t phys =3D priv->buffer;
>> +
>> +=C2=A0=C2=A0=C2=A0 dma_free_coherent((void *)phys);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static const struct dm_rng_ops turris_rwtm_rng_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .read =3D turris_rwtm_rng_random_read,
>> +};
>> +
>> +/*
>> + * only Turris MOX firmware has the RNG but allow all probable
>> devices to be
>> + * probed the default firmware will just reject the probe
>> + */
>> +static const struct udevice_id turris_rwtm_rng_match[] =3D {
>> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "cznic,turris-mox-rwtm" },
>> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "marvell,armada-3700-rwtm-firmwar=
e" },
>> +=C2=A0=C2=A0=C2=A0 {},
>> +};
>> +
>> +U_BOOT_DRIVER(turris_rwtm_rng) =3D {
>> +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =3D "turris-rwtm-rng",
>> +=C2=A0=C2=A0=C2=A0 .id=C2=A0=C2=A0=C2=A0 =3D UCLASS_RNG,
>> +=C2=A0=C2=A0=C2=A0 .of_match =3D turris_rwtm_rng_match,
>> +=C2=A0=C2=A0=C2=A0 .ops=C2=A0=C2=A0=C2=A0 =3D &turris_rwtm_rng_ops,
>> +=C2=A0=C2=A0=C2=A0 .probe=C2=A0=C2=A0=C2=A0 =3D turris_rwtm_rng_probe,
>> +=C2=A0=C2=A0=C2=A0 .remove =3D turris_rwtm_rng_remove,
>> +=C2=A0=C2=A0=C2=A0 .priv_auto =3D sizeof(struct turris_rwtm_rng_priv),
>> +};
>
> Thanks,
> Stefan

