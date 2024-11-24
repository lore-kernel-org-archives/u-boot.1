Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5DFD3B7C2
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 22:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8ED895AC;
	Sun, 24 Nov 2024 23:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732488675;
	bh=qQaBpwRoZI5qgS6PDx5Q86E4lJsiJGWkn0v8ogrJDU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PCSQWxBihUwbK6VlB0Y/4/27cQN8gMHSkAlrcj+W/Htbrne5pRXtSR76JDlm/LS2S
	 RHCXD0zR+Kd0Bt8wgocfXqlDHMU0B+0N+ptJj+TrBp9S7DdiTkUGEaVKuH4kbJ5gtG
	 6zLvrBpWRta5GQvr4w/iObU4h9BndSrkc1nqjhwhvXkrPq9SZD0fYDwlmmAhX44SLp
	 vB8Z/yHBJ+7Dyvu0iMa5WpLwYGNfP9EbLvV0RDVdHIHgX4jilzzeMNrgGJ9tsjnYdB
	 sX2b2F05DCCzwMT5CqjHY7FuOdcSyKHxmfG/imDlYAdzcb47oiNExs9ezJRYpDEMVi
	 rQWuSFPiKpgCg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 40F0E89582;
 Sun, 24 Nov 2024 23:51:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732488673;
 bh=qQaBpwRoZI5qgS6PDx5Q86E4lJsiJGWkn0v8ogrJDU8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=w9kjHhenhYtZ1ff+jrOpT+LftU61Jpl/1BuGFbf9EXLQfogVFM0JUy9L9GwGDEjwh
 0WLPXLSw518jYApM11XA+Q0rRxns4Z7wScsowCkzqocJzN0wAIuvXawgY9lB3Z9R2O
 h2jAUrz1bnkMiRtMi7Z7WcghlAAALygxZV5rO1dDIVuOAAPftwkJdlNlKZk06tvc4n
 eorahX5Gza+m4STCyfX3pveTo5u2B14SJri2Vr/wp+Kt7+i71kJn4SZPGQWQGU1vMb
 vbYvnHjnnkJO2a0W0m7atHRlRapvNzKopK8BBaojW/EYLUVd1rYGTtPzdkTEFGCt0l
 /eKPUjeo5Oc0g==
Message-ID: <38fa4180-707b-4870-9f47-a1aaf7056795@denx.de>
Date: Sun, 24 Nov 2024 22:01:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/3] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241121172154.90507-1-cniedermaier@dh-electronics.com>
 <20241121172154.90507-2-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241121172154.90507-2-cniedermaier@dh-electronics.com>
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

On 11/21/24 6:21 PM, Christoph Niedermaier wrote:

[...]

> +struct eeprom_id_page {
> +	u8	id[3];		/* Identifier 'D', 'H', 'E' - 'D' is at index 0 */
> +	u8	version;	/* 0x10 -- Version 1.0 */
> +	u8	data_crc16[2];	/* [1] is MSbyte */
> +	u8	header_crc8;
> +	u8	mac0[6];
> +	u8	mac1[6];
> +	u8	item_prefix;	/* H/F is coded in MSbits, Vendor coding starts at LSbits */
> +	u8	item_num[3];	/* [2] is MSbyte */
> +	u8	serial[9];	/* [8] is MSbyte */
> +};
> +
> +#define DH_EEPROM_ID_PAGE_HEADER_LEN	offsetof(struct eeprom_id_page, mac0)

If this is really meant to be header length and it should work reliably, 
then it should not depend on payload layout. You likely need something like:

offsetof(struct eeprom_id_page, header_crc8) + sizeof(u8)

Or better yet, rework the structure this way:

struct eeprom_id_page {
    struct {
	u8	id[3];		/* Identifier 'D', 'H', 'E' - 'D' is at index 0 */
	u8	version;	/* 0x10 -- Version 1.0 */
	u8	data_crc16[2];	/* [1] is MSbyte */
	u8	header_crc8;
    } header;

    struct {
	u8	mac0[6];
	u8	mac1[6];
	u8	item_prefix;	/* H/F is coded in MSbits, Vendor coding starts at 
LSbits */
	u8	item_num[3];	/* [2] is MSbyte */
	u8	serial[9];	/* [8] is MSbyte */
    } payload;
};

... and in the one callsite (*) which does use this macro, do:

struct eeprom_id_page *eip;
...
-crc16_calc = crc16(0xffff, eeprom_buffer + 
DH_EEPROM_ID_PAGE_HEADER_LEN, data_len);
+crc16_calc = crc16(0xffff, eip->payload, sizeof(*eip->payload));

> +#define DH_EEPROM_ID_PAGE_V1_0		0x10
> +#define DH_EEPROM_ID_PAGE_V1_0_DATA_LEN	(sizeof(struct eeprom_id_page) - \
> +					offsetof(struct eeprom_id_page, mac0))

This is not needed either, this would become

sizeof(*eip->payload)

in the only callsite which does use the macro.

>   bool dh_mac_is_in_env(const char *env)
>   {
>   	unsigned char enetaddr[6];
> @@ -30,6 +65,141 @@ int dh_get_mac_is_enabled(const char *alias)
>   	return 0;
>   }
>   
> +int dh_read_eeprom_id_page(u8 *eeprom_buffer, const char *alias)
> +{
> +	struct eeprom_id_page *eip;

You can assign the eip pointer here already:

struct eeprom_id_page *eip = eeprom_buffer;

> +	struct udevice *dev;
> +	size_t data_len;
> +	int eeprom_size;
> +	u16 crc16_calc;
> +	u16 crc16_eip;
> +	u8 crc8_calc;
> +	ofnode node;
> +	int ret;
> +
> +	node = ofnode_path(alias);
> +
> +	ret = uclass_get_device_by_ofnode(UCLASS_I2C_EEPROM, node, &dev);
> +	if (ret)
> +		return ret;
> +
> +	eeprom_size = i2c_eeprom_size(dev);
> +	if (eeprom_size < 0 || eeprom_size > DH_EEPROM_ID_PAGE_MAX_SIZE) {

Wouldn't it be better to exit if eeprom_size < 0 (error) ?

What happens if eeprom_size == 0 ? Maybe that should be considered 
problematic too ?

> +		eeprom_size = DH_EEPROM_ID_PAGE_MAX_SIZE;
> +		printf("Warning: Cannot get valid EEPROM.ID page size! Try to read %d bytes.\n",

s@EEPROM.ID@EEPROM ID@ , replace dot with space .

Also please drop the Warning: prefix , it is unnecessary.

> +		       DH_EEPROM_ID_PAGE_MAX_SIZE);

Print both the original eeprom_size reported by i2c_eeprom_size() and 
DH_EEPROM_ID_PAGE_MAX_SIZE , the former is an important hint for debug 
purposes.

> +	}
> +
> +	ret = i2c_eeprom_read(dev, 0x0, eeprom_buffer, eeprom_size);
> +	if (ret) {
> +		printf("%s: Error reading EEPROM ID page! ret = %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	eip = (struct eeprom_id_page *)eeprom_buffer;

See above.

> +	/* Validate header ID */
> +	if (eip->id[0] != 'D' || eip->id[1] != 'H' || eip->id[2] != 'E') {
> +		printf("%s: Error validating header ID! (expected DHE)\n", __func__);

To expedite and ease debugging, it is also important to print what the 
code received , not just what the code expected to receive.

> +		return -EINVAL;
> +	}
> +
> +	/* Validate header checksum */
> +	crc8_calc = crc8(0xff, eeprom_buffer, offsetof(struct eeprom_id_page, header_crc8));
> +	if (eip->header_crc8 != crc8_calc) {
> +		printf("%s: Error validating header checksum! (expected 0x%02X)\n",

Better use %02x , I believe lib/tiny-printf.c cannot handle X modifier , 
please fix globally.

To expedite and ease debugging, it is also important to print what the 
code received , not just what the code expected to receive, please fix 
globally.

> +		       __func__, crc8_calc);
> +		return -EINVAL;
> +	}
> +
> +	/* Validate header version */
> +	if (eip->version == DH_EEPROM_ID_PAGE_V1_0) {

if if (eip->version != DH_EEPROM_ID_PAGE_V1_0) {
   printf(...);
   return -EINVAL;
}

data_len = sizeof(*eip->payload);

> +		data_len = DH_EEPROM_ID_PAGE_V1_0_DATA_LEN;
> +	} else {
> +		printf("%s: Error validating version! (0x%02X is not supported)\n",

The CRC that got calculated is also very interesting, not only the 
expected one.

> +		       __func__, eip->version);
> +		return -EINVAL;
> +	}
> +
> +	/* Validate data checksum */
> +	crc16_eip = (eip->data_crc16[1] << 8) | eip->data_crc16[0];
> +	crc16_calc = crc16(0xffff, eeprom_buffer + DH_EEPROM_ID_PAGE_HEADER_LEN, data_len);

See (*) above

> +	if (crc16_eip != crc16_calc) {
> +		printf("%s: Error validating data checksum! (expected 0x%02X)\n",
> +		       __func__, crc16_calc);

The CRC that got calculated is also very interesting, not only the 
expected one.

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int dh_get_value_from_eeprom_buffer(enum eip_request_values request, u8 *data, int data_len,
> +				    u8 *eeprom_buffer)
> +{
> +	struct eeprom_id_page *eip = (struct eeprom_id_page *)eeprom_buffer;

Is the type cast really needed at all here ? (it might be, please check)

> +	char soc_chr;
> +
> +	if (!eeprom_buffer)

Why not pass in "struct eeprom_id_page *eip" directly as function 
parameter of this function ?

This would become if (!eip) return -EINVAL; and the whole type cast 
business above would go away altogether.

> +		return -EINVAL;
> +
> +	/* Copy requested data */
> +	switch (request) {
> +	case DH_MAC0:
> +		if (!is_valid_ethaddr(eip->mac0))
> +			return -EINVAL;
> +
> +		if (data_len >= sizeof(eip->mac0))
> +			memcpy(data, eip->mac0, sizeof(eip->mac0));
> +		else
> +			return -EINVAL;
> +		break;
> +	case DH_MAC1:
> +		if (!is_valid_ethaddr(eip->mac1))
> +			return -EINVAL;
> +
> +		if (data_len >= sizeof(eip->mac1))
> +			memcpy(data, eip->mac1, sizeof(eip->mac1));
> +		else
> +			return -EINVAL;
> +		break;
> +	case DH_ITEM_NUMBER:
> +		if (data_len < 8) /* String length must be 7 characters + string termination */
> +			return -EINVAL;
> +
> +		const u8 soc_coded = eip->item_prefix & 0xf;

Doesn't the compiler warn about mixing code and variable declarations ?
If yes, you can easily move this line to the very beginning of this 
function, which is probably just fine to do.

[...]

> @@ -28,9 +37,40 @@ int dh_get_mac_is_enabled(const char *alias);
>    */
>   int dh_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias);
>   
> +/*
> + * dh_read_eeprom_id_page() - Read EEPROM ID page content into given buffer
> + * @eeprom_buffer:	Buffer for EEPROM ID page content
> + * @alias:		Alias for EEPROM device tree node

Is this really alias to the EEPROM node or to the EEPROM WLP node ?

> + * Read the content of the EEPROM ID page into the given buffer (parameter
> + * eeprom_buffer). The EEPROM device is selected via alias device tree name
> + * (parameter alias). The data of the EEPROM ID page is verified. An error
> + * is returned for reading failures and invalid data.
> + *
> + * Return: 0 if OK, other value on error
> + */
> +int dh_read_eeprom_id_page(u8 *eeprom_buffer, const char *alias);
> +
> +/*
> + * dh_get_value_from_eeprom_buffer() - Get value from EEPROM buffer
> + * @eip_request_values:	Requested value as enum
> + * @data:		Buffer where value is to be stored
> + * @data_len:		Length of the value buffer
> + * @eeprom_buffer:	EEPROM buffer from which the data is parsed
> + *
> + * Gets the value specified by the parameter eip_request_values from the EEPROM
> + * buffer (parameter eeprom_buffer). The data is written to the specified data
> + * buffer (parameter data). If the length of the data (parameter data_len) is
> + * not sufficient to copy the data into the buffer, an error is returned.
> + *
> + * Return: 0 if OK, other value on error
> + */
> +int dh_get_value_from_eeprom_buffer(enum eip_request_values request, u8 *data, int data_len,
> +				    u8 *eeprom_buffer);

[...]

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
> +		printf("%s: Unable to get DHSOM item number from EEPROM ID page! ret = %d\n",
> +		       __func__, ret);
> +	} else {
> +		item_number_env = env_get("dh_som_item_number");
> +		if (!item_number_env)
> +			env_set("dh_som_item_number", item_number);
> +		else if (strcmp(item_number_env, item_number) != 0)

The != 0 is not necessary, please drop it.

> +			printf("Warning: Environment dh_som_item_number differs from EEPROM ID page value (%s != %s)\n",
> +			       item_number_env, item_number);
> +	}
> +
> +	ret = dh_get_value_from_eeprom_buffer(DH_SERIAL_NUMBER, serial, sizeof(serial),
> +					      eeprom_buffer);
> +	if (ret) {
> +		printf("%s: Unable to get DHSOM serial number from EEPROM ID page! ret = %d\n",
> +		       __func__, ret);
> +	} else {
> +		serial_env = env_get("dh_som_serial_number");
> +		if (!serial_env)
> +			env_set("dh_som_serial_number", serial);
> +		else if (strcmp(serial_env, serial) != 0)

The != 0 is not necessary, please drop it.

> +			printf("Warning: Environment dh_som_serial_number differs from EEPROM ID page value (%s != %s)\n",
> +			       serial_env, serial);
> +	}
> +}
> +
>   int board_init(void)
>   {
>   	return 0;
> @@ -117,7 +160,26 @@ int board_init(void)
>   
>   int board_late_init(void)
>   {
> -	dh_setup_mac_address();
> +	u8 eeprom_buffer[DH_EEPROM_ID_PAGE_MAX_SIZE] = { 0 };

Do the following cast here:

struct eeprom_id_page *eip = eeprom_buffer;

and then you can pass *eip to dh_setup_mac_address() and 
dh_add_item_number_and_serial_to_env() and save yourself a lot of 
typecasts all around.

> +	int ret;
> +
> +	ret = dh_read_eeprom_id_page(eeprom_buffer, "eeprom0wl");
> +	if (ret) {
> +		/*
> +		 * The EEPROM ID page is available on SoM rev. 200 and greater.
> +		 * For SoM rev. 100 the return value will be -ENODEV. Suppress
> +		 * the error message for that, because the absence cannot be
> +		 * treated as an error.
> +		 */
> +		if (ret != -ENODEV)
> +			printf("%s: Cannot read valid data from EEPROM ID page! ret = %d\n",
> +			       __func__, ret);
> +		dh_setup_mac_address(NULL);
> +	} else {
> +		dh_setup_mac_address(eeprom_buffer);
> +		dh_add_item_number_and_serial_to_env(eeprom_buffer);
[...]
