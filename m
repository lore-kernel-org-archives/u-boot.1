Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946C4D3B7C3
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 22:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539DF895A4;
	Sun, 24 Nov 2024 23:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732488678;
	bh=I3Rv4ftqcxHKTs2FssalUhz/qdXQ4lo6XEXpfxHFgcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PldMl867V3HkBGJnCWU6h1Tj7hY6Q5W1mUYxRnwJg2c3OBdk4mTPw6SywZmRbjhrY
	 PTAMBd5qLtTJoFhulqvcILdlrj7Xjq0y3cGPEAA0UOW6/uUvjJIFeV6mUMdmvex+1B
	 /NnzbcpSXQyUljzyUQARlFwekl7g4axpEzEPrs+rko5YWQD2/BOmyUh9cWdpUZ9ayO
	 c1aGtSPPhF/elNz7kTHIuDldnZMEda17RU64Sw1fB8swt+t+8iNm8cucia555OHyxR
	 TPEp1Qn0MZsnc2ONlYV/qI0uA3h1CvSVdr/2bgThVOKa2kCb6sjTTpUj1XA3hkYKm+
	 X1B8888u454Xg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 64647895A7;
 Sun, 24 Nov 2024 23:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732488674;
 bh=I3Rv4ftqcxHKTs2FssalUhz/qdXQ4lo6XEXpfxHFgcM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=t21+YLMwxmlZzR7gBRiwQZoLOS/7vX3CH+k3kOnEFcF9FlTeK897b77pjZ+f+mz8k
 EJPlfz2K8wloCVWqRUFa7DWGjUCToIt13eFeQS0TRK9R9f2CLM0m3NwmaSsnEmo32S
 WZ1If3BeWUlpwTwnfKhK6A+sznztzNRt3F6abtr3EeYHWPLuxonC0zxyxKvNVsZZHs
 ogkknFeJjbRKJiBkGvFw0FNVRlW+OCF3r/V9WtySmOjatiJD44u65sv5TW8AnZ85mX
 NAbWt/3uBUPlNiU5xO6tELJ2d+zCO9ukqW7fi43RDg/vUNkfHW64l5Em3OMLE/eM52
 E27TASmuK13gg==
Message-ID: <f87a45e6-0f37-4625-bf34-12205b8ee4b7@denx.de>
Date: Sun, 24 Nov 2024 22:10:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241121172154.90507-1-cniedermaier@dh-electronics.com>
 <20241121172154.90507-3-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241121172154.90507-3-cniedermaier@dh-electronics.com>
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
> The env variable "SN" is used to store the serial number on DH electronics
> SoMs. New SoMs will use the variable "dh_som_serial_number". To ensure
> compatibility, these env variables are synchronized. This is achieved
> using callback functions. To avoid recursive calls, these are locked
> against each other.

What kind of recursive calls?

It would be good to expand the commit message and elaborate on the 
recursive calls problem .

> diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
> index a7b0472a09..2e3e5c483b 100644
> --- a/board/dhelectronics/common/dh_common.c
> +++ b/board/dhelectronics/common/dh_common.c
> @@ -45,6 +45,32 @@ struct eeprom_id_page {
>   #define DH_EEPROM_ID_PAGE_V1_0_DATA_LEN	(sizeof(struct eeprom_id_page) - \
>   					offsetof(struct eeprom_id_page, mac0))
>   
> +static bool in_dh_som_serial_number;
> +static bool in_SN;
> +
> +static int on_dh_som_serial_number(const char *name, const char *value, enum env_op op,
> +				   int flags)
> +{
> +	in_dh_som_serial_number = true;
> +	if (!in_SN)
> +		env_set("SN", value);
> +	in_dh_som_serial_number = false;
> +	return 0;
> +}
> +
> +U_BOOT_ENV_CALLBACK(dh_som_serial_number, on_dh_som_serial_number);
> +
> +static int on_SN(const char *name, const char *value, enum env_op op, int flags)
> +{
> +	in_SN = true;
> +	if (!in_dh_som_serial_number)
> +		env_set("dh_som_serial_number", value);
> +	in_SN = false;
> +	return 0;
> +}
> +
> +U_BOOT_ENV_CALLBACK(SN, on_SN);
> +
>   bool dh_mac_is_in_env(const char *env)
>   {
>   	unsigned char enetaddr[6];
> diff --git a/configs/imx8mp_dhsom.config b/configs/imx8mp_dhsom.config
> index 416143178c..87bf3bf65e 100644
> --- a/configs/imx8mp_dhsom.config
> +++ b/configs/imx8mp_dhsom.config
> @@ -59,6 +59,7 @@ CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=20
>   CONFIG_SYS_EEPROM_SIZE=16384
>   CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
>   
> +CONFIG_ENV_CALLBACK_LIST_STATIC="dh_som_serial_number:dh_som_serial_number,SN:SN,"
dh_common.c is also used on imx6 and stm32 boards, so this has to go 
into configs/dhsom.config fragment I think ?
