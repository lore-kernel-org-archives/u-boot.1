Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3FBC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F02F9880FB;
	Thu, 28 Mar 2024 10:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711619668;
	bh=i9KR52zzeBKzE2hrDpHl/5WRxSdGIQjbG02msnfMc3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=klHstYT+xKghrf3A3u2vP9L/b6hjQWaZjSVEJ/0xfolvLNbUer8k5/T/KNLG/xI//
	 RtrlbT1R72osVd7ulQ66r1TQpDe3SSmswnc6DINo/BAGKKywhpe1ZudVmQgXBldODI
	 +s5DNi9RciyhN9ZwF3+BD2z1xz0eF/t5ykrxBQgqh8y+Bik2aKz/kRhJQDRigw7/pI
	 7GttOeQbZ83SoTcFby3ho5wTRlXXwVlD59wH8CfKLQOeIAJs+KKtjoIJgn11iusOWL
	 jJrwguGz44oLiFred7L5rY8LHhUZ8ypaMBSdpbJLZ6L/Ff7JeGvssxQuFKgsAKhLNb
	 yPWTBE6NMs2kQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3DE487FAC; Thu, 28 Mar 2024 10:54:26 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D8488101
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V4zQk6hFDz9spY;
 Thu, 28 Mar 2024 10:54:22 +0100 (CET)
Message-ID: <b350b575-3b2f-496a-9a29-b80aaaeac5ce@denx.de>
Date: Thu, 28 Mar 2024 10:54:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 04/18] arm: mvebu: turris_omnia: Update
 MCU status and features reading
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-5-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-5-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V4zQk6hFDz9spY
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

On 3/27/24 17:23, Marek Behún wrote:
> Refactor MCU status word and MCU firmware features reading to make it
> simpler to use.
> 
> Try reading 32 bits of features, if that fails, read 16 bits. Older MCU
> firmware supports only 16-bit wide features, and if more bytes are read,
> either 0xff is sent or I2C transaction fails. Handle both cases.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   board/CZ.NIC/turris_omnia/turris_omnia.c | 100 +++++++++++++++--------
>   1 file changed, 68 insertions(+), 32 deletions(-)
> 
> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
> index 87e33d88c4..6dfde5ee7a 100644
> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> @@ -133,6 +133,59 @@ static int omnia_mcu_write(u8 cmd, const void *buf, int len)
>   	return dm_i2c_write(chip, cmd, buf, len);
>   }
>   
> +static int omnia_mcu_get_sts_and_features(u16 *psts, u32 *pfeatures)
> +{
> +	u16 sts, feat16;
> +	int ret;
> +
> +	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &sts, sizeof(sts));
> +	if (ret)
> +		return ret;
> +
> +	if (psts)
> +		*psts = sts;
> +
> +	if (!pfeatures)
> +		return 0;
> +
> +	if (sts & STS_FEATURES_SUPPORTED) {
> +		/* try read 32-bit features */
> +		ret = omnia_mcu_read(CMD_GET_FEATURES, pfeatures,
> +				     sizeof(*pfeatures));
> +		if (ret) {
> +			/* try read 16-bit features */
> +			ret = omnia_mcu_read(CMD_GET_FEATURES, &feat16,
> +					     sizeof(&feat16));
> +			if (ret)
> +				return ret;
> +
> +			*pfeatures = feat16;
> +		} else {
> +			if (*pfeatures & FEAT_FROM_BIT_16_INVALID)
> +				*pfeatures &= GENMASK(15, 0);
> +		}
> +	} else {
> +		*pfeatures = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int omnia_mcu_get_sts(u16 *sts)
> +{
> +	return omnia_mcu_get_sts_and_features(sts, NULL);
> +}
> +
> +static bool omnia_mcu_has_feature(u32 feature)
> +{
> +	u32 features;
> +
> +	if (omnia_mcu_get_sts_and_features(NULL, &features))
> +		return false;
> +
> +	return feature & features;
> +}
> +
>   static void enable_a385_watchdog(unsigned int timeout_minutes)
>   {
>   	struct sar_freq_modes sar_freq;
> @@ -194,7 +247,7 @@ static bool disable_mcu_watchdog(void)
>   static bool omnia_detect_sata(const char *msata_slot)
>   {
>   	int ret;
> -	u16 stsword;
> +	u16 sts;
>   
>   	puts("MiniPCIe/mSATA card detection... ");
>   
> @@ -210,24 +263,24 @@ static bool omnia_detect_sata(const char *msata_slot)
>   		}
>   	}
>   
> -	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &stsword, sizeof(stsword));
> +	ret = omnia_mcu_get_sts(&sts);
>   	if (ret) {
>   		printf("omnia_mcu_read failed: %i, defaulting to MiniPCIe card\n",
>   		       ret);
>   		return false;
>   	}
>   
> -	if (!(stsword & STS_CARD_DET)) {
> +	if (!(sts & STS_CARD_DET)) {
>   		puts("none\n");
>   		return false;
>   	}
>   
> -	if (stsword & STS_MSATA_IND)
> +	if (sts & STS_MSATA_IND)
>   		puts("mSATA\n");
>   	else
>   		puts("MiniPCIe\n");
>   
> -	return stsword & STS_MSATA_IND;
> +	return sts & STS_MSATA_IND;
>   }
>   
>   static bool omnia_detect_wwan_usb3(const char *wwan_slot)
> @@ -355,14 +408,14 @@ static int omnia_get_ram_size_gb(void)
>   static const char * const omnia_get_mcu_type(void)
>   {
>   	static char result[] = "xxxxxxx (with peripheral resets)";
> -	u16 stsword, features;
> +	u16 sts;
>   	int ret;
>   
> -	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &stsword, sizeof(stsword));
> +	ret = omnia_mcu_get_sts(&sts);
>   	if (ret)
>   		return "unknown";
>   
> -	switch (stsword & STS_MCU_TYPE_MASK) {
> +	switch (sts & STS_MCU_TYPE_MASK) {
>   	case STS_MCU_TYPE_STM32:
>   		strcpy(result, "STM32");
>   		break;
> @@ -377,11 +430,8 @@ static const char * const omnia_get_mcu_type(void)
>   		break;
>   	}
>   
> -	if (stsword & STS_FEATURES_SUPPORTED) {
> -		ret = omnia_mcu_read(CMD_GET_FEATURES, &features, sizeof(features));
> -		if (ret == 0 && (features & FEAT_PERIPH_MCU))
> -			strcat(result, " (with peripheral resets)");
> -	}
> +	if (omnia_mcu_has_feature(FEAT_PERIPH_MCU))
> +		strcat(result, " (with peripheral resets)");
>   
>   	return result;
>   }
> @@ -660,9 +710,6 @@ int board_early_init_f(void)
>   
>   void spl_board_init(void)
>   {
> -	u16 val;
> -	int ret;
> -
>   	/*
>   	 * If booting from UART, disable MCU watchdog in SPL, since uploading
>   	 * U-Boot proper can take too much time and trigger it. Instead enable
> @@ -679,12 +726,8 @@ void spl_board_init(void)
>   	 * resets then LAN eth switch is initialized automatically by bootstrap
>   	 * pins when A385 is released from the reset.
>   	 */
> -	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &val, sizeof(val));
> -	if (ret == 0 && (val & STS_FEATURES_SUPPORTED)) {
> -		ret = omnia_mcu_read(CMD_GET_FEATURES, &val, sizeof(val));
> -		if (ret == 0 && (val & FEAT_PERIPH_MCU))
> -			initialize_switch();
> -	}
> +	if (omnia_mcu_has_feature(FEAT_PERIPH_MCU))
> +		initialize_switch();
>   }
>   
>   #if IS_ENABLED(CONFIG_OF_BOARD_FIXUP) || IS_ENABLED(CONFIG_OF_BOARD_SETUP)
> @@ -884,16 +927,9 @@ static int fixup_mcu_gpio_in_eth_wan_node(void *blob)
>   #if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
>   int board_fix_fdt(void *blob)
>   {
> -	u16 val;
> -	int ret;
> -
> -	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &val, sizeof(val));
> -	if (ret == 0 && (val & STS_FEATURES_SUPPORTED)) {
> -		ret = omnia_mcu_read(CMD_GET_FEATURES, &val, sizeof(val));
> -		if (ret == 0 && (val & FEAT_PERIPH_MCU)) {
> -			fixup_mcu_gpio_in_pcie_nodes(blob);
> -			fixup_mcu_gpio_in_eth_wan_node(blob);
> -		}
> +	if (omnia_mcu_has_feature(FEAT_PERIPH_MCU)) {
> +		fixup_mcu_gpio_in_pcie_nodes(blob);
> +		fixup_mcu_gpio_in_eth_wan_node(blob);
>   	}
>   
>   	fixup_msata_port_nodes(blob);

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
