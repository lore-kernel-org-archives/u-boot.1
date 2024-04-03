Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9609CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 15:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488F487EB4;
	Wed,  3 Apr 2024 17:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="M4UIV1Lx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E40087ECD; Wed,  3 Apr 2024 17:50:05 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264B588237
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 17:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd4H+4dTrIJTuR0cG63X8Mr1pNfPcHkhw1T73edfvwckGUuDVXF6qhdo/tQB0AqAueUYoJo4/reDHQspCUMhhZaCQsS87Ok2dGLryejl4LkojiLgSjc6BeWbNPyVTv5xptCBklrb4m52VmVYqnJ1N1n82iF2uuZfDpraoC1IFahwwdWMOYLMPgcJHN7LECqNU/zgfBEXl83tj+V7rvIwdk+9Bch5he8pR8UuGPZ4S2g4jzTIm3uOREP2+gNFy/8dRcD4900dHokihw0mC8VKETmuRTNNuhxWeQgObJShBkFJpD/vavIK5gWR2NJCOOREfn6KYnylLUgyxX55ZO9K/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnlyF8ijo8JRyheOpQVY3zFMt9VNAXlZuno08fYqYJk=;
 b=mWXElGmX0f53QrwZY6x/6enrSIhzxmgSSDxcd7gWknXfugBZEWckdeGYqoqhHIlrheRm5alIu1KwuJyUf1wxBoh/KHaZ6CotILPD1kPt75qt55ptvSRhtPIFIzVRS3tBfQkD2672SJHuKW8B3x4kQOkqYbz6xWMmp5bBTv9bRok1gFNJ4kTUIKVIOPa037hmL+NY8fhatxynVq48OzZmbGlruJhyTjIPI6uxnpZSYF1mL6VNdWBbRKwXWszkd3EBkbmyzbUuVYvZb67+K//wXftfWbs2QIyP72c7zQMroccrUJp/DKizGwyV21YL2Nr7Rk7Hmj+cYWFiCbYN+PTnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnlyF8ijo8JRyheOpQVY3zFMt9VNAXlZuno08fYqYJk=;
 b=M4UIV1LxLL8kucKuyrav3Kydt1JhsvFLuZMRNsbKNa14dBQk2d0XgYG+Fp2ufPH57A+j6nqDl6WbMQ0TSs1BNMiGt4MhgPP8Uu88pQyi//2fzkMX79ov53IQMS0Gs4jahluMLLEFgXTvYx4u2+sFLrEXa3Y4lPDhuUVzn2ECSL0=
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VE1PR10MB3919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 15:49:57 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ca1:4adc:e34d:58d2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ca1:4adc:e34d:58d2%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 15:49:55 +0000
Message-ID: <4a398e65-96da-41cc-bc02-fbf515860cdd@kontron.de>
Date: Wed, 3 Apr 2024 17:49:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] spinand: bind UBI block
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 kmpark@infradead.org, hs@denx.de, joe.hershberger@ni.com, dunaev@tecon.ru,
 sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de,
 tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com,
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <20240325144148.3738195-7-avromanov@salutedevices.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240325144148.3738195-7-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VE1PR10MB3919:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yq+qsVvV6nJAff4PatN1nHoz9Or/r682iB/1x58nVqkl6Oj3jq+jBzdb0SMjNl6kYwTI/JSe879kB8cgFhwRcn4C2/8dJ/v6H0B+Pu+XV04wW7D0/c5aPLhUlvksUg9CHRtqt9EHgRgpG9NH+vGA9hF+gaM3PJlvAS6ehk3mmMm5YRhu9asAnciW4g4NC5dD4cB4nOsLm8A5x3kbr+EBjxKJYRuZMFCToEOZIngRgUBNEw025VdqvdazStXjYP1EgUjJMFwwDrknXZ7Eh7XOwEW7d6k6jhwbmWiZXaPoyluJbLNlZ/6zP0rGEWI0ahvZpVQDedubbwIpryhvRQ2Da5MPUvSS8KWIFpReBSvmpENm9823Q0S8Ei3+6imFxeeB+THFPE/QclGdl++M47UCAEZjXY9ZAKmMwG9Cxktm8wjidNka5nlXETeX+Nnr7w3LFOsVwmEiZOt2c/2k11gYQyzPqNaEVLxbyVMNhi5lJd7M01FL4qenajReChDy41jtpZknPWE813fLRjv6VstBZPmAw82cj4SQSsxFOXSvzxfXsnys0OCt4bLhKy7kMYGMFxPDrbMOI0nMV5/mpIe5tKSaTdgse/N7o52GLsUvo7F7xl7yG+eicXPvT20S/h0lmQTCuFkc2bW9eTNq8qeSFciIUtYjvIiZtjNErfDiG1C+6zAvcgt9eXPPOwqtCMinmyTRY1DOmR13yTDkLP5QSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(366007)(1800799015)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YktldmdqM3BzVnRMNUFrR3VLZ0wzOTAwMVZnUTNpQ0RkQ2tFQnZBVTg0TGxq?=
 =?utf-8?B?NnNjN0Q2dGUwUGFmWmcyeHZZT0tET29lVDBwNzM4bUdldkdWWGgwRUtTbnQy?=
 =?utf-8?B?RkpERmpOQmdpWVJYRkRmUWhRRnpVNjcwRVBqR1V2YjRCSjZtNzVwbzdhMDNx?=
 =?utf-8?B?YWtveFNGYzJJdVk5S3VqL1hLcy9kWFNQalVSTCs1cjRQdk5QWm5BTS9iYlp0?=
 =?utf-8?B?Ym1jMkZ5TGZjLy8wa3ZabE9rQWRDZ0VHNkdNSmZkZHRLb1VMa2tFbHQ0QzB5?=
 =?utf-8?B?alNMNmdocG5iZ1dUV09LM1NweUwza2NRQmRnay9ldUR2eVVnOFNYeVY5UEsv?=
 =?utf-8?B?Q0pIZGhaZ1JwN2xDaEJTaytkZDBQY1FxYzJCS2l4c3dnVHZrQ0xSSzhLWmVW?=
 =?utf-8?B?WU5yNVdyTnZYZmZqaXI2WlZibXJYbTlOblNQcEU5V0U4UjRIdHNTVkNLV0R3?=
 =?utf-8?B?WVdWN0U4V0lVRm5LbjFHNWxxaTlCNzg3S1BzWEErWHBBL2liWFlQUEY3QTdU?=
 =?utf-8?B?b1N1WXdxSXE4MWYyMG5Cb0ptSWN0YjUvTXRSQlluMXBFTys5UXMrcVlUUU5S?=
 =?utf-8?B?d01tMG5nbDQ1UFBYTnN6MEhZZllEKzVUWjdGNTlSNXVqYmJWVDVPZnFsSytK?=
 =?utf-8?B?TjAyMzdVMEZ3NGhJd2J6WXZPWXRacHN1R0tnMDFSRC9aZXUrblhiOXlVN0Nk?=
 =?utf-8?B?ZS9jTzJUNituODdaUEs0MzcvNjRTdWxJNCthbHBORDJGS0pqNk9VU0dxUkJG?=
 =?utf-8?B?cEIyR0ZOY2NnbEhrcy9YMEtjQmFyL3M1TFlEZFEzLzh1c2ZqeUdtNU9VeHRP?=
 =?utf-8?B?dHNqQjFCV0JFWTlqU1JGTThPVXFoRTZwMkRWVVAxaWZsU21BQXNFRkVPQVZB?=
 =?utf-8?B?bFFZbzMrRjZZUTlVL1JuUlFub0hXZnhnNzgxM2xJRkRRYm80aWtYQnVBbzdR?=
 =?utf-8?B?eUJxUkV3aDZYa0NnQmcxMXFQSW9FZ1E5TGhLY0g4dEJ2SCtRekxMbyt2S0xr?=
 =?utf-8?B?U0N3S0EwRWNSRms2YTR2ZGpCOERJUldGZGdiWHVIK3I1d1poTmE1QThoQUVk?=
 =?utf-8?B?Q2p0T3FnRURvdkxLaWRMRkhLSlBFdEJKbFNsOFVSaUVvMk5NTlhHcTMvNGFq?=
 =?utf-8?B?SnpGaGFOQm9LaEtKdk9WSVJIU1J6eElxWTM1dm4zTElLN0xWZUdPVDlweDlQ?=
 =?utf-8?B?RFJKZFkxdkVwdW1HQXJKdHJYSncyQVN6RmxFUHJSd3F0WEcvbVExamNMRDEr?=
 =?utf-8?B?ejVldkxCYkJVZDUwSkFkeWNuR0VRVmV2MEJjVXhaUVoraE9iYXRaZWdUZkNn?=
 =?utf-8?B?alk2NXhRcUwxTHYwRkxaNjV5d2Y1TGtWWDF0NllPRHRQWEJkczRzVzNrWGNj?=
 =?utf-8?B?MWRTcmxwRlZCbzZGaWtUNU9NMFRYdVZzK1h0NXNDMXNXS3hBSTc4dlh2S1Vr?=
 =?utf-8?B?WTA2N1FyMys4VHVzSjBVWGEwODlMM1B0L2ZQYTR1czdTeExITUlWTlU3RTRE?=
 =?utf-8?B?U2NPK0lPNnkrMzlTdXJpdzZFVmNrd3VsTzdCOWJac1kxbGVrZFJ1WkNxd1Na?=
 =?utf-8?B?dWdjdm5uQ1R5VXN0enNOTUY0YkZUeWZ0c1NzcU1Zc2V0SEdJaGxPa29VVEFl?=
 =?utf-8?B?U1lXUTRoSVB5VGc5TFpPbndVM3N4eGw2eXJwU2FNUE1hZlY0SVlRcTZXVnJo?=
 =?utf-8?B?OVAzNnJXUU1zVDRZRk5uSVVBOGlXTjBqbm1od3BCSWpvS29MTklpaDF4bHRS?=
 =?utf-8?B?UG9pNVhCenhvRGdZeS9MVWZRRE9NanliRFRhaStqZmxKQzJsMnhwRVphaVhm?=
 =?utf-8?B?ZDQvalVVRTE0c2tzdXBsQkwwTjByQ3JQbW5jMEk4dmRPVWtITmxZdDl0aExy?=
 =?utf-8?B?WWh4VHZzNytGeDdTcUx3QWFUM3Q2bld4WTdkSlVYc2ljRUJONHlpM1FRUzN1?=
 =?utf-8?B?N3huamk2SFBQWnNmUDNEdTNNUzY1clowblFBemI0TUxGUnh0dUo2UkhFbFg4?=
 =?utf-8?B?c21CYVJnMnU3cWsxNWFrdWR3UWZhYlFBSlp2dU9Cd2JnMGo4U3dFREt2M2dq?=
 =?utf-8?B?ZmdiNmJ0Nnd2NGZlczI3Umg0VUY4VTlxQmdvVjE2eUZ0cnpoTlppTVo3blJG?=
 =?utf-8?B?Zi90dmxPRVhCdWF4VERSdzBNUDFJa1kzNlI2SnQrTXE1cFYyWmFzYXpmT29t?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a2196e-6fba-4e89-a353-08dc53f5b50f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 15:49:55.1143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkG/1WIHgExKjRqxAoDMPub1tic7Z0h7lJSTp2PAj2GR8ErrN1bEKXEKgVBUKDFYYxB+pWWfAB6K3EfAPbtE6Lpmp4DP+mz/HkkZ8BZpOgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3919
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

On 25.03.24 15:41, Alexey Romanov wrote:
> UBI block is virtual block device, which is an abstraction
> over MTD layer. Therefore it is logical to use it in combination
> with MTD drivers.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/mtd/nand/spi/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index dd880adf31..c47f6c1b46 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -27,6 +27,7 @@
>  #include <watchdog.h>
>  #include <spi.h>
>  #include <spi-mem.h>
> +#include <ubi_uboot.h>
>  #include <dm/device_compat.h>
>  #include <dm/devres.h>
>  #include <dm/uclass.h>
> @@ -1182,8 +1183,13 @@ static int spinand_bind(struct udevice *dev)
>  {
>  	if (blk_enabled()) {
>  		struct spinand_plat *plat = dev_get_plat(dev);
> +		int ret;
> +
> +		ret = mtd_bind(dev, &plat->mtd);
> +		if (ret)
> +			return ret;
>  
> -		return mtd_bind(dev, &plat->mtd);
> +		return ubi_bind(dev);
>  	}
>  
>  	return 0;
