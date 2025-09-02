Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386B9CA1007
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 23:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 869F4833D0;
	Wed,  3 Sep 2025 01:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E3F833ED; Wed,  3 Sep 2025 01:29:54 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1012832AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 01:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C68D5B2200E7;
 Wed,  3 Sep 2025 01:29:49 +0200 (CEST)
Message-ID: <e9aef297-c073-4f36-b83d-4b5a254a409c@freeshell.de>
Date: Tue, 2 Sep 2025 16:29:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 05/10] eeprom: starfive: Update eeprom data format version
 to 3
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-6-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250829060931.79940-6-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
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


On 8/28/25 23:09, Hal Feng wrote:
> Add eeprom data format v3 support.
> Add wifi_bt field in ATOM4 and add "mac wifi_bt <?>" command to modify it.
> Set or show eth0/1 MAC address only if the board has eth0/1.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../visionfive2/visionfive2-i2c-eeprom.c      | 91 ++++++++++++++++---
>  1 file changed, 78 insertions(+), 13 deletions(-)
> 
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> index 43b8af4fc59..7352252c475 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -11,7 +11,7 @@
>  #include <u-boot/crc.h>
>  #include <linux/delay.h>
>  
> -#define FORMAT_VERSION		0x2
> +#define FORMAT_VERSION		0x3

No. This stays FORMAT_VERSION 0x2 for compatibility, allow to write
EEPROM in the "old" format on boards. We must allow compatible action
for vendor BSP firmware and weird old software that we do not want
responsibility for updating.

Update to 0x3 only if some data field is expressed that needs 0x3 format.

>  #define PCB_VERSION		0xB1
>  #define BOM_VERSION		'A'
>  /*
> @@ -105,7 +105,8 @@ struct eeprom_atom4_data {
>  	u8 bom_revision;		/* BOM version */
>  	u8 mac0_addr[MAC_ADDR_BYTES];	/* Ethernet0 MAC */
>  	u8 mac1_addr[MAC_ADDR_BYTES];	/* Ethernet1 MAC */
> -	u8 reserved[2];
> +	u8 wifi_bt;			/* WIFI/BT support flag */

Are you sure a whole u8 for a one-bit flag?

> +	u8 reserved;
>  };
>  
>  struct starfive_eeprom_atom4 {
> @@ -128,6 +129,35 @@ static union {
>  /* Set to 1 if we've read EEPROM into memory */
>  static int has_been_read __section(".data");
>  
> +static const char * const board_no_eth0_list[] = {
> +	"FML13V01",
> +};
> +
> +static const char * const board_no_eth1_list[] = {
> +	"FML13V01",
> +	"MARS",
> +	"VF7110SL",
> +};
> +
> +static bool board_have_eth(u8 eth)
> +{
> +	int i;
> +
> +	if (eth == 0) {
> +		for (i = 0 ; i < ARRAY_SIZE(board_no_eth0_list); i++)
> +			if (!strncmp(pbuf.eeprom.atom1.data.pstr, board_no_eth0_list[i],
> +				     strlen(board_no_eth0_list[i])))
> +				return false;
> +	} else {
> +		for (i = 0 ; i < ARRAY_SIZE(board_no_eth1_list); i++)
> +			if (!strncmp(pbuf.eeprom.atom1.data.pstr, board_no_eth1_list[i],
> +				     strlen(board_no_eth1_list[i])))
> +				return false;
> +	}
> +
> +	return true;
> +}
> +

No. Drop all this no_eth0 no_eth1 configuration, the string arrays, it
exists only to show or hide some EEPROM configuration text and can be
deleted.

>  static inline int is_match_magic(void)
>  {
>  	return strncmp(pbuf.eeprom.header.signature, STARFIVE_EEPROM_HATS_SIG,
> @@ -176,17 +206,22 @@ static void show_eeprom(void)
>  	printf("Vendor : %s\n", pbuf.eeprom.atom1.data.vstr);
>  	printf("Product full SN: %s\n", pbuf.eeprom.atom1.data.pstr);
>  	printf("data version: 0x%x\n", pbuf.eeprom.atom4.data.version);
> -	if (pbuf.eeprom.atom4.data.version == 2) {

> +	if (pbuf.eeprom.atom4.data.version >= 2 && pbuf.eeprom.atom4.data.version <= 3) {

This is not some floating point value. Compare with discrete values:

+ if (pbuf.eeprom.atom4.data.version == 2 ||
+     pbuf.eeprom.atom4.data.version == 3) {

or else I think more readable is convert to a switch case conditional:

+ switch (pbuf.eeprom.atom4.data.version) {
+ case 2:
+ case 3:
		...

>  		printf("PCB revision: 0x%x\n", pbuf.eeprom.atom4.data.pcb_revision);
>  		printf("BOM revision: %c\n", pbuf.eeprom.atom4.data.bom_revision);
> -		printf("Ethernet MAC0 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
> -		       pbuf.eeprom.atom4.data.mac0_addr[0], pbuf.eeprom.atom4.data.mac0_addr[1],
> -		       pbuf.eeprom.atom4.data.mac0_addr[2], pbuf.eeprom.atom4.data.mac0_addr[3],
> -		       pbuf.eeprom.atom4.data.mac0_addr[4], pbuf.eeprom.atom4.data.mac0_addr[5]);
> -		printf("Ethernet MAC1 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
> -		       pbuf.eeprom.atom4.data.mac1_addr[0], pbuf.eeprom.atom4.data.mac1_addr[1],
> -		       pbuf.eeprom.atom4.data.mac1_addr[2], pbuf.eeprom.atom4.data.mac1_addr[3],
> -		       pbuf.eeprom.atom4.data.mac1_addr[4], pbuf.eeprom.atom4.data.mac1_addr[5]);
> +		if (board_have_eth(0))
> +			printf("Ethernet MAC0 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
> +			pbuf.eeprom.atom4.data.mac0_addr[0], pbuf.eeprom.atom4.data.mac0_addr[1],
> +			pbuf.eeprom.atom4.data.mac0_addr[2], pbuf.eeprom.atom4.data.mac0_addr[3],
> +			pbuf.eeprom.atom4.data.mac0_addr[4], pbuf.eeprom.atom4.data.mac0_addr[5]);
> +
> +		if (board_have_eth(1))

No. There is not any purpose to hide this data from the user. In fact it
is useful when Mars CM Lite SoM installed to carrier board that has its
own additional network interface on PCIe bus, setting eth2addr
environment variable to be the same as (disabled) MAC1 from EEPROM print
output.

> +			printf("Ethernet MAC1 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
> +			pbuf.eeprom.atom4.data.mac1_addr[0], pbuf.eeprom.atom4.data.mac1_addr[1],
> +			pbuf.eeprom.atom4.data.mac1_addr[2], pbuf.eeprom.atom4.data.mac1_addr[3],
> +			pbuf.eeprom.atom4.data.mac1_addr[4], pbuf.eeprom.atom4.data.mac1_addr[5]);
> +		if (pbuf.eeprom.atom4.data.version >= 3)
> +			printf("WIFI/BT support: %x\n", pbuf.eeprom.atom4.data.wifi_bt);
+break;

+ default:

>  	} else {
>  		printf("Custom data v%d is not Supported\n", pbuf.eeprom.atom4.data.version);
>  		dump_raw_eeprom();
> @@ -260,6 +295,7 @@ static void init_local_copy(void)
>  	pbuf.eeprom.atom4.data.bom_revision = BOM_VERSION;
>  	set_mac_address(STARFIVE_DEFAULT_MAC0, 0);
>  	set_mac_address(STARFIVE_DEFAULT_MAC1, 1);
> +	pbuf.eeprom.atom4.data.wifi_bt = 0;
+ break;
>  }
>  
>  /**
> @@ -385,6 +421,28 @@ static void set_bom_revision(char *string)
>  	update_crc();
>  }
>  
> +/**
> + * set_wifi_bt() - stores a StarFive WIFI/BT support flag into the local EEPROM copy
> + *
> + * Takes a pointer to a string representing the numeric WIFI/BT support flag in
> + * decimal ("0" or "1"), stores it in the wifi_bt field of the
> + * EEPROM local copy, and updates the CRC of the local copy.
> + */
> +static void set_wifi_bt(char *string)
> +{
> +	u8 wifi_bt;
> +
> +	wifi_bt = simple_strtoul(string, &string, 16);
> +	if (wifi_bt > 1) {
> +		printf("WIFI/BT support flag must not be greater than 1");
> +		return;
> +	}
> +
> +	pbuf.eeprom.atom4.data.wifi_bt = wifi_bt;
> +
> +	update_crc();
> +}
> +

I am surprised this wifi_bt u8 is a 1-bit flag and does not contain any
mac address. What is the SDIO module present on VisionFive2 Lite and
does it contain memory for WiFi MAC address and Bluetooth MAC address?

>  /**
>   * set_product_id() - stores a StarFive product ID into the local EEPROM copy
>   *
> @@ -478,6 +536,9 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	} else if (!strcmp(cmd, "bom_revision")) {
>  		set_bom_revision(argv[2]);
>  		return 0;
> +	} else if (!strcmp(cmd, "wifi_bt")) {
> +		set_wifi_bt(argv[2]);
> +		return 0;
>  	} else if (!strcmp(cmd, "product_id")) {
>  		set_product_id(argv[2]);
>  		return 0;
> @@ -513,8 +574,10 @@ int mac_read_from_eeprom(void)
>  	}
>  
>  	// 1, setup ethaddr env
> -	eth_env_set_enetaddr("ethaddr", pbuf.eeprom.atom4.data.mac0_addr);
> -	eth_env_set_enetaddr("eth1addr", pbuf.eeprom.atom4.data.mac1_addr);
> +	if (board_have_eth(0))
> +		eth_env_set_enetaddr("ethaddr", pbuf.eeprom.atom4.data.mac0_addr);
> +	if (board_have_eth(1))
> +		eth_env_set_enetaddr("eth1addr", pbuf.eeprom.atom4.data.mac1_addr);
>  

No. Unnecessary complication to have a list of products and do all this
extra work. We should only update fields that the user has set.

>  	/**
>  	 * 2, setup serial# env, reference to hifive-platform-i2c-eeprom.c,
> @@ -585,6 +648,8 @@ U_BOOT_LONGHELP(mac,
>  	"    - stores a StarFive PCB revision into the local EEPROM copy\n"
>  	"mac bom_revision <A>\n"
>  	"    - stores a StarFive BOM revision into the local EEPROM copy\n"
> +	"mac wifi_bt <?>\n"
> +	"    - stores a StarFive WIFI/BT support flag into the local EEPROM copy\n"
>  	"mac product_id <VF7110A1-2228-D008E000-xxxxxxxx>\n"
>  	"    - stores a StarFive product ID into the local EEPROM copy\n"
>  	"mac vendor <Vendor Name>\n"

NAK to this patch.

Add the support for the new EEPROM format and keep it simple:

- It is okay if the user sees print of all valid fields of EEPROM, even
when some printed data does not have any importance for them. The format
version will hide or show some data fields - okay.

- For compatibility keep FORMAT_VERSION (0x2) default and each field
being set should do a check with pbuf.eeprom.header.version ; for
example if there is wifi_bt being set then it is appropriate to promote
format version (0x3) and print info that the format version has changed.

- For explicit write operation to EEPROM of format version 0x3 but user
did not set any data fields that need more than format version (0x2),
then the user must set format version to 0x3. Make it possible to set
the format version directly.

If you want to get complicated and add conditional for promotion of
minimum format version required by each data field, okay then, I would
like to see that.

-E
