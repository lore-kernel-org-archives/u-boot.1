Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DB6E9E30A
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E8483CE3;
	Wed, 11 Feb 2026 14:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=muxen.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=muxen.fr header.i=@muxen.fr header.b="BhstQfcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C7C283A5A; Wed, 11 Feb 2026 14:18:33 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1D0802C1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 14:18:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=muxen.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=william.martin@muxen.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82DCB43A1D;
 Wed, 11 Feb 2026 13:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=muxen.fr; s=gm1;
 t=1770815910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auCDb1cRbUajU/6RP0sTXEFyJf/pf5jQnfCwQaNLat4=;
 b=BhstQfcO6e/PlOk9rl52FnL3jna51suWdxbg8Y4j2Y8azXuNKJ76MMIsIkCK3r564vafnK
 flYhDPiofanN+JwZMb3kHxShvgKdeRT1cqWcB3NWn9FRNahBq4S9dG3OQ4MWVN/6hPHpJU
 5F2Qu3sM+reabr6ii26PXICRcq0Rv2csIX13Px3Wsbrh56pvAaFFfSDYYX3rscmIAmEtkc
 kF6HudFWgHaJ/dKiBX/xANVLe6B5mCbLCTWC+FTLTW4vjCCqwNZGFe+TG+2pwVbqdtZYbc
 axMZFyuvD79kam0Ck3/NaED105eLosF191ZBA603E5+cO7IZqNz+NFdc0jWmQQ==
Message-ID: <97f029a0-ac83-42d0-87c7-fd09f88f1807@muxen.fr>
Date: Wed, 11 Feb 2026 14:18:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm: imx8m: add boot_device and boot_instance env
 variables
To: Peng Fan <peng.fan@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 herve codina <herve.codina@bootlin.com>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, "Ye Li (OSS)" <ye.li@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, dl-uboot-imx <uboot-imx@nxp.com>
References: <20260211103109.92178-1-william.martin@muxen.fr>
 <PAXPR04MB84597449572BC512CABC27CD8863A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: William MARTIN <william.martin@muxen.fr>
In-Reply-To: <PAXPR04MB84597449572BC512CABC27CD8863A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: william.martin@muxen.fr
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvieehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhephghilhhlihgrmhcuofettffvkffpuceofihilhhlihgrmhdrmhgrrhhtihhnsehmuhigvghnrdhfrheqnecuggftrfgrthhtvghrnhepgfdtvdeviedugeegveehvefftdelfefgveetfeejffevtdeghefhueevjefgudffnecukfhppeektddruddurdeivddrudefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeektddruddurdeivddrudefhedphhgvlhhopegludelvddrudeikedruddriedungdpmhgrihhlfhhrohhmpeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhrpdhqihgupeekvdffveeugeefteduffdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgsrggsi
 hgtsehnrggslhgruggvvhdrtghomhdprhgtphhtthhopeihvgdrlhhisehoshhsrdhngihprdgtohhm
X-GND-State: clean
X-Mailman-Approved-At: Wed, 11 Feb 2026 14:54:02 +0100
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


Le 11/02/2026 à 12:49, Peng Fan a écrit :
> Hi William,
>
> Thanks for your patch!
>
>> Subject: [PATCH v3] arm: imx8m: add boot_device and boot_instance
>> env variables
>>
>> Some SoCs have supports for 'boot_device' and 'boot_instance'
>> environment variable. Those variables help to choose the right boot
>> media during the execution of the boot command.
>>
>> The i.MX8M SoC doesn't have support for those variables but provides
>> internally all the needed information to create those variables.
>>
>> Fill this lack adding support for those variables in the i.MX8M SoC.
>>
>> Signed-off-by: William MARTIN <william.martin@muxen.fr>
>> ---
> No change log here.
I will add in next patch
>
>>   arch/arm/mach-imx/imx8m/soc.c | 72
>> +++++++++++++++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-
>> imx/imx8m/soc.c index 1fe083ae94f..498b565183b 100644
>> --- a/arch/arm/mach-imx/imx8m/soc.c
>> +++ b/arch/arm/mach-imx/imx8m/soc.c
>> @@ -1472,6 +1472,76 @@ void reset_cpu(void)  #endif
>>
>>   #if IS_ENABLED(CONFIG_ARCH_MISC_INIT)
>> +static void setup_boot_mode(void)
>> +{
>> +       enum boot_device dev = get_boot_device();
>> +
>> +       log_debug("setup_boot_mode = %u\n", dev);
>> +
>> +       switch (dev) {
>> +       case USB_BOOT:
>> +               env_set("boot_device", "usb");
>> +               env_set("boot_instance", "0");
>> +               break;
>> +
>> +       case USB2_BOOT:
>> +               env_set("boot_device", "usb");
>> +               env_set("boot_instance", "1");
>> +               break;
>> +
>> +       case QSPI_BOOT:
>> +               env_set("boot_device", "flexspi");
> i.MX8MQ does not have flexspi. It is qspi.
> i.MX8MM/N/P has flexspi.
>
> Regards
> Peng.

Thanks for your feedback.

Does the use of IS_ENABLED(CONFIG_IMX8MQ) to change boot_device from 
flexspi to qspi is enought ?

Regards,
William

>
>> +               env_set("boot_instance", "0");
>> +               break;
>> +
>> +       case SPI_NOR_BOOT:
>> +               env_set("boot_device", "spi");
>> +               env_set("boot_instance", "0");
>> +               break;
>> +
>> +       case NAND_BOOT:
>> +               env_set("boot_device", "nand");
>> +               env_set("boot_instance", "0");
>> +               break;
>> +
>> +       case SD1_BOOT:
>> +               env_set("boot_device", "sdcard");
>> +               env_set("boot_instance", "0");
>> +               break;
>> +
>> +       case SD2_BOOT:
>> +               env_set("boot_device", "sdcard");
>> +               env_set("boot_instance", "1");
>> +               break;
>> +
>> +       case SD3_BOOT:
>> +               env_set("boot_device", "sdcard");
>> +               env_set("boot_instance", "2");
>> +               break;
>> +
>> +       case MMC1_BOOT:
>> +               env_set("boot_device", "mmc");
>> +               env_set("boot_instance", "0");
>> +               break;
>> +
>> +       case MMC2_BOOT:
>> +               env_set("boot_device", "mmc");
>> +               env_set("boot_instance", "1");
>> +               break;
>> +
>> +       case MMC3_BOOT:
>> +               env_set("boot_device", "mmc");
>> +               env_set("boot_instance", "2");
>> +               break;
>> +
>> +       default:
>> +               env_set("boot_device", "invalid");
>> +               env_set("boot_instance", "");
>> +               log_err("unexpected boot mode = %x\n", dev);
>> +               break;
>> +       }
>> +}
>> +
>>   int arch_misc_init(void)
>>   {
>>          if (IS_ENABLED(CONFIG_FSL_CAAM)) { @@ -1483,6 +1553,8 @@
>> int arch_misc_init(void)
>>                          printf("Failed to initialize caam_jr: %d\n", ret);
>>          }
>>
>> +       setup_boot_mode();
>> +
>>          return 0;
>>   }
>>   #endif
>> --
>> 2.47.3
