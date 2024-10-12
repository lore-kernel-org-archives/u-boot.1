Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D68CF2584
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 21:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41C9188E42;
	Sat, 12 Oct 2024 23:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728768370;
	bh=LDD+O9N7ptFlqPuoBXV7Bu2tOLs6cH0fTYpLCH4gHXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x5jymDXs25WSYrDErcwEcnrtncDuMgKWhahKoFMs5LHbwABcnraj+ab8IbaGgVg+4
	 93e3+lu6QMRO4teQSoD664uibNbCM6RZcnrMEcKGhpvlLkLu+fgEqVeh0HpZQQ9h8G
	 DCbEgds9wcvsM/MM2jwRPXHWO0r2Dl/9wXRbT5KEslqB0pz6tyo7V0tcixQ7FPALu5
	 FKEF9wJH6hFwJuETXWW7arjmmvokaj5otyRfuiYZAo79cuKY9/M6EpwHdZ3gJdGwoD
	 cgWDs43AgXG/63ovG7Q9iBLgeBMzMZKL620doIB73UJuHYezb5AsA8Aq64ovrqbiHq
	 eVvoTK+chklCA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 19E6888A1C;
 Sat, 12 Oct 2024 23:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728768365;
 bh=LDD+O9N7ptFlqPuoBXV7Bu2tOLs6cH0fTYpLCH4gHXo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Qnj8PZDqxfsXJUz2DPnAQ1phfdi6lm0oNLg08YIi0z4zs2kx8K7g+N5qEOS+cSkeJ
 rekLFmeWspjrvjoYG7O9APhggbJNATvcyWNJjvNQwhHl88jY7iAuLcLAQngP9Tovx1
 3KK/UZ3kwdOxDGfdeuDUqXoRKUmmuRcIV9NDBAa2XzOBjmC5xOnY1iHc/2+IjPORif
 AKTfini3bCx87DXYfpF9EbLQtqQhCy76IdMFz440kWpvor1l1EujkeenYnrqCfkner
 BT8ORws7Zgij8OMjBMj0BHDn7aejkD8R/OICqk1gTl4N6W7IWaKlwZBU3eVACpZqI6
 sERVEPr9aiYVQ==
Message-ID: <934d25c2-39d8-4f51-b29e-8f20feb7431f@denx.de>
Date: Sat, 12 Oct 2024 22:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: imx8mp: Read item and serial number from
 EEPROM ID page on DH i.MX8MP DHCOM
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <20241010132337.3259-2-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241010132337.3259-2-cniedermaier@dh-electronics.com>
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

On 10/10/24 3:23 PM, Christoph Niedermaier wrote:
> The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
> which contains additional write-lockable page called ID page, which
> is populated with a structure containing the item and serial number.
> 
> Extend the support for parsing the item and serial number of the
> EEPROM ID page. Write the item and serial number to the U-Boot
> environment if the aren't there. If the environment is already
> there compare it with the one from the EEPROM ID page and output
> a warning if it differs.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> ---
>   board/dhelectronics/common/dh_common.c        | 51 ++++++++++++++++++
>   board/dhelectronics/common/dh_common.h        |  2 +
>   .../dh_imx8mp/imx8mp_dhcom_pdk2.c             | 53 +++++++++++++++++++
>   3 files changed, 106 insertions(+)
> 
> diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
> index 8ea70fc984..4c31b32e0c 100644
> --- a/board/dhelectronics/common/dh_common.c
> +++ b/board/dhelectronics/common/dh_common.c
> @@ -11,6 +11,23 @@
>   
>   #include "dh_common.h"
>   
> +/* DH item: Vendor coding */
> +#define ITEM_PREFIX_NXP		0x01
> +#define ITEM_PREFIX_NXP_CHR	'I'
> +#define ITEM_PREFIX_ST		0x02
> +#define ITEM_PREFIX_ST_CHR	'S'

#define DH_ITEM_... to namespace the macros, please fix globally.

> +/*
> + * DH item: Finished state coding
> + * Bit = 0 means half finished
> + *         Prefix is 'H'
> + * Bit = 1 means finished with a customer image flashed
> + *         Prefix is 'F'
> + */
> +#define ITEM_PREFIX_FIN_BIT		BIT(7)
> +#define ITEM_PREFIX_FIN_HALF_CHR	'H'
> +#define ITEM_PREFIX_FIN_FLASHED_CHR	'F'
> +
>   struct eeprom_id_page {
>   	u8	id[3];		/* Identifier 'D', 'H', 'E' - 'D' is at index 0 */
>   	u8	version;	/* 0x10 -- Version 1.0 */
> @@ -54,6 +71,7 @@ int dh_get_value_from_eeprom_id_page(enum eip_request_values request, u8 *data,
>   	ofnode node;
>   	u16 c16;
>   	u8 c8;
> +	char soc;

Reverse xmas tree ordering here please.

>   	eipp = (struct eeprom_id_page *)eipa;
>   
> @@ -136,6 +154,39 @@ int dh_get_value_from_eeprom_id_page(enum eip_request_values request, u8 *data,
>   		else
>   			return -EINVAL;
>   		break;
> +	case ITEM_NUMBER:
> +		if (data_len >= 8) { /* String with 7 characters + string termination */

Invert this condition and reduce indent:

if (data < 8)
   return -EINVAL;

switch ...
...

> +			switch (eipp->item_prefix & 0xf) {
> +			case ITEM_PREFIX_NXP:
> +				soc = ITEM_PREFIX_NXP_CHR;
> +				break;
> +			case ITEM_PREFIX_ST:
> +				soc = ITEM_PREFIX_ST_CHR;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			snprintf(data, data_len, "%c%c%05d",
> +				 (eipp->item_prefix & ITEM_PREFIX_FIN_BIT) ?
> +				 ITEM_PREFIX_FIN_FLASHED_CHR : ITEM_PREFIX_FIN_HALF_CHR,
> +				 soc, (eipp->item_num[0] << 16) | (eipp->item_num[1] << 8)
> +				       | eipp->item_num[2]);
> +		} else {
> +			return -EINVAL;
> +		}
> +		break;
> +	case SN:

Use namespaced "DH_SERIAL_NUMBER":

> +		/*
> +		 * data_len must be greater than the size of eipp->serial,
> +		 * because there is a string termination needed.
> +		 */

Invert this condition and reduce indent:

if (data_len <= sizeof(eipp->serial))
   return -EINVAL;

...

> +		if (data_len > sizeof(eipp->serial)) {
> +			data[sizeof(eipp->serial)] = 0;
> +			memcpy(data, eipp->serial, sizeof(eipp->serial));
> +		} else {
> +			return -EINVAL;
> +		}
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/board/dhelectronics/common/dh_common.h b/board/dhelectronics/common/dh_common.h
> index 4c22ece435..1baa45e340 100644
> --- a/board/dhelectronics/common/dh_common.h
> +++ b/board/dhelectronics/common/dh_common.h
> @@ -6,6 +6,8 @@
>   enum eip_request_values {
>   	MAC0,
>   	MAC1,
> +	ITEM_NUMBER,
> +	SN,

Why is this patch not squashed into 1/2 ? It seems to be changing the 
same code.

>   };
>   
>   /*
> diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> index 9a8f09fcd4..8970c8fc2d 100644
> --- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> +++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> @@ -116,6 +116,56 @@ int dh_setup_mac_address(void)
>   	return ret;
>   }
>   
> +void dh_add_item_number_and_serial_to_env(void)
> +{
> +	char item_number[8];	/* String with 7 characters + string termination */
> +	char *item_number_env;
> +	char serial[10];	/* String with 9 characters + string termination */
> +	char *serial_env;
> +	int ret;

Reverse xmas tree please -- swap the first pair and second pair of 
variables.

> +
> +	ret = dh_get_value_from_eeprom_id_page(ITEM_NUMBER, item_number, sizeof(item_number),
> +					       "eeprom0");
> +	if (ret) {
> +		/*
> +		 * The function only returns the value -ENOENT for SoM rev.100, because
> +		 * the EEPROM ID page isn't available there. Therefore the output makes
> +		 * no sense and will be suppressed here.
> +		 */
> +		if (ret != -ENOENT)
> +			printf("%s: Unable to get item number form EEPROM ID page! ret = %d\n",
> +			       __func__, ret);

This will be printed on every device, even the ones without ID EEPROM, 
correct ? This should not be printed on devices without ID EEPROM. Also,

if (ret && ret != -ENOENT) {}

works equally well without the extra indent.

> +	} else {
> +		item_number_env = env_get("vendor_item_number");
> +		if (!item_number_env)
> +			env_set("vendor_item_number", item_number);
> +		else
> +			if (strcmp(item_number_env, item_number) != 0)

else if (strcmp(..., ...))
   log_warning(...)

> +				printf("Warning: Environment vendor_item_number differs from EEPROM ID page value (%s != %s)\n",
> +				       item_number_env, item_number);
> +	}
> +
> +	ret = dh_get_value_from_eeprom_id_page(SN, serial, sizeof(serial), "eeprom0");
> +	if (ret) {
> +		/*
> +		 * The function only returns the value -ENOENT for SoM rev.100, because
> +		 * the EEPROM ID page isn't available there. Therefore the output makes
> +		 * no sense and will be suppressed here.
> +		 */
> +		if (ret != -ENOENT)
> +			printf("%s: Unable to get serial form EEPROM ID page! ret = %d\n",
> +			       __func__, ret);

See above.

Also, this shouldn't be repeatedly reading the EEPROM, the EEPROM read 
operation is the slow part, the EEPROM is 32 bytes, so the EEPROM should 
be read once and cached, and once the cache is populated all read 
accesses to the EEPROM should use the cache.

> +	} else {
> +		serial_env = env_get("SN");
> +		if (!serial_env)
> +			env_set("SN", serial);
> +		else
> +			if (strcmp(serial_env, serial) != 0)
> +				printf("Warning: Environment SN differs from EEPROM ID page value (%s != %s)\n",
> +				       serial_env, serial);
> +	}
> +}
> +
>   int board_init(void)
>   {
>   	return 0;
[...]
