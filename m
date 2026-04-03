Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA6BE88D82
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 05:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A20840ED;
	Sat,  4 Apr 2026 07:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wTL5qHmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E7C840AA; Sat,  4 Apr 2026 07:09:44 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96DD283B8F
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 07:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fnkD40YNwz9v8y;
 Sat,  4 Apr 2026 07:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775279380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UowXNcZas2C80sRZEvBY65054QBKalsPVvg2XspKauE=;
 b=wTL5qHmWTd5QHtneV51HrJyMWRzn7cI2x6HgXhrTIhTaWNuQ9SxTyK+PLg6wsZorg8k/t0
 wBtwkwi/PRiKQ4RVO3SYgoxrmug8pyqcW001x0ZRwnOGRjPuSV1Gc0VPaq+i/BHhldIiBX
 pM36RbRIiAEvmzQUi3EVb26unNHkmsaXJebiXxGvdu9UCbU9gXwSKFja3dgSMmxyi41UT3
 0SfHefRa2DCTK5TyqY/W91pYex2P4A1OGXHw3P3hlZuXdO+CJOLwjRIHxqf3HachzR6QQ1
 TVnzMnUqZzdnKKTyJrsQ2Z9pgtMTRhFX6IOJjkBtSBKsQQs6UPjX+VY0oAZ6jw==
Message-ID: <723d3321-cf32-4739-bfdf-88cd8dcac394@mailbox.org>
Date: Sat, 4 Apr 2026 01:00:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/6] imx9: Add support for saving DDR training data to
 NVM
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, viorel.suman@nxp.com,
 simona.toaca@nxp.com, ye.li@nxp.com, ping.bai@nxp.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <7edcce04b39aabc1f58e09814e7fadff226e2bb8.1775121078.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <7edcce04b39aabc1f58e09814e7fadff226e2bb8.1775121078.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: k8wrmdxa6b9t49icst6d7txbodomqzko
X-MBO-RS-ID: 5f076326857ef3d99cb
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

On 4/2/26 11:40 AM, Simona Toaca (OSS) wrote:
> From: Simona Toaca <simona.toaca@nxp.com>
> 
> DDR training data can be saved to NVM and be available
> to OEI at boot time, which will trigger QuickBoot flow.
> 
> U-Boot only checks for data integrity (CRC32), while
> OEI is in charge of authentication when it tries to
> load the data from NVM.
> 
> On iMX95 A0/A1, 'authentication' is done via another
> CRC32. On the other boards, authentication is done by

On the other ... SoC revisions (not boards) , ... ?

[...]

> +++ b/arch/arm/include/asm/arch-imx9/ddr.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>   /*
> - * Copyright 2022 NXP
> + * Copyright 2022-2026 NXP
>    */
>   
>   #ifndef __ASM_ARCH_IMX8M_DDR_H
> @@ -100,6 +100,52 @@ struct dram_timing_info {
>   
>   extern struct dram_timing_info dram_timing;
>   
> +/* Quick Boot related */
> +#define DDRPHY_QB_CSR_SIZE	5168
> +#define DDRPHY_QB_ACSM_SIZE	(4 * 1024)
> +#define DDRPHY_QB_MSB_SIZE	0x200
> +#define DDRPHY_QB_PSTATES	0
> +#define DDRPHY_QB_PST_SIZE	(DDRPHY_QB_PSTATES * 4 * 1024)
> +
> +/**
> + * This structure needs to be aligned with the one in OEI.
> + */
> +struct ddrphy_qb_state {
> +	u32 crc;		  /* Used for ensuring integrity in DRAM */
> +#define MAC_LENGTH              8 /* 256 bits, 32-bit aligned */

Please indent with tabs.

> +	u32 mac[MAC_LENGTH];	  /* For 95A0/1 use mac[0] to keep CRC32 value */


[...]

> +++ b/arch/arm/include/asm/mach-imx/qb.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2026 NXP
> + */
> +
> +#ifndef __IMX_QB_H__
> +#define __IMX_QB_H__
> +
> +#include <stdbool.h>
> +
> +bool qb_check(void);
> +int qb(int qb_dev, bool save);
> +void spl_qb_save(void);

Please call the functions something less opaque than "qb()" , imx_qb_*() 
would alrady be so much better.

[...]

> diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
> new file mode 100644
> index 00000000000..220545192d4
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx9/qb.c
> @@ -0,0 +1,379 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/**
> + * Copyright 2024-2026 NXP
> + */
> +#include <dm/device-internal.h>
> +#include <dm/uclass.h>
> +#include <errno.h>
> +#include <imx_container.h>
> +#include <linux/bitfield.h>
> +#include <mmc.h>
> +#include <spi_flash.h>
> +#include <spl.h>
> +#include <stdlib.h>
> +#include <u-boot/crc.h>
> +
> +#include <asm/arch/ddr.h>
> +#include <asm/mach-imx/boot_mode.h>
> +#include <asm/mach-imx/sys_proto.h>
> +
> +#define QB_STATE_LOAD_SIZE    SZ_64K
> +
> +#define MMC_DEV		0
> +#define QSPI_DEV	1
> +
> +#define IMG_FLAGS_IMG_TYPE_MASK   0xF
> +#define IMG_FLAGS_IMG_TYPE(x)     FIELD_GET(IMG_FLAGS_IMG_TYPE_MASK, (x))
> +
> +#define IMG_TYPE_DDR_TDATA_DUMMY  0xD   /* dummy DDR training data image */
> +
> +bool qb_check(void)
> +{
> +	struct ddrphy_qb_state *qb_state;
> +	u32 size, crc;
> +
> +	/**
> +	 * Ensure CRC is not empty, the reason is that
> +	 * the data is invalidated after first save run
> +	 * or after it is overwritten.
> +	 */
> +	qb_state = (struct ddrphy_qb_state *)CONFIG_QB_SAVED_STATE_BASE;
> +	size = sizeof(struct ddrphy_qb_state) - sizeof(qb_state->crc);
> +	crc = crc32(0, (u8 *)qb_state->mac, size);
> +
> +	if (!qb_state->crc || crc != qb_state->crc)
> +		return false;
> +
> +	return true;
> +}
> +
> +static unsigned long qb_get_boot_device_offset(void *dev, int dev_type)
> +{
> +	unsigned long offset = 0;
> +	struct mmc *mmc;
> +
> +	switch (dev_type) {
> +	case MMC_DEV:
> +		mmc = dev;
> +
> +		if (IS_SD(mmc) || mmc->part_config == MMCPART_NOAVAILABLE) {
> +			offset = CONTAINER_HDR_MMCSD_OFFSET;

Multiple return in this case will make the function simpler:

return CONTAINER_HDR_MMCSD_OFFSET;

> +		} else {

No need for } else { anymore.

> +			u8 part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
> +
> +			if (part == EMMC_BOOT_PART_BOOT1 || part == EMMC_BOOT_PART_BOOT2)
> +				offset = CONTAINER_HDR_EMMC_OFFSET;

return CONTAINER_HDR_EMMC_OFFSET;

> +			else
> +				offset = CONTAINER_HDR_MMCSD_OFFSET;

return CONTAINER_HDR_MMCSD_OFFSET;

> +		}
> +		break;
> +	case QSPI_DEV:
> +		offset = CONTAINER_HDR_QSPI_OFFSET;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return offset;
> +}

[...]

> +static int get_dev_qbdata_offset(void *dev, int dev_type, unsigned long offset,
> +				 u32 *qbdata_offset)
> +{
> +	int ret = -EOPNOTSUPP;
> +	u16 ctnr_hdr_align = CONTAINER_HDR_ALIGNMENT;
> +	void *buf = kmalloc(ctnr_hdr_align, GFP_KERNEL);

Can you use buffer on stack ? u8 buf[CONTAINER_HDR_ALIGNMENT]; ? That 
would allow you to remove all the goto statements.

If not, use malloc() not kmalloc().

> +	if (!buf) {
> +		printf("kmalloc buffer failed\n");

if malloc fails, so will printing, so drop this print and return -ENOMEM 
only.

> +		return -ENOMEM;
> +	}
> +
> +	switch (dev_type) {
> +	case MMC_DEV:
> +		unsigned long count = 0;
> +		struct mmc *mmc = dev;
> +
> +		if (!(CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(MMC_WRITE)))
> +			goto get_dev_qbdata_offset_exit;
> +
> +		count = blk_dread(mmc_get_blk_desc(mmc),
> +				  offset / mmc->read_bl_len,
> +				  ctnr_hdr_align / mmc->read_bl_len,
> +				  buf);
> +		if (count == 0) {
> +			printf("Read container image from MMC/SD failed\n");
> +			ret = -EIO;
> +			goto get_dev_qbdata_offset_exit;
> +		}
> +		break;
> +	case QSPI_DEV:
> +		if (!CONFIG_IS_ENABLED(SPI))
> +			goto get_dev_qbdata_offset_exit;
> +
> +		ret = spi_flash_read(dev, offset,
> +				     ctnr_hdr_align, buf);
> +		if (ret) {
> +			printf("Read container header from QSPI failed\n");
> +			ret = -EIO;
> +			goto get_dev_qbdata_offset_exit;
> +		}
> +		break;
> +	default:
> +		printf("Support for device %d not enabled\n", dev_type);
> +		goto get_dev_qbdata_offset_exit;
> +	}
> +
> +	ret = qb_parse_container(buf, qbdata_offset);
> +
> +get_dev_qbdata_offset_exit:
> +	free(buf);
> +
> +	return ret;
> +}

[...]

> +void spl_qb_save(void)
> +{
> +	int dev = spl_boot_device();
> +
> +	/* Save QB data on current boot device */
> +	if (qb(dev, true))

Please call this function something less opaque than "qb()" , pick 
something more descriptive.

> +		printf("QB save failed\n");
> +}
[...]
