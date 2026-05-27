Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C66CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C0884704;
	Wed, 27 May 2026 14:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0Y6HZ80h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D925839A8; Wed, 27 May 2026 10:26:45 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B092F8056B
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 10:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 3FD6C1A36E1;
 Wed, 27 May 2026 08:26:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0933C601A1;
 Wed, 27 May 2026 08:26:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 087C310888BE9; 
 Wed, 27 May 2026 10:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779870401; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qmAGBFsw2Ss0B5IIFJsORIucGQ8VX1sNnPs+ggiH4XQ=;
 b=0Y6HZ80hS7PgzzIpDOWa8dH0A153OrGmEht0BUyKh9GeO9D7GbR4DPAJoELYk6Ok+xGmJW
 L1i71LdBdVtW5Ns/eDo2dhcLsUdrddzqPub6J+Osb15mcm+KCdDInRnpTzmmzkt38b4as5
 smJ85V46aJu25Mx02Z5CBXEc/ZjoU/V8Fx/bsW1Vej0EhgaDCcGAwNaG3Kmh0nBYm3Q7Uf
 OCkKlHWJs5LVUN+91w0BUuZaWmvz6YLby5x7mpGIEGYng3lUx5M0g0acwqRU83ckeiKW0o
 i0zsBcdyQumOV/EKEWczIEXxAK4uMnpWEFLzTVt/0y+3h2tW/lDWxRzqBOTvLA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: <u-boot@lists.denx.de>,  GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>,  Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Frieder Schrempf
 <frieder.schrempf@kontron.de>,  Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,  Tianling Shen <cnsztl@gmail.com>,  Cheng
 Ming Lin <chengminglin@mxic.com.tw>,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH] mtd: spinand: add support for Etron SPI-NAND flashes
In-Reply-To: <20260429081313.151656-1-weijie.gao@mediatek.com> (Weijie Gao's
 message of "Wed, 29 Apr 2026 16:13:13 +0800")
References: <20260429081313.151656-1-weijie.gao@mediatek.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 27 May 2026 10:26:36 +0200
Message-ID: <875x49l0lf.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 27 May 2026 14:57:52 +0200
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

Hello Weijie,

Sorry for the delay, I have a couple of comments, see below.

On 29/04/2026 at 16:13:13 +08, Weijie Gao <weijie.gao@mediatek.com> wrote:

> This patch adds some Etron SPI-NAND flashes from 1Gb to 8Gb with
> 4-bits/8-bits On-die ECC support.
>
> EM73C044VCF/EM73D044VCO/EM73E044VCE/EM73F044VCA are tested on MediaTek
> filogic MT7988 reference board.
>
> Datasheets:
> https://etron.com/wp-content/uploads/2024/08/EM73C044VCF-SPI-NAND-Flash_R=
ev-1.03.pdf
> https://etron.com/wp-content/uploads/2022/04/EM73D044VCOR-SPI-NAND-Flash_=
Rev-1.00.pdf
> https://etron.com/wp-content/uploads/2022/04/EM78DE044VC-SPI-NAND-Flash_R=
ev-1.01.pdf
> https://etron.com/wp-content/uploads/2024/08/EM73E044VCEG-SPI-NAND-Flash_=
Rev-1.00.pdf
> https://etron.com/wp-content/uploads/2022/04/EM738F044VCA-SPI-NAND-Flash_=
Rev-1.02.pdf

I haven't checked all the chips in detail, I checked just a couple of them.

> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---

[...]

> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif

Please drop this #if block

> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_ETRON		0xD5
> +
> +#define STATUS_ECC_LIMIT_BITFLIPS	(3 << 4)

Please add a prefix aligned with Etron's namespace.

> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
> +
> +static int etron_ecc4_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				    struct mtd_oob_region *region)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +
> +	if (section >=3D spinand->base.memorg.pagesize / mtd->ecc_step_size)
> +		return -ERANGE;
> +
> +	region->offset =3D (8 * section) + 32;
> +	region->length =3D 8;

This should be grouped into one big continuous area.

> +
> +	return 0;
> +}
> +
> +static int etron_ecc4_ooblayout_free(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *region)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +
> +	if (section >=3D spinand->base.memorg.pagesize / mtd->ecc_step_size)
> +		return -ERANGE;
> +
> +	if (section) {
> +		region->offset =3D 8 * section;
> +		region->length =3D 8;

Ditto.

And same below, in the other OOB layouts.

> +	} else {
> +		/* section 0 has two bytes reserved for bad block mark */
> +		region->offset =3D 2;
> +		region->length =3D 6;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops etron_ecc4_ooblayout =3D {
> +	.ecc =3D etron_ecc4_ooblayout_ecc,
> +	.rfree =3D etron_ecc4_ooblayout_free,
> +};
> +
> +static int etron_ecc8_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				    struct mtd_oob_region *region)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +
> +	if (section >=3D spinand->base.memorg.pagesize / mtd->ecc_step_size)
> +		return -ERANGE;
> +
> +	region->offset =3D (14 * section) + 72;
> +	region->length =3D 14;
> +
> +	return 0;
> +}
> +
> +static int etron_ecc8_ooblayout_free(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *region)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +
> +	if (section >=3D spinand->base.memorg.pagesize / mtd->ecc_step_size)
> +		return -ERANGE;
> +
> +	if (section) {
> +		region->offset =3D 18 * section;
> +		region->length =3D 18;
> +	} else {
> +		/* section 0 has two bytes reserved for bad block mark */
> +		region->offset =3D 2;
> +		region->length =3D 16;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops etron_ecc8_ooblayout =3D {
> +	.ecc =3D etron_ecc8_ooblayout_ecc,
> +	.rfree =3D etron_ecc8_ooblayout_free,

         ^

Should not even compile?

> +};
> +
> +static int etron_ecc_get_status(struct spinand_device *spinand, u8 statu=
s)
> +{
> +	struct nand_device *nand =3D spinand_to_nand(spinand);
> +
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case STATUS_ECC_UNCOR_ERROR:
> +		return -EBADMSG;
> +
> +	case STATUS_ECC_HAS_BITFLIPS:
> +		return nand->eccreq.strength >> 1;

This is incorrect, you should probably return strength - 1 if that is
what the bit means. We already had a discussion about this in the past:
https://lore.kernel.org/linux-mtd/20210908201624.237634-1-bert@biot.com/

> +
> +	case STATUS_ECC_LIMIT_BITFLIPS:
> +		return nand->eccreq.strength;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}

Thanks,
Miqu=C3=A8l
