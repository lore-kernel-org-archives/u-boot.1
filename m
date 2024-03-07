Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A9BC48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 14:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F19587E39;
	Thu,  7 Mar 2024 15:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="R83k96t1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D3A087EBD; Thu,  7 Mar 2024 11:24:46 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9087F87E11
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 11:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B49C310000F;
 Thu,  7 Mar 2024 13:24:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B49C310000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709807082;
 bh=7Rhhy/u6pqPse8f4v4KsxPndizTXCjCodrFlNGVmszE=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=R83k96t1ZVMAqCOszs9stsDSUjvN8NuqWuLkYdoSI5FRgtbLQdhQDtI2DPWHGfyoc
 X7f0+xy8spuGAxBtNfvwKAnr+7JA/bGHXNKI1PtDucmLhaInE4nS8aS/bi+16FTmbW
 urbyK5aN+C6gfFgl/gVfWtFtByLo9eAp/x7wyyYLq0s17t5osuvQsc9P+75Pmw6qVx
 YOFVyeAMul03vR38sqBfm1hCpO2geOrEY5Rvo4gFafM4D4F5GVw4FIEpEaFeDicsVw
 WbxAjqoU3F4URzj9ze086M5dJkSoU9DpbbXb336ljKG7DESE3PPZaPiflulLgPajZW
 bdCsKFY2y21jA==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru
 [172.24.196.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  7 Mar 2024 13:24:42 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Mar 2024 13:24:42 +0300
Received: from p-i-exch-a-m1.sberdevices.ru (172.24.196.116) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 13:24:42 +0300
Received: from p-i-exch-a-m1.sberdevices.ru ([fe80::49d0:5751:faed:eb08]) by
 p-i-exch-a-m1.sberdevices.ru ([fe80::49d0:5751:faed:eb08%10]) with mapi id
 15.02.1544.004; Thu, 7 Mar 2024 13:24:42 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: kernel <kernel@sberdevices.ru>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, "michael@amarulasolutions.com"
 <michael@amarulasolutions.com>, "frieder.schrempf@kontron.de"
 <frieder.schrempf@kontron.de>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "sjg@chromium.org" <sjg@chromium.org>,
 "bmeng@tinylab.org" <bmeng@tinylab.org>, "tobias@waldekranz.com"
 <tobias@waldekranz.com>, "jpewhacker@gmail.com" <jpewhacker@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "jbx6244@gmail.com"
 <jbx6244@gmail.com>, "abdellatif.elkhlifi@arm.com"
 <abdellatif.elkhlifi@arm.com>, "michal.simek@amd.com" <michal.simek@amd.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v1 1/4] drivers: introduce mtdblock abstraction
Thread-Topic: [PATCH v1 1/4] drivers: introduce mtdblock abstraction
Thread-Index: AQHaaWRq1gNB1mcZxEGOgA+vHYmZg7Ed/xWAgA3vJgA=
Date: Thu, 7 Mar 2024 10:24:41 +0000
Message-ID: <20240307102436.r6ansla3xz6d4j7u@cab-wsm-0029881>
References: <20240227100441.1811047-1-avromanov@salutedevices.com>
 <20240227100441.1811047-2-avromanov@salutedevices.com>
 <083f018d-d22e-455f-98c9-9c21730e4a7d@gmx.de>
In-Reply-To: <083f018d-d22e-455f-98c9-9c21730e4a7d@gmx.de>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EADAE6C35A050B4AA2AECC28B37AD94C@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 07 Mar 2024 15:55:57 +0100
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

Hi Heinrich,

On Tue, Feb 27, 2024 at 02:37:17PM +0100, Heinrich Schuchardt wrote:
> On 27.02.24 11:04, Alexey Romanov wrote:
> > MTD block - abstraction over MTD subsystem, allowing
> > to read and write in blocks using BLK UCLASS.
> >=20
> > - Read algorithm:
> >=20
> >    1. Convert start block number to start address.
> >    2. Read block_dev->blksz bytes using mtd_read() and
> >       add to start address pointer block_dev->blksz bytes,
> >       until the requested number of blocks have been read.
> >=20
> > - Write algorithm:
> >=20
> >    1. Convert start block number to start address.
> >    2. Round this address down by mtd->erasesize.
> >=20
> >    Erase addr      Start addr
> >       |                |
> >       v                v
> >       +----------------+----------------+----------------+
> >       |     blksz      |      blksz     |      blksz     |
> >       +----------------+----------------+----------------+
> >=20
> >    3. Calculate offset between this two addresses.
> >    4. Read mtd->erasesize bytes using mtd_read() into
> >       temporary buffer from erase address.
> >=20
> >    Erase addr      Start addr
> >       |                |
> >       v                v
> >       +----------------+----------------+----------------+
> >       |     blksz      |      blksz     |      blksz     |
> >       +----------------+----------------+----------------+
> >       ^            mtd->erasesize =3D blksz * 3
>=20
> Can you really erase only the start of the erase block?

Yeah.

>=20
> Wouldn't you have also to round the end address up to the end of an
> erase block and read and rewrite the data between the end address and
> the end of the last erase block?

I think I didn't express myself quite correctly. Of coure, we erase
and write only by mtd->erasesize bytes and don't overwrite this field.

> >       ^            mtd->erasesize =3D blksz * 3

I just wrote that for example mtd->erasesize can be equal to blksz * 3,
for the situtation I describe above. In reality it can be anything. I
will describe this point in more detail in v2.


>=20
> >       |
> >       |
> >       |
> >=20
> >    mtd_read()
> >    from here
> >=20
> >    5. Copy data from user buffer to temporary buffer with offset,
> >       calculated at step 3.
> >    6. Erase and write mtd->erasesize bytes at erase address
> >       pointer using mtd_erase/mtd_write().
> >    7. Add to erase address pointer mtd->erasesize bytes.
> >    8. goto 1 until the requested number of blocks have
> >       been written.
>=20
> Commit messages is not were developers typically look for documentation.
> Please, add the information to /doc/develop/ or to the source code.

Move it to docs in v2.

>=20
> Best regards
>=20
> Heinrich
>=20
> >=20
> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > ---
> >   drivers/block/blk-uclass.c |   1 +
> >   drivers/mtd/Makefile       |   1 +
> >   drivers/mtd/mtdblock.c     | 170 ++++++++++++++++++++++++++++++++++++=
+
> >   include/linux/mtd/mtd.h    |  12 +++
> >   4 files changed, 184 insertions(+)
> >   create mode 100644 drivers/mtd/mtdblock.c
> >=20
> > diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> > index 77066da352..ab0a9105c9 100644
> > --- a/drivers/block/blk-uclass.c
> > +++ b/drivers/block/blk-uclass.c
> > @@ -37,6 +37,7 @@ static struct {
> >   	{ UCLASS_PVBLOCK, "pvblock" },
> >   	{ UCLASS_BLKMAP, "blkmap" },
> >   	{ UCLASS_RKMTD, "rkmtd" },
> > +	{ UCLASS_MTD, "mtd" },
> >   };
> >=20
> >   static enum uclass_id uclass_name_to_iftype(const char *uclass_idname=
)
> > diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> > index c638980ea2..993b122ac4 100644
> > --- a/drivers/mtd/Makefile
> > +++ b/drivers/mtd/Makefile
> > @@ -26,6 +26,7 @@ obj-y +=3D onenand/
> >   obj-y +=3D spi/
> >   obj-$(CONFIG_MTD_UBI) +=3D ubi/
> >   obj-$(CONFIG_NVMXIP) +=3D nvmxip/
> > +obj-$(CONFIG_BLK) +=3D mtdblock.o
> >=20
> >   #SPL/TPL build
> >   else
> > diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> > new file mode 100644
> > index 0000000000..0563d0b795
> > --- /dev/null
> > +++ b/drivers/mtd/mtdblock.c
> > @@ -0,0 +1,170 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * (C) Copyright 2024 SaluteDevices, Inc.
> > + *
> > + * Author: Alexey Romanov <avromanov@salutedevices.com>
> > + */
> > +
> > +#include <blk.h>
> > +#include <dm/device.h>
> > +#include <dm/device-internal.h>
> > +#include <linux/mtd/mtd.h>
> > +
> > +int mtd_bind(struct udevice *dev, struct mtd_info **mtd)
> > +{
> > +	struct blk_desc *bdesc;
> > +	struct udevice *bdev;
> > +	int ret;
> > +
> > +	ret =3D blk_create_devicef(dev, "mtd_blk", "blk", UCLASS_MTD,
> > +				 dev_seq(dev), 512, 0, &bdev);
> > +	if (ret) {
> > +		pr_err("Cannot create block device");
> > +		return ret;
> > +	}
> > +
> > +	bdesc =3D dev_get_uclass_plat(bdev);
> > +	dev_set_priv(bdev, mtd);
> > +	bdesc->bdev =3D bdev;
> > +
> > +	return 0;
> > +}
> > +
> > +static ulong mtd_bread(struct udevice *dev, lbaint_t start, lbaint_t b=
lkcnt,
> > +		       void *dst)
> > +{
> > +	struct blk_desc *block_dev =3D dev_get_uclass_plat(dev);
> > +	struct mtd_info *mtd =3D blk_desc_to_mtd(block_dev);
> > +	unsigned int sect_size =3D block_dev->blksz;
> > +	lbaint_t cur =3D start;
> > +	ulong read_cnt =3D 0;
> > +
> > +	while (read_cnt < blkcnt) {
> > +		int ret;
> > +		loff_t sect_start =3D cur * sect_size;
> > +		size_t retlen;
> > +
> > +		ret =3D mtd_read(mtd, sect_start, sect_size, &retlen, dst);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (retlen !=3D sect_size) {
> > +			pr_err("mtdblock: failed to read block 0x%lx\n", cur);
> > +			return -EIO;
> > +		}
> > +
> > +		cur++;
> > +		dst +=3D sect_size;
> > +		read_cnt++;
> > +	}
> > +
> > +	return read_cnt;
> > +}
> > +
> > +static int mtd_erase_write(struct mtd_info *mtd, uint64_t start, const=
 void *src)
> > +{
> > +	int ret;
> > +	size_t retlen;
> > +	struct erase_info erase =3D { 0 };
> > +
> > +	erase.mtd =3D mtd;
> > +	erase.addr =3D start;
> > +	erase.len =3D mtd->erasesize;
> > +
> > +	ret =3D mtd_erase(mtd, &erase);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D mtd_write(mtd, start, mtd->erasesize, &retlen, src);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (retlen !=3D mtd->erasesize) {
> > +		pr_err("mtdblock: failed to read block at 0x%llx\n", start);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static ulong mtd_bwrite(struct udevice *dev, lbaint_t start, lbaint_t =
blkcnt,
> > +			const void *src)
> > +{
> > +	struct blk_desc *block_dev =3D dev_get_uclass_plat(dev);
> > +	struct mtd_info *mtd =3D blk_desc_to_mtd(block_dev);
> > +	unsigned int sect_size =3D block_dev->blksz;
> > +	lbaint_t cur =3D start, blocks_todo =3D blkcnt;
> > +	ulong write_cnt =3D 0;
> > +	u8 *buf;
> > +	int ret =3D 0;
> > +
> > +	buf =3D malloc(mtd->erasesize);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	while (blocks_todo > 0) {
> > +		loff_t sect_start =3D cur * sect_size;
> > +		loff_t erase_start =3D ALIGN_DOWN(sect_start, mtd->erasesize);
> > +		u32 offset =3D sect_start - erase_start;
> > +		size_t cur_size =3D min_t(size_t,  mtd->erasesize - offset,
> > +					blocks_todo * sect_size);
> > +		size_t retlen;
> > +		lbaint_t written;
> > +
> > +		ret =3D mtd_read(mtd, erase_start, mtd->erasesize, &retlen, buf);
> > +		if (ret)
> > +			goto out;
> > +
> > +		if (retlen !=3D mtd->erasesize) {
> > +			pr_err("mtdblock: failed to read block 0x%lx\n", cur);
> > +			ret =3D -EIO;
> > +			goto out;
> > +		}
> > +
> > +		memcpy(buf + offset, src, cur_size);
> > +
> > +		ret =3D mtd_erase_write(mtd, erase_start, buf);
> > +		if (ret)
> > +			goto out;
> > +
> > +		written =3D cur_size / sect_size;
> > +
> > +		blocks_todo -=3D written;
> > +		cur +=3D written;
> > +		src +=3D cur_size;
> > +		write_cnt +=3D written;
> > +	}
> > +
> > +out:
> > +	free(buf);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return write_cnt;
> > +}
> > +
> > +static int mtd_blk_probe(struct udevice *dev)
> > +{
> > +	int ret;
> > +
> > +	ret =3D device_probe(dev);
> > +	if (ret) {
> > +		pr_err("Probing %s failed (err=3D%d)\n", dev->name, ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct blk_ops mtd_blk_ops =3D {
> > +	.read =3D mtd_bread,
> > +	.write =3D mtd_bwrite,
> > +};
> > +
> > +U_BOOT_DRIVER(mtd_blk) =3D {
> > +	.name =3D "mtd_blk",
> > +	.id =3D UCLASS_BLK,
> > +	.ops =3D &mtd_blk_ops,
> > +	.probe =3D mtd_blk_probe,
> > +};
> > diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> > index 09f5269887..9b997fadd1 100644
> > --- a/include/linux/mtd/mtd.h
> > +++ b/include/linux/mtd/mtd.h
> > @@ -26,6 +26,9 @@
> >   #include <dm/device.h>
> >   #endif
> >   #include <dm/ofnode.h>
> > +#if IS_ENABLED(CONFIG_BLK)
> > +#include <blk.h>
> > +#endif
> >=20
> >   #define MAX_MTD_DEVICES 32
> >   #endif
> > @@ -412,6 +415,15 @@ int mtd_write(struct mtd_info *mtd, loff_t to, siz=
e_t len, size_t *retlen,
> >   int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size=
_t *retlen,
> >   		    const u_char *buf);
> >=20
> > +#if IS_ENABLED(CONFIG_BLK)
> > +static inline struct mtd_info *blk_desc_to_mtd(struct blk_desc *bdesc)
> > +{
> > +	return *((struct mtd_info **)dev_get_priv(bdesc->bdev));
> > +}
> > +
> > +int mtd_bind(struct udevice *dev, struct mtd_info **mtd);
> > +#endif
> > +
> >   int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_op=
s *ops);
> >   int mtd_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops=
 *ops);
> >=20
>=20

--=20
Thank you,
Alexey=
