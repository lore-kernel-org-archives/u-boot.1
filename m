Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0109D64084
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 19:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0060789275;
	Fri,  8 Nov 2024 20:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731095749;
	bh=7lcEKxAL+q+FVGP99hSNibZILIDi/Gjxki7dPUPngqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ExstBPiGodDxHYvU6zVLlpRflx6MNrO2ltb9jFLxx1peVinOlSutDYrQCoGrXbmJu
	 QoY5XRcXHr8f5TfuJLLj6f65tfDmjoGZw6VRvP0Ifpd8IjBtXGnZxMk5s1ypwVscJc
	 cZGo0qd0CFIHXHCI6762J15gIjgN1bnWvjumIFZ5ep+TBSGa2hwkw81GiIodQ0zPIo
	 BN+8ExjbyviZ182zE47ZxSnm6t0H0XLyDtECQ9r6ave7Su7KgL6ZwJ4dJlWi+xbiWW
	 6bEXAxXVjAKX4f4rGlsJnt+A+2pOVDHwbejGtk3SA/NY13fQqG2DKbYGdPIadQ2kad
	 X9y1QUYrRDEkg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0C53A88D70;
 Fri,  8 Nov 2024 20:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731095747;
 bh=7lcEKxAL+q+FVGP99hSNibZILIDi/Gjxki7dPUPngqo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bI5wJkz2+hy0fckr+lz5jnW/+49+CKZ4ZlXnvdFwDqh6AvUe2GR53JKhS2tSXzYoF
 ECSIYgY9EA0LgwpyPbN30NLG920BCRkiSCSxf4S8+v7AqGWFoUdzHVh9HCeoxVbQW2
 NQ7yDaUN3wUxAT6EZy/bxoAPRcrlwvVLBoAi5ibF4duVqMfMGr0ygiOgemalv+0v/M
 JHSTFemUf/L8iAl+6Oj1BrlBAOVN4ieKKBM/n8uWWbe8lw+wzGQiKe16YxX2qDCNon
 yHCcVYjP047gvWPYf7o/FEdkQFVxT4HO5AkL9i3/F22TzS7VlSPmFbfHEAntWSk3Wh
 ejzocZfSuAU5g==
Message-ID: <bf5944f1-c55b-4e52-b4c4-f396cf71fe78@denx.de>
Date: Fri, 8 Nov 2024 20:27:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241108170633.46504-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241108170633.46504-1-cniedermaier@dh-electronics.com>
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

On 11/8/24 6:06 PM, Christoph Niedermaier wrote:

[...]

> +int dh_read_eeprom_id_page(u8 *eeprom_buffer, const char *alias)
> +{
> +	u8 buffer[DH_EEPROM_ID_PAGE_MAX_SIZE] = { 0 };
> +	struct eeprom_id_page *eipp;
> +	struct udevice *dev;
> +	int eeprom_size;
> +	char path[128];
> +	ofnode node;
> +	int len;
> +	int ret;
> +	u8 c8;

A more descriptive variable name would be useful. What does 'c8' mean ?

> +	node = ofnode_path(alias);
> +	if (!ofnode_valid(node)) {
> +		printf("%s: ofnode for %s not found!", __func__, alias);
> +		return -ENOENT;
> +	}
> +
> +	ret = ofnode_get_path(node, path, sizeof(path));
> +	if (ret)
> +		return ret;
> +
> +	len = strlen(path);
> +	if (len <= 0)
> +		return -EINVAL;
> +
> +	if (path[len - 1] == '0')
> +		path[len - 1] = '8';
> +	else if (path[len - 1] == '3')
> +		path[len - 1] = 'b';

Simply add alias to eeprom0wl/eeprom1wl and outright look up the alias:

arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
"
#include "imx8mp-u-boot.dtsi"

/ {
         aliases {
                 eeprom0 = &eeprom0;
                 eeprom1 = &eeprom1;
+               eeprom0wl = &eeprom0wl;
+               eeprom1wl = &eeprom1wl;
                 mmc0 = &usdhc2; /* MicroSD */
                 mmc1 = &usdhc3; /* eMMC */
                 mmc2 = &usdhc1; /* SDIO */
         };
};
"

node = ofnode_path(alias); // use the eeprom0wl/eeprom1wl alias

> +	else
> +		return -ENOENT;
> +
> +	node = ofnode_path(path);
> +	if (!ofnode_valid(node))	/* ID page not present in DT */
> +		return -ENOENT;
> +
> +	if (!ofnode_is_enabled(node))	/* ID page not enabled in DT */
> +		return -ENOENT;
> +
> +	eeprom_size = ofnode_read_u32_default(node, "pagesize", 32);

There are two problems here, pagesize != total EEPROM size and pagesize 
may not be specified in DT but can still be inferred from compatible 
string. Better use:

board/toradex/common/tdx-eeprom.c

uclass_get_device_by_ofnode(UCLASS_I2C_EEPROM, eeprom, devp);

include/i2c_eeprom.h

int i2c_eeprom_size(struct udevice *dev);

to get the EEPROM size . 24C32 WLP compatible string is already present 
in drivers/misc/i2c_eeprom.c since:

3c11643b1915 ("eeprom: at24: add ST M24C32-D Additional Write lockable 
page support")

> +	if (eeprom_size > DH_EEPROM_ID_PAGE_MAX_SIZE) {
> +		eeprom_size = DH_EEPROM_ID_PAGE_MAX_SIZE;
> +		log_warning("Warning: Read data from EEPROM ID page truncated to %d bytes\n",
> +			    DH_EEPROM_ID_PAGE_MAX_SIZE);
> +	}
> +
> +	ret = uclass_get_device_by_ofnode(UCLASS_I2C_EEPROM, node, &dev);
> +	if (ret) {
> +		printf("%s: Cannot find ID page! Check DT, maybe EEPROM ID page is enabled but not populated! ret = %d\n",
> +		       __func__, ret);

Use log_warning() consistently .

> +		return ret;
> +	}
> +
> +	ret = i2c_eeprom_read(dev, 0x0, buffer, eeprom_size);
> +	if (ret) {
> +		printf("%s: Error reading ID page! ret = %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	eipp = (struct eeprom_id_page *)buffer;
> +
> +	/* Validate header magic */
> +	if (eipp->id[0] != 'D' || eipp->id[1] != 'H' || eipp->id[2] != 'E')
> +		return -EINVAL;
> +
> +	/* Validate header checksum */
> +	c8 = crc8(0xff, buffer, offsetof(struct eeprom_id_page, header_crc8));
> +	if (eipp->header_crc8 != c8)
> +		return -EINVAL;
> +
> +	/* Here the data has a valid header, so that all data can be copied */
> +	memcpy(eeprom_buffer, buffer, eeprom_size);

No need for the extra local buffer, drop the memcpy() and use 
eeprom_buffer directly. If the data in eeprom_buffer would be garbage 
for whatever reason, this function would return -ve anyway and the 
called should not use the content of eeprom_buffer .

> +
> +	return 0;
> +}
> +
> +int dh_get_value_from_eeprom_buffer(enum eip_request_values request, u8 *data, int data_len,
> +				    u8 *eeprom_buffer)
> +{
> +	struct eeprom_id_page *eipp;

struct eeprom_id_page *eipp = eeprom_buffer;

> +	char soc;
> +	u16 c16;
> +	u8 c8;

A more descriptive variable name would be helpful.

> +
> +	eipp = (struct eeprom_id_page *)eeprom_buffer;
> +
> +	/* Validate header magic */
> +	if (eipp->id[0] != 'D' || eipp->id[1] != 'H' || eipp->id[2] != 'E')
> +		return -EINVAL;
> +
> +	/* Validate header checksum */
> +	c8 = crc8(0xff, eeprom_buffer, offsetof(struct eeprom_id_page, header_crc8));
> +	if (eipp->header_crc8 != c8)
> +		return -EINVAL;
> +
> +	/* Validate header version */
> +	if (eipp->version != 0x10)

This could use a macro for 0x10.

> +		return -EINVAL;
> +
> +	/* Validate structure checksum */
> +	c16 = crc16(0xffff, eeprom_buffer + offsetof(struct eeprom_id_page, mac0),
> +		    sizeof(*eipp) - offsetof(struct eeprom_id_page, mac0));
> +	if (((eipp->data_crc16[1] << 8) | eipp->data_crc16[0]) != c16)
> +		return -EINVAL;

This entire header and payload validation can be done once in 
dh_read_eeprom_id_page(), no need to do it every time this function is 
called on in-memory buffer. Doing so saves you multiple crc8/crc16 
passes and some wasted CPU cycles.

> +	/* Copy requested data */
> +	switch (request) {
> +	case MAC0:
> +		if (!is_valid_ethaddr(eipp->mac0))
> +			return -EINVAL;
> +		if (data_len >= sizeof(eipp->mac0))

Can you return pointer into the eeprom buffer instead of this memcpy ?
That would save you unnecessary memory copying.

> +			memcpy(data, eipp->mac0, sizeof(eipp->mac0));
> +		else
> +			return -EINVAL;
> +		break;
> +	case MAC1:
> +		if (!is_valid_ethaddr(eipp->mac1))
> +			return -EINVAL;
> +		if (data_len >= sizeof(eipp->mac1))
> +			memcpy(data, eipp->mac1, sizeof(eipp->mac1));
> +		else
> +			return -EINVAL;
> +		break;
> +	case DH_ITEM_NUMBER:
> +		if (data_len < 8) /* String length must be 7 characters + string termination */
> +			return -EINVAL;
> +

const u8 item_prefix = eipp->item_prefix & 0xf;

if (item_prefix == DH_ITEM_PREFIX_NXP)
	soc = DH_ITEM_PREFIX_NXP_CHR;
else if (item_prefix == DH_ITEM_PREFIX_ST)
	soc = DH_ITEM_PREFIX_ST_CHR;
else
	return -EINVAL

This has fewer lines.

> +		switch (eipp->item_prefix & 0xf) {
> +		case DH_ITEM_PREFIX_NXP:
> +			soc = DH_ITEM_PREFIX_NXP_CHR;
> +			break;
> +		case DH_ITEM_PREFIX_ST:
> +			soc = DH_ITEM_PREFIX_ST_CHR;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		snprintf(data, data_len, "%c%c%05d",

Using a temporary variable for this item_prefix would likely help 
readability:


const char fin_chr = (eipp->item_prefix & DH_ITEM_PREFIX_FIN_BIT) ?
                      DH_ITEM_PREFIX_FIN_FLASHED_CHR :
                      DH_ITEM_PREFIX_FIN_HALF_CHR;
...
snprintf(data, data_len, "%c%c%05d", fin_chr, soc_chr, ...

> +			 (eipp->item_prefix & DH_ITEM_PREFIX_FIN_BIT) ?
> +			 DH_ITEM_PREFIX_FIN_FLASHED_CHR : DH_ITEM_PREFIX_FIN_HALF_CHR,
> +			 soc, (eipp->item_num[0] << 16) | (eipp->item_num[1] << 8)
> +			       | eipp->item_num[2]);
> +		break;
> +	case DH_SERIAL_NUMBER:
> +		/*
> +		 * data_len must be greater than the size of eipp->serial,
> +		 * because there is a string termination needed.
> +		 */
> +		if (data_len <= sizeof(eipp->serial))
> +			return -EINVAL;
> +
> +		data[sizeof(eipp->serial)] = 0;
> +		memcpy(data, eipp->serial, sizeof(eipp->serial));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   int dh_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias)
>   {
>   	struct udevice *dev;
> @@ -62,7 +255,7 @@ int dh_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias)
>   	return 0;
>   }
>   
> -__weak int dh_setup_mac_address(void)
> +__weak int dh_setup_mac_address(u8 *eeprom_buffer)
>   {
>   	unsigned char enetaddr[6];
>   
> @@ -72,6 +265,9 @@ __weak int dh_setup_mac_address(void)
>   	if (dh_get_mac_is_enabled("ethernet0"))
>   		return 0;
>   
> +	if (!dh_get_value_from_eeprom_buffer(MAC0, enetaddr, sizeof(enetaddr), eeprom_buffer))
> +		return 0;

Is this missing some eth_env_set_enetaddr("ethaddr", enetaddr); here ?

> +
>   	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
>   		return eth_env_set_enetaddr("ethaddr", enetaddr);
>   
> diff --git a/board/dhelectronics/common/dh_common.h b/board/dhelectronics/common/dh_common.h
> index a2de5b1553..60806c452a 100644
> --- a/board/dhelectronics/common/dh_common.h
> +++ b/board/dhelectronics/common/dh_common.h
> @@ -3,6 +3,15 @@
>    * Copyright 2022 DENX Software Engineering GmbH, Philip Oberfichtner <pro@denx.de>
>    */
>   
> +#define DH_EEPROM_ID_PAGE_MAX_SIZE	64
> +
> +enum eip_request_values {
> +	MAC0,
> +	MAC1,

Please be consistent with the prefixes, DH_MAC...

> +	DH_ITEM_NUMBER,
> +	DH_SERIAL_NUMBER,
> +};
> +
>   /*
>    * dh_mac_is_in_env - Check if MAC address is already set
>    *

[...]

> +++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> @@ -40,7 +40,26 @@ int board_phys_sdram_size(phys_size_t *size)
>   	return 0;
>   }
>   
> -static int dh_imx8_setup_ethaddr(void)
> +int dh_get_som_rev(void)
> +{
> +	int ret;
> +
> +	/*
> +	 * The hardware revision numbers are binary coded with 3 GPIOs:
> +	 * 0x0 = Rev. 100
> +	 * 0x1 = Rev. 200
> +	 * 0x2 = Rev. 300
> +	 * ...
> +	 */
> +	ret = !!(readl(GPIO3_BASE_ADDR) & BIT(14));
> +	ret |= !!(readl(GPIO4_BASE_ADDR) & BIT(19)) << 1;
> +	ret |= !!(readl(GPIO3_BASE_ADDR) & BIT(25)) << 2;
> +	ret = ret * 100 + 100;

This entire function will be unnecessary, see below (*) ...

> +	return ret;
> +}
> +
> +static int dh_imx8_setup_ethaddr(u8 *eeprom_buffer)
>   {
>   	unsigned char enetaddr[6];
>   
> @@ -53,6 +72,11 @@ static int dh_imx8_setup_ethaddr(void)
>   	if (!dh_imx_get_mac_from_fuse(enetaddr))
>   		goto out;
>   
> +	/* The EEPROM ID page is available on SoM rev. 200 and greater. */
> +	if ((dh_get_som_rev() > 100) &&
> +	    (!dh_get_value_from_eeprom_buffer(MAC0, enetaddr, sizeof(enetaddr), eeprom_buffer)))
> +		goto out;
> +
>   	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
>   		goto out;
>   
> @@ -62,7 +86,7 @@ out:
>   	return eth_env_set_enetaddr("ethaddr", enetaddr);
>   }
>   
> -static int dh_imx8_setup_eth1addr(void)
> +static int dh_imx8_setup_eth1addr(u8 *eeprom_buffer)
>   {
>   	unsigned char enetaddr[6];
>   
> @@ -75,6 +99,11 @@ static int dh_imx8_setup_eth1addr(void)
>   	if (!dh_imx_get_mac_from_fuse(enetaddr))
>   		goto increment_out;
>   
> +	/* The EEPROM ID page is available on SoM rev. 200 and greater. */
> +	if ((dh_get_som_rev() > 100) &&
> +	    (!dh_get_value_from_eeprom_buffer(MAC1, enetaddr, sizeof(enetaddr), eeprom_buffer)))
> +		goto out;
> +
>   	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom1"))
>   		goto out;
>   
> @@ -95,21 +124,58 @@ out:
>   	return eth_env_set_enetaddr("eth1addr", enetaddr);
>   }
>   
> -int dh_setup_mac_address(void)
> +int dh_setup_mac_address(u8 *eeprom_buffer)
>   {
>   	int ret;
>   
> -	ret = dh_imx8_setup_ethaddr();
> +	ret = dh_imx8_setup_ethaddr(eeprom_buffer);
>   	if (ret)
>   		printf("%s: Unable to setup ethaddr! ret = %d\n", __func__, ret);
>   
> -	ret = dh_imx8_setup_eth1addr();
> +	ret = dh_imx8_setup_eth1addr(eeprom_buffer);
>   	if (ret)
>   		printf("%s: Unable to setup eth1addr! ret = %d\n", __func__, ret);
>   
>   	return ret;
>   }
>   
> +void dh_add_item_number_and_serial_to_env(u8 *eeprom_buffer)
> +{
> +	char *item_number_env;
> +	char item_number[8];	/* String with 7 characters + string termination */
> +	char *serial_env;
> +	char serial[10];	/* String with 9 characters + string termination */
> +	int ret;
> +
> +	ret = dh_get_value_from_eeprom_buffer(DH_ITEM_NUMBER, item_number, sizeof(item_number),
> +					      eeprom_buffer);
> +	if (ret) {
> +		printf("%s: Unable to get item number from EEPROM ID page! ret = %d\n",
> +		       __func__, ret);

log_warning or log_error to be consistent with the rest of this patch.

> +	} else {
> +		item_number_env = env_get("vendor_item_number");

Can these variables get prefixes, "dh_...", so they are namespaced and 
it is clear they are not generic U-Boot environment variables ?

> +		if (!item_number_env)
> +			env_set("vendor_item_number", item_number);
> +		else if (strcmp(item_number_env, item_number) != 0)
> +			log_warning("Warning: Environment vendor_item_number differs from EEPROM ID page value (%s != %s)\n",
> +				    item_number_env, item_number);
> +	}
> +
> +	ret = dh_get_value_from_eeprom_buffer(DH_SERIAL_NUMBER, serial, sizeof(serial),
> +					      eeprom_buffer);
> +	if (ret) {
> +		printf("%s: Unable to get serial from EEPROM ID page! ret = %d\n",
> +		       __func__, ret);

return ret;

> +	} else {
> +		serial_env = env_get("SN");
> +		if (!serial_env)
> +			env_set("SN", serial);
> +		else if (strcmp(serial_env, serial) != 0)
> +			log_warning("Warning: Environment SN differs from EEPROM ID page value (%s != %s)\n",
> +				    serial_env, serial);
> +	}
> +}
> +
>   int board_init(void)
>   {
>   	return 0;
> @@ -117,7 +183,19 @@ int board_init(void)
>   
>   int board_late_init(void)
>   {
> -	dh_setup_mac_address();
> +	u8 eeprom_buffer[DH_EEPROM_ID_PAGE_MAX_SIZE] = { 0 };
> +	int ret;
> +
> +	/* The EEPROM ID page is available on SoM rev. 200 and greater. */
> +	if (dh_get_som_rev() > 100) {

If the WLP is not described or disabled in DT (the later is the case for 
rev.100 SoM) (*), dh_read_eeprom_id_page() will bail and so there is not 
need for this custom SoM revision check. DT is, after all, a hardware 
description.

[...]
