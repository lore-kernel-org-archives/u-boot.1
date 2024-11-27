Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6428DD6D23D
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 21:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6366989825;
	Wed, 27 Nov 2024 22:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732741685;
	bh=pU45BQyhFMlnvHBfpwb0LL+03km+j0v5Z4s7XW0Jf1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Feu8Oqe5h+pU7/dxQMTnJpReOlCKwDFPcXLmbnFtmBZzJCob1ugnRvcJzbI7nzUfy
	 UVFPMaG1isWR8fvX8dNUm72EUumeWMEoilD3JTLZLnx0IRTr0WiWTvEiEbgEknj2oU
	 GeFfrvoR/GBF1PbbDCxbRNmvAQhddciyghh/aeh0oPX8EW28841y7mZEdfj4Qtke7L
	 8AKRJzyua421VYc1562wYNsP6XpJgM3gntNY+jMwtTI/AbG2bocYiWgaRqVyzivdOM
	 xCUuThtnBY1qDp4Fp2NfLH2udWjGrQmt+/4fB3NU5qBTAsMjf7TR4VqZcWeXWxvZEE
	 UBsysuJF4NB7w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5E849897EE;
 Wed, 27 Nov 2024 22:07:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732741684;
 bh=pU45BQyhFMlnvHBfpwb0LL+03km+j0v5Z4s7XW0Jf1Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O2ZZ+/TRlNiaWB0Efv9T760xopxKivEAks79XPBO3v3bw6g47Ufwb70pxFnxqS+KD
 qO25+9jJM8auDf0azgmrceOgYx1zrQNOEm+1JoENuHg98AWQd9rQVUcwkxXrW9u/61
 DZxAyfz7MFNmEb3ZC6CR0ocjA52GNHqNDm+QwP0SoTz4LWbLvFCp/jN7wDc9xandp8
 Oh+Adyv3x26qwzNEHSkkfgjYcfwWef3AhiJ4gRx8rLLMY+2KgpDKONsBaQfwOnCT97
 DmZ0zYQZ7p9sg0OzK9lgUZfasX/x4cQT1+upZeEX/a4c4CqX2q6nbNf5XbmuSNBywV
 5ZwIJ6dqkeBJw==
Message-ID: <2a8ae710-1083-4d89-9689-24a679cc9aba@denx.de>
Date: Wed, 27 Nov 2024 21:47:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: stm32: env: Enable scan and start for AB schema
 on STM32MP15 DHSOM
To: Pascal Zimmermann <pzimmermann@dh-electronics.com>, u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
References: <20241127102924.7652-1-pzimmermann@dh-electronics.com>
 <20241127102924.7652-3-pzimmermann@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241127102924.7652-3-pzimmermann@dh-electronics.com>
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

On 11/27/24 11:29 AM, Pascal Zimmermann wrote:

Please CC me on the entire series.

> diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
> index efc149577e..22d8bd3241 100644
> --- a/configs/stm32mp15_dhsom.config
> +++ b/configs/stm32mp15_dhsom.config
> @@ -10,6 +10,9 @@ CONFIG_BOARD_EARLY_INIT_F=y
>   CONFIG_BOARD_SIZE_LIMIT=1441792
>   CONFIG_BOOTCOUNT_BOOTLIMIT=3
>   CONFIG_BOOTDELAY=1
> +CONFIG_BOOTRETRY=y
> +CONFIG_RESET_TO_RETRY=y
> +CONFIG_BOOT_RETRY_TIME=-1
>   CONFIG_CMD_ADC=y
>   CONFIG_CMD_REMOTEPROC=y
>   CONFIG_CMD_STBOARD=y
> diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
> index c004a8cec8..267e344677 100644
> --- a/include/configs/stm32mp15_dh_dhsom.h
> +++ b/include/configs/stm32mp15_dh_dhsom.h
> @@ -17,7 +17,40 @@
>   			" 0x800000\0"
>   #endif
>   
> +/* Add the search for AB partitons */
> +#define SCAN_DEV_FOR_BOOT_PARTS						\
> +	"run dh_check_if_ab; "						\
> +	"if test -z \"${devplist}\"; "					\
> +		"then "							\

"then" can be part of the previous line

> +		"part list ${devtype} ${devnum} -bootable devplist; "	\
> +	"fi; "
> +
>   #define STM32MP_BOARD_EXTRA_ENV						\
> +	"altbootcmd= "							\
> +	"setenv dh_ab_get_partnames "					\
> +		"'setenv dh_ab_partnames ${dh_ab_partname_secondary} "	\
> +			"${dh_ab_partname_primary}' && "		\
> +		"run bootcmd\0"						\
> +	"dh_check_if_ab= " /* Sets devplist if AB partitions*/		\
> +		"echo test for AB on ${devtype} ${devnum} && "		\
> +		"run dh_ab_get_partnames && "				\
> +		"setenv devplist && "					\
> +		"for partname in ${dh_ab_partnames}; do "		\
> +			"setenv partnum && "				\
> +			"if part number ${devtype} ${devnum} ${partname} partnum; "\
> +				"then "					\
> +				"setenv devplist \"${devplist} ${partnum}\" && "\
> +				"setenv bootretry 60 ;"			\
> +			"fi; "						\
> +		"done ; "						\
> +		"if test -n \"${devplist}\"; "				\
> +			"then echo AB partitions found! ; "		\
> +		"fi\0"							\
> +	"dh_ab_get_partnames= " /* Sets dh_ab_partnames */		\
> +		"setenv dh_ab_partnames ${dh_ab_partname_primary} "	\
> +			"${dh_ab_partname_secondary}\0"			\
> +	"dh_ab_partname_primary=rootfs-a\0" /* Names of AB partitions */\
> +	"dh_ab_partname_secondary=rootfs-b\0"				\
>   	"dh_preboot="							\
>   		"run dh_testbench_backward_compat\0"			\
>   	"dh_update_sd_to_emmc=" /* Install U-Boot from SD to eMMC */	\

I suspect this also applies to other DHSOM, so this should be moved to 
some common include/configs/dh_dhsom.h and renamed to #define 
DH_AB_UPDATE_EXTRA_ENV . The common dh_dhsom.h can be included in 
stm32mp15_dh_dhsom.h , matching stm32mp13 DHSOM header , 
imx8mp_dhcom_pdk2.h , dh_imx6.h and DH_AB_UPDATE_EXTRA_ENV inserted into 
each board extra environment . The configs/ change should be in 
configs/dhsom.config fragment . That way, all DHSOM will consistently 
support the same AB detection and handling mechanism .
