Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0240DC88E42
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 05:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A83E83E86;
	Mon, 26 Jan 2026 06:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="hv2M75Ok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BA183E8E; Mon, 26 Jan 2026 06:30:18 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A20A83E70
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 06:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C09A10E454; Mon, 26 Jan 2026 06:30:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769405414;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=KeLCMamY8+MZMYkwgUN1bJZ/eKCSzq2nd8/cUivMNac=;
 b=hv2M75OkO4kSa9pjLPeKkdd3K5mQoCbD+35JsJw8b7HEjzrp90KHTa8UtNOyh2q7vZNWKK
 sW3OfrUsvzycYqw54p9Vd06vMkjwAVqlRnZvc04wLiG2fTYNICS8CiyCOj47mc/FI/R1hz
 PJHCwQymA1JVN1WSAQDhvXkUZMAta8ylhsPMmnykQbmFYTAT8n7hp4HnxwQEFbn9rd2cPI
 pXr8BfApPZWQcmMofmF8wU6uiyBNk4WtybTUyf3XQCqKNCfvI6xFGMGbRZjS667VFUX6bi
 /lvnWG52NhfmSZUpcgHbGNOBskk4SyvoCuR79HYfvLGXE/e7TZbnBK4fvSX1xg==
Message-ID: <fa65e079-58e3-2a3e-f77c-12e07b824c81@nabladev.com>
Date: Mon, 26 Jan 2026 06:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 07/11] siemens: capricorn: add logic to U-Boot to avoid
 zig-zag boot
Content-Language: en-US
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-8-hs@nabladev.com> <aXbDjGfIgPGIc439@shlinux89>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <aXbDjGfIgPGIc439@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Peng,

On 26.01.26 02:29, Peng Fan wrote:
> On Sat, Jan 24, 2026 at 06:54:48AM +0100, Heiko Schocher wrote:
>> add logic in board code for detecting the real boot
>> partition and set a local hush shell variable fallback
>> which can be used later in boot variables for detecting
>> a ROMbootloader fallback case.
> 
> Typo: ROM bootloader

Fixed

> 
>>
>> We use the local hush shell variable, as we do not want
>> to save in any case the fallback variable in U-Boot
>> Environment, as the default Environment is may saved
> 
> Typo: maybe

Fixed

> 
>> in boards, which are downgraded to older U-Boot versions.
>>
>> And than the board code does not run, and fallback never
>> gets the correct value.
>>
>> Introduce also hush shell variable envvers to value "v2_"
>> so we can use them in Environment for running different
>> versions of variables between new and old U-Boot images.
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>> Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
>> ---
>>
>> board/siemens/capricorn/Kconfig |  2 ++
>> board/siemens/capricorn/board.c | 43 +++++++++++++++++++++++++++------
>> 2 files changed, 37 insertions(+), 8 deletions(-)
>>
>> diff --git a/board/siemens/capricorn/Kconfig b/board/siemens/capricorn/Kconfig
>> index fe230971e97..d6d1aad75b2 100644
>> --- a/board/siemens/capricorn/Kconfig
>> +++ b/board/siemens/capricorn/Kconfig
>> @@ -1,5 +1,7 @@
>> if TARGET_CAPRICORN
>>
>> +config HUSH_INIT_VAR
>> +	def_bool y
>>
>> config SYS_BOARD
>> 	default "capricorn"
>> diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
>> index 390a7b0d841..d4f26b6ff7f 100644
>> --- a/board/siemens/capricorn/board.c
>> +++ b/board/siemens/capricorn/board.c
>> @@ -5,6 +5,7 @@
>>   * Copyright 2019 Siemens AG
>>   *
>>   */
>> +#include <cli_hush.h>
>> #include <command.h>
>> #include <dm.h>
>> #include <env.h>
>> @@ -29,6 +30,7 @@
>> #include "../common/board.h"
>> #include "../common/eeprom.h"
>> #include "../common/factoryset.h"
>> +#include <firmware/imx/sci/sci.h>
>>
>> #define GPIO_PAD_CTRL \
>> 		((SC_PAD_CONFIG_NORMAL << PADRING_CONFIG_SHIFT) | \
>> @@ -373,23 +375,48 @@ __weak int mmc_map_to_kernel_blk(int dev_no)
>>
>> void board_late_mmc_env_init(void)
>> {
>> -	char cmd[32];
>> -	char mmcblk[32];
>> 	u32 dev_no = mmc_get_env_dev();
>>
>> 	if (!check_mmc_autodetect())
>> 		return;
>>
>> 	env_set_ulong("mmcdev", dev_no);
>> +}
>> +
>> +#if defined(CONFIG_HUSH_INIT_VAR)
>> +int hush_init_var(void)
>> +{
>> +	sc_misc_bt_t boot_type;
>>
>> -	/* Set mmcblk env */
>> -	sprintf(mmcblk, "/dev/mmcblk%dp2 rootwait rw",
>> -		mmc_map_to_kernel_blk(dev_no));
>> -	env_set("mmcroot", mmcblk);
>> +	if (sc_misc_get_boot_type(-1, &boot_type) != 0) {
>> +		puts("boottype cannot be retrieved\n");
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Set here explicitly a hush shell variable, so if a saveenv
>> +	 * happens, this variable is *not* saved in U-Boot environment.
>> +	 *
>> +	 * This is for devices which are already in the field essential,
>> +	 * as if such a device breaks, the cutsomer gets a new device
>> +	 * with a new U-Boot version (and so a new U-Boot environment).
>> +	 *
>> +	 * But the customer makes a downgrade to an older U-bootversion,
> 
> Typo: U-Boot version.

Fixed.

> 
> 
> Otherwise:
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Many thanks for your review of all the patches!

I worked in all your comments for the series, try to make a test which Benjamin
requested yesterday for patch:

"env: add w flags for net config in explicit write mode"
https://patchwork.ozlabs.org/project/uboot/patch/20260124054040.7597-1-hs@nabladev.com/

and wait for more comments before I resend v2.

Thanks!

bye,
Heiko
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
