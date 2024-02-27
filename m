Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD8DC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 299B287FD2;
	Tue, 27 Feb 2024 14:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j3hCY3Z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A6887FDE; Tue, 27 Feb 2024 14:37:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E79B87EDF
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709041039; x=1709645839; i=xypron.glpk@gmx.de;
 bh=A+bUu1cR8vibvkuV5EBCR20h0I2uLoFZe/pwI9IEcOU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=j3hCY3Z8M1nsDctqfz22wQN6+uIW6mhwXKVOeeTdOXwncWAKSinAtfvMPpQ1nIKa
 XWOr8GliTC67hJA6rIJLT77jZr0+urSpMUtIt5IvkYiBHO7ibP4TG0/gfnZJsHP/E
 i6tyBRU/gL1rLymq8ozZuefeD6xb+hcTcsLoU+m4uRFqfcT1DpWAPVT0bJbi/nODS
 vChGE9o2hdw/1hIV6ZAmpNlVgcSv6pcyLEDtsW1PavsP7Hk+E+bElMdeALXariLjO
 63upDTXO9RZAkolXvS0xVqjdIlsPOmyxjBmfWlOivfrVgU1rFu4eZ1piE1GZAjBoV
 zojDDxcMFdYZoTVV8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([95.222.37.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1rIuYZ0bNg-00M4xb; Tue, 27
 Feb 2024 14:37:19 +0100
Message-ID: <083f018d-d22e-455f-98c9-9c21730e4a7d@gmx.de>
Date: Tue, 27 Feb 2024 14:37:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] drivers: introduce mtdblock abstraction
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: kernel@salutedevices.com, u-boot@lists.denx.de,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 bmeng@tinylab.org, tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com, michal.simek@amd.com,
 mikhail.kshevetskiy@iopsys.eu, patrice.chotard@foss.st.com
References: <20240227100441.1811047-1-avromanov@salutedevices.com>
 <20240227100441.1811047-2-avromanov@salutedevices.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240227100441.1811047-2-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8tdnMwY/gRRuZazJ4xD6mWg9/VdElOLfZGBCjvptnrSa1XQk26M
 ghWOEJOjIepBir/vEiJmTewjzLwo32+EaSXWlDOHf/5nAF4zgEvr3UD5BEnPPhcgz2W1A2N
 qvH4t831Qa8KVmIMPMCduC+0AomBv4vYbzj+NxEsdHdq9x2KUuYD5LtLY8ZnV9V6SWnslki
 9Sl3tqLmX9LUOxmGeJP5g==
UI-OutboundReport: notjunk:1;M01:P0:6iEmw3g2lIo=;lTnUAy6kAEDtcS6qtK5eWAz0txl
 XrPtza1wgst7cr7b7HRAPo+TGvVvAirTBOMifoo7YXECxsRdtplkXSQ6Z9+He0pqNuGYrmnPO
 CDRoJI9IvfPFiE/IkYVXouIenwnv5jjkByB2Z4o7Fg1Cw43KL8F+jTLGO3BF62e2c/gzqlKDK
 XabmPdJKUzfzdC/NsAAoe+PWLEnh7+3P+tq2rt29aWBPPcylNQJHpNWtSL9uNQPboj+FN9ztX
 pdMefOSGIZ17SBtYnPUwjh7CAbfO+DMS4ZvWSrOlDrxG50X5lCzrXPrCSwFHFicVT8tGevmXe
 LeofauHsp8FXv309nYY29lytAyq+OEcI4nPZrPvqFkpFUm34Gmp+5+lyfc6RHSUigFx80oJ04
 r7o8Bb4x5Ok4S5XOixTw/EhVbwWaDUY1sIfT5GHUWPiCDIp81I/p1AUQQd+CIWZPFOaAneaJY
 43Uze4XBspi9/NhEWRQ0qcuxPdzVOGqhbqG2NCpzm+8Pj/1kwDmmUKqLxjzPWg37xwXq7x15v
 /nsKhNHnEipardzk2knKRi8AxOCTgXBWDL5EX3aEBNaVOeOkSoyxP/1HAFE3vJIm5rSctdMg6
 g8YTZG/9O0OokWzBl3uFRIRCUibEZ+kPmx7vkhE53QoJjAeWn55BeqAWmR8mkvfIrON4fS+WC
 eOOtydf45Feoi74dA7cZU1mpHfaJ1maEdxTCOkDPtrSTcNikhZ5YDjxxUCbPQLMEhgAkQqs3G
 a1cY1JGo9UO+tYF+6Nfw8eZTPh3ne+zdQyPvP4xpNG8wNUDN9NEMLWQ7oyTqziFFCae/aX3xy
 r58fWz8PKrLWvP4ByM2I4rpyfR2QYpf+u088XHZdgilZk=
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

On 27.02.24 11:04, Alexey Romanov wrote:
> MTD block - abstraction over MTD subsystem, allowing
> to read and write in blocks using BLK UCLASS.
>
> - Read algorithm:
>
>    1. Convert start block number to start address.
>    2. Read block_dev->blksz bytes using mtd_read() and
>       add to start address pointer block_dev->blksz bytes,
>       until the requested number of blocks have been read.
>
> - Write algorithm:
>
>    1. Convert start block number to start address.
>    2. Round this address down by mtd->erasesize.
>
>    Erase addr      Start addr
>       |                |
>       v                v
>       +----------------+----------------+----------------+
>       |     blksz      |      blksz     |      blksz     |
>       +----------------+----------------+----------------+
>
>    3. Calculate offset between this two addresses.
>    4. Read mtd->erasesize bytes using mtd_read() into
>       temporary buffer from erase address.
>
>    Erase addr      Start addr
>       |                |
>       v                v
>       +----------------+----------------+----------------+
>       |     blksz      |      blksz     |      blksz     |
>       +----------------+----------------+----------------+
>       ^            mtd->erasesize =3D blksz * 3

Can you really erase only the start of the erase block?

Wouldn't you have also to round the end address up to the end of an
erase block and read and rewrite the data between the end address and
the end of the last erase block?

>       |
>       |
>       |
>
>    mtd_read()
>    from here
>
>    5. Copy data from user buffer to temporary buffer with offset,
>       calculated at step 3.
>    6. Erase and write mtd->erasesize bytes at erase address
>       pointer using mtd_erase/mtd_write().
>    7. Add to erase address pointer mtd->erasesize bytes.
>    8. goto 1 until the requested number of blocks have
>       been written.

Commit messages is not were developers typically look for documentation.
Please, add the information to /doc/develop/ or to the source code.

Best regards

Heinrich

>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/block/blk-uclass.c |   1 +
>   drivers/mtd/Makefile       |   1 +
>   drivers/mtd/mtdblock.c     | 170 +++++++++++++++++++++++++++++++++++++
>   include/linux/mtd/mtd.h    |  12 +++
>   4 files changed, 184 insertions(+)
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
> index 0000000000..0563d0b795
> --- /dev/null
> +++ b/drivers/mtd/mtdblock.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 SaluteDevices, Inc.
> + *
> + * Author: Alexey Romanov <avromanov@salutedevices.com>
> + */
> +
> +#include <blk.h>
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
> +		pr_err("Cannot create block device");
> +		return ret;
> +	}
> +
> +	bdesc =3D dev_get_uclass_plat(bdev);
> +	dev_set_priv(bdev, mtd);
> +	bdesc->bdev =3D bdev;
> +
> +	return 0;
> +}
> +
> +static ulong mtd_bread(struct udevice *dev, lbaint_t start, lbaint_t bl=
kcnt,
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
> +	int ret;
> +
> +	ret =3D device_probe(dev);
> +	if (ret) {
> +		pr_err("Probing %s failed (err=3D%d)\n", dev->name, ret);
> +		return ret;
> +	}
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

