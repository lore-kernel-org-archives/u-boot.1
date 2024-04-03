Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E57CD1294
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 09:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB5A388206;
	Wed,  3 Apr 2024 11:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PIJNjdSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F48E8820C; Wed,  3 Apr 2024 11:51:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABEBB881F6
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 11:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712137839; x=1712742639; i=xypron.glpk@gmx.de;
 bh=Qj3EtsTPfSN2O8iaztVvTs3UFBB1qKJc/3Hc3UUoYAo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=PIJNjdSsOpUYSZNWV2t562Xov7vp/eLdkUauzdEEM26+kZxfHJGAmRvkcbRZe355
 25JR7ccxcX5f0A5qE0037IdMJF3hwoP5DYxnv3W8VeiJpPupKdnPwtQyBafIwvNmh
 VUf7aVQIzdAUAXgSFfgdfFr+T1Oz3HXPjMSnssbJqH5HZeeDE9vGJUZl9MkdJGfjt
 vhHpGiWBPYQACHCDxz+ECGbwgaTA0th3z/DkVJKl7G/NeBHVI+ibaL5U8wAd7JS7e
 FiZZdtFb0obDzWgETduaURnuRG9OZ7TxdqMcXxEPEKVztszy17fA/glL6utbE1R5j
 GPbGr31kq2AopYTvdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O6e-1rpCu90nss-003tXx; Wed, 03
 Apr 2024 11:50:39 +0200
Message-ID: <fdb5fdb2-393d-43f0-895a-a7a2a088846f@gmx.de>
Date: Wed, 3 Apr 2024 11:50:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drivers: introduce mtdblock abstraction
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 bmeng@tinylab.org, tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com, michal.simek@amd.com,
 mikhail.kshevetskiy@iopsys.eu, patrice.chotard@foss.st.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240307130726.1582487-1-avromanov@salutedevices.com>
 <20240307130726.1582487-3-avromanov@salutedevices.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240307130726.1582487-3-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nnKbVr85LlOeMmAcxgn/Nv1Bag/HvwRgdL6g6PC3vM4d1LqRgsV
 6MkbNHRPjHRhylzTQjHmCzcvoYBARSyC701KzExLwVuNFosEgMScrcmpS1i6y+6+jd+xzJb
 m6qex+1Zhb+KQvQtnt8QZoT4qITq0m3KJnUy7m9MwXAvkeJZFvvJVrvSP79N3epfl4E7aFY
 nffppFQmzfFH9IE/3XCwQ==
UI-OutboundReport: notjunk:1;M01:P0:BBAckjro0Kk=;axa6yuR+QaQOPPL0gAPjjymZzWr
 9rYnkEQ5limXTj0sLNgjqLRMdItuaZ33bN4AN5LZz1On+fpdYzmuGs4dfAC0IwdDX6p7e0AtK
 /h0V5cejX065yByyFmGksGliVrJdFnGTwYzIwljR0QktLWSAgohjYvm0ECiKSRp4FZL5lO6Ud
 vRq/w0Xnp6SsHj3hT+P4UY4bwA9lzxhaaok9LvuKN/9RJxS++u2Y5DrWtwRS+cr4L/oZsEl4Q
 UT0Dlk9D4N/QrQFHjuHa1TSaXTuUeRHYqerQPrtYRiRTvDsZ2WjAUTivCd9JGc0KwCxxV8NJD
 AChfFrdSNtbymhUOFgAUDfn3fGucApIKcPw/tcH2R08rSMxymbuxFfA/IfT908diT57VN8Xv8
 vAoCGFHIvJgqal2Cj/64Hej/OoG9M+Fxm4tde9VtR5qUXsQUQiv0ncIFtHkKS0v4CRKz4ef13
 Pbyp+vH5MLXoWQFaZKUMeRLGuv6pqjhaIjlo6o07J7SQnnPexL/VnKVGMec7v2TJ5aZwXhpUF
 omT2kODWJk5VIFu4GpCCklS3YsVbsNfBK05btlM2wvJlHAyssiqH3P2E8i43ik1J/+hAeSe3G
 G/yVshHm/nxJ+OLhimN9uP2ZwGL7b2EMG/yLV3Z1utIflXPPeDyZKxT3PB4O1r4GIZUWscRq0
 wvvL0NwkMRYUNVnkAJfIbr42aawMsx1d05hf7X3VBF//AssS4I9WqkcCoZ7675gOwUDyMKXKF
 bLghQQRbDesvZiTyCzFsbGyvqKC8Lvv+jcs8usqLMs536McRTzdaSCGaZ68Jz/rCj5MxzJCsr
 76gLmLdYa8KrpRAOrMjvX5Yza0yOpEkM+OIyo7+nCtsTQ=
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

On 07.03.24 14:07, Alexey Romanov wrote:
> MTD block - abstraction over MTD subsystem, allowing
> to read and write in blocks using BLK UCLASS.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/block/blk-uclass.c |   1 +
>   drivers/mtd/Makefile       |   1 +
>   drivers/mtd/mtdblock.c     | 227 +++++++++++++++++++++++++++++++++++++
>   include/linux/mtd/mtd.h    |  12 ++
>   4 files changed, 241 insertions(+)
>   create mode 100644 drivers/mtd/mtdblock.c
>
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index 77066da352..ab0a9105c9 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -37,6 +37,7 @@ static struct {
>   	{ UCLASS_PVBLOCK, "pvblock" },
>   	{ UCLASS_BLKMAP, "blkmap" },
>   	{ UCLASS_RKMTD, "rkmtd" },
> +	{ UCLASS_MTD, "mtd" },
>   };
>
>   static enum uclass_id uclass_name_to_iftype(const char *uclass_idname)
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index c638980ea2..993b122ac4 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -26,6 +26,7 @@ obj-y +=3D onenand/
>   obj-y +=3D spi/
>   obj-$(CONFIG_MTD_UBI) +=3D ubi/
>   obj-$(CONFIG_NVMXIP) +=3D nvmxip/
> +obj-$(CONFIG_BLK) +=3D mtdblock.o
>
>   #SPL/TPL build
>   else
> diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> new file mode 100644
> index 0000000000..b409674173
> --- /dev/null
> +++ b/drivers/mtd/mtdblock.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0+

nits:

GPL-2.0-or-later
see https://spdx.org/licenses/GPL-2.0-or-later.html

> +/*
> + * MTD block - abstraction over MTD subsystem, allowing
> + * to read and write in blocks using BLK UCLASS.
> + *
> + * - Read algorithm:
> + *
> + *   1. Convert start block number to start address.
> + *   2. Read block_dev->blksz bytes using mtd_read() and
> + *      add to start address pointer block_dev->blksz bytes,
> + *      until the requested number of blocks have been read.
> + *
> + * - Write algorithm:
> + *
> + *   1. Convert start block number to start address.
> + *   2. Round this address down by mtd->erasesize.
> + *
> + *   Erase addr      Start addr
> + *      |                |
> + *      v                v
> + *      +----------------+----------------+----------------+
> + *      |     blksz      |      blksz     |      blksz     |
> + *      +----------------+----------------+----------------+
> + *
> + *   3. Calculate offset between this two addresses.
> + *   4. Read mtd->erasesize bytes using mtd_read() into
> + *      temporary buffer from erase address.
> + *
> + *   Erase addr      Start addr
> + *      |                |
> + *      v                v
> + *      +----------------+----------------+----------------+
> + *      |     blksz      |      blksz     |      blksz     |
> + *      +----------------+----------------+----------------+
> + *      ^
> + *      |
> + *      |
> + *   mtd_read()
> + *   from here
> + *
> + *   5. Copy data from user buffer to temporary buffer with offset,
> + *      calculated at step 3.
> + *   6. Erase and write mtd->erasesize bytes at erase address
> + *      pointer using mtd_erase/mtd_write().
> + *   7. Add to erase address pointer mtd->erasesize bytes.
> + *   8. goto 1 until the requested number of blocks have
> + *      been written.
> + *
> + * (C) Copyright 2024 SaluteDevices, Inc.
> + *
> + * Author: Alexey Romanov <avromanov@salutedevices.com>
> + */
> +
> +#include <blk.h>
> +#include <part.h>
> +#include <dm/device.h>
> +#include <dm/device-internal.h>
> +#include <linux/mtd/mtd.h>
> +
> +int mtd_bind(struct udevice *dev, struct mtd_info **mtd)
> +{
> +	struct blk_desc *bdesc;
> +	struct udevice *bdev;
> +	int ret;
> +
> +	ret =3D blk_create_devicef(dev, "mtd_blk", "blk", UCLASS_MTD,
> +				 dev_seq(dev), 512, 0, &bdev);
> +	if (ret) {
> +		pr_err("Cannot create block device\n");
> +		return ret;
> +	}
> +
> +	bdesc =3D dev_get_uclass_plat(bdev);
> +	dev_set_priv(bdev, mtd);
> +	bdesc->bdev =3D bdev;
> +	bdesc->part_type =3D PART_TYPE_MTD;
> +
> +	return 0;
> +}
> +
> +static ulong mtd_bread(struct udevice *dev, lbaint_t start, lbaint_t bl=
kcnt,

nits:

Reading bread I thought of nutrition. How about mtd_blk_read()?

> +		       void *dst)
> +{
> +	struct blk_desc *block_dev =3D dev_get_uclass_plat(dev);
> +	struct mtd_info *mtd =3D blk_desc_to_mtd(block_dev);
> +	unsigned int sect_size =3D block_dev->blksz;
> +	lbaint_t cur =3D start;
> +	ulong read_cnt =3D 0;
> +
> +	while (read_cnt < blkcnt) {
> +		int ret;
> +		loff_t sect_start =3D cur * sect_size;
> +		size_t retlen;
> +
> +		ret =3D mtd_read(mtd, sect_start, sect_size, &retlen, dst);
> +		if (ret)
> +			return ret;
> +
> +		if (retlen !=3D sect_size) {
> +			pr_err("mtdblock: failed to read block 0x%lx\n", cur);
> +			return -EIO;
> +		}
> +
> +		cur++;
> +		dst +=3D sect_size;
> +		read_cnt++;
> +	}
> +
> +	return read_cnt;
> +}
> +
> +static int mtd_erase_write(struct mtd_info *mtd, uint64_t start, const =
void *src)
> +{
> +	int ret;
> +	size_t retlen;
> +	struct erase_info erase =3D { 0 };
> +
> +	erase.mtd =3D mtd;
> +	erase.addr =3D start;
> +	erase.len =3D mtd->erasesize;
> +
> +	ret =3D mtd_erase(mtd, &erase);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mtd_write(mtd, start, mtd->erasesize, &retlen, src);
> +	if (ret)
> +		return ret;
> +
> +	if (retlen !=3D mtd->erasesize) {
> +		pr_err("mtdblock: failed to read block at 0x%llx\n", start);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static ulong mtd_bwrite(struct udevice *dev, lbaint_t start, lbaint_t b=
lkcnt,

mtd_blk_write()?

Best regards

Heinrich

> +			const void *src)
> +{
> +	struct blk_desc *block_dev =3D dev_get_uclass_plat(dev);
> +	struct mtd_info *mtd =3D blk_desc_to_mtd(block_dev);
> +	unsigned int sect_size =3D block_dev->blksz;
> +	lbaint_t cur =3D start, blocks_todo =3D blkcnt;
> +	ulong write_cnt =3D 0;
> +	u8 *buf;
> +	int ret =3D 0;
> +
> +	buf =3D malloc(mtd->erasesize);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	while (blocks_todo > 0) {
> +		loff_t sect_start =3D cur * sect_size;
> +		loff_t erase_start =3D ALIGN_DOWN(sect_start, mtd->erasesize);
> +		u32 offset =3D sect_start - erase_start;
> +		size_t cur_size =3D min_t(size_t,  mtd->erasesize - offset,
> +					blocks_todo * sect_size);
> +		size_t retlen;
> +		lbaint_t written;
> +
> +		ret =3D mtd_read(mtd, erase_start, mtd->erasesize, &retlen, buf);
> +		if (ret)
> +			goto out;
> +
> +		if (retlen !=3D mtd->erasesize) {
> +			pr_err("mtdblock: failed to read block 0x%lx\n", cur);
> +			ret =3D -EIO;
> +			goto out;
> +		}
> +
> +		memcpy(buf + offset, src, cur_size);
> +
> +		ret =3D mtd_erase_write(mtd, erase_start, buf);
> +		if (ret)
> +			goto out;
> +
> +		written =3D cur_size / sect_size;
> +
> +		blocks_todo -=3D written;
> +		cur +=3D written;
> +		src +=3D cur_size;
> +		write_cnt +=3D written;
> +	}
> +
> +out:
> +	free(buf);
> +
> +	if (ret)
> +		return ret;
> +
> +	return write_cnt;
> +}
> +
> +static int mtd_blk_probe(struct udevice *dev)
> +{
> +	struct blk_desc *bdesc;
> +	struct mtd_info *mtd;
> +	int ret;
> +
> +	ret =3D device_probe(dev);
> +	if (ret) {
> +		pr_err("Probing %s failed (err=3D%d)\n", dev->name, ret);
> +		return ret;
> +	}
> +
> +	bdesc =3D dev_get_uclass_plat(dev);
> +	mtd =3D blk_desc_to_mtd(bdesc);
> +
> +	if (mtd_type_is_nand(mtd))
> +		pr_warn("MTD device '%s' is NAND, please use UBI devices instead\n",
> +			mtd->name);
> +
> +	return 0;
> +}
> +
> +static const struct blk_ops mtd_blk_ops =3D {
> +	.read =3D mtd_bread,
> +	.write =3D mtd_bwrite,
> +};
> +
> +U_BOOT_DRIVER(mtd_blk) =3D {
> +	.name =3D "mtd_blk",
> +	.id =3D UCLASS_BLK,
> +	.ops =3D &mtd_blk_ops,
> +	.probe =3D mtd_blk_probe,
> +};
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 09f5269887..9b997fadd1 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -26,6 +26,9 @@
>   #include <dm/device.h>
>   #endif
>   #include <dm/ofnode.h>
> +#if IS_ENABLED(CONFIG_BLK)
> +#include <blk.h>
> +#endif
>
>   #define MAX_MTD_DEVICES 32
>   #endif
> @@ -412,6 +415,15 @@ int mtd_write(struct mtd_info *mtd, loff_t to, size=
_t len, size_t *retlen,
>   int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_=
t *retlen,
>   		    const u_char *buf);
>
> +#if IS_ENABLED(CONFIG_BLK)
> +static inline struct mtd_info *blk_desc_to_mtd(struct blk_desc *bdesc)
> +{
> +	return *((struct mtd_info **)dev_get_priv(bdesc->bdev));
> +}
> +
> +int mtd_bind(struct udevice *dev, struct mtd_info **mtd);
> +#endif
> +
>   int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops=
 *ops);
>   int mtd_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops =
*ops);
>

