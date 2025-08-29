Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A52CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 338D383531;
	Fri, 29 Aug 2025 09:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RZ0LaINO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 090738354B; Fri, 29 Aug 2025 09:47:29 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E607A83487
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 575313F2CB
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756453646;
 bh=abnj6yfUQNnaV9WxHJYkwL5dFylf5lW/glZsdQFibsk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=RZ0LaINORAfgR2vKgFZ6KdwmI5uLwzOcg0E38tz/tDJ9scDzAuzLq3izmgupN/InD
 9WaP+ACFsCChVleKTo7mFe2vFAK7y+ZPP/kHjekOfi82IheMO4ftagbG1Vgver2ThQ
 wOMfN/67vNDybuBnfHX/+MnxiKofqvcv+chE1fb6VPFB0ItD68j8wavuoTyxr8y8dm
 fMvgLdERZ9G6I9WDvVHM3k1vfjH0tgBrFe568RLFhU00Oi/sgUqPFh0XR6LyclOIkK
 nC/oWnrdmfR3jsb1YtKIBmBRnVWMdCJH3g41pSCMvwR1KINxVrMH0DJ8bj7AWq52H5
 vkLczss8dzRAA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b7c4c738cso5691185e9.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 00:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756453646; x=1757058446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=abnj6yfUQNnaV9WxHJYkwL5dFylf5lW/glZsdQFibsk=;
 b=iYy7mb8kItU1h0gw4Dll9hdkN20FJCTyNnml4QeJpAZegLu7TgfUY/oUBhU0Qp/2XC
 0IwdKQCWOWFi8dpIJ+rnYL7HxIgi+SOaC2U7zF56mPErsi27ClCpzJlTUzAFOj3JxS7X
 kgm38IBd8zupuHIsuK6+agVCHuqKxh/Xfn1KVHeSErm5urcaY2HEh/lmqpZNmYvIgAwY
 JhwvqxE0uOlaQJGSHtdBArW/zTsmSWg9yz22cnIvOjSQYynsDQKVbbCh1BfEEk+h2sY/
 oDqcuTsVURBoctrcz/maQhSn2TOs1yoAT9RGIRWcU/w7gknMCLsWcxkxJYUTPnm2z99T
 bNZw==
X-Gm-Message-State: AOJu0Yzaom+4ahqKsrHDoDjlmybfodsLgkSyD72pof3rkxh0EjYaWagj
 Nn4RdvcY/CYYglOvWNuPNXU8pUWrcRo7X5tFkjiz2ceEXtdJMmrTRBJnb2aZq1cWOfQJYBnSN/d
 zMRyIugrgwy4JftqoeNppQnqwLCFCVEQdmtu8thZtZmtNzkXstqQp6+N6Xy6GoDUBO+f3GL8=
X-Gm-Gg: ASbGncuFRleqs9CaPZLMvKybZKoK7TaVUuHeNZ8GSlI4LMNQJY58mz58zw4mIq5JO4T
 WzJ/3Lqd2gW/HLXlZlOC6RYjHD0zifwdd6wCc4Y6Hiz9Y9CwewDoS32aKsQkyBB7cCT/Yf21OQx
 DnIAeOds/Bcpk+R+AX4WBK//4kxhmDlD2oGfPP+4SxeOJhHLKAWMydbstYSOMAls40adKUeqlJ5
 SlyuxmEIdJTEeNKbdCIAAusC44nMHJw2evTDN3V6bGaJIKaZ5wfEiG2/CSjHzPb9q6wXb1fCdUD
 XQFgCUfIjXwS/Pn1UF2IX8Cyyz7eBwv+GXQ2KpXYQZBgI6nDEscQ/hhJoJ/ZmxN4zcGYdS3urJw
 F5gSQ4vrJ5WAkZsmQQIWBW2WK9dlq
X-Received: by 2002:a05:6000:2088:b0:3d0:64c1:1a39 with SMTP id
 ffacd0b85a97d-3d064c11c42mr816297f8f.35.1756453645715; 
 Fri, 29 Aug 2025 00:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvUXe58Pzvu1suy/aDyofmBHtjQ9AW/eAkYuhvTs5Px88IcXaIKzmyvSF/mFmT5gvzkazCzA==
X-Received: by 2002:a05:6000:2088:b0:3d0:64c1:1a39 with SMTP id
 ffacd0b85a97d-3d064c11c42mr816272f8f.35.1756453645239; 
 Fri, 29 Aug 2025 00:47:25 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:88f7:ae8f:dfdc:303a:75d?
 ([2a02:3035:6e0:88f7:ae8f:dfdc:303a:75d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276ccc13sm2273641f8f.22.2025.08.29.00.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 00:47:24 -0700 (PDT)
Message-ID: <55f9201c-4083-48f3-a90b-89e625d96195@canonical.com>
Date: Fri, 29 Aug 2025 09:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 05/10] eeprom: starfive: Update eeprom data format version
 to 3
To: Hal Feng <hal.feng@starfivetech.com>
Cc: u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 E Shattow <e@freeshell.de>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-6-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250829060931.79940-6-hal.feng@starfivetech.com>
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

On 29.08.25 08:09, Hal Feng wrote:
> Add eeprom data format v3 support.
> Add wifi_bt field in ATOM4 and add "mac wifi_bt <?>" command to modify it.
> Set or show eth0/1 MAC address only if the board has eth0/1.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>   .../visionfive2/visionfive2-i2c-eeprom.c      | 91 ++++++++++++++++---
>   1 file changed, 78 insertions(+), 13 deletions(-)
> 
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> index 43b8af4fc59..7352252c475 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -11,7 +11,7 @@
>   #include <u-boot/crc.h>
>   #include <linux/delay.h>
>   
> -#define FORMAT_VERSION		0x2
> +#define FORMAT_VERSION		0x3
>   #define PCB_VERSION		0xB1
>   #define BOM_VERSION		'A'
>   /*
> @@ -105,7 +105,8 @@ struct eeprom_atom4_data {
>   	u8 bom_revision;		/* BOM version */
>   	u8 mac0_addr[MAC_ADDR_BYTES];	/* Ethernet0 MAC */
>   	u8 mac1_addr[MAC_ADDR_BYTES];	/* Ethernet1 MAC */
> -	u8 reserved[2];
> +	u8 wifi_bt;			/* WIFI/BT support flag */
> +	u8 reserved;
>   };
>   
>   struct starfive_eeprom_atom4 {
> @@ -128,6 +129,35 @@ static union {
>   /* Set to 1 if we've read EEPROM into memory */
>   static int has_been_read __section(".data");
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

Do you know in which category the Milk-V Mars CM ("MARC") falls?

Best regards

Heinrich

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
>   static inline int is_match_magic(void)
>   {
>   	return strncmp(pbuf.eeprom.header.signature, STARFIVE_EEPROM_HATS_SIG,
> @@ -176,17 +206,22 @@ static void show_eeprom(void)
>   	printf("Vendor : %s\n", pbuf.eeprom.atom1.data.vstr);
>   	printf("Product full SN: %s\n", pbuf.eeprom.atom1.data.pstr);
>   	printf("data version: 0x%x\n", pbuf.eeprom.atom4.data.version);
> -	if (pbuf.eeprom.atom4.data.version == 2) {
> +	if (pbuf.eeprom.atom4.data.version >= 2 && pbuf.eeprom.atom4.data.version <= 3) {
>   		printf("PCB revision: 0x%x\n", pbuf.eeprom.atom4.data.pcb_revision);
>   		printf("BOM revision: %c\n", pbuf.eeprom.atom4.data.bom_revision);
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
> +			printf("Ethernet MAC1 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
> +			pbuf.eeprom.atom4.data.mac1_addr[0], pbuf.eeprom.atom4.data.mac1_addr[1],
> +			pbuf.eeprom.atom4.data.mac1_addr[2], pbuf.eeprom.atom4.data.mac1_addr[3],
> +			pbuf.eeprom.atom4.data.mac1_addr[4], pbuf.eeprom.atom4.data.mac1_addr[5]);
> +		if (pbuf.eeprom.atom4.data.version >= 3)
> +			printf("WIFI/BT support: %x\n", pbuf.eeprom.atom4.data.wifi_bt);
>   	} else {
>   		printf("Custom data v%d is not Supported\n", pbuf.eeprom.atom4.data.version);
>   		dump_raw_eeprom();
> @@ -260,6 +295,7 @@ static void init_local_copy(void)
>   	pbuf.eeprom.atom4.data.bom_revision = BOM_VERSION;
>   	set_mac_address(STARFIVE_DEFAULT_MAC0, 0);
>   	set_mac_address(STARFIVE_DEFAULT_MAC1, 1);
> +	pbuf.eeprom.atom4.data.wifi_bt = 0;
>   }
>   
>   /**
> @@ -385,6 +421,28 @@ static void set_bom_revision(char *string)
>   	update_crc();
>   }
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
>   /**
>    * set_product_id() - stores a StarFive product ID into the local EEPROM copy
>    *
> @@ -478,6 +536,9 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   	} else if (!strcmp(cmd, "bom_revision")) {
>   		set_bom_revision(argv[2]);
>   		return 0;
> +	} else if (!strcmp(cmd, "wifi_bt")) {
> +		set_wifi_bt(argv[2]);
> +		return 0;
>   	} else if (!strcmp(cmd, "product_id")) {
>   		set_product_id(argv[2]);
>   		return 0;
> @@ -513,8 +574,10 @@ int mac_read_from_eeprom(void)
>   	}
>   
>   	// 1, setup ethaddr env
> -	eth_env_set_enetaddr("ethaddr", pbuf.eeprom.atom4.data.mac0_addr);
> -	eth_env_set_enetaddr("eth1addr", pbuf.eeprom.atom4.data.mac1_addr);
> +	if (board_have_eth(0))
> +		eth_env_set_enetaddr("ethaddr", pbuf.eeprom.atom4.data.mac0_addr);
> +	if (board_have_eth(1))
> +		eth_env_set_enetaddr("eth1addr", pbuf.eeprom.atom4.data.mac1_addr);
>   
>   	/**
>   	 * 2, setup serial# env, reference to hifive-platform-i2c-eeprom.c,
> @@ -585,6 +648,8 @@ U_BOOT_LONGHELP(mac,
>   	"    - stores a StarFive PCB revision into the local EEPROM copy\n"
>   	"mac bom_revision <A>\n"
>   	"    - stores a StarFive BOM revision into the local EEPROM copy\n"
> +	"mac wifi_bt <?>\n"
> +	"    - stores a StarFive WIFI/BT support flag into the local EEPROM copy\n"
>   	"mac product_id <VF7110A1-2228-D008E000-xxxxxxxx>\n"
>   	"    - stores a StarFive product ID into the local EEPROM copy\n"
>   	"mac vendor <Vendor Name>\n"

