Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5101FCD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF25383FEC;
	Mon,  8 Jun 2026 09:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="L42dNFIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2614A8405A; Mon,  8 Jun 2026 09:13:05 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD5B1807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 09:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgJJpwrVEoKhlCQmEjQ0HPuJr4L8ujY4cr9nbL/vT7t/HJcpJKqn/DxNKFOpPWGSv8naRPN3WzS9B7G4dlLSJZFLIZ1On0KKnvcWbSFG2d8lnAVZRgF65kP1zf2SyGoG1RSxX4gNY72Co0yEsU7sr8afRj0TM8DBNLnoEXerMB1VlSawivrlwOCx3sQgHzIlNN1DqzfOUJLw1i72PI0OUGkQiHKEc7QRqM79V6h3cL8dTi7w5uiAp88J5Tj/BU7fOS6+UrGr6ngSgVrfdlZufDu7Oe4PNkwg/BPn/7V7PUB4o9x3kXgNJh14tyTjensGKPoRNivJzWpJYB2X6XRFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdZcuvfZi/L0WjatlVMHGLfzGRpxTAasTtfJHicaanI=;
 b=TVIOusHITa8VvULkag5jBZX0s4M52hGqWE7q6tLDnAiDSn2+aLt607qLFSONxPqpfycTXLzAUPRq+6U28sLK3felfpHMRiF8U/YI53IUQsQyNLOc6lz2/9/v4KB8at6TsTmX7/XscCfxk1nTPhPLZo0kl/flKkMC00vokD+T4fGzJ1lq4Yz9aZPKa0/lfIC9tnlboJpC9TdMlzb9fN1Psnoj4SeiKatKbuFWk9v2a2vd8sgOVeeoqRCqNaAKZITpM3wNc+fp4Fy4/n5rjyslnnGNZtjJm/l2MmGp8pEgh96eoBPiGuXQtT9iyKL3NNNTtx+BzlqgdF4s4e29TwZBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdZcuvfZi/L0WjatlVMHGLfzGRpxTAasTtfJHicaanI=;
 b=L42dNFIOOe9a/j3d1yM9oXmRIonFaMZJMKuwEf97aAxqR8sat1u5BN3SzcTJPEoRtsNZ80D8h+Oc7jAOBr+D4RqHjRuUuW82AWwN8GTYkp7vA7xemjP9YSAW3jEp9nmAnYvnP9boum0S1yYQpGymA7/gCyzySoj08QFIhZj0h6DxZV4i3sCrtcGFSrxHyVBkq7f4dgWfuTwry9GWvThSdmIi1Dz3U8ynnWtBIFfSTb4FnkmcnMNygRPyMElXfOkRGyY3T6bqpdvwIq8qh+z074xb692YOIkuPbYnKy4N6K1uzc3zjpWpIEs4iMS9zpyP4NFJX+AzyaZH6QnXaaGvmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GVXPR10MB8946.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 07:12:55 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:12:55 +0000
Message-ID: <f085873b-ce5b-4ac9-9a7e-f4edbeb8491a@kontron.de>
Date: Mon, 8 Jun 2026 09:12:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: spinand: core: fix Winbond W25N bad block marker
 (1 byte BBM)
To: Zunyi Hu <roberhu001@163.com>, u-boot@lists.denx.de
References: <20260605152347.684-1-roberhu001@163.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260605152347.684-1-roberhu001@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GVXPR10MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdcdeb2-428d-4290-6ea9-08dec52d5c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V/dO4cg5AzLtK9rU8NVrjn/VuFnxzUp6ah50eb631iGADmBBUCGX0dIMF329EKA/EG0i6e0dLkcawrK0QDrcdFEp6RNhSPJRk64/i77I84U07SLnn+97iiA7lAFYnN06xgLl/EbrBPic06G5nRZRzClXCf86FsZETqKjwfjOKy8LsR9ePn60Cizkhp0Fsu4CbsgPATAYne1L64YZxxzt8M/r9sN+yzUCAh0BSmzQ3/Mn/YH0g1dNgJmDffwU74eSAbKMCwQ+r40oOXQUxfj8hsdweRrKh5oDgtzP6C7vlISMoJ1ibO5QsLlL3cHeagQ9lHoJ6eT54OFb8qlRle5xIwkFrKvd6pB+ByMGSOTnsaJQju1+I49AJsUaPndkhcKkUTL/4DVxVIfrNFD8dpvJ6FFfxjyfLxm4SS46Qh9Yw3T4qOFCF6mvef0gVy3B8irNYM46+JXPq4jrX+q0wwBZZCCXSj5gK9pDCbRRs12SsTQjCOdSwdnsVGiJq/pZjOA3XOvlBE6BJOV1tBE/jKyMWrgVfCQc6MPgoKX9BZYcyLpIPx9sy/PDh8Dr6Pj61ERneJ2I+d6loiJrpcu+mqFjfCkLVZzEVa3Kbi8mcRhR4CnWuW+LzCdljv+VKtTe1eReJfyzYT5HFiIE+WE21ZYCDlENs3wmltSU432I1A3ajUrvaO/k48gYgRPQblg76Ugl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THlySzV0NE5VWmxVSUxLV0lSdmpwMFlCMkdDRWw5VTBLYlN2ZFY5cUI3cXdU?=
 =?utf-8?B?Kytxem9wRmhzREN3M1E1N3I3R2lmMzZrYm5ZaEVDMHpDeWlRejFYeHd2YlNP?=
 =?utf-8?B?Zjltbm5DcHBoaVhuYm9uc0d6TTZpanduQXRjSnJGQXFHaVhEdE9SV2NBaEFa?=
 =?utf-8?B?OHM0RFpJNHNlRGk1ZEhnT1kxNi9DNCtVVk5ZV09lQjJaUysrcndyaXdzTTZL?=
 =?utf-8?B?d0todTR2WkJsVTNrZzJoNTErNlNxRkR3bWxVU1BDdnZFUTg4MnR5Z056Ym9D?=
 =?utf-8?B?WlBvYytkUVZCby9sc3BUMTVISkVFdlVUbWlHZlVadnlKcTZOVm5XbURJWkhz?=
 =?utf-8?B?ZHRxUjFWTU5wSlcrOGwwZUtDYlRWZTJzaWVHdXF4d0h0dnFlbFk2aTR4OU9V?=
 =?utf-8?B?SWdXZEZsVEJNK3NJN3RzcGZYMUlid0srdlVxYkx3ZGx6bVZHVDBJUTE2Q2x5?=
 =?utf-8?B?YmdPRG9rSEk0THFOcGVVTmh2MVlyV1JtOFFWWWdlblBQenY0VXlSbWg4RWZz?=
 =?utf-8?B?SUlSNVZyVElFREJyTTZ6Q1lEY2ZDMmdONnN5NEhuZFJ2L3dxQjkyOFJRNHly?=
 =?utf-8?B?dkZCVGFva1NLeDhjV1NMcTZpbTFGV3kxTmh4V29Md2J5MjlScWlEWDFSYm1I?=
 =?utf-8?B?R3VSWUFmZ3lCb29sb3pDbWxsOHNKQ3I2YjJmN1ZIenRJTHJGNnJLVk00NCtJ?=
 =?utf-8?B?QWdNQ1huYmlCOUFmUmx1eUcxQ3JYbktoV0hvVFJyNTFRSWNuTnNnK1pwUy9T?=
 =?utf-8?B?ZnNkT1hNeWMwcDVrU01hZG90c29UcUlqc1F3YndUM1hHeWF4RTFmVGJ0U0d6?=
 =?utf-8?B?SllHS3FaL0RMS1dicWdKY1ExSHBsU2tMVDJiNTg5aS95Q0NWdmx3WkJVMndF?=
 =?utf-8?B?L0dBUWhUWk4zbzcreTRjdlpCQ0FzNTErYjdVZEZMT3NLZ21FQ2JlT2FzaVRG?=
 =?utf-8?B?aFhKMnFJbW9WbDdQMkI4RU5ocDhjZXoxeXFNNTN1cHNxMkNDTHdZbzJpcndY?=
 =?utf-8?B?U3JFa3RzSzRyL25tcFlic1FmbXV0MWg1Y01kcmZPcXo2dlExdE1iL3gvT09t?=
 =?utf-8?B?QmZiRGJBeUYzWjh2NllhWHA5U1o1d1EyYitmblI0NzZXOVNZNWFoN1p6UXdn?=
 =?utf-8?B?ejZ5cFpHU0ZwYmE5VGRZQXNaUjEzbWhLYVc5RlJjQlVsMWZXSTNsUE9PaXJW?=
 =?utf-8?B?WDhXb1JoV2gzS3pURDFIZm0vZHlKNVF4VFJ1V2xneENqNDlRVzA2SCtKdW9i?=
 =?utf-8?B?WklZdWxhWTBSUTZYNnZ5eWpsbnMzRnZDUkxiWk9WWEZvR2RUdWpmVXRJSXBU?=
 =?utf-8?B?T3MrWkFET3ZGbDZTWkI5dDNicW50UVhma1ZZTzBoTFFKOC9OYnNLUk1qQ29j?=
 =?utf-8?B?ZlpLMGNEM0RMczVVaVp2VjUyZnJibGYvNmVIQVNhZzkrVUdqdXpjNktPRUFW?=
 =?utf-8?B?c2ZiNm4raWNSZkk5TjdSNUFnRjNiekRNSW81SXVUMDQxbG9zYU5ZQ2FEbFpH?=
 =?utf-8?B?bElHSjZlQjNvWDBNZXBGczR0UUlqZk9CNGJIRzdOVGswS2FzWWN5TFlLU0Yx?=
 =?utf-8?B?aThVMER0TG9BbmZUN2l4V2dCS0dIUWJCYmxtZkpjZ3hxbjlrKzZEYUpOdWhS?=
 =?utf-8?B?TXI1TkdEWG1ad3hMZVNRczZITEJOMTUxT2F3K1BBdUtsRVJOSlZ5OEgySU05?=
 =?utf-8?B?TDhTLzNiUm5EdEtZN2tBaDQ3bXM1NU9jU3l3VWJmTW9Mc2xJZFVGOXBBYXor?=
 =?utf-8?B?YmVCdWgzVm4yYWRzNEFFRG04R1YvSktUZXM1bCs1OFEyM3B1WXBqWkl5QlFt?=
 =?utf-8?B?bzF3WGkzSklMS2VKUHp5UDQzSlhsV3l6NS9xUTdnTTlsSnJLR01ObTkvM0NR?=
 =?utf-8?B?WnBNdDR2dG81aVV1Q0VIR0JxM3VlRXZSNDQvRk9ERWNZSGliV21xd1h3MHY0?=
 =?utf-8?B?djMxVk0xUTlDTDIzbjRwemErUkt4eDV3cU91VHdFYi8vT3AyeExvQlEyRmhs?=
 =?utf-8?B?MVBKRWl3MFlxb3U1TzUxd0RuNE04Lzh4NHVnaENmTlhrQ1R2TitOdDV1V0NN?=
 =?utf-8?B?VE56U3VrcWZRNlhaVVlQQ0ZjalJDU3ZzNzhUOTVaTzY3eVJSMWZ3UE8wdXgr?=
 =?utf-8?B?azdPUnJ5L0tJNUpYemxHdEdWMGVrVEwyYTVGbmRaeENzaVgzQUpFMjhUM090?=
 =?utf-8?B?Zno1cXhsTVcrUkVOLytRcnIyN3pFc2RNQ2h4YWtPKzJuWVlpNXpuTU94WGg1?=
 =?utf-8?B?SnhOWVYydUdEbGY3WVFUeEROTmwwaFpRbEFuWXVkem1wVlNxdmdLcmxObllk?=
 =?utf-8?B?YU1URXdEYTVDSjlDQmM0cmtKWTlub2p5MC9EVnZrVUhlYzh2bHVpS2Ntamhl?=
 =?utf-8?Q?cnUDftdB8oJv4b3k=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdcdeb2-428d-4290-6ea9-08dec52d5c95
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 07:12:55.1877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWlBCXF+4Q7ZXY5X1n+djnp/zYLyfQ9jx7+jEjV33qzONtvKms1lDDxTlgw1bDGnd60qZnu0Q6XdkyZQ7UlsS5mW1dqKCwDtCf5QZyExeK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8946
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

On 05.06.26 17:23, Zunyi Hu wrote:
> [Sie erhalten nicht häufig E-Mails von roberhu001@163.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> According to the Winbond datasheet, the factory Bad Block Marker
> is strictly a single non-0xFF byte located at spare byte 0.
> The default spinand core assumes a 2-byte marker (byte 0 and 1).

When I look at the datasheet for the W25N01GV for example, it says:

A “Bad Block Marker” is a non-FFh data byte stored at Byte 0 of Page
0 for each bad block. An additional marker is also stored in the first
two bytes of the 64-Byte spare area.

So checking for the first two bytes in the spare area seems correct.

> 
> However, after programming, upper-layer file systems (such as UBI)
> may utilize byte 1 for metadata.

The OOB layout excludes the first two bytes from being used by the
software. So if UBI uses these bytes something is very wrong.

> The default 2-byte check leads to
> false-positive bad block detections on valid blocks. Introduce a
> manufacturer-specific check (Winbond ID: 0xEF) to strictly evaluate
> only marker[0].
> 
> Signed-off-by: Zunyi Hu <roberhu001@163.com>

If you want to submit changes to the logic of the SPI NAND drivers,
please also submit them to the Linux kernel driver. We want to stay in
sync with the kernel.

> ---
>  drivers/mtd/nand/spi/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index e5330958c7e..5395a1bdf68 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -676,6 +676,17 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
>         if (ret)
>                 return ret;
> 
> +       /*
> +        * Winbond W25N (incl. W25N01G/GV): factory BBM is a single non-0xFF
> +        * byte at spare byte 0 (see datasheet).  Byte 1 may hold ECC or file
> +        * system markers after programming — do not treat it as BBM.
> +        */
> +       if (spinand->id.data[1] == 0xEF) {
> +               if (marker[0] != 0xff)
> +                       return true;
> +               return false;
> +       }

If this is actually needed (and I dont't think it is), this code should
better be put in the manufacturer driver (windbond.c), not in the core.

> +
>         if (marker[0] != 0xff || marker[1] != 0xff)
>                 return true;
> 
> --
> 2.17.1
> 

