Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEC2CD342E
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 07:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B956E88ABA;
	Tue,  3 Sep 2024 09:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725347194;
	bh=41iJR0gfpE3QMpq/KZ5ihakpLWhenOAhjFTPyb/cHrQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S92l7BTAAEphAgOzz9HcwDxb1Mcs1IcaPaE5g2mL/p2/bMbsJgGv1vxMNmEgT2aLS
	 Zjgv9xyklBS8t1hxRhgI9uN0TswbP/tb23ONUWMoKQjW190nf8s2QdMrabLHPam4Gb
	 D0B8I35MD2R/7o4cTwfCgFOTrsxPnIkhoTGoBhLeNCneeOBvlDmQebAJxl9q9eQP3b
	 cdVzHtHCoMfRb0Mez4oAjQK+ApxPlAcwjZNNqvBRJwss/AaYQSDDAaZb3KOmK6SCXK
	 rupguUynMn3G69bQUjIqLZWfsB/Xhj4Gq9nwwpI6M0x8qhiFLGU8aiDYnOZOtJAOdP
	 jhbd50dgZegSg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C2588B4B; Tue,  3 Sep 2024 09:06:33 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE6D388A0E
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 09:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Wyc9d6c0Hz9skF;
 Tue,  3 Sep 2024 09:06:29 +0200 (CEST)
Message-ID: <99d7d684-74bf-4ea8-9e30-2610fd35747f@denx.de>
Date: Tue, 3 Sep 2024 09:06:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-marvell 3/3] arm: mvebu: turris_omnia: Switch DDR
 speed to 1333H when reset 9 is selected
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240829080849.20276-1-kabel@kernel.org>
 <20240829080849.20276-4-kabel@kernel.org>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240829080849.20276-4-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Wyc9d6c0Hz9skF
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

On 8/29/24 10:08, Marek Behún wrote:
> Users experiencing random kernel crashes due to new versions of
> Marvell's DDR training algorithm can solve the issue by setting DDR
> speed to 1333H.
> 
> But if kernel crashes, it has to be done in U-Boot, which is impossible
> without UART connection.
> 
> In order to make it easier for users, use the rescue button mechanism:
> when rescue mode 9 is selected (that is when 10 LEDs are ON), U-Boot
> will train DDR in 1333H mode and also update EEPROM so that subsequent
> boot will use this mode.
> 
> User has to use the `eeprom` command in U-Boot or `omnia-eeprom` command
> in OS to switch back to 1600K mode.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>   board/CZ.NIC/turris_omnia/turris_omnia.c | 90 ++++++++++++++++++++----
>   1 file changed, 77 insertions(+), 13 deletions(-)
> 
> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
> index 46f20f05c05..eb88ee7f1ed 100644
> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> @@ -47,6 +47,9 @@ DECLARE_GLOBAL_DATA_PTR;
>   #define OMNIA_I2C_EEPROM_CHIP_LEN	2
>   #define OMNIA_I2C_EEPROM_MAGIC		0x0341a034
>   
> +#define OMNIA_RESET_TO_LOWER_DDR_SPEED	9
> +#define OMNIA_LOWER_DDR_SPEED		"1333H"
> +
>   #define A385_SYS_RSTOUT_MASK		MVEBU_REGISTER(0x18260)
>   #define   A385_SYS_RSTOUT_MASK_WD	BIT(10)
>   
> @@ -206,6 +209,20 @@ static u32 omnia_mcu_crc32(const void *p, size_t len)
>   	return ~bitrev32(crc);
>   }
>   
> +static int omnia_mcu_get_reset(void)
> +{
> +	u8 reset_status;
> +	int ret;
> +
> +	ret = omnia_mcu_read(CMD_GET_RESET, &reset_status, 1);
> +	if (ret) {
> +		printf("omnia_mcu_read failed: %i, reset status unknown!\n", ret);
> +		return ret;
> +	}
> +
> +	return reset_status;
> +}
> +
>   /* Can only be called after relocation, since it needs cleared BSS */
>   static int omnia_mcu_board_info(char *serial, u8 *mac, char *version)
>   {
> @@ -463,14 +480,17 @@ static bool check_eeprom_crc(const void *buf, size_t size, u32 expected,
>   	return true;
>   }
>   
> +static struct udevice *omnia_get_eeprom(void)
> +{
> +	return omnia_get_i2c_chip("EEPROM", OMNIA_I2C_EEPROM_CHIP_ADDR,
> +				  OMNIA_I2C_EEPROM_CHIP_LEN);
> +}
> +
>   static bool omnia_read_eeprom(struct omnia_eeprom *oep)
>   {
> -	struct udevice *eeprom;
> +	struct udevice *eeprom = omnia_get_eeprom();
>   	int ret;
>   
> -	eeprom = omnia_get_i2c_chip("EEPROM", OMNIA_I2C_EEPROM_CHIP_ADDR,
> -				    OMNIA_I2C_EEPROM_CHIP_LEN);
> -
>   	if (!eeprom)
>   		return false;
>   
> @@ -502,6 +522,35 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
>   	return true;
>   }
>   
> +static void omnia_eeprom_set_lower_ddr_speed(void)
> +{
> +	struct udevice *eeprom = omnia_get_eeprom();
> +	struct omnia_eeprom oep;
> +	int ret;
> +
> +	if (!eeprom || !omnia_read_eeprom(&oep))
> +		return;
> +
> +	puts("Setting DDR speed to " OMNIA_LOWER_DDR_SPEED " in EEPROM as requested by reset button... ");
> +
> +	/* check if already set */
> +	if (!strncmp(oep.ddr_speed, OMNIA_LOWER_DDR_SPEED, sizeof(oep.ddr_speed)) &&
> +	    (oep.old_ddr_training == 0 || oep.old_ddr_training == 0xff)) {
> +		puts("was already set\n");
> +		return;
> +	}
> +
> +	strncpy(oep.ddr_speed, OMNIA_LOWER_DDR_SPEED, sizeof(oep.ddr_speed));
> +	oep.old_ddr_training = 0xff;
> +	oep.crc2 = crc32(0, (const void *)&oep, offsetof(struct omnia_eeprom, crc2));
> +
> +	ret = i2c_eeprom_write(eeprom, 0, (const void *)&oep, sizeof(oep));
> +	if (ret)
> +		printf("cannot write EEPROM: %d\n", ret);
> +	else
> +		puts("done\n");
> +}
> +
>   int omnia_get_ram_size_gb(void)
>   {
>   	static int ram_size;
> @@ -531,6 +580,13 @@ bool board_use_old_ddr3_training(void)
>   {
>   	struct omnia_eeprom oep;
>   
> +	/*
> +	 * If lower DDR speed is requested by reset button, we can't use old DDR
> +	 * training algorithm.
> +	 */
> +	if (omnia_mcu_get_reset() == OMNIA_RESET_TO_LOWER_DDR_SPEED)
> +		return false;
> +
>   	if (!omnia_read_eeprom(&oep))
>   		return false;
>   
> @@ -711,13 +767,19 @@ static void fixup_speed_in_ddr_topology(struct mv_ddr_topology_map *topology)
>   	const struct omnia_ddr_speed *setting;
>   	const char *speed;
>   	static bool done;
> +	int reset_status;
>   
>   	if (done)
>   		return;
>   
>   	done = true;
>   
> -	speed = omnia_get_ddr_speed();
> +	reset_status = omnia_mcu_get_reset();
> +	if (reset_status == OMNIA_RESET_TO_LOWER_DDR_SPEED)
> +		speed = OMNIA_LOWER_DDR_SPEED;
> +	else
> +		speed = omnia_get_ddr_speed();
> +
>   	if (!speed)
>   		return;
>   
> @@ -734,7 +796,10 @@ static void fixup_speed_in_ddr_topology(struct mv_ddr_topology_map *topology)
>   	if (params->speed_bin_index == setting->speed_bin)
>   		return;
>   
> -	printf("Fixing up DDR3 speed (EEPROM defines %s)\n", speed);
> +	if (reset_status == OMNIA_RESET_TO_LOWER_DDR_SPEED)
> +		printf("Fixing up DDR3 speed to %s as requested by reset button\n", speed);
> +	else
> +		printf("Fixing up DDR3 speed (EEPROM defines %s)\n", speed);
>   
>   	params->speed_bin_index = setting->speed_bin;
>   	params->memory_freq = setting->freq;
> @@ -771,8 +836,7 @@ static int set_regdomain(void)
>   static void handle_reset_button(void)
>   {
>   	const char * const vars[1] = { "bootcmd_rescue", };
> -	int ret;
> -	u8 reset_status;
> +	int reset_status;
>   
>   	/*
>   	 * Ensure that bootcmd_rescue has always stock value, so that running
> @@ -781,12 +845,12 @@ static void handle_reset_button(void)
>   	 */
>   	env_set_default_vars(1, (char * const *)vars, 0);
>   
> -	ret = omnia_mcu_read(CMD_GET_RESET, &reset_status, 1);
> -	if (ret) {
> -		printf("omnia_mcu_read failed: %i, reset status unknown!\n",
> -		       ret);
> +	reset_status = omnia_mcu_get_reset();
> +	if (reset_status < 0)
>   		return;
> -	}
> +
> +	if (reset_status == OMNIA_RESET_TO_LOWER_DDR_SPEED)
> +		return omnia_eeprom_set_lower_ddr_speed();
>   
>   	env_set_ulong("omnia_reset", reset_status);
>   

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
