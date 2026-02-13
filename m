Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66843EDF175
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 15:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBAF483CB5;
	Fri, 13 Feb 2026 16:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="byPObsKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F002983C4B; Fri, 13 Feb 2026 16:34:38 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3349D83CEE
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 16:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8cb403b7c75so13633985a.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 07:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770996875; x=1771601675; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SpkKQ0GeILRrNrVPwGmB8P/O9IkweoueMY2+YrehFCg=;
 b=byPObsKF8i6PA9/foO/b/egrO2SiKw5fWU7q7k6FRGfczgyL218inxL0xHFYZK8/9t
 rYzLLXnb8Bw+tf1/uEVMqjLrLyBlyvNN7bQB18uNy+pmzErHEVAn2QPOOLxuKNxAyyHM
 HVPpeKreJ3dANJfCPzPKketJsiXfARymtFABXCSmLthPCPLUTOPisHpgqUvohSruHXt6
 b5eU2Agwni52lx70Onlcs0YIvmpTF0MjXsv+8eTi80njQg7Q2ciiCKZRxowBhXELpJxI
 UFgQNjO82EodeEbXLD2l8ZczW4WHzpKMjbG1eQI6JvxHoATsuTXLvCfYWxtpBPWori2s
 Qggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770996875; x=1771601675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SpkKQ0GeILRrNrVPwGmB8P/O9IkweoueMY2+YrehFCg=;
 b=FrJr3I+kYjhvHnrOMji2ibcH4UtFyw3goZYgsNCyFRlejaLcK6cE7K/At6tz9bnm07
 0yfMCQeeIPZWc6nb26Aj7upms4uYMf1Zoc2l1G2V0BRfr6dxEv5ioq1LPNaOVRz5ydnN
 kkqOQxo/5gQD4xnUVlGlqMSY7XH4KNHEgZWDE03BB65WAoYyJIoilDKpAX4aljUuY2lW
 cPcW2aqTkVRJLuCkQiXnOaHK2Xm0qy11FT+561Qtoa3YL5pMiPRvwEOs+aiVPmkgzmRE
 C6wzf6LZJerPba1U71J2yFs5mrJxP6NwoMd8IuiLdH+VwnHk+BD8BlzgHy4Zb0DyskrI
 TmYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIsLSzTB4fpJrjZaAlq/BgqIq0CzmuMEPfxK6X0n/VsJ4OUVuNdALH1MeBOcyOv/D90CDzEQs=@lists.denx.de
X-Gm-Message-State: AOJu0YyAESBYQrrPN1ZTNTBHzPCPtBKXIE20GzQjVZQ4yZpJ3Yrji/BA
 zviKA/vHtGFbbS4Yp1YiGZWm8b+vQj+tx09DfBaBtq8E3JnD/uQpkwPU
X-Gm-Gg: AZuq6aJ1l5bGjzL5NTJW9smGU1PU3jx6Llm4PcqsXyvT9+2SJxvJ7MWjVENjwhBR0Aa
 AQvld7BvCg7mgKoA/vwNhoneX9NWUyk/gdjYsnn1Wniwx273h+aKGbnFrNnCP1YiLfsZV4jDzz5
 XYj9ckQrFN8AY4s/f0JrXuiNN5/ljuzqJRgW4CtaTf0m8/hFmL4RWNxTTrcN8eLrIR6a/epe4uk
 /qziv3Mw31Op0CMpZaf9+xjz3HSy2h0zwqH6gvcTgBypFGxt2qB4Jzt0liXOo78Ab1nSoxCjMzv
 5lNzVr4amwMoK5YwL80Qn+vqNS6Xh1m1XUSagEblHrcFg4cihJpqhPqHFLLww0t+wHZApkzCtb5
 oJ7QufchkeXU14V2ubW9WxOEmTumakpdjHB7VVUggtjKcp/N5uazXuErYoB52MQLhK6NBuWR6Z0
 X2az7CUXoE9YpjBwNg5goId1lKhVPEwKJpPk9A8Epk+gfMLWwj2I0TkhOKs02N3YbStq8=
X-Received: by 2002:a05:6214:4f05:b0:897:1d50:2336 with SMTP id
 6a1803df08f44-897347ccd64mr31787026d6.6.1770996874726; 
 Fri, 13 Feb 2026 07:34:34 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cc823a4sm62690376d6.8.2026.02.13.07.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 07:34:34 -0800 (PST)
Message-ID: <3fe5e11d-7240-c577-64fc-062d5c5e4d6a@gmail.com>
Date: Fri, 13 Feb 2026 10:34:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/6] misc: Add support for bit fields in NVMEM cells
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, u-boot@lists.denx.de,
 sumit.garg@kernel.org, casey.connolly@linaro.org, u-boot-qcom@groups.io
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
 <20260213112717.1256823-3-aswin.murugan@oss.qualcomm.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260213112717.1256823-3-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/13/26 06:27, Aswin Murugan wrote:
> NVMEM cells currently only support byte-level access. Many hardware
> registers pack multiple fields into single bytes, requiring bit-level
> granularity. For example, Qualcomm PMIC PON registers store a 7-bit
> reboot reason field within a single byte, with bit 0 reserved for other
> purposes.
> 
> Add support for the optional 'bits' property in NVMEM cell device tree
> bindings. This property specifies <bit_offset num_bits> to define a bit
> field within the cell's register space.
> 
> Implement multi-byte bit field support by porting bit manipulation
> algorithms from the Linux kernel driver [1]:
> 
> 1. nvmem_shift_read_buffer_in_place() - Extract bit fields from raw
>     bytes by shifting and masking across byte boundaries. Handles fields
>     that span multiple bytes.
> 
> 2. nvmem_cell_prepare_write_buffer() - Perform Read-Modify-Write to
>     preserve bits outside the target field. Read current values, mask to
>     preserve adjacent bits, and combine with new value.
> 
> Example device tree usage:
>          reboot-reason@48 {
>                  reg = <0x48 0x01>;
>                  bits = <0x01 0x07>;  /* 7 bits starting at bit 1 */
>          };
> 
> This reads bits [7:1] from the byte at offset 0x48, leaving bit 0
> untouched during write operations.
> 
> Cells without the 'bits' property continue to work unchanged, ensuring
> backward compatibility with existing device trees.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvmem/core.c
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

This seems like it adds a lot of calculations; have you looked at the size
increase? Maybe this should be a separate config, since the feature does not
seem too common.

Actually, I think we could reduce the complexity quite a bit by refusing
to process bits longer than a ulong. A quick grep through Linux's dts shows
that the largest bits is <6 12>. I don't really see any reason we need to
support arbitrary bit extraction.

There should also be a test for this. The existing code is lightly tested by
checking that mac addresses are loaded correctly. Maybe you can extend
test/dm/reboot-mode.c.

> ---
>   drivers/misc/nvmem.c | 241 ++++++++++++++++++++++++++++++++++++++++---
>   include/nvmem.h      |   4 +
>   2 files changed, 231 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
> index 33e80858565..6a75c326189 100644
> --- a/drivers/misc/nvmem.c
> +++ b/drivers/misc/nvmem.c
> @@ -12,52 +12,251 @@
>   #include <dm/ofnode.h>
>   #include <dm/read.h>
>   #include <dm/uclass.h>
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +
> +/**
> + * nvmem_shift_read_buffer_in_place() - Shift read buffer to extract bit field
> + * @cell: NVMEM cell with bit field information
> + * @buf: Buffer containing raw bytes read from NVMEM
> + *
> + * This function shifts and masks the buffer to extract only the bits specified
> + * by cell->bit_offset and cell->nbits. It handles bit fields that span multiple
> + * bytes by shifting bits across byte boundaries.
> + *
> + */
> +static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
> +{
> +	u8 *prev_byte, *buf_ptr;
> +	int i, extra, bit_offset = cell->bit_offset;
> +	int bytes_needed;
> +
> +	bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
> +
> +	prev_byte = buf_ptr = buf;
> +	if (bit_offset) {
> +		/* First byte: shift right by bit_offset */
> +		*buf_ptr++ >>= bit_offset;
> +
> +		/* Process remaining bytes, combining bits across boundaries */
> +		for (i = 1; i < bytes_needed; i++) {
> +			/* Get bits from next byte and shift them towards MSB */
> +			*prev_byte |= *buf_ptr << (BITS_PER_BYTE - bit_offset);
> +
> +			prev_byte = buf_ptr;
> +			*buf_ptr++ >>= bit_offset;
> +		}
> +	} else {
> +		/* Point to the MSB */
> +		prev_byte += bytes_needed - 1;
> +	}
> +
> +	/* Clear extra bytes if result fits in fewer bytes */
> +	extra = bytes_needed - DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE);
> +	while (--extra >= 0)
> +		*prev_byte-- = 0;
> +
> +	/* Clear MSB bits if any leftover in the last byte */
> +	if (cell->nbits % BITS_PER_BYTE)
> +		*prev_byte &= GENMASK((cell->nbits % BITS_PER_BYTE) - 1, 0);
> +}
> +
> +/**
> + * nvmem_cell_prepare_write_buffer() - Prepare buffer for writing bit field
> + * @cell: NVMEM cell with bit field information
> + * @buf: Buffer containing value to write
> + * @size: Size of buf
> + * @data: Output buffer with prepared data for writing
> + *
> + * This function performs Read-Modify-Write to preserve bits outside the
> + * specified bit field. It reads current values, modifies only the target
> + * bits, and prepares the complete bytes for writing back.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
> +					   const void *buf, size_t size,
> +					   u8 *data)
> +{
> +	int i, rc, nbits, bit_offset = cell->bit_offset;
> +	int bytes_needed;
> +	u8 current_val, *prev_byte, *buf_ptr, prev_byte_val, prev_bits;
> +
> +	nbits = cell->nbits;
> +	bytes_needed = DIV_ROUND_UP(nbits + bit_offset, BITS_PER_BYTE);
> +
> +	memcpy(data, buf, size);
> +	prev_byte = buf_ptr = data;
> +
> +	if (bit_offset) {
> +		prev_byte_val = *buf_ptr;
> +		*buf_ptr <<= bit_offset;
> +
> +		/* Setup the first byte with LSB bits from NVMEM */
> +		switch (cell->nvmem->driver->id) {
> +		case UCLASS_I2C_EEPROM:
> +			rc = i2c_eeprom_read(cell->nvmem, cell->offset, &current_val, 1);
> +			break;
> +		case UCLASS_MISC:
> +			rc = misc_read(cell->nvmem, cell->offset, &current_val, 1);
> +			if (rc < 0)
> +				return rc;
> +			if (rc != 1)
> +				return -EIO;
> +			rc = 0;
> +			break;
> +		case UCLASS_RTC:
> +			rc = dm_rtc_read(cell->nvmem, cell->offset, &current_val, 1);
> +			break;
> +		default:
> +			return -ENOSYS;
> +		}

Can you use nvmem_cell_read for this to reduce duplication?

> +
> +		if (rc)
> +			return rc;
> +
> +		*buf_ptr++ |= GENMASK(bit_offset - 1, 0) & current_val;
> +
> +		/* Setup rest of the bytes if any */
> +		for (i = 1; i < bytes_needed; i++) {
> +			/* Get last byte bits and shift them towards LSB */
> +			prev_bits = prev_byte_val >> (BITS_PER_BYTE - 1 - bit_offset);
> +			prev_byte_val = *buf_ptr;
> +			prev_byte = buf_ptr;
> +			*buf_ptr <<= bit_offset;
> +			*buf_ptr++ |= prev_bits;
> +		}
> +	}
> +
> +	/* If it's not end on byte boundary */
> +	if ((nbits + bit_offset) % BITS_PER_BYTE) {
> +		/* Setup the last byte with MSB bits from NVMEM */
> +		switch (cell->nvmem->driver->id) {
> +		case UCLASS_I2C_EEPROM:
> +			rc = i2c_eeprom_read(cell->nvmem,
> +					     cell->offset + bytes_needed - 1,
> +					     &current_val, 1);
> +			break;
> +		case UCLASS_MISC:
> +			rc = misc_read(cell->nvmem,
> +				       cell->offset + bytes_needed - 1,
> +				       &current_val, 1);
> +			if (rc < 0)
> +				return rc;
> +			if (rc != 1)
> +				return -EIO;
> +			rc = 0;
> +			break;
> +		case UCLASS_RTC:
> +			rc = dm_rtc_read(cell->nvmem,
> +					 cell->offset + bytes_needed - 1,
> +					 &current_val, 1);
> +			break;
> +		default:
> +			return -ENOSYS;
> +		}
> +
> +		if (rc)
> +			return rc;
> +
> +		*prev_byte |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) & current_val;
> +	}
> +
> +	return 0;
> +}
>   
>   int nvmem_cell_read(struct nvmem_cell *cell, void *buf, size_t size)
>   {
> +	u8 data[size];

No alloca.

> +	int bytes_needed;
> +	int ret;
> +
>   	dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, cell->offset, size);

Please update these.

> +
>   	if (size != cell->size)
>   		return -EINVAL;
>   
> +	/* Calculate how many bytes we need to read */
> +	if (cell->nbits > 0) {

just if (cell->nbits) for clarity please

(ditto for elsewhere)

> +		bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
> +		if (bytes_needed > sizeof(data))
> +			return -EINVAL;
> +	} else {
> +		bytes_needed = size;

This should always be true even when nbits != 0, as bits specifies the offset/size
"within the address range specified by reg." This will allow you to use the original buffer.

> +	}
> +
>   	switch (cell->nvmem->driver->id) {
>   	case UCLASS_I2C_EEPROM:
> -		return i2c_eeprom_read(cell->nvmem, cell->offset, buf, size);
> -	case UCLASS_MISC: {
> -		int ret = misc_read(cell->nvmem, cell->offset, buf, size);
> -
> +		ret = i2c_eeprom_read(cell->nvmem, cell->offset, data, bytes_needed);
> +		break;
> +	case UCLASS_MISC:
> +		ret = misc_read(cell->nvmem, cell->offset, data, bytes_needed);
>   		if (ret < 0)
>   			return ret;
> -		if (ret != size)
> +		if (ret != bytes_needed)
>   			return -EIO;
> -		return 0;
> -	}
> +		ret = 0;
> +		break;
>   	case UCLASS_RTC:
> -		return dm_rtc_read(cell->nvmem, cell->offset, buf, size);
> +		ret = dm_rtc_read(cell->nvmem, cell->offset, data, bytes_needed);
> +		break;
>   	default:
>   		return -ENOSYS;
>   	}
> +
> +	if (ret)
> +		return ret;
> +
> +	if (cell->nbits > 0) {
> +		/* Extract bit field from raw bytes */
> +		nvmem_shift_read_buffer_in_place(cell, data);
> +		/* Copy only the bytes containing the bit field result */
> +		memcpy(buf, data, DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE));
> +	} else {
> +		memcpy(buf, data, size);
> +	}
> +
> +	return 0;
>   }
>   
>   int nvmem_cell_write(struct nvmem_cell *cell, const void *buf, size_t size)
>   {
> +	u8 data[size];

Again, no alloca. Limit the size for cells with bits and you can use a static
allocation on the stack.

> +	int bytes_needed;
> +	int ret;
> +
>   	dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, cell->offset, size);
> +
>   	if (size != cell->size)
>   		return -EINVAL;
>   
> +	if (cell->nbits > 0) {
> +		bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
> +		if (bytes_needed > sizeof(data))
> +			return -EINVAL;
> +
> +		/* Prepare write buffer with Read-Modify-Write */
> +		ret = nvmem_cell_prepare_write_buffer(cell, buf, size, data);
> +		if (ret)
> +			return ret;
> +	} else {
> +		bytes_needed = size;
> +		memcpy(data, buf, size);
> +	}
> +
>   	switch (cell->nvmem->driver->id) {
>   	case UCLASS_I2C_EEPROM:
> -		return i2c_eeprom_write(cell->nvmem, cell->offset, buf, size);
> +		return i2c_eeprom_write(cell->nvmem, cell->offset, data, bytes_needed);
>   	case UCLASS_MISC: {
> -		int ret = misc_write(cell->nvmem, cell->offset, buf, size);
> -
> +		ret = misc_write(cell->nvmem, cell->offset, data, bytes_needed);
>   		if (ret < 0)
>   			return ret;
> -		if (ret != size)
> +		if (ret != bytes_needed)
>   			return -EIO;
>   		return 0;
>   	}
>   	case UCLASS_RTC:
> -		return dm_rtc_write(cell->nvmem, cell->offset, buf, size);
> +		return dm_rtc_write(cell->nvmem, cell->offset, data, bytes_needed);
>   	default:
>   		return -ENOSYS;
>   	}
> @@ -121,13 +320,27 @@ int nvmem_cell_get_by_index(struct udevice *dev, int index,
>   
>   	offset = ofnode_get_addr_size_index_notrans(args.node, 0, &size);
>   	if (offset == FDT_ADDR_T_NONE || size == FDT_SIZE_T_NONE) {
> -		dev_dbg(cell->nvmem, "missing address or size for %s\n",
> +		dev_err(cell->nvmem, "missing address or size for %s\n",
>   			ofnode_get_name(args.node));
>   		return -EINVAL;
>   	}
>   
>   	cell->offset = offset;
>   	cell->size = size;
> +
> +	ret = ofnode_read_u32_index(args.node, "bits", 0, &cell->bit_offset);
> +	if (ret) {
> +		cell->bit_offset = 0;
> +		cell->nbits = 0;
> +	} else {
> +		ret = ofnode_read_u32_index(args.node, "bits", 1, &cell->nbits);
> +		if (ret)
> +			return -EINVAL;
> +
> +		if (cell->bit_offset + cell->nbits > cell->size * 8)
> +			return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/include/nvmem.h b/include/nvmem.h
> index e6a8a98828b..dd82122f16f 100644
> --- a/include/nvmem.h
> +++ b/include/nvmem.h
> @@ -26,11 +26,15 @@
>    * @nvmem: The backing storage device
>    * @offset: The offset of the cell from the start of @nvmem
>    * @size: The size of the cell, in bytes
> + * @bit_offset: Bit offset within the cell (0 for byte-level access)
> + * @nbits: Number of bits to use (0 for byte-level access)
>    */
>   struct nvmem_cell {
>   	struct udevice *nvmem;
>   	unsigned int offset;
>   	size_t size;
> +	unsigned int bit_offset;
> +	unsigned int nbits;
>   };

Please also update the documentation for read/write.

>   struct udevice;

