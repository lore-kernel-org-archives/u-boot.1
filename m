Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0B6C83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 08:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D222683390;
	Wed,  9 Jul 2025 10:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KF0ywmbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EA3083394; Wed,  9 Jul 2025 10:19:27 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38AD83371
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 10:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 43ADA5C63A8;
 Wed,  9 Jul 2025 08:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774B6C4CEEF;
 Wed,  9 Jul 2025 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752049163;
 bh=HBio2KDJfqlj2F0UvgYEqaAdPQfzWjdF0JXq7AXaBFc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KF0ywmbHMoKnLfqlzsy95o9Y0wu9l6Qv5LNTnMKl+5soyEifeHM2yYP6xJ3Sfby08
 Jv67sB7c9vQQv2DnPt2JO+a2mCdCQPImC07Y8MuMpjuXbWXKVPP41+DlETveuM2ZiM
 x8/yjyEaInHTZCF4zbG2Ek7HmV/ZlzZrUHeKoUcwYdJLQFCT+31q3IoePEVlfIG0cj
 0KFS97nvo4FOB96IfKHmpqaEx3W8BzjY0gL1Flw33eitzakJypuEJorVt3/PUj5jBW
 Co+nFD2UYjAW5I1WYcU7Pbbj5Y9c8uo970zlfiRBmuBoAVr7bDDqPyw4jTQYKEZIfV
 fjJwEjtTrK2Sw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de, Dmitrii Merkurev
 <dimorinny@google.com>
Subject: Re: [PATCH RFT v6 1/3] fastboot: blk: introduce fastboot block
 flashing support
In-Reply-To: <20250702045934.15bc47ab@karo-electronics.de>
References: <20250630-topic-fastboot-blk-v6-0-7cdfd3a24786@linaro.org>
 <20250630-topic-fastboot-blk-v6-1-7cdfd3a24786@linaro.org>
 <20250702045934.15bc47ab@karo-electronics.de>
Date: Wed, 09 Jul 2025 10:19:19 +0200
Message-ID: <87zfddpyig.fsf@kernel.org>
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

Hi Lothar,

Thanks for participating in review. I gave you some wording feedback
off-list but since I did not get any response I'm sending it to everyone
as well.

On Wed, Jul 02, 2025 at 04:59, Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>=
 wrote:

> Hi,
>
> On Mon, 30 Jun 2025 17:19:57 +0200 Neil Armstrong wrote:
>> From: Dmitrii Merkurev <dimorinny@google.com>
>>=20
>> Introduce fastboot block flashing functions and helpers
>> to be shared with the MMC implementation.
>>=20
>> The write logic comes from the mmc implementation, while
>> the partition lookup is much simpler and could be extended.
>>=20
>> For the erase logic, allmost no block drivers exposes the
>> erase operation, except mmc & virtio, so in order to allow
>> erasiong any partition a soft-erase logic has been added
>> to write zero-ed buffers in a loop.
>>=20
>> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>  drivers/fastboot/fb_block.c | 323 +++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/fb_block.h          | 105 ++++++++++++++
>>  2 files changed, 428 insertions(+)
>>=20
>> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..b725397c91af2717812e69e2=
b624076eb30f781d
>> --- /dev/null
>> +++ b/drivers/fastboot/fb_block.c
>> @@ -0,0 +1,323 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2024 The Android Open Source Project
>> + */
>> +
>> +#include <blk.h>
>> +#include <div64.h>
>> +#include <fastboot-internal.h>
>> +#include <fastboot.h>
>> +#include <fb_block.h>
>> +#include <image-sparse.h>
>> +#include <part.h>
>> +#include <malloc.h>
>>
> The alphabet seems to be a difficult concept for programmers to
> grasp... ;-)


This might be intended as a joke, but it could also be taken as an insult
for the submitter. ("the submitter is so dumb he could not even sort
alphabetically his includes").

Next time, please consider using something more neutral like:
"Make sure to sort alphabetically your includes".

No ill intention here. Thanks again for reviewing patches submitted on
the U-Boot mailing list.

Mattijs

>
>> +/**
>> + * FASTBOOT_MAX_BLOCKS_ERASE - maximum blocks to erase per derase call
>> + *
>> + * in the ERASE case we can have much larger buffer size since
>> + * we're not transferring an actual buffer
>> + */
>> +#define FASTBOOT_MAX_BLOCKS_ERASE 1048576
>> +/**
>> + * FASTBOOT_MAX_BLOCKS_SOFT_ERASE - maximum blocks to software erase at=
 once
>> + */
>> +#define FASTBOOT_MAX_BLOCKS_SOFT_ERASE 4096
>> +/**
>> + * FASTBOOT_MAX_BLOCKS_WRITE - maximum blocks to write per dwrite call
>> + */
>> +#define FASTBOOT_MAX_BLOCKS_WRITE 65536
>> +
> Why invent an arbitrary number here, when there is already
> CONFIG_FASTBOOT_BUF_SIZE which could be used for this purpose?
>
>> +struct fb_block_sparse {
>> +	struct blk_desc	*dev_desc;
>> +};
>> +
>> +/* Write 0s instead of using erase operation, inefficient but functiona=
l */
>> +static lbaint_t fb_block_soft_erase(struct blk_desc *block_dev, lbaint_=
t blk,
>> +				    lbaint_t cur_blkcnt, lbaint_t erase_buf_blks,
>> +				    void *erase_buffer)
>> +{
>> +	lbaint_t blks_written =3D 0;
>> +	int j;
>>
> lbaint_t to match the type of cur_blkcnt and prevent integer overflow
> on 32bit systems!
>
>> +
>> +	memset(erase_buffer, 0, erase_buf_blks * block_dev->blksz);
>> +
>> +	for (j =3D 0; j < cur_blkcnt; j +=3D erase_buf_blks) {
>> +		lbaint_t remain =3D min_t(lbaint_t, cur_blkcnt - j,
>> +				erase_buf_blks);
>> +
> No need for min_t() here (see above).
>
>> +		blks_written +=3D blk_dwrite(block_dev, blk + j,
>> +				remain, erase_buffer);
>> +		printf(".");
>> +	}
>> +
>> +	return blks_written;
>> +}
>> +
>> +static lbaint_t fb_block_write(struct blk_desc *block_dev, lbaint_t sta=
rt,
>> +			       lbaint_t blkcnt, const void *buffer)
>> +{
>> +	lbaint_t blk =3D start;
>> +	lbaint_t blks_written =3D 0;
>> +	lbaint_t cur_blkcnt =3D 0;
>>
> useless initialization of cur_blkcnt; definition could be moved inside
> the for loop.
>> +	lbaint_t blks =3D 0;
>> +	void *erase_buf =3D NULL;
>> +	int erase_buf_blks =3D 0;
>> +	int step =3D buffer ? FASTBOOT_MAX_BLOCKS_WRITE : FASTBOOT_MAX_BLOCKS_=
ERASE;
>> +	int i;
>>
> lbaint_t for 'step' an 'i' to match the type of blkcnt!
>
>> +
>> +	for (i =3D 0; i < blkcnt; i +=3D step) {
>> +		cur_blkcnt =3D min((int)blkcnt - i, step);
>>
> No type cast needed.
>
>
> Lothar Wa=C3=9Fmann
