Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FA1CCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 12:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4578362A;
	Fri, 24 Oct 2025 14:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B04FF83631; Fri, 24 Oct 2025 14:41:09 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940C583621
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 14:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.255])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7DDD9B2200E2;
 Fri, 24 Oct 2025 14:41:05 +0200 (CEST)
Message-ID: <097a85b5-3772-460e-a519-4146986aea79@freeshell.de>
Date: Fri, 24 Oct 2025 05:41:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] eeprom: starfive: Support eeprom data format v3
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-6-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251024085932.83596-6-hal.feng@starfivetech.com>
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


On 10/24/25 01:59, Hal Feng wrote:
> Add eeprom data format v3 support. Add onboard_module field in
> ATOM4 and add "mac onboard_module <?>" command to modify it.
> 
> The onboard module field marks the additional modules compared
> with VisionFive 2 board. Now we define
> 
> bit7-1: reserved, bit0: WIFI/BT
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../visionfive2/visionfive2-i2c-eeprom.c      | 36 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> index 986dcc94992..b9197cdd34f 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -105,7 +105,8 @@ struct eeprom_atom4_data {
>  	u8 bom_revision;		/* BOM version */
>  	u8 mac0_addr[MAC_ADDR_BYTES];	/* Ethernet0 MAC */
>  	u8 mac1_addr[MAC_ADDR_BYTES];	/* Ethernet1 MAC */
> -	u8 reserved[2];
> +	u8 onboard_module;	/* Onboard module flag: bit7-1: reserved, bit0: WIFI/BT */
> +	u8 reserved;
>  };
>  
>  struct starfive_eeprom_atom4 {
> @@ -176,7 +177,7 @@ static void show_eeprom(void)
>  	printf("Vendor : %s\n", pbuf.eeprom.atom1.data.vstr);
>  	printf("Product full SN: %s\n", pbuf.eeprom.atom1.data.pstr);
>  	printf("data version: 0x%x\n", pbuf.eeprom.atom4.data.version);
> -	if (pbuf.eeprom.atom4.data.version == 2) {
> +	if (pbuf.eeprom.atom4.data.version == 2 || pbuf.eeprom.atom4.data.version == 3) {

small nit, maybe as two lines:

        if (pbuf.eeprom.atom4.data.version == 2 ||
            pbuf.eeprom.atom4.data.version == 3) {

>  		printf("PCB revision: 0x%x\n", pbuf.eeprom.atom4.data.pcb_revision);
>  		printf("BOM revision: %c\n", pbuf.eeprom.atom4.data.bom_revision);
>  		printf("Ethernet MAC0 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
> @@ -187,6 +188,14 @@ static void show_eeprom(void)
>  		       pbuf.eeprom.atom4.data.mac1_addr[0], pbuf.eeprom.atom4.data.mac1_addr[1],
>  		       pbuf.eeprom.atom4.data.mac1_addr[2], pbuf.eeprom.atom4.data.mac1_addr[3],
>  		       pbuf.eeprom.atom4.data.mac1_addr[4], pbuf.eeprom.atom4.data.mac1_addr[5]);

I guess that the previous author must have 100col (?) not 80col for
editing. It is readable in 100col but just a little unusual on a
collaborative project in git repo to write code this way. It is not
anything you are the author for, so ignore my review comment here.

> +		if (pbuf.eeprom.atom4.data.version == 3) {
> +			char str[25] = "Onboard module: ";
> +
> +			if (pbuf.eeprom.atom4.data.onboard_module & BIT(0))
> +				strcat(str, "WIFI/BT");
> +
> +			printf("%s\n", str);
> +		}

I am concerned about a memory safety code mistake in future with this.
Let the compiler do our work for us. Avoid strcat or requirement that
the programmer knows buffer length for a scoped string allocation and
several other actions, as:

if (pbuf.eeprom.atom4.data.version == 3) {
	printf("Onboard module: %s\n",
	       (pbuf.eeprom.atom4.data.onboard_module & BIT(0) ?
	       "WIFI/BT" :
	       "None"));
}

>  	} else {
>  		printf("Custom data v%d is not Supported\n", pbuf.eeprom.atom4.data.version);
>  		dump_raw_eeprom();
> @@ -260,6 +269,7 @@ static void init_local_copy(void)
>  	pbuf.eeprom.atom4.data.bom_revision = BOM_VERSION;
>  	set_mac_address(STARFIVE_DEFAULT_MAC0, 0);
>  	set_mac_address(STARFIVE_DEFAULT_MAC1, 1);
> +	pbuf.eeprom.atom4.data.onboard_module = 0;
>  }
>  
>  /**
> @@ -385,6 +395,23 @@ static void set_bom_revision(char *string)
>  	update_crc();
>  }
>  
> +/**
> + * set_onboard_module() - stores a StarFive onboard module flag into the local EEPROM copy
> + *
> + * Takes a pointer to a string representing the numeric onboard module flag in
> + * Hexadecimal ("0" - "FF"), stores it in the onboard_module field of the
> + * EEPROM local copy, and updates the CRC of the local copy.
> + */
> +static void set_onboard_module(char *string)
> +{
> +	u8 onboard_module;
> +
> +	onboard_module = simple_strtoul(string, &string, 16);
> +	pbuf.eeprom.atom4.data.onboard_module = onboard_module;
> +
> +	update_crc();
> +}
> +
>  /**
>   * set_product_id() - stores a StarFive product ID into the local EEPROM copy
>   *
> @@ -478,6 +505,9 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	} else if (!strcmp(cmd, "bom_revision")) {
>  		set_bom_revision(argv[2]);
>  		return 0;
> +	} else if (!strcmp(cmd, "onboard_module")) {
> +		set_onboard_module(argv[2]);
> +		return 0;
>  	} else if (!strcmp(cmd, "product_id")) {
>  		set_product_id(argv[2]);
>  		return 0;
> @@ -585,6 +615,8 @@ U_BOOT_LONGHELP(mac,
>  	"    - stores a StarFive PCB revision into the local EEPROM copy\n"
>  	"mac bom_revision <A>\n"
>  	"    - stores a StarFive BOM revision into the local EEPROM copy\n"
> +	"mac onboard_module <?>\n"

Seeing the example of product_id would this onboard_module flag be
described as <xx> and not <?> ?

I understand that pcb_revision is stated as <?> however a pcb_revision
of zero value is not a sensible value because of the error handling, so
that can be different.

> +	"    - stores a StarFive onboard module flag into the local EEPROM copy\n"
>  	"mac product_id <VF7110A1-2228-D008E000-xxxxxxxx>\n"
>  	"    - stores a StarFive product ID into the local EEPROM copy\n"
>  	"mac vendor <Vendor Name>\n"

Looks good to me with only some nits about style choices. With that,

Reviewed-by: E Shattow <e@freeshell.de>
