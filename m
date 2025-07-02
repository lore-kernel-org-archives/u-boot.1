Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E26C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 02:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1A682103;
	Wed,  2 Jul 2025 04:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="PTcLORex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20EBE82A76; Wed,  2 Jul 2025 04:59:38 +0200 (CEST)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CD481FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 04:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
 s=kas202503070814; t=1751425175;
 bh=p0S96Zj3NoQHtRiEJ5X+YvH5nBqHZ3HpCZ1pJnCQR/E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PTcLORexnoDbvA5mQS4BMOLh1x4o3GulbG2U+nt0i3NAKCfFAeQ+Gvq3rnPkStqvj
 clF9IEwO8AB+BU2ymPfKnN95VPnX2FZfiWJKHatPIN0HJfBda2TVke4NZvDNYw20hM
 LbVEdcRMZqAf9iy96GiSzmIwS8GJYfWJZBGjjD52F+sB4aHUi9WEIYhQHJjwaBqEFZ
 73VjjbpElwEr8406WtUrG4XfLGZgQoloTgPc30IdHEjt4B6C32Ep2RR4YsrbOCJzex
 qOE6khkAcYqpzWTpUwN5uL2up4DuEs+cCYW21zXunQSn/mmiul2YMSYhd5rGHBnmEa
 fy9C1VX1V5bRA==
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id 6D8F87721A54;
 Wed,  2 Jul 2025 04:59:35 +0200 (CEST)
Date: Wed, 2 Jul 2025 04:59:34 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de, Dmitrii Merkurev
 <dimorinny@google.com>
Subject: Re: [PATCH RFT v6 1/3] fastboot: blk: introduce fastboot block
 flashing support
Message-ID: <20250702045934.15bc47ab@karo-electronics.de>
In-Reply-To: <20250630-topic-fastboot-blk-v6-1-7cdfd3a24786@linaro.org>
References: <20250630-topic-fastboot-blk-v6-0-7cdfd3a24786@linaro.org>
 <20250630-topic-fastboot-blk-v6-1-7cdfd3a24786@linaro.org>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Mon, 30 Jun 2025 17:19:57 +0200 Neil Armstrong wrote:
> From: Dmitrii Merkurev <dimorinny@google.com>
>=20
> Introduce fastboot block flashing functions and helpers
> to be shared with the MMC implementation.
>=20
> The write logic comes from the mmc implementation, while
> the partition lookup is much simpler and could be extended.
>=20
> For the erase logic, allmost no block drivers exposes the
> erase operation, except mmc & virtio, so in order to allow
> erasiong any partition a soft-erase logic has been added
> to write zero-ed buffers in a loop.
>=20
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/fastboot/fb_block.c | 323 ++++++++++++++++++++++++++++++++++++++=
++++++
>  include/fb_block.h          | 105 ++++++++++++++
>  2 files changed, 428 insertions(+)
>=20
> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b725397c91af2717812e69e2b=
624076eb30f781d
> --- /dev/null
> +++ b/drivers/fastboot/fb_block.c
> @@ -0,0 +1,323 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 The Android Open Source Project
> + */
> +
> +#include <blk.h>
> +#include <div64.h>
> +#include <fastboot-internal.h>
> +#include <fastboot.h>
> +#include <fb_block.h>
> +#include <image-sparse.h>
> +#include <part.h>
> +#include <malloc.h>
>
The alphabet seems to be a difficult concept for programmers to
grasp... ;-)

> +/**
> + * FASTBOOT_MAX_BLOCKS_ERASE - maximum blocks to erase per derase call
> + *
> + * in the ERASE case we can have much larger buffer size since
> + * we're not transferring an actual buffer
> + */
> +#define FASTBOOT_MAX_BLOCKS_ERASE 1048576
> +/**
> + * FASTBOOT_MAX_BLOCKS_SOFT_ERASE - maximum blocks to software erase at =
once
> + */
> +#define FASTBOOT_MAX_BLOCKS_SOFT_ERASE 4096
> +/**
> + * FASTBOOT_MAX_BLOCKS_WRITE - maximum blocks to write per dwrite call
> + */
> +#define FASTBOOT_MAX_BLOCKS_WRITE 65536
> +
Why invent an arbitrary number here, when there is already
CONFIG_FASTBOOT_BUF_SIZE which could be used for this purpose?

> +struct fb_block_sparse {
> +	struct blk_desc	*dev_desc;
> +};
> +
> +/* Write 0s instead of using erase operation, inefficient but functional=
 */
> +static lbaint_t fb_block_soft_erase(struct blk_desc *block_dev, lbaint_t=
 blk,
> +				    lbaint_t cur_blkcnt, lbaint_t erase_buf_blks,
> +				    void *erase_buffer)
> +{
> +	lbaint_t blks_written =3D 0;
> +	int j;
>
lbaint_t to match the type of cur_blkcnt and prevent integer overflow
on 32bit systems!

> +
> +	memset(erase_buffer, 0, erase_buf_blks * block_dev->blksz);
> +
> +	for (j =3D 0; j < cur_blkcnt; j +=3D erase_buf_blks) {
> +		lbaint_t remain =3D min_t(lbaint_t, cur_blkcnt - j,
> +				erase_buf_blks);
> +
No need for min_t() here (see above).

> +		blks_written +=3D blk_dwrite(block_dev, blk + j,
> +				remain, erase_buffer);
> +		printf(".");
> +	}
> +
> +	return blks_written;
> +}
> +
> +static lbaint_t fb_block_write(struct blk_desc *block_dev, lbaint_t star=
t,
> +			       lbaint_t blkcnt, const void *buffer)
> +{
> +	lbaint_t blk =3D start;
> +	lbaint_t blks_written =3D 0;
> +	lbaint_t cur_blkcnt =3D 0;
>
useless initialization of cur_blkcnt; definition could be moved inside
the for loop.
> +	lbaint_t blks =3D 0;
> +	void *erase_buf =3D NULL;
> +	int erase_buf_blks =3D 0;
> +	int step =3D buffer ? FASTBOOT_MAX_BLOCKS_WRITE : FASTBOOT_MAX_BLOCKS_E=
RASE;
> +	int i;
>
lbaint_t for 'step' an 'i' to match the type of blkcnt!

> +
> +	for (i =3D 0; i < blkcnt; i +=3D step) {
> +		cur_blkcnt =3D min((int)blkcnt - i, step);
>
No type cast needed.


Lothar Wa=C3=9Fmann
