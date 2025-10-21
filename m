Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E04ECCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 11:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F65780422;
	Tue, 21 Oct 2025 13:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0zK42jBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348E1807C0; Tue, 21 Oct 2025 13:47:51 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1535800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 13:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so4697866f8f.2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761047268; x=1761652068;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7v1VRsyTsoxUz2otuSWns1m3sWymox9KlnpOL36vjnk=;
 b=0zK42jBq617P4Ek+tw+aXw7TibHdzxM0LnzhILnNZgltDambhuKC7W0JyUERJ+03M0
 8oEi7SrPnth73p4ypdJdut4wqkZW8kLKCk8n5in/vgkMz210aYB+Ua6g08KQZBR0pzRS
 nUoEmNef5SDKcJup/fZmxU2CpjKQe5I5nUizD9/xOcSSvjP6/pt0G0c3jdx2eTRMBM4E
 sx+eoSKJEy6wekCI1/6OMOdns1o/MtKzhiXILjbIBGNBBOw4ic5tNFU1o8urOxo5u2S2
 DFeyCMjKH3zpSB5HN/kiBAjyCG6nc43Fw95NyyK1tzpc/pZFmQUbA/aYIgnKg5r6Ed3C
 HKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761047268; x=1761652068;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7v1VRsyTsoxUz2otuSWns1m3sWymox9KlnpOL36vjnk=;
 b=g0OV0z3ku4Fg7PbQNzfiYycjB6IFswwKO2yhIsFFxoUy9nrI8Hf9+vU/lTOKn2/Hvs
 yBor7VralpJiiSDWMVDyEygpiOuo0eLL0RhUilbdft9a0qyWHkMEUk1f07eO108j6JtU
 jdzre3jlCm23JV88NFFJ8tnoPtKPJ66EFvzFHKcEh2jKGJzIlxW4Kz31LTL9+L8P2FTM
 oNXjGIZ+n97bBdW7Ihp2KlpTG8Fv0RZbbmOk2mmVyLIDCOFfviwWaacTj1jVfwVtTKeY
 oqEaiy1wwfNmMdKO9ArKIOxmfirEdrf0jeNhCZ6GnYEKLQWblYsapbc6I7Cl5XTj8eQH
 RLSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsR1ej4TkbxmctRjANfov3RwssXSJLz1N/7kogicQGMsmebA9nFo1+jx06DOU75Gv6ypyc+bI=@lists.denx.de
X-Gm-Message-State: AOJu0YxzdFxT8f8/cpjyaex3vYgbuJZF6Sru+0PB/zSws+OH88u5fiXj
 YNOh+JMSxyaeYPpNx9oUQQzZ6rljudHx/CyxIJbRibJ/yysiDlthhiAIHLI2o7U/69M=
X-Gm-Gg: ASbGncuD5gmHW0/hu7/dDYWdUn/0y2gjBQw1SAb2aPYS3Rz/1gQQ9Tz34t3l1udIm0N
 mfrLOslqu/ov3uEjIJcGOWuvhD4J1qK6DpxNuUVgBVxTnvURxIROkmHnb0TgRWriCv54Wh3quWZ
 mmEAXL6vgBhnS86CNUnBH6FKvE9HEgJdWj6XTAPRUwwdRjcIwQZmRrIcdQ49y28vZlUpKvAFCP4
 SD/F+pvJQzWE44Bhynnm7CmdATY43+PBpS5tu/99twmYmGfioJQ6rGRAhuHUtE1eAuhyD+8d0Tc
 5sazsUL4bmffj0MS0zyTCAEqSkfOOuLrehdFJQLzQSJjw4tF33Ke7VbhOfx2CxBWlBMSHtzN2IX
 LPHUIgAUpJDNWY16gZ2z+Ir7NT0RkEqbIySwxD/zkXeA1Z8O+keAO94wdkkm36rwWXqD+IXz1Cu
 LkQ2nrxpiMlsqVUkecjPRt+lB2aVVWkHg=
X-Google-Smtp-Source: AGHT+IFpCAg1GFU823UUfGkHPc0si7DGLHhUxYX3jYy9UgL9opdrjRhMsxiLWxJKQpAfPO10EZ8d8g==
X-Received: by 2002:a05:6000:2303:b0:427:6c7:66f8 with SMTP id
 ffacd0b85a97d-42706c76a55mr11329428f8f.52.1761047268086; 
 Tue, 21 Oct 2025 04:47:48 -0700 (PDT)
Received: from [10.1.5.55] (88-127-129-70.subs.proxad.net. [88.127.129.70])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f19sm20139101f8f.9.2025.10.21.04.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 04:47:47 -0700 (PDT)
Message-ID: <4fe82af4-cca8-4e82-9ea8-40a730276f59@baylibre.com>
Date: Tue, 21 Oct 2025 13:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: am62x: Add support for reading eeprom data
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>,
 Garrett Giordano <ggiordano@phytec.com>, Wadim Egorov <w.egorov@phytec.de>,
 Neha Malcom Francis <n-francis@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Devarsh Thakkar
 <devarsht@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Judith Mendez <jm@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20251017-am62xeeprom-v1-1-31f83124189f@baylibre.com>
 <87ecqwbsju.fsf@kernel.org>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <87ecqwbsju.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 21/10/2025 à 09:52, Mattijs Korpershoek a écrit :
> Hi Guillaume,
>
> Thank you for the patch.


Hi,


>
> On Fri, Oct 17, 2025 at 08:24, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:
>
>> I2C EEPROM data contains the board name and its revision.
>> Add support for:
>> - Reading EEPROM data and store a copy at end of SRAM
>> - Updating env variable with relevant board info
>> - Printing board info during boot.
>>
>> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>> ---
>>   arch/arm/mach-k3/am62x/Kconfig |  3 ++
>>   board/ti/am62x/evm.c           | 95 +++++++++++++++++++++++++++++++++++++++++-
>>   configs/am62x_evm_r5_defconfig |  1 +
>>   3 files changed, 98 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
>> index 81199ada3a1..f7ad52db7d8 100644
>> --- a/arch/arm/mach-k3/am62x/Kconfig
>> +++ b/arch/arm/mach-k3/am62x/Kconfig
>> @@ -14,6 +14,8 @@ config TARGET_AM625_A53_EVM
>>   	select ARM64
>>   	select BINMAN
>>   	select OF_SYSTEM_SETUP
>> +	imply TI_COMMON_CMD_OPTIONS
>> +	imply TI_I2C_BOARD_DETECT
>>   
>>   config TARGET_AM625_R5_EVM
>>   	bool "TI K3 based AM625 EVM running on R5"
>> @@ -25,6 +27,7 @@ config TARGET_AM625_R5_EVM
>>   	select K3_DDRSS
>>   	select BINMAN
>>   	imply SYS_K3_SPL_ATF
>> +	imply TI_I2C_BOARD_DETECT
>>   
>>   config TARGET_PHYCORE_AM62X_A53
>>   	bool "PHYTEC phyCORE-AM62x running on A53"
>> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
>> index d7b07a0d34d..fbd45608efa 100644
>> --- a/board/ti/am62x/evm.c
>> +++ b/board/ti/am62x/evm.c
>> @@ -22,8 +22,18 @@
>>   #include <dm/uclass.h>
>>   #include <asm/arch/k3-ddr.h>
>>   
>> +#include "../common/board_detect.h"
>>   #include "../common/fdt_ops.h"
>>   
>> +#include "../common/k3-ddr.h"
>> +
>> +#define board_is_am62x_skevm()  (board_ti_k3_is("AM62-SKEVM") || \
>> +				 board_ti_k3_is("AM62B-SKEVM"))
>> +#define board_is_am62b_p1_skevm() board_ti_k3_is("AM62B-SKEVM-P1")
>> +#define board_is_am62x_lp_skevm()  board_ti_k3_is("AM62-LP-SKEVM")
>> +#define board_is_am62x_sip_skevm()  board_ti_k3_is("AM62SIP-SKEVM")
>> +#define board_is_am62x_play()	board_ti_k3_is("BEAGLEPLAY-A0-")
>> +
>>   DECLARE_GLOBAL_DATA_PTR;
>>   
>>   #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
>> @@ -74,9 +84,92 @@ struct efi_capsule_update_info update_info = {
>>   	.images = fw_images,
>>   };
>>   
>> -#ifdef CONFIG_BOARD_LATE_INIT
>> +#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
>> +int do_board_detect(void)
> Can't this be static?
yes
>> +{
>> +	int ret;
>> +
>> +	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
>> +					 CONFIG_EEPROM_CHIP_ADDRESS);
>> +	if (ret) {
>> +		printf("EEPROM not available at 0x%02x, trying to read at 0x%02x\n",
>> +		       CONFIG_EEPROM_CHIP_ADDRESS, CONFIG_EEPROM_CHIP_ADDRESS + 1);
>> +		ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
>> +						 CONFIG_EEPROM_CHIP_ADDRESS + 1);
>> +		if (ret)
>> +			pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
>> +			       CONFIG_EEPROM_CHIP_ADDRESS + 1, ret);
>> +	}
>> +
>> +	return ret;
>> +}
> This code seems very close to what's already in board/ti/am64x/evm.c
> Maybe it's not needed before merging this patch, but should we consider
> reducing code duplication and move this to a common place?
it's possible but not sure all am6X board can use same function for 
board_detect and serial , i'll check with TI if yes i will do rework, if 
not do a common function in board/ti/common for only this two boards not 
sure it's relevant.

Guillaume
>> +
>> +int checkboard(void)
>> +{
>> +	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
>> +
>> +	if (!do_board_detect())
>> +		printf("Board: %s rev %s\n", ep->name, ep->version);
>> +
>> +	return 0;
>> +}
>> +
>> +#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
>> +static void setup_board_eeprom_env(void)
>> +{
>> +	char *name = "am62x_skevm";
>> +
>> +	if (do_board_detect())
>> +		goto invalid_eeprom;
>> +
>> +	if (board_is_am62x_skevm())
>> +		name = "am62x_skevm";
>> +	else if (board_is_am62b_p1_skevm())
>> +		name = "am62b_p1_skevm";
>> +	else if (board_is_am62x_lp_skevm())
>> +		name = "am62x_lp_skevm";
>> +	else if (board_is_am62x_sip_skevm())
>> +		name = "am62x_sip_skevm";
>> +	else if (board_is_am62x_play())
>> +		name = "am62x_beagleplay";
>> +	else
>> +		printf("Unidentified board claims %s in eeprom header\n",
>> +		       board_ti_get_name());
>> +
>> +invalid_eeprom:
>> +	set_board_info_env_am6(name);
>> +}
>> +
>> +static void setup_serial(void)
>> +{
>> +	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
>> +	unsigned long board_serial;
>> +	char *endp;
>> +	char serial_string[17] = { 0 };
>> +
>> +	if (env_get("serial#"))
>> +		return;
>> +
>> +	board_serial = simple_strtoul(ep->serial, &endp, 16);
>> +	if (*endp != '\0') {
>> +		pr_err("Error: Can't set serial# to %s\n", ep->serial);
>> +		return;
>> +	}
>> +
>> +	snprintf(serial_string, sizeof(serial_string), "%016lx", board_serial);
>> +	env_set("serial#", serial_string);
>> +}
>> +#endif
>> +#endif
>> +
>> +#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
>>   int board_late_init(void)
>>   {
>> +	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
>> +		setup_board_eeprom_env();
>> +		setup_serial();
>> +	}
>> +
>>   	ti_set_fdt_env(NULL, NULL);
>>   	return 0;
>>   }
>> diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
>> index 18ffc991b25..d42bdf1f074 100644
>> --- a/configs/am62x_evm_r5_defconfig
>> +++ b/configs/am62x_evm_r5_defconfig
>> @@ -85,6 +85,7 @@ CONFIG_SPL_CLK_K3_PLL=y
>>   CONFIG_SPL_CLK_K3=y
>>   CONFIG_TI_SCI_PROTOCOL=y
>>   CONFIG_DA8XX_GPIO=y
>> +CONFIG_DM_I2C=y
>>   CONFIG_DM_MAILBOX=y
>>   CONFIG_K3_SEC_PROXY=y
>>   CONFIG_SPL_MISC=y
>>
>> ---
>> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
>> change-id: 20251016-am62xeeprom-41a1920b8bd2
>>
>> Best regards,
>> -- 
>> Guillaume La Roque (TI.com) <glaroque@baylibre.com>


