Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EACE677F5
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 13:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F3888F70;
	Sat,  2 Nov 2024 14:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tYwDNwtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A11788FEA; Sat,  2 Nov 2024 14:27:20 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9738988E99
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 14:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730554012; x=1731158812; i=xypron.glpk@gmx.de;
 bh=kI8pA6G/2n/S8o09Yju1UGSXGAMSOdPTA5/wJUvi6pQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tYwDNwtTA43f/9cIBoNCH+OfZQ0ixhWfjNeEbtIEbicJMsX2NQOcXrjMgMlLxbLS
 GxPa0rootxghV1mTjJm83ZEOGteuyRL+eMwGGx5JDb5/LH14wTljZNh+8/dfveVM6
 PlGVtTSPDvT7WYfOTQ+oZhmgBEIJQHRZiqT059JmyjWMwS+j0CXfcaNKU71uoGXJf
 Nj5XPPQbKKuhtSWS1JycmfrPcm+VXIVh4q4zIUtgVwU8gnL4b8dyiAL6b1jz5ICHr
 Fk8WLG0xYcK2F3pS79iCsptAKYHPg1sKA58Vr16Isuwb7BKOGLJw1wh+3ytJ4YXBX
 pMnwXqUOOklBy/R5LA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1tiTuZ1zVT-00kOap; Sat, 02
 Nov 2024 14:26:52 +0100
Message-ID: <2590f353-add2-4770-816b-650c70fed8a9@gmx.de>
Date: Sat, 2 Nov 2024 14:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] Revert "mtd: spi-nor: Add parallel and stacked
 memories support"
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
References: <20241022210633.271534-1-marek.vasut+renesas@mailbox.org>
 <20241022210633.271534-6-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241022210633.271534-6-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ohWQp7T56RKTC7Mq/dTKL0OnVQ2prk5/RUzCbLIyA7NWX+JLcd2
 VbvUi4QgULIXLYh/n3s37UEoDxLtOI/YrLyKcU7AmiN+Dfrd9pxRreVLAr6A5gBdTqb02x9
 wEroVkxtmGJdaoN5htbGRDLJwq4we37r9nRwkyIbWMLryc95mY9dyyVMIBuiHViZYFa1qIB
 3u14QhLZCk9VXKPknXipg==
UI-OutboundReport: notjunk:1;M01:P0:XfChQzMuIgU=;C9ocVnI2HshC3EINK3OW6oCzp9M
 BdN4H0rOs8hGPuqJCtNW3vNSkBSh4hUH3cC8XxycRPfHPE8obZR2viu2AUfVQw4o2rZMNyNDJ
 62+fUUpEOTgRO2UMRXjJ6YD0/hqc8Hz7ogH4UNIYG8nXlSYDipe9Y88RNaHVmPNp9M2teUD1r
 bnzEnBj0KfdkQwv44gBPWIoHI13XHWKqUodquC/L5j/urSEvzDsjJew+mvk5x8mVqNAYnHPo7
 c3fHCpZFDhMnecZ3ssmEWZz/93yPBhu3b4uNykMSiWx7/8ApufdYz4x3GTvhXQ9ICSgxx/Qt3
 VVyllyoHHCQZT9hMRbVmlqm4EGVSi5EcbFVr+7YAKapSctvdt/tH6ShxKWOr68gF28Xh/xnd9
 387uadrKI3XYQQR38bsTvvfZW+fdRaF9U/O6ODEnd4PH0wiW9kfoX2VjLg8JwaYWmhyQ2o5Gr
 kGperud5Wi0ubO7aoJfAFrTPGQx4wpiIj6S9ZRS63xXlfeXRbDWcowTeg7eganR1JI8sUG0ec
 Tk7ZvYEC6Hu+j7hqGDZyqpbv0YtKIsOpXJqutlbTOJ9C7IgadAEp0weMxpd+coMdSJVIU3phB
 w+jR95BcoyXDPkSVjGCt59S2WTkHB0rgIz85GgLtyeOBImWlt2AMFk+QuHhob00ybGmI0oitz
 8VlTsM8HfqyY79rUSAV93D8WggJQ3HU+sDRS7ieZWYUlQuFQb9LG3/D7NEl/VDyJYIbOhKTMt
 rrSkhRRmobsiCY6BkSGqGywOUfblm4BSBySC+NOzVYVCdCgvv6W9RPzLYxA5Gll2Bnm2DBM4N
 xwbPZKBvXhHnMrF2Y7FL7cRA==
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

On 10/22/24 23:06, Marek Vasut wrote:
> This reverts commit 5d40b3d384dc536ec26ce9b76b20b0b84749d2d1.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Pratyush Yadav <p.yadav@ti.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>   drivers/mtd/spi/spi-nor-core.c | 301 ++++-----------------------------
>   drivers/spi/Kconfig            |   6 -
>   include/linux/mtd/spi-nor.h    |  17 --
>   include/spi.h                  |  11 --
>   4 files changed, 34 insertions(+), 301 deletions(-)
>
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-co=
re.c
> index 25fb034dcae..85d12d58907 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -696,17 +696,12 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
>   static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
>   				      const struct flash_info *info)
>   {
> -	bool shift =3D 0;
> -
> -	if (nor->flags & SNOR_F_HAS_PARALLEL)
> -		shift =3D 1;
> -
>   	/* Do some manufacturer fixups first */
>   	switch (JEDEC_MFR(info)) {
>   	case SNOR_MFR_SPANSION:
>   		/* No small sector erase for 4-byte command set */
>   		nor->erase_opcode =3D SPINOR_OP_SE;
> -		nor->mtd.erasesize =3D info->sector_size << shift;
> +		nor->mtd.erasesize =3D info->sector_size;
>   		break;
>
>   	default:
> @@ -1041,8 +1036,8 @@ static int spi_nor_erase_sector(struct spi_nor *no=
r, u32 addr)
>   static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *inst=
r)
>   {
>   	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
> -	u32 addr, len, rem, offset, max_size;
>   	bool addr_known =3D false;
> +	u32 addr, len, rem, max_size;
>   	int ret, err;
>
>   	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
> @@ -1068,18 +1063,6 @@ static int spi_nor_erase(struct mtd_info *mtd, st=
ruct erase_info *instr)
>   			ret =3D -EINTR;
>   			goto erase_err;
>   		}
> -		offset =3D addr;
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			offset /=3D 2;
> -
> -		if (nor->flags & SNOR_F_HAS_STACKED) {
> -			if (offset >=3D (mtd->size / 2)) {
> -				offset =3D offset - (mtd->size / 2);
> -				nor->spi->flags |=3D SPI_XFER_U_PAGE;
> -			} else {
> -				nor->spi->flags &=3D ~SPI_XFER_U_PAGE;
> -			}
> -		}
>   #ifdef CONFIG_SPI_FLASH_BAR
>   		ret =3D write_bar(nor, addr);
>   		if (ret < 0)
> @@ -1491,9 +1474,6 @@ static const struct flash_info *spi_nor_read_id(st=
ruct spi_nor *nor)
>   	u8			id[SPI_NOR_MAX_ID_LEN];
>   	const struct flash_info	*info;
>
> -	if (nor->flags & SNOR_F_HAS_PARALLEL)
> -		nor->spi->flags |=3D SPI_XFER_LOWER;

This line was definitely wrong as nor->spi->flags is u8 and
SPI_XFER_LOWER =3D 0x100.

You could add
Addresses-Coverity-ID: 510804 Extra high-order bits

Best regards

Heinrich

> -
>   	tmp =3D nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
>   	if (tmp < 0) {
>   		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
> @@ -1518,67 +1498,28 @@ static int spi_nor_read(struct mtd_info *mtd, lo=
ff_t from, size_t len,
>   {
>   	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
>   	int ret;
> -	loff_t offset =3D from;
> -	u32 read_len =3D 0;
> -	u32 rem_bank_len =3D 0;
> -	u8 bank;
> -	bool is_ofst_odd =3D false;
>
>   	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
>
> -	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (offset & 1)) {
> -	    /* We can hit this case when we use file system like ubifs */
> -		from--;
> -		len++;
> -		is_ofst_odd =3D true;
> -	}
> -
>   	while (len) {
> -		if (nor->addr_width =3D=3D 3) {
> -			if (nor->flags & SNOR_F_HAS_PARALLEL) {
> -				bank =3D (u32)from / (SZ_16M << 0x01);
> -				rem_bank_len =3D ((SZ_16M << 0x01) *
> -					(bank + 1)) - from;
> -			} else {
> -				bank =3D (u32)from / SZ_16M;
> -				rem_bank_len =3D (SZ_16M * (bank + 1)) - from;
> -			}
> -		}
> -		offset =3D from;
> +		loff_t addr =3D from;
> +		size_t read_len =3D len;
>
> -		if (nor->flags & SNOR_F_HAS_STACKED) {
> -			if (offset >=3D (mtd->size / 2)) {
> -				offset =3D offset - (mtd->size / 2);
> -				nor->spi->flags |=3D SPI_XFER_U_PAGE;
> -			} else {
> -				nor->spi->flags &=3D ~SPI_XFER_U_PAGE;
> -			}
> -		}
> -
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			offset /=3D 2;
> -
> -		if (nor->addr_width =3D=3D 3) {
>   #ifdef CONFIG_SPI_FLASH_BAR
> -			ret =3D write_bar(nor, offset);
> -			if (ret < 0)
> -				return log_ret(ret);
> -#endif
> -		}
> +		u32 remain_len;
>
> -		if (len < rem_bank_len)
> +		ret =3D write_bar(nor, addr);
> +		if (ret < 0)
> +			return log_ret(ret);
> +		remain_len =3D (SZ_16M * (nor->bank_curr + 1)) - addr;
> +
> +		if (len < remain_len)
>   			read_len =3D len;
>   		else
> -			read_len =3D rem_bank_len;
> -
> -		if (read_len =3D=3D 0)
> -			return -EIO;
> -
> -		ret =3D spi_nor_wait_till_ready(nor);
> -		if (ret)
> -			goto read_err;
> +			read_len =3D remain_len;
> +#endif
>
> -		ret =3D nor->read(nor, offset, read_len, buf);
> +		ret =3D nor->read(nor, addr, read_len, buf);
>   		if (ret =3D=3D 0) {
>   			/* We shouldn't see 0-length reads */
>   			ret =3D -EIO;
> @@ -1587,15 +1528,8 @@ static int spi_nor_read(struct mtd_info *mtd, lof=
f_t from, size_t len,
>   		if (ret < 0)
>   			goto read_err;
>
> -		if (is_ofst_odd =3D=3D true) {
> -			memmove(buf, (buf + 1), (len - 1));
> -			*retlen +=3D (ret - 1);
> -			buf +=3D ret - 1;
> -			is_ofst_odd =3D false;
> -		} else {
> -			*retlen +=3D ret;
> -			buf +=3D ret;
> -		}
> +		*retlen +=3D ret;
> +		buf +=3D ret;
>   		from +=3D ret;
>   		len -=3D ret;
>   	}
> @@ -1890,7 +1824,6 @@ static int spi_nor_write(struct mtd_info *mtd, lof=
f_t to, size_t len,
>   	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
>   	size_t page_offset, page_remain, i;
>   	ssize_t ret;
> -	u32 offset;
>
>   #ifdef CONFIG_SPI_FLASH_SST
>   	/* sst nor chips use AAI word program */
> @@ -1900,27 +1833,6 @@ static int spi_nor_write(struct mtd_info *mtd, lo=
ff_t to, size_t len,
>
>   	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
>
> -	if (!len)
> -		return 0;
> -
> -	/*
> -	 * Cannot write to odd offset in parallel mode,
> -	 * so write 2 bytes first
> -	 */
> -	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (to & 1)) {
> -		u8 two[2] =3D {0xff, buf[0]};
> -		size_t local_retlen;
> -
> -		ret =3D spi_nor_write(mtd, to & ~1, 2, &local_retlen, two);
> -		if (ret < 0)
> -			return ret;
> -
> -		*retlen +=3D 1; /* We've written only one actual byte */
> -		++buf;
> -		--len;
> -		++to;
> -	}
> -
>   	for (i =3D 0; i < len; ) {
>   		ssize_t written;
>   		loff_t addr =3D to + i;
> @@ -1938,35 +1850,18 @@ static int spi_nor_write(struct mtd_info *mtd, l=
off_t to, size_t len,
>
>   			page_offset =3D do_div(aux, nor->page_size);
>   		}
> -		offset =3D (to + i);
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			offset /=3D 2;
> -
> -		if (nor->flags & SNOR_F_HAS_STACKED) {
> -			if (offset >=3D (mtd->size / 2)) {
> -				offset =3D offset - (mtd->size / 2);
> -				nor->spi->flags |=3D SPI_XFER_U_PAGE;
> -			} else {
> -				nor->spi->flags &=3D ~SPI_XFER_U_PAGE;
> -			}
> -		}
> -
> -		if (nor->addr_width =3D=3D 3) {
> -#ifdef CONFIG_SPI_FLASH_BAR
> -			ret =3D write_bar(nor, offset);
> -			if (ret < 0)
> -				return ret;
> -#endif
> -		}
>   		/* the size of data remaining on the first page */
>   		page_remain =3D min_t(size_t,
>   				    nor->page_size - page_offset, len - i);
>
> -		ret =3D spi_nor_wait_till_ready(nor);
> -		if (ret)
> -			goto write_err;
> +#ifdef CONFIG_SPI_FLASH_BAR
> +		ret =3D write_bar(nor, addr);
> +		if (ret < 0)
> +			return ret;
> +#endif
>
>   		write_enable(nor);
> +
>   		/*
>   		 * On DTR capable flashes like Micron Xcella the writes cannot
>   		 * start or end at an odd address in DTR mode. So we need to
> @@ -1974,7 +1869,7 @@ static int spi_nor_write(struct mtd_info *mtd, lof=
f_t to, size_t len,
>   		 * address and end address are even.
>   		 */
>   		if (spi_nor_protocol_is_dtr(nor->write_proto) &&
> -		    ((offset | page_remain) & 1)) {
> +		    ((addr | page_remain) & 1)) {
>   			u_char *tmp;
>   			size_t extra_bytes =3D 0;
>
> @@ -1985,10 +1880,10 @@ static int spi_nor_write(struct mtd_info *mtd, l=
off_t to, size_t len,
>   			}
>
>   			/* Prepend a 0xff byte if the start address is odd. */
> -			if (offset & 1) {
> +			if (addr & 1) {
>   				tmp[0] =3D 0xff;
>   				memcpy(tmp + 1, buf + i, page_remain);
> -				offset--;
> +				addr--;
>   				page_remain++;
>   				extra_bytes++;
>   			} else {
> @@ -1996,13 +1891,13 @@ static int spi_nor_write(struct mtd_info *mtd, l=
off_t to, size_t len,
>   			}
>
>   			/* Append a 0xff byte if the end address is odd. */
> -			if ((offset + page_remain) & 1) {
> +			if ((addr + page_remain) & 1) {
>   				tmp[page_remain + extra_bytes] =3D 0xff;
>   				extra_bytes++;
>   				page_remain++;
>   			}
>
> -			ret =3D nor->write(nor, offset, page_remain, tmp);
> +			ret =3D nor->write(nor, addr, page_remain, tmp);
>
>   			kfree(tmp);
>
> @@ -2015,7 +1910,7 @@ static int spi_nor_write(struct mtd_info *mtd, lof=
f_t to, size_t len,
>   			 */
>   			written =3D ret - extra_bytes;
>   		} else {
> -			ret =3D nor->write(nor, offset, page_remain, buf + i);
> +			ret =3D nor->write(nor, addr, page_remain, buf + i);
>   			if (ret < 0)
>   				goto write_err;
>   			written =3D ret;
> @@ -2024,11 +1919,6 @@ static int spi_nor_write(struct mtd_info *mtd, lo=
ff_t to, size_t len,
>   		ret =3D spi_nor_wait_till_ready(nor);
>   		if (ret)
>   			goto write_err;
> -
> -		ret =3D write_disable(nor);
> -		if (ret)
> -			goto write_err;
> -
>   		*retlen +=3D written;
>   		i +=3D written;
>   	}
> @@ -2069,10 +1959,6 @@ static int macronix_quad_enable(struct spi_nor *n=
or)
>   	if (ret)
>   		return ret;
>
> -	ret =3D write_disable(nor);
> -	if (ret)
> -		return ret;
> -
>   	ret =3D read_sr(nor);
>   	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
>   		dev_err(nor->dev, "Macronix Quad bit not set\n");
> @@ -2134,7 +2020,7 @@ static int spansion_quad_enable_volatile(struct sp=
i_nor *nor, u32 addr_base,
>   		return -EINVAL;
>   	}
>
> -	return write_disable(nor);
> +	return 0;
>   }
>   #endif
>
> @@ -2310,10 +2196,6 @@ static int spi_nor_read_sfdp(struct spi_nor *nor,=
 u32 addr,
>   	nor->read_dummy =3D 8;
>
>   	while (len) {
> -		/* Both chips are identical, so should be the SFDP data */
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			nor->spi->flags |=3D SPI_XFER_LOWER;
> -
>   		ret =3D nor->read(nor, addr, len, (u8 *)buf);
>   		if (!ret || ret > len) {
>   			ret =3D -EIO;
> @@ -3008,13 +2890,6 @@ static int spi_nor_init_params(struct spi_nor *no=
r,
>   			       const struct flash_info *info,
>   			       struct spi_nor_flash_parameter *params)
>   {
> -#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_ADVANCE)
> -	struct udevice *dev =3D nor->spi->dev;
> -	u64 flash_size[SNOR_FLASH_CNT_MAX] =3D {0};
> -	u32 idx =3D 0, i =3D 0;
> -	int rc;
> -#endif
> -
>   	/* Set legacy flash parameters as default. */
>   	memset(params, 0, sizeof(*params));
>
> @@ -3133,63 +3008,8 @@ static int spi_nor_init_params(struct spi_nor *no=
r,
>
>   		spi_nor_post_sfdp_fixups(nor, params);
>   	}
> -#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_ADVANCE)
> -	/*
> -	 * The flashes that are connected in stacked mode should be of same ma=
ke.
> -	 * Except the flash size all other properties are identical for all th=
e
> -	 * flashes connected in stacked mode.
> -	 * The flashes that are connected in parallel mode should be identical=
.
> -	 */
> -	while (i < SNOR_FLASH_CNT_MAX) {
> -		rc =3D ofnode_read_u64_index(dev_ofnode(dev), "stacked-memories",
> -					   idx, &flash_size[i]);
> -		if (rc =3D=3D -EINVAL) {
> -			break;
> -		} else if (rc =3D=3D -EOVERFLOW) {
> -			idx++;
> -		} else {
> -			idx++;
> -			i++;
> -			if (!(nor->flags & SNOR_F_HAS_STACKED))
> -				nor->flags |=3D SNOR_F_HAS_STACKED;
> -			if (!(nor->spi->flags & SPI_XFER_STACKED))
> -				nor->spi->flags |=3D SPI_XFER_STACKED;
> -		}
> -	}
> -
> -	i =3D 0;
> -	idx =3D 0;
> -	while (i < SNOR_FLASH_CNT_MAX) {
> -		rc =3D ofnode_read_u64_index(dev_ofnode(dev), "parallel-memories",
> -					   idx, &flash_size[i]);
> -		if (rc =3D=3D -EINVAL) {
> -			break;
> -		} else if (rc =3D=3D -EOVERFLOW) {
> -			idx++;
> -		} else {
> -			idx++;
> -			i++;
> -			if (!(nor->flags & SNOR_F_HAS_PARALLEL))
> -				nor->flags |=3D SNOR_F_HAS_PARALLEL;
> -		}
> -	}
>
> -	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
> -		params->size =3D 0;
> -		for (idx =3D 0; idx < SNOR_FLASH_CNT_MAX; idx++)
> -			params->size +=3D flash_size[idx];
> -	}
> -	/*
> -	 * In parallel-memories the erase operation is
> -	 * performed on both the flashes simultaneously
> -	 * so, double the erasesize.
> -	 */
> -	if (nor->flags & SNOR_F_HAS_PARALLEL) {
> -		nor->mtd.erasesize <<=3D 1;
> -		params->page_size <<=3D 1;
> -	}
> -#endif
> -	spi_nor_late_init_fixups(nor, params);
> +	spi_nor_post_sfdp_fixups(nor, params);
>
>   	return 0;
>   }
> @@ -3503,54 +3323,16 @@ static int spi_nor_select_erase(struct spi_nor *=
nor,
>   	/* prefer "small sector" erase if possible */
>   	if (info->flags & SECT_4K) {
>   		nor->erase_opcode =3D SPINOR_OP_BE_4K;
> -		/*
> -		 * In parallel-memories the erase operation is
> -		 * performed on both the flashes simultaneously
> -		 * so, double the erasesize.
> -		 */
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			mtd->erasesize =3D 4096 * 2;
> -		else
> -			mtd->erasesize =3D 4096;
> +		mtd->erasesize =3D 4096;
>   	} else if (info->flags & SECT_4K_PMC) {
>   		nor->erase_opcode =3D SPINOR_OP_BE_4K_PMC;
> -		/*
> -		 * In parallel-memories the erase operation is
> -		 * performed on both the flashes simultaneously
> -		 * so, double the erasesize.
> -		 */
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			mtd->erasesize =3D 4096 * 2;
> -		else
> -			mtd->erasesize =3D 4096;
> +		mtd->erasesize =3D 4096;
>   	} else
>   #endif
>   	{
>   		nor->erase_opcode =3D SPINOR_OP_SE;
> -		/*
> -		 * In parallel-memories the erase operation is
> -		 * performed on both the flashes simultaneously
> -		 * so, double the erasesize.
> -		 */
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			mtd->erasesize =3D info->sector_size * 2;
> -		else
> -			mtd->erasesize =3D info->sector_size;
> -	}
> -
> -	if ((JEDEC_MFR(info) =3D=3D SNOR_MFR_SST) && info->flags & SECT_4K) {
> -		nor->erase_opcode =3D SPINOR_OP_BE_4K;
> -		/*
> -		 * In parallel-memories the erase operation is
> -		 * performed on both the flashes simultaneously
> -		 * so, double the erasesize.
> -		 */
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			mtd->erasesize =3D 4096 * 2;
> -		else
> -			mtd->erasesize =3D 4096;
> +		mtd->erasesize =3D info->sector_size;
>   	}
> -
>   	return 0;
>   }
>
> @@ -4206,9 +3988,6 @@ static int spi_nor_init(struct spi_nor *nor)
>   {
>   	int err;
>
> -	if (nor->flags & SNOR_F_HAS_PARALLEL)
> -		nor->spi->flags |=3D SPI_NOR_ENABLE_MULTI_CS;
> -
>   	err =3D spi_nor_octal_dtr_enable(nor);
>   	if (err) {
>   		dev_dbg(nor->dev, "Octal DTR mode not supported\n");
> @@ -4395,7 +4174,6 @@ int spi_nor_scan(struct spi_nor *nor)
>   	struct spi_slave *spi =3D nor->spi;
>   	int ret;
>   	int cfi_mtd_nb =3D 0;
> -	bool shift =3D 0;
>
>   #ifdef CONFIG_FLASH_CFI_MTD
>   	cfi_mtd_nb =3D CFI_FLASH_BANKS;
> @@ -4533,9 +4311,7 @@ int spi_nor_scan(struct spi_nor *nor)
>   		nor->addr_width =3D 3;
>   	}
>
> -	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED))
> -		shift =3D 1;
> -	if (nor->addr_width =3D=3D 3 && (mtd->size >> shift) > SZ_16M) {
> +	if (nor->addr_width =3D=3D 3 && mtd->size > SZ_16M) {
>   #ifndef CONFIG_SPI_FLASH_BAR
>   		/* enable 4-byte addressing if the device exceeds 16MiB */
>   		nor->addr_width =3D 4;
> @@ -4545,7 +4321,6 @@ int spi_nor_scan(struct spi_nor *nor)
>   #else
>   	/* Configure the BAR - discover bank cmds and read current bank */
>   	nor->addr_width =3D 3;
> -	set_4byte(nor, info, 0);
>   	ret =3D read_bar(nor, info);
>   	if (ret < 0)
>   		return ret;
> @@ -4563,14 +4338,6 @@ int spi_nor_scan(struct spi_nor *nor)
>   	if (ret)
>   		return ret;
>
> -	if (nor->flags & SNOR_F_HAS_STACKED) {
> -		nor->spi->flags |=3D SPI_XFER_U_PAGE;
> -		ret =3D spi_nor_init(nor);
> -		if (ret)
> -			return ret;
> -		nor->spi->flags &=3D ~SPI_XFER_U_PAGE;
> -	}
> -
>   	nor->rdsr_dummy =3D params.rdsr_dummy;
>   	nor->rdsr_addr_nbytes =3D params.rdsr_addr_nbytes;
>   	nor->name =3D info->name;
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index fa817ec4883..280d1f62ae9 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -20,12 +20,6 @@ menuconfig SPI
>
>   if SPI
>
> -config SPI_ADVANCE
> -	bool "Enable the advance feature"
> -	help
> -	 Enable the SPI advance feature support. By default this is disabled.
> -	 If you intend to use the advance feature support you should enable.
> -
>   config DM_SPI
>   	bool "Enable Driver Model for SPI drivers"
>   	depends on DM
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 655a6d197ea..651628200b7 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -13,9 +13,6 @@
>   #include <linux/mtd/mtd.h>
>   #include <spi-mem.h>
>
> -/* In parallel configuration enable multiple CS */
> -#define SPI_NOR_ENABLE_MULTI_CS	(BIT(0) | BIT(1))
> -
>   /*
>    * Manufacturer IDs
>    *
> @@ -185,12 +182,6 @@
>   /* Status Register 3 bits. */
>   #define SR3_WPS			BIT(2)
>
> -/*
> - * Maximum number of flashes that can be connected
> - * in stacked/parallel configuration
> - */
> -#define SNOR_FLASH_CNT_MAX	2
> -
>   /* For Cypress flash. */
>   #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
>   #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
> @@ -308,13 +299,6 @@ enum spi_nor_option_flags {
>   	SNOR_F_BROKEN_RESET	=3D BIT(6),
>   	SNOR_F_SOFT_RESET	=3D BIT(7),
>   	SNOR_F_IO_MODE_EN_VOLATILE =3D BIT(8),
> -#if defined(CONFIG_SPI_ADVANCE)
> -	SNOR_F_HAS_STACKED	=3D BIT(9),
> -	SNOR_F_HAS_PARALLEL	=3D BIT(10),
> -#else
> -	SNOR_F_HAS_STACKED	=3D 0,
> -	SNOR_F_HAS_PARALLEL	=3D 0,
> -#endif
>   };
>
>   struct spi_nor;
> @@ -573,7 +557,6 @@ struct spi_nor {
>   	u8			bank_read_cmd;
>   	u8			bank_write_cmd;
>   	u8			bank_curr;
> -	u8			upage_prev;
>   #endif
>   	enum spi_nor_protocol	read_proto;
>   	enum spi_nor_protocol	write_proto;
> diff --git a/include/spi.h b/include/spi.h
> index 6e8e0cce7f2..9e9851284c8 100644
> --- a/include/spi.h
> +++ b/include/spi.h
> @@ -38,15 +38,6 @@
>
>   #define SPI_DEFAULT_WORDLEN	8
>
> -/* SPI transfer flags */
> -#define SPI_XFER_STRIPE	(1 << 6)
> -#define SPI_XFER_MASK	(3 << 8)
> -#define SPI_XFER_LOWER	(1 << 8)
> -#define SPI_XFER_UPPER	(2 << 8)
> -
> -/* Max no. of CS supported per spi device */
> -#define SPI_CS_CNT_MAX	2
> -
>   /**
>    * struct dm_spi_bus - SPI bus info
>    *
> @@ -164,8 +155,6 @@ struct spi_slave {
>   #define SPI_XFER_BEGIN		BIT(0)	/* Assert CS before transfer */
>   #define SPI_XFER_END		BIT(1)	/* Deassert CS after transfer */
>   #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
> -#define SPI_XFER_U_PAGE		BIT(4)
> -#define SPI_XFER_STACKED	BIT(5)
>   };
>
>   /**

