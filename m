Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D472C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 09:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7109D87861;
	Tue, 19 Mar 2024 10:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="QJ1h2j7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB9287D64; Tue, 19 Mar 2024 10:21:52 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC3187572
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 10:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoHLodfJVzgRFzIrJsdxh0ja3/HSEb+aJBUgU7Q/KAo41pt/uHsgqFLYmCgCoFFvY7LEb+3UDnz1F4t1UAZytGK9hNRmI/+zBEkOxXOPwfzIUGf9kpmu119r0ZwodVbUWmj7VjLEDWzeawA+LaSWOJFAN+0gCsNafv4bytz7WbGjwA9chgQzLXPyCZiidZNhFrtf6I07pI1NnWfL/R66GPd9lY4W9afJz3rbFgM9l7gdOil69TbOKalmxxwpSmBB+ogNMSVf2MYy1oSIQnEwzFQYhldDObjtXTJfLJ8WX9TN+dThsZydfURzbVAGa9JyPEP822hQxMSd0nXTy/endw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc0gLymolfRIto5ds9g79CM0ZxpF5fTCY2CFG5791Lo=;
 b=K8i3Bnz6rgBut5/G2kXB45S5rupW7xDZbrfVpYdY3krl2hTItGwiJGFMJJsZD0r9KyYYXAf4nKPvI4Q8wuVxAbD2EfNiah4nwpwwb33bhhNb1aFD9x5adopgdMZOen/XhsdPPVRVPYPELnBg2nzEvW4dqAivPnyj+WxNxDs920Ee80GOOtdt6u2ei8l24QXcGmZuztMJwP25HKhjWhPp3A4VE85uxwk6CaAkwSB9TceWwjF/JXvRs1Ru5/87BFPc+54CIk0N+8haMt3VuYdzOz9OMNVmOgDzLDUGQb5qYVXB0UezWmSQ4USo+OuI9tE7/Z+qN+J2BzMKacpV7tJ3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc0gLymolfRIto5ds9g79CM0ZxpF5fTCY2CFG5791Lo=;
 b=QJ1h2j7NnPhIdFYMvuOkCSNmyJ6BoO+J1QEDdupayn75SlhZTFW6vMYhNZXlzyyptxqitmTSaYFt3lroieyG11D60V/5q2X9cwOtcAqSCKYeMO6cFgOkw3Ihy+LK0OtkKefzUnlv5hcXajegkHIzLIYiSHNVHRwJUdB+SIsB3ns=
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PRAPR10MB5251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:291::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 19 Mar
 2024 09:21:46 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ca1:4adc:e34d:58d2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ca1:4adc:e34d:58d2%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 09:21:46 +0000
Message-ID: <c7d0f4b9-f04b-4e6d-b1f6-2c8e8d6002c9@kontron.de>
Date: Tue, 19 Mar 2024 10:21:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] spinand: bind mtdblock
Content-Language: en-US, de-DE
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 bmeng@tinylab.org, tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com, michal.simek@amd.com,
 mikhail.kshevetskiy@iopsys.eu, patrice.chotard@foss.st.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240307130726.1582487-1-avromanov@salutedevices.com>
 <20240307130726.1582487-4-avromanov@salutedevices.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240307130726.1582487-4-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PRAPR10MB5251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYHglGbS2EuHlrZSmKNuCzzZ1Pa/KLvjuVcek0cFI468qwto6oJPuBXlATR3hLnGukidDSNgOkauBbVmEA35Tr722gtMPDMjWgeDyZS3gPIDntzU3W7bzsBpStyWLFRvtM+W/8kzowfgOEgndjW2hwenKYsTkp6EiwpJ1cV1F3PlbVEdVF9ZxluhS62k1qw60K4rfwzt//NtNJXJHudheyyD3KNBNLSQLW+aDvAOK6dBvj+L8Eswkhfr0/a1UIpsnsG6ba9Favy1dC/wg2wyBX8I14WWGomVxlkq5IrzRpaq7OhD+wJIPlecWb5zHvuA/lRdnz4JdAAAnMCiHLX4Oaus+3tcF6dcPsa6S6VYTvqYUu4A3z0sBwhMPNm+oECsoFcCH97htWrRC5Zqit9+zG/lRVBHCQdkWRwtHhkxgoJgksUzEUc1DJtTtdHnMLV9hcq6lQcOAcUcLOOCwFCP9B86NbELs0ngNhbN1jqmNk0Cua04mKPAr+mjLgQOE3h4cTiErykIlxWc5jA8Sv03q3rR3T3praXtMKae8KAA41Egw2TNVrNr3M84jszvgq4z79dbOjgynFDbJBDvVvV/YKFLNtS09IyVulLld9GWY8ZLdxwDbR9vHbu89vyXc10f4MyKvzNBEU8neWx1k5ljT+aeD9TLqQs6CnFo/sl+IYOsKLsKaCNqqN2rMbufKONnAvt0adyAnRtnEn8MFYkW0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZOamF4cnJXQ3NqMCtSbnZNVmRyMmF1Ymp1NDNma2RueTdIZUUybnVDaEtG?=
 =?utf-8?B?VlpoOG9ucVh6M2UxaTJkNTgySmdvaC9QdVF3ZU81MlY0eUhHRm9HMEg4TkVu?=
 =?utf-8?B?Wm9YbDFFbm9TNXozcnBZdUdQWlBWcGwyYUJZalNnUk5rWmd2WmVNcnlqU1U3?=
 =?utf-8?B?Q2V0TTY0Mm9ucFR0ZUFSUjRuek1hT0d6VnYwTjdyZlluY1Q1V0hOUnJiVFBI?=
 =?utf-8?B?eWlOaW5Va0FLSVZPNzE3b0NGRmdGT3RhZGMwaWY3L1JhQzJsUVRwVjBtRk9h?=
 =?utf-8?B?UmhIdmQzQzhDNGRxZHhsRWxvcXFITFVaMGRQUmtkdjRDSmNUUXBxWXI1eDc4?=
 =?utf-8?B?YnRCTENUZzc2WWthcVc4cEtLcURYUHpCVm5TL2M3b0x6QjRJV25HNGswNXV4?=
 =?utf-8?B?TmhBYmdtN2VNZFp5UjFuaGdlSjBsZk1WeEZ1OCt3UUV1bE4rL3B6am5QQmRs?=
 =?utf-8?B?ZzA1ODhkZTZPaHJoTWI1Z25qR0VudytjMjRjMEd0dTlKTlMvQU4yL1dGQjdh?=
 =?utf-8?B?dUVxMmJhaVUwV29DMXArR004YVJ5QzRORGVmUWMvVytrcXFudW12Tk9HQk5J?=
 =?utf-8?B?UncxRjRaejlOeWFIWUF6TDV0cEZFNDdaZXA3YjJ2YjNoWXUxLzNPd21GU1Ev?=
 =?utf-8?B?ZUphaHFCVDlONnRjN0R6eXR1RWx0UzRYUHgvVHFHUUJGVDI4U0hLTnNPWXk5?=
 =?utf-8?B?UHNwS1BVYVhLbG5XanJnZUNXaXlsbHlsSnlFWGx3ZndGTFZ4WDh1MG5XMU5Q?=
 =?utf-8?B?LzdQZDZIeGYzVXNoMEwvaTdpRzllRk92ZzJOUUFKL2JZUnhjSXNwR05scDdZ?=
 =?utf-8?B?TUlpclhPdmYwc21uQnZFcVlHMnpNZ1owbzQvV25ZTjFTYjlNU1M3b3hjcVVq?=
 =?utf-8?B?ZnA4STBCV0NVajZYWEJFbCtRTEI5SHNVbXNMaHFNSE8yWFlZWVUxOEhqOGxp?=
 =?utf-8?B?dVRDbW9KUmJSVVhkbWJYM3V5R3hBYUttWHFRQWFsRXhBdVJrWXBlVXFOWEpJ?=
 =?utf-8?B?VmIvV0dhbG1aSmhnY0FKTW1QZ2IveHpBWStEdU10M042bE1ubkdDSkU4RVNB?=
 =?utf-8?B?KzMvZkZ5UEc3b3RHMkwzVkRMSGJYaDRoeTB0Lzd2Zzd5bWlnN20yazhSa09w?=
 =?utf-8?B?SzdrakpENDV3cVBrTmYvOTNvUmJLczNaVlkzS1RKdmQ4MlNQbzJvVWdsZE9J?=
 =?utf-8?B?TUxuVHZ1ZGU0WmkyN2J3WC9ZbE11Wm14aG5GbFN6bS9QaHc0VVFaRkY1UHFK?=
 =?utf-8?B?T1NTVHFtOU1KY3UxNnBRK3VGc0ZGTnB4aE5nOHlYVEpkcVlTSzN6WFA3MVJR?=
 =?utf-8?B?WDZSWTdtV0ZVWVkwcDh3emNseFlRcHNFdkxWWjNHZW8yWXREZTNFb1pzNkVN?=
 =?utf-8?B?alZIVG9JQ0lnL01TSHJHbjQvZzVGQWtzelNNRFBOeldlbHZQVDc5U2xCVS9w?=
 =?utf-8?B?VUN2eE5FVFoxQXdUcjdPZmpWdm5kQUpXWW91d216UW9yUTdGQTdwNkRyMGE5?=
 =?utf-8?B?ekVuakNsU0xZOEN3Mk05RW5jTVQ2TDFWYkVzNEVNRUg0T1JtWjlMYUR4cXFw?=
 =?utf-8?B?Tlo2Y0JpWU9UV2taeUppcWpTblFCOGw4cjEzZnRWcEZqZXFpcXI2N3ZqZG01?=
 =?utf-8?B?ZkhyOUVqbFQ0S0p4d0pNTWQ3UVlIVm4yMy9Od3hPbVRyazh6dVg2aGx1Zmpw?=
 =?utf-8?B?RjB6OTlwYmpNZ1lja1NGSXc5Nm5SVEI2QUxhdVMveERjN2FtYWE5UmMrY25L?=
 =?utf-8?B?MWZsK3BKN2N6UkM0ZnFqTjEwQy9MYSthQm9QSHpPNVRSUUQzUmRGZTZ2OTRn?=
 =?utf-8?B?U24yOElQYWJIR0VYMmxvWmFSeWdsYTYwdE52M0xsMDlsZzdXZkpIeE5jdndo?=
 =?utf-8?B?SlBkNm1IY1FFSytOc1VLekxBZUw3dksyWWF1SzFaWTlYRHlmUGoxbFRvWVdJ?=
 =?utf-8?B?elM2cStESlk5SElIN3YvZ09BSTVtZTFET2lYa1NhejczckowSTFoUDhqZlJC?=
 =?utf-8?B?eDdQNCt1aXZ6OXY4aXRIOVl2b21Gc0hGZEIyN1gzdWREQzhtL3ZYcXlYd2JW?=
 =?utf-8?B?aFMzdCszcDdnTHd1SXk1WjJ6dnVINFh0QUs0eWhTUTByWlVwRmdWNzJORjEy?=
 =?utf-8?B?RFkyZ0czbGI4bktaWmtSalFwYk5ROEFOMzVZc2FySDZwbHcvdXYzVDVxTkth?=
 =?utf-8?Q?sUoUm4/2Z2K5b+fQC/5vsxw=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1123de-27da-4b9a-1693-08dc47f5ffc2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 09:21:46.5100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ICbxpHC4I2R5ffWUat1j3YdPtXl2RRwUQUpa+TKiIAob2FOVdo2OPhQBTGBAK2L6rOy7EUQcMtJQ/GXPRkA9cADn1tk6faQWJ1m0b9ZXsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5251
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

On 07.03.24 14:07, Alexey Romanov wrote:
> Bind SPI-NAND driver to MTD block driver.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/mtd/nand/spi/core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 2a3dbcfcb4..dd880adf31 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -36,6 +36,10 @@
>  #include <linux/printk.h>
>  #endif
>  
> +struct spinand_plat {
> +	struct mtd_info *mtd;
> +};
> +
>  /* SPI NAND index visible in MTD names */
>  static int spi_nand_idx;
>  
> @@ -1174,12 +1178,24 @@ static void spinand_cleanup(struct spinand_device *spinand)
>  	kfree(spinand->scratchbuf);
>  }
>  
> +static int spinand_bind(struct udevice *dev)
> +{
> +	if (blk_enabled()) {
> +		struct spinand_plat *plat = dev_get_plat(dev);
> +
> +		return mtd_bind(dev, &plat->mtd);
> +	}
> +
> +	return 0;
> +}
> +
>  static int spinand_probe(struct udevice *dev)
>  {
>  	struct spinand_device *spinand = dev_get_priv(dev);
>  	struct spi_slave *slave = dev_get_parent_priv(dev);
>  	struct mtd_info *mtd = dev_get_uclass_priv(dev);
>  	struct nand_device *nand = spinand_to_nand(spinand);
> +	struct spinand_plat *plat = dev_get_plat(dev);
>  	int ret;
>  
>  #ifndef __UBOOT__
> @@ -1219,6 +1235,8 @@ static int spinand_probe(struct udevice *dev)
>  	if (ret)
>  		goto err_spinand_cleanup;
>  
> +	plat->mtd = mtd;
> +
>  	return 0;
>  
>  err_spinand_cleanup:
> @@ -1288,6 +1306,8 @@ U_BOOT_DRIVER(spinand) = {
>  	.of_match = spinand_ids,
>  	.priv_auto	= sizeof(struct spinand_device),
>  	.probe = spinand_probe,
> +	.bind = spinand_bind,
> +	.plat_auto = sizeof(struct spinand_plat),
>  };
>  
>  void board_nand_init(void)
