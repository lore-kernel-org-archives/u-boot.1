Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB309CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5236984099;
	Fri, 15 May 2026 14:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PhseRrZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 670E484663; Fri, 15 May 2026 14:50:07 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C13583AA9
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8slqpLs+8o1LPH6+ocCRgSKDaEE1T5eZaJkmAYrixBH2Q3Id28PBQfYIUP3i9bsI+tRbYyQtkyDl3l1ugKMfTa0a0EpGm0PX2DGKFSisOqjGqKs65CL0pPUuIfIw6AGUVtnb8mOeY3x+IlP6lSmgHG9UY8tlr0a5NkTedAv/1TUmChxrmmL6hOJBc7S4TtGMplli4YdqE9mKYEMN5dqp8mi1VcjXhTQv9yQuahXEfHi4vrVSaJIUkpHlPGUFjd2NZqhEixh8BQu8QxqkxIhfgfEuOcXMm6Or2byYcsFLo47CzmHOTxqkHDjAqFdWErqpgtOElj4ORSQEo0EHEWLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dX3n7CEF/klRG1MiW4v6RIjtddVBVd2K9kAbIktetc=;
 b=wFclRCzIm8V5Dgt2HwhCy4Brdq9YW/bLOnE2bl08QAqe6IYstGkNfaevuj/zV5wmkQSob8qSUXvnfXRP8UbT+Wi6I6vOnVjhW/27Ot+jnJd9z3/OB/0aaJbNiv+u3H12EWeK1St5ilL7ZaN0n6V1oxbAsWt/RU5LPE20ZcTZAHWZz6Y0PfhooA9DMZxI/ckL4A6kEop/1IvOhqSs6JgP8Eo+Sga3LrLHkipmSxK/tFrkf8gZQv8Iuive2W92gPZ1TABTZ9I8xzw/h3DwwjaW+IISnXji3LiIGB7pXmCx9ZeHT4WZSh689WsZCH0YfHdyaeDtl749Ev7XIGJvKbTtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dX3n7CEF/klRG1MiW4v6RIjtddVBVd2K9kAbIktetc=;
 b=PhseRrZmBbsYRk4Zji1L2RRU4AVM1sNSZTn93hWsT9S44m1GaiFk/JkIizQ6T4yfNESjKXEWMclhrd39KAIzzmt9oDG3LrorXqdadsqfseIm0uzghupjqreh92Ak1tnpMk4rOkihGW78LgpMim6F2wiFeKsvy5webLrdyk5bQ9i4/PO1aiwJU8kxXlru+ztlwRVtJpbuqHl648Kb1ByizVgM38Nugz/TYzjzmDGM2bBD02zeLu3y0GQ6MfCCsqeyC+MovfGK++hOqxzbh9sO80kYAvsJCoDiRhyQNgiyW6MCkUBU5BpW8GplNUB6yOnQ4K6N4Z/TLdZdpEv5YZhdYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DB8PR04MB7130.eurprd04.prod.outlook.com (2603:10a6:10:123::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 12:49:59 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 12:49:59 +0000
Date: Fri, 15 May 2026 22:07:08 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Ye Li <ye.li@nxp.com>, ye.li@oss.nxp.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] power: regulator: Fix power on/off delay issue
Message-ID: <agcojGdjiWq8B25L@nxa18884-linux.ap.freescale.net>
References: <20260511074953.3777767-1-ye.li@nxp.com>
 <c60ea578-30e9-49c2-8d45-0731b9fd74b0@kwiboo.se>
 <32618820-7e62-44d0-bbbd-da90be7327de@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32618820-7e62-44d0-bbbd-da90be7327de@kwiboo.se>
X-ClientProxiedBy: MA5PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DB8PR04MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 4707d849-395a-40c9-1b49-08deb2807963
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|1800799024|19092799006|56012099003|22082099003|4143699003|18002099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: F+q6E4qj+RreLOtLsl747OVsNMMHtJRs+wkJDvIdtzepihFwcfQ5FkE5rK0kDsPj3KCVfKXJhdhHFIVV5JPLaOviwNZRxXGXDCUo0X2wtpHvOShguQ/K1/r0Crx8vLs4eLnIkJGNNx5OYwAIN4TTTIQzj19UlgDZMWF/p4ReaFJmhdntHZlS0QYtAShFLvPLntAg1s14gReh6YAVCZJJr3iXD9rc9aBxgVjSs19dG+9W1uZoAsUy9hahcXKQFcOMVGO+B45ChRVrAF9nPdfMiDOdCJfA2vqVugIlq7ePrLPMulQo+qaiqoTzm6F3FoAstiXDEcrfEhDWbH3+zSyraZsObj+HJqi36bXE7HEQCX9FZzamPsB5HC56cj5ShVhqZCW2/ApKXjaFuE2bGV7WXqxpScG7fDf8eQDOAc5hq8MLUwDoeLgRHUdv9xIeSIwRz1Ime70Th4sMhnRrre0ePCekHZahe9urCGZUtPpSTz4x+G3YROaL00EqWnBpAGQ8yhzYiRKaFse0YEquCWQUX2wRJATuLBiQaqNk61coZDzA7+TMA/CYz5AxYh/gc4BNY/FIvefdWZVwBG2jpGmsZ1ANpE3WY2tOC5eLNJOE939FcoswOiU1Ccbkk5NWjRK3IRyM+1oFh96WZdywFDFBhXyGYfm7BzD45zSdzCkZYC0dPJCWXQqiZUb8kZZe4MT9YyNcTr42O5WSVMjmWN0fIpn9nw3Hq6Na0syftt1ZPkUGBEu6tQzQ+coWLodySoTo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(1800799024)(19092799006)(56012099003)(22082099003)(4143699003)(18002099003)(38350700014)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lbb+jeLgu214ZZqmZ48CLOlDNobgyOqjvd9IiSGt0ViFrkbpq/QmXF5PK0TP?=
 =?us-ascii?Q?C4und24NsfWADkkfkgpA6EyVXxdTVVvk73VXKQCAg2cZ1FrObpXvVaREvHOV?=
 =?us-ascii?Q?s41biiYw9hfr1kqQg6uUhS2ajTCaKlalDzLF4qYuFgqP5n2r35s5D9SeZ3wP?=
 =?us-ascii?Q?QYD9RCaK/de4I8N2veXBvWcdhyBsjgSFqBugglCSNmRsPe2HCn+ebWGQGFPL?=
 =?us-ascii?Q?ehCOz5uurPO6eIGK30e2CVsVR07yRdWD0Lwz6Scin5Oon5Mibs4S14hnUS17?=
 =?us-ascii?Q?4durLQHek3IvWoqVTdWe9dBPaG3gMpDSvS9TGol1ehfYB0NWMQTIgwN4J6Ct?=
 =?us-ascii?Q?17UA5XUPIupaGzHIykcv8gG47cTZXl4mVyOU7sts2DfBroIXhkHaCoPyfljz?=
 =?us-ascii?Q?9wk7q14z/70QsflrZsUY12t62woqMv08LKJiN+QDZnLO3IENLFsCZ0+qPDer?=
 =?us-ascii?Q?7Gzn6ZXxxhgkKCTdk8q+qEGXbvMLUs5WYjXJTEHIIRY4PHwxPahedQSHN6dD?=
 =?us-ascii?Q?E3y/D2vPB+m+I2/TgQc5+mwaU3ybi/ujnWk5B8wR/8QRUqtvdJ2egLy5uPae?=
 =?us-ascii?Q?6MNxHoBLlovUyBwnMjlD02vlkkuDxvlLZmFKSK2+Mybp3zr96ygHreir/DE5?=
 =?us-ascii?Q?nx4+gJipR/EK5DJPcZ1aEAOD7NzKdowVCmUEvLpLZ2vBe8Rex63C2D5gftc6?=
 =?us-ascii?Q?PCE3xmYTOARSEX4+D0eciLlzLwLXCYFDcMQPGr+6DvQpPa5pzclY0VDm7Xc3?=
 =?us-ascii?Q?51nx/BZo4jMcalB/oMB/05+8gWjDeHjflWQKkSno4IPdAI3ZcNX2Qli+8LCW?=
 =?us-ascii?Q?Hi9/O2fmpcwDhawW9dfh/3b3Xyxdixz9yiw33C+M/eqX8GgC2cOvS2w6hcZC?=
 =?us-ascii?Q?kW4bCxD6M9zUZzs2AdVRJM0xRTnF59xyuMA18+koAO39QrRqFHwy2oJjfShy?=
 =?us-ascii?Q?a2k4wTPxZfkqdJ2uIrUaxO1HpGYGp8NSfSQliiKv75OEnmynEajuBzgolPlA?=
 =?us-ascii?Q?osZchOgIkJdUpA7LKz170rLN56CO0ELLpb6UMsYZ3KGGpxj9q59WWXGUniTr?=
 =?us-ascii?Q?mBykk14NUUP0LPPqF5w2rdLQPT4exSXu7m2WhWmhHXdKgcHrxbBcpcL19gYO?=
 =?us-ascii?Q?m5zu50biaTuSW0gekgp7lqlgUWOVLio7XdnWN/4jEIry5x03V9aSc9C65A4k?=
 =?us-ascii?Q?KsAhcJEOlwvrT3MKw4T5StC8thLZ//jwV5jzze8P2SrXCds13Yihmrshq0UN?=
 =?us-ascii?Q?Eja815rKGOu7XiXKykfMEuytHHhouG73l6Ji9qcZeqAa7mZeeyUaIUgZBmTB?=
 =?us-ascii?Q?517nOxHXWVXGKu115WRkqAzxrdamfoFyMqA+ZQEIwAkKiPS8buw/7z3bXH+i?=
 =?us-ascii?Q?7n/iDjU0a8WRYvsUrslZAUYcQbt1Hgm64q3svXZtks6boHNU7VgnZcPMZe3q?=
 =?us-ascii?Q?T/+9wyzYdQV2ogjmiZVn1h7bHZc1xatJSyew5ZfPOe5iM/how0Y+VsMDf3kI?=
 =?us-ascii?Q?DQT6VBiqnnASoCb2IXah8x+Yk+RU5qudOSX6v3T24BPyZOMf7F3mBdUvllWp?=
 =?us-ascii?Q?s5V5pC8rZRvGJ8QW+APfxWRMX2tGxY0bU+reMRwgu4ixKuAR/6KMGbDTIGMz?=
 =?us-ascii?Q?3g5BmcxZP8PEF5etAOC7Ds2HhmTw6RU2tJxFGlHr7QKKySjRt863PqtvxUeP?=
 =?us-ascii?Q?Pi/EDzpljc++Z/Pwa0LQr/v5IecBki/jTv46ZDu3xoDO+YHLmERRZmkHUz18?=
 =?us-ascii?Q?c9bcZrzN5A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4707d849-395a-40c9-1b49-08deb2807963
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:49:59.7102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ebZEZPFvYkGQKKjZcuCn/6i34LC/SHneCRN37up6e4pJb7Zw1JY+a4Oa87qiE4++FdM/VYTulX3oiCWET767A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7130
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

On Mon, May 11, 2026 at 03:10:16PM +0200, Jonas Karlman wrote:
>Hi again,
>
>On 5/11/2026 10:30 AM, Jonas Karlman wrote:
>> Hi,
>> 
>> On 5/11/2026 9:49 AM, Ye Li wrote:
>>> SD initialization failure happens with some UHS-I SD cards on
>>> iMX8MM/iMX93/iMX91 EVK after
>>> commit 4fcba5d556b4 ("regulator: implement basic reference counter").
>>> When sending operation condition to SD card, the OCR does not return
>>> correct status. The root cause is regulator on/off delay is missed
>>> in MMC power cycle with above commit, so SD card is not completely
>>> power off.
>>>
>>> When SD startup, the sequence of MMC power cycle is:
>>> mmc_power_init(get vmmc_supply dev) -> mmc_power_off -> udelay(2000)
>>> -> mmc_power_on
>>>
>>> Before above commit, as a fixed regulator, the GPIO is set as:
>>>   GPIO inactive (in mmc_power_init) ->
>>>   GPIO inactive and delay off-on-delay-us (in mmc_power_off) ->
>>>   udelay(2000) ->
>>>   GPIO active (in mmc_power_on)
>>>
>>> After the commit:
>>>   GPIO inactive (in mmc_power_init) ->
>>>   enable_count is 0, regulator_set_enable returns -EALREADY immediately,
>>>       so GPIO is inactive but No off-on-delay-us (in mmc_power_off) ->
>
>If the regulator is off at boot-on then this is working as intended.
>
>However, if probing the regulator turns it off and that requires a
>off-on-delay-us delay, maybe you are missing a regulator-boot-on
>property to indicate that the regulator is on at boot/reset. That should
>also align the enable count with boot-on state of the regulator.
>
>Looking at the kernel the off-on-delay-us is applied before a regulator
>is enabled, not after it is disabled like in U-Boot. Maybe U-Boot should
>do something similar, in simplest form always udelay off-on-delay-us
>before the regulator is enabled.

Yeah. Something below should work(Not tested).

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index 85af8d599ad..7bf25f6a176 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -68,6 +68,9 @@ int regulator_common_set_enable(const struct udevice *dev,
 	      dev->name, enable, plat->startup_delay_us,
 	      dm_gpio_is_valid(&plat->gpio));
 
+	if (enable && plat->off_on_delay_us)
+		udelay(plat->off_on_delay_us);
+
 	/* Enable GPIO is optional */
 	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&plat->gpio)) {
 		/* If previously enabled, increase count */
@@ -97,9 +100,6 @@ int regulator_common_set_enable(const struct udevice *dev,
 		if (enable && plat->startup_delay_us)
 			udelay(plat->startup_delay_us);
 
-		if (!enable && plat->off_on_delay_us)
-			udelay(plat->off_on_delay_us);
-
 		if (enable)
 			plat->enable_count++;
 		else

Regards
Peng.

>
>>>   udelay(2000) ->
>>>   GPIO active (in mmc_power_on)
>>>
>>> Add the on/off delay and startup delay after GPIO request in
>>> regulator_common_of_to_plat which is called in regulator device probing.
>>> So in mmc_power_init, after GPIO is set to default inactive, the
>>> off-on-delay-us is applied.
>>>
>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>> ---
>>>  drivers/power/regulator/regulator_common.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
>>> index 85af8d599ad..158284a3309 100644
>>> --- a/drivers/power/regulator/regulator_common.c
>>> +++ b/drivers/power/regulator/regulator_common.c
>>> @@ -46,6 +46,12 @@ int regulator_common_of_to_plat(struct udevice *dev,
>>>  			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
>>>  	}
>>>  
>>> +	if ((flags & GPIOD_IS_OUT_ACTIVE) && plat->startup_delay_us)
>>> +		udelay(plat->startup_delay_us);
>>> +
>>> +	if (!(flags & GPIOD_IS_OUT_ACTIVE) && plat->off_on_delay_us)
>>> +		udelay(plat->off_on_delay_us);
>> 
>> regulator_common_of_to_plat() is for parsing the values, no udelay()
>> should be applied here.
>> 
>> regulator_common_set_enable() applies udelay() when the regulator is
>> enabled.
>
>Or disabled.
>
>> 
>> Does your regulator .get_enable() ops not being called or does it not
>> implement its own udelay() based on parsed values?
>
>I meant set_enable() here :-)
>
>Regards,
>Jonas
>
>> 
>> Regards,
>> Jonas
>> 
>>> +
>>>  	return 0;
>>>  }
>>>  
>> 
>
>
