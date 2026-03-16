Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E34FD874A
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 11:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4923A84207;
	Tue, 17 Mar 2026 12:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="joS2ZgI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC0B84068; Tue, 17 Mar 2026 06:07:07 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AFE8401A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 659D210D5C8; Tue, 17 Mar 2026 06:07:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773724024;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=92JzwUkJtyFqsSVb9r6yxkNTTOMHi+lpLp1ss8H5++Q=;
 b=joS2ZgI5+LYhwV+K8wj6tmzk/HS0AflR6ILy9tzv4NlyeK3lDcxkOgJXGri2e2OQwBNp8m
 Nz79kxPZ2AcwKs0X9pa+X8DekXUVm6Ze9Fz17zRT1xXtA/NzVGLsnGrxY4L2s8/O+6x+HA
 eCURnLwbjsxyJLGZkx5C9o0K7IYIcuksw3dkv31CnjqVuFenMFp/0IEpTpY65/gxMtGLrb
 hj70PJNJq3t6yUS+CHnlI51zAXNONgGQ+qXBO8UgivEjHKlqSMCrYxboOtymZsBypYR9eO
 e5yFLnhVUQEw9CARneoMwtMnpFEyHIlr3ebj5w45IqT7WfdhCNGXobxV/2qQ2w==
Message-ID: <04ea62f9-f82a-4c10-9866-0ce78ea90b05@nabladev.com>
Date: Mon, 16 Mar 2026 13:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] imx9: Add support for saving DDR training data to
 NVM
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, sebastien.szymanski@armadeus.com,
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <5a7a3063ce3a429c67396c1d0bae95444ac3f996.1773648510.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <5a7a3063ce3a429c67396c1d0bae95444ac3f996.1773648510.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 17 Mar 2026 12:56:37 +0100
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

On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:

> diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
> index a8e3f7354c7..d2afbe59ffb 100644
> --- a/arch/arm/include/asm/arch-imx9/ddr.h
> +++ b/arch/arm/include/asm/arch-imx9/ddr.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>   /*
> - * Copyright 2022 NXP
> + * Copyright 2022-2025 NXP

2026

>    */
>   
>   #ifndef __ASM_ARCH_IMX8M_DDR_H
> @@ -100,6 +100,56 @@ struct dram_timing_info {
>   
>   extern struct dram_timing_info dram_timing;
>   
> +#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) /* CONFIG_IMX95 || CONFIG_IMX94 */
> +#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)

These are only macros and structure definitions, do they need to be 
conditionally compiled ?

> +/* Quick Boot related */
> +#define DDRPHY_QB_CSR_SIZE	5168
> +#define DDRPHY_QB_ACSM_SIZE	4 * 1024

(4 * 1024) to avoid side effects

> +#define DDRPHY_QB_MSB_SIZE	0x200
> +#define DDRPHY_QB_PSTATES	0
> +#define DDRPHY_QB_PST_SIZE	DDRPHY_QB_PSTATES * 4 * 1024

Add ( )

> +/**
> + * This structure needs to be aligned with the one in OEI.
> + */
> +struct ddrphy_qb_state {
> +	u32 crc;		  /* Used for ensuring integrity in DRAM */
> +#define MAC_LENGTH              8 /* 256 bits, 32-bit aligned */
> +	u32 mac[MAC_LENGTH];	  /* For 95A0/1 use mac[0] to keep CRC32 value */
> +	u8 TrainedVREFCA_A0;

Avoid camel case please

> +	u8 TrainedVREFCA_A1;
> +	u8 TrainedVREFCA_B0;
> +	u8 TrainedVREFCA_B1;
> +	u8 TrainedVREFDQ_A0;

[...]

> diff --git a/arch/arm/include/asm/mach-imx/qb.h b/arch/arm/include/asm/mach-imx/qb.h
> new file mode 100644
> index 00000000000..5efe68f0a60
> --- /dev/null
> +++ b/arch/arm/include/asm/mach-imx/qb.h

[...]

> +bool qb_check(void);
> +int  qb(int qb_dev, int qb_bootdev, bool save);

One space after 'int' is enough.

Also, please rename the function with some more descriptive name .

[...]

> diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
> new file mode 100644
> index 00000000000..9987c57b16a
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx9/qb.c

[...]

> +#if CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(MMC_WRITE)
> +#define QB_MMC_EN	1

Place these conditionals directly into the code to maintain code 
coverage, i.e.:

if (CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(MMC_WRITE)) {
  ... do_stuff();
}

> +#endif /* DM_MMC && MMC_WRITE */
> +#if CONFIG_IS_ENABLED(SPI)
> +#define QB_SPI_EN	1
> +#endif /* SPI */
> +
> +#define IMG_FLAGS_IMG_TYPE_MASK   0xFU
> +#define IMG_FLAGS_IMG_TYPE(x)     FIELD_GET(IMG_FLAGS_IMG_TYPE_MASK, x)

Add ( ) around x in the macro to avoid side effects , i.e. (x)

> +#define IMG_TYPE_DDR_TDATA_DUMMY  0xDU   /* dummy DDR training data image */

0xd , drop the U

> +/**
> + * Table used to implement half-byte CRC
> + * Polynomial: 0xEDB88320
> + */
> +static const u32 p_table[] = {
> +	0x00000000, 0x1db71064, 0x3b6e20c8, 0x26d930ac,
> +	0x76dc4190, 0x6b6b51f4, 0x4db26158, 0x5005713c,
> +	0xedb88320, 0xf00f9344, 0xd6d6a3e8, 0xcb61b38c,
> +	0x9b64c2b0, 0x86d3d2d4, 0xa00ae278, 0xbdbdf21c,
> +};
> +
> +/**
> + * Implement half-byte CRC algorithm
> + */
> +static u32 qb_crc32(const void *addr, u32 len)
> +{
> +	u32 crc = ~0x00, idx, i, val;
> +	const u8 *chr = (const u8 *)addr;
> +
> +	for (i = 0; i < len; i++, chr++) {
> +		val = (u32)(*chr);
> +
> +		idx = (crc ^ (val >> 0)) & 0x0F;
> +		crc = p_table[idx] ^ (crc >> 4);
> +		idx = (crc ^ (val >> 4)) & 0x0F;
> +		crc = p_table[idx] ^ (crc >> 4);
> +	}
> +
> +	return ~crc;
> +}

Why not simply call crc32() U-Boot function ?

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
> +	qb_state = (struct ddrphy_qb_state *)CONFIG_SAVED_QB_STATE_BASE;
> +	size = sizeof(struct ddrphy_qb_state) - sizeof(qb_state->crc);
> +	crc = qb_crc32(qb_state->mac, size);

"
   size = sizeof(struct ddrphy_qb_state) - MAC_LENGTH * sizeof(u32);
   crc = crc32(0, &qb_state->TrainedVREFCA_A0, size);
"

Does this work ?

> +	if (!qb_state->crc || crc != qb_state->crc)
> +		return false;
> +
> +	return true;
> +}
> +
> +static unsigned long get_boot_device_offset(void *dev, int dev_type, bool bootdev)
> +{
> +	unsigned long offset = 0;
> +	struct mmc *mmc;
> +
> +	switch (dev_type) {
> +	case ROM_API_DEV:
> +		offset = (unsigned long)dev;

Please get rid of this void * casting horribleness.

> +		break;
> +	case MMC_DEV:
> +		mmc = (struct mmc *)dev;

Also here.

[...]

> +static int parse_container(void *addr, u32 *qb_data_off)
> +{
> +	struct container_hdr *phdr;
> +	struct boot_img_t *img_entry;
> +	u8 i = 0;

int i;

> +	u32 img_type, img_end;
> +
> +	phdr = (struct container_hdr *)addr;
> +	if (phdr->tag != 0x87 || (phdr->version != 0x0 && phdr->version != 0x2))
> +		return -1;

Use errno.h return codes.

> +	img_entry = (struct boot_img_t *)(addr + sizeof(struct container_hdr));
> +	for (i = 0; i < phdr->num_images; i++) {
> +		img_type = IMG_FLAGS_IMG_TYPE(img_entry->hab_flags);
> +		if (img_type == IMG_TYPE_DDR_TDATA_DUMMY && img_entry->size == 0) {
> +			/* Image entry pointing to DDR Training Data */
> +			(*qb_data_off) = img_entry->offset;

() are not needed

> +			return 0;
> +		}
> +
> +		img_end = img_entry->offset + img_entry->size;
> +		if (i + 1 < phdr->num_images) {
> +			img_entry++;
> +			if (img_end + QB_STATE_LOAD_SIZE == img_entry->offset) {
> +				/* hole detected */
> +				(*qb_data_off) = img_end;

() are not needed
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	return -1;

errno.h

> +}
> +
> +static int get_dev_qbdata_offset(void *dev, int dev_type, unsigned long offset, u32 *qbdata_offset)
> +{
> +	int ret = 0;
> +	u16 ctnr_hdr_align = CONTAINER_HDR_ALIGNMENT;
> +	void *buf = kmalloc(ctnr_hdr_align, GFP_KERNEL);
> +
> +	if (!buf) {
> +		printf("kmalloc buffer failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	switch (dev_type) {
> +#ifdef QB_MMC_EN

Remove this ...

> +	case MMC_DEV:

... and use this:

if (!(CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(MMC_WRITE)))
   return -EOPNOTSUPP;

> +		unsigned long count = 0;
> +		struct mmc *mmc = (struct mmc *)dev;

The void * casting has to go ...

> +		count = blk_dread(mmc_get_blk_desc(mmc),
> +				  offset / mmc->read_bl_len,
> +				  ctnr_hdr_align / mmc->read_bl_len,
> +				  buf);
> +		if (count == 0) {
> +			printf("Read container image from MMC/SD failed\n");
> +			free(buf);
> +			return -EIO;
> +		}
> +		break;
> +#endif /* QB_MMC_EN */
> +#ifdef QB_SPI_EN
> +	case QSPI_DEV:
> +		struct spi_flash *flash = (struct spi_flash *)dev;
> +
> +		ret = spi_flash_read(flash, offset,
> +				     ctnr_hdr_align, buf);
> +		if (ret) {
> +			printf("Read container header from QSPI failed\n");
> +			free(buf);
> +			return -EIO;
> +		}
> +		break;
> +#endif /* QB_SPI_EN */
> +	case QSPI_NOR_DEV:
> +	case RAM_DEV:
> +		memcpy(buf, (const void *)offset, ctnr_hdr_align);
> +		break;
> +	default:
> +		printf("Support for device %d not enabled\n", dev_type);
> +		free(buf);
> +		return -EIO;
> +	}
> +
> +	ret = parse_container(buf, qbdata_offset);

Ideally, prefix all those functions with some universal prefix, e.g. 
qb_...(), it makes it easier to look them up in disassembly dump.

> +
> +	free(buf);
> +
> +	return ret;
> +}
> +
> +static int get_qbdata_offset(void *dev, int dev_type, u32 *qbdata_offset, bool bootdev)
> +{
> +	u32 offset = get_boot_device_offset(dev, dev_type, bootdev);
> +	u16 ctnr_hdr_align = CONTAINER_HDR_ALIGNMENT;
> +	u32 cont_offset;
> +	int ret, i;
> +
> +	for (i = 0; i < 3; i++) {
> +		cont_offset = offset + i * ctnr_hdr_align;
> +		ret = get_dev_qbdata_offset(dev, dev_type, cont_offset, qbdata_offset);
> +		if (ret == 0) {
> +			(*qbdata_offset) += cont_offset;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +#ifdef QB_MMC_EN

Use if (!(CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(MMC_WRITE))) in 
code and you won't need this ifdeffery.

> +static int mmc_get_device_index(u32 dev)
> +{
> +	switch (dev) {
> +	case BOOT_DEVICE_MMC1:
> +		return 0;
> +	case BOOT_DEVICE_MMC2:
> +	case BOOT_DEVICE_MMC2_2:
> +		return 1;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int mmc_find_device(struct mmc **mmcp, int mmc_dev)
> +{
> +	int err;

Stop mixing err and ret, pick one or the other and use it consistently 
in the whole file as a return value variable;

> +	err = mmc_init_device(mmc_dev);
> +	if (err)
> +		return err;
> +
> +	*mmcp = find_mmc_device(mmc_dev);
> +
> +	return (*mmcp) ? 0 : -ENODEV;

() are unnecessary

> +}
> +
> +static int do_qb_mmc(int dev, bool save, bool is_bootdev)
> +{
> +	struct mmc *mmc;
> +	int ret = 0, mmc_dev;
> +	bool has_hw_part;
> +	u8 orig_part, part;
> +	u32 offset;
> +	void *buf;
> +
> +	mmc_dev = mmc_get_device_index(dev);
> +	if (mmc_dev < 0)
> +		return mmc_dev;
> +
> +	ret = mmc_find_device(&mmc, mmc_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (!mmc->has_init)
> +		ret = mmc_init(mmc);

mmc_init() already handles the mmc->has_init conditional, drop it.

> +	if (ret)
> +		return ret;
> +
> +	has_hw_part = !IS_SD(mmc) && mmc->part_config != MMCPART_NOAVAILABLE;
> +
> +	if (has_hw_part) {
> +		orig_part = mmc_get_blk_desc(mmc)->hwpart;
> +		part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
> +
> +		/* Select the partition */
> +		ret = mmc_switch_part(mmc, part);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = get_qbdata_offset(mmc, MMC_DEV, &offset, is_bootdev);
> +	if (ret)
> +		return ret;
> +
> +	if (save) {
> +		/* QB data is stored in DDR -> can use it as buf */
> +		buf = (void *)CONFIG_SAVED_QB_STATE_BASE;
> +		ret = blk_dwrite(mmc_get_blk_desc(mmc),
> +				 offset / mmc->write_bl_len,
> +				 QB_STATE_LOAD_SIZE / mmc->write_bl_len,
> +				 (const void *)buf);
> +	} else {
> +		/* erase */
> +		ret = blk_derase(mmc_get_blk_desc(mmc),
> +				 offset / mmc->write_bl_len,
> +				 QB_STATE_LOAD_SIZE / mmc->write_bl_len);
> +	}
> +
> +	ret = (ret > 0) ? 0 : -1;

Use CMD_RET_SUCCESS and co.

> +	/* Return to original partition */
> +	if (has_hw_part)
> +		ret |= mmc_switch_part(mmc, orig_part);

$ret is signed integer, you cannot do bit operations on it.

> +	return ret;
> +}
> +#else
> +static int do_qb_mmc(int dev, bool save, bool is_bootdev)
> +{
> +	printf("Please enable MMC and MMC_WRITE\n");

Use if (!(CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(MMC_WRITE))) 
and avoid the ifdeffery.

> +	return -EOPNOTSUPP;
> +}
> +#endif /* QB_MMC_EN */
> +
> +#ifdef QB_SPI_EN

Ifdeffery, code coverage, if (CONFIG...), same as above.

> +static int spi_find_device(struct spi_flash **dev)
> +{
> +	unsigned int sf_bus = CONFIG_SF_DEFAULT_BUS;
> +	unsigned int sf_cs = CONFIG_SF_DEFAULT_CS;
> +	struct spi_flash *flash;
> +	int ret = 0;
> +
> +	flash = spi_flash_probe(sf_bus, sf_cs,
> +				CONFIG_SF_DEFAULT_SPEED,
> +				CONFIG_SF_DEFAULT_MODE);
> +
> +	if (!flash) {
> +		puts("SPI probe failed.\n");
> +		return -ENODEV;
> +	}
> +
> +	*dev = flash;
> +
> +	return ret;
> +}
> +
> +static int do_qb_spi(int dev, bool save, bool is_bootdev)
> +{
> +	int ret = 0;
> +	u32 offset;
> +	void *buf;
> +	struct spi_flash *flash;
> +
> +	ret = spi_find_device(&flash);
> +	if (ret)
> +		return -ENODEV;
> +
> +	ret = get_qbdata_offset(flash, QSPI_DEV, &offset, is_bootdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = spi_flash_erase(flash, offset,
> +			      QB_STATE_LOAD_SIZE);

if (ret)
   return ret;

if (!save)
   return 0;

Reduce indent ...

> +	if (!ret && save) {
> +		/* QB data is stored in DDR -> can use it as buf */
> +		buf = (void *)CONFIG_SAVED_QB_STATE_BASE;
> +		ret = spi_flash_write(flash, offset,
> +				      QB_STATE_LOAD_SIZE, buf);
> +	}
> +
> +	return ret;
> +}
> +#else
> +static int do_qb_spi(int dev, bool save, bool is_bootdev)
> +{
> +	printf("Please enable SPI\n");
> +
> +	return -EOPNOTSUPP;
> +}
> +#endif /* QB_SPI_EN */
> +
> +int qb(int qb_dev, int qb_bootdev, bool save)
> +{
> +	int ret = -1;

Use errno.h return values.

> +	if (save && !qb_check())
> +		return ret;
> +
> +	switch (qb_dev) {
> +	case BOOT_DEVICE_MMC1:
> +	case BOOT_DEVICE_MMC2:
> +	case BOOT_DEVICE_MMC2_2:
> +		ret = do_qb_mmc(qb_dev, save, !!(qb_dev == qb_bootdev));
> +		break;
> +	case BOOT_DEVICE_SPI:
> +		ret = do_qb_spi(qb_dev, save, !!(qb_dev == qb_bootdev));
> +		break;
> +	default:
> +		printf("Unsupported quickboot device\n");
> +		break;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!save)
> +		return 0;
> +
> +	/**
> +	 * invalidate qb_state mem so that at next boot
> +	 * the check function will fail and save won't happen
> +	 */
> +	memset((void *)CONFIG_SAVED_QB_STATE_BASE, 0, sizeof(struct ddrphy_qb_state));
> +
> +	return 0;
> +}
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> index 17269ddd2fc..eb9bfe19a69 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -281,6 +281,15 @@ static struct mm_region imx9_mem_map[] = {
>   			 PTE_BLOCK_NON_SHARE |
>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>   	}, {
> +#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
> +		/* QB data */

Is the ifdeffery necessary ?

Where are the QB data located in this case, DRAM or SRAM ?

> +		.virt = CONFIG_SAVED_QB_STATE_BASE,
> +		.phys = CONFIG_SAVED_QB_STATE_BASE,
> +		.size = 0x200000UL,	/* 2M */
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_OUTER_SHARE
> +	}, {
> +#endif /* CONFIG_IMX_SNPS_DDR_PHY_QB_GEN */
>   		/* empty entry to split table entry 5 if needed when TEEs are used */
>   		0,
>   	}, {
> diff --git a/drivers/ddr/imx/imx9/Kconfig b/drivers/ddr/imx/imx9/Kconfig
> index 0a45340ffb6..7c244ddb5dd 100644
> --- a/drivers/ddr/imx/imx9/Kconfig
> +++ b/drivers/ddr/imx/imx9/Kconfig
> @@ -29,4 +29,12 @@ config SAVED_DRAM_TIMING_BASE
>   	  info into memory for low power use.
>   	default 0x2051C000

Please fix ^ that one in separate patch, default goes after depends.

>   
> +config SAVED_QB_STATE_BASE

IMX_SNPS_DDR_PHY_QB_SAVED_STATE_ADDRESS ... to make the prefix of this 
Kconfig symbol aligned with IMX_SNPS_DDR_PHY_QB_GEN below .

> +	hex "Define the base address for saved QuickBoot state"
> +	depends on IMX_SNPS_DDR_PHY_QB_GEN

"default" goes here.

> +	help
> +	  Once DRAM is trained, need to save the dram related timing
> +	  info into memory in order to be reachable from U-Boot.
> +	default 0x8fe00000
> +
>   endmenu
> diff --git a/drivers/ddr/imx/phy/Kconfig b/drivers/ddr/imx/phy/Kconfig
> index d3e589b23c4..e8d0c005689 100644
> --- a/drivers/ddr/imx/phy/Kconfig
> +++ b/drivers/ddr/imx/phy/Kconfig
> @@ -2,3 +2,10 @@ config IMX_SNPS_DDR_PHY
>   	bool "i.MX Snopsys DDR PHY"
>   	help
>   	  Select the DDR PHY driver support on i.MX8M and i.MX9 SOC.
> +
> +config IMX_SNPS_DDR_PHY_QB_GEN
> +	bool "i.MX Synopsys DDR PHY training data saving for QuickBoot mode"
> +	depends on IMX94 || IMX95
> +	help
> +	  Select the DDR PHY training data saving for
> +	  QuickBoot support on i.MX9 SOC.
