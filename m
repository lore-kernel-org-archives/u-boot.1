Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3895EC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 14:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39CFA86FAE;
	Tue, 24 Oct 2023 16:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="WNDmrlP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F6487969; Tue, 24 Oct 2023 16:32:33 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12BBC8795D
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H61gpKRxtaFYS0fYKsfg0YeSvyz13+MFCqGqSaZ3WSIjYkGj177y6gDNaARixY0QImXf1zIusUeOhRe93SveguUdjZUg0XVf9QMUVvQtRVSOZEFeXSCDBpdHU0bZ+0X65tzNcw3ei2hCWJ4BPxNBjbzNB1Y0zaAKQdS3r7jIEqz0d7Tfzh9tu6+Gzm6S3pfct1A2UGn99ORZxTVOHUMCw06DRsIzv0uVaOI4wp/AmKsLB3bFDBfRlXpCliQv6NwjcBKc9V9uLWntRMHnoQgjqD2mSCEJwPqYZ5V+xE5lTCQR9rVfNr+Zc/4ogJY8DLhhneuwY2rbn4YNXVAhcI/mDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rdus82OLPcd1oa10xxfgy2XNKYl0H6lvRpm6gAWIAhw=;
 b=Ugs3DANvB3/PQvKGXzRLtUsvDYUYFO6JnbQuR2J9yx5rgjkWMFpH6ppEhMcGLjh8VQn3jetN+sRAQyeDwXn/BdkCsjEDEDkAsWoyurC4+TMP2/A1Zzhe574nO9hbj/Ifg0xA+qNG86nF+35QJfq4252TM/+L94tXr/MYD6S7uoBO/26PgBsjD/26BhyFn/uRnXAAIXbNNf2NdUHSNAxWvPNlxVwTzyyIY1SVVUzWBN9UeIhxCqg1gR7/qPj+jJ6zdK76WEgMPPZ4L6WuwqrWT6hB56tG5CIig9tAm/LZolDOMjGjpSD3FDXlaFLkXjwFmNTDREWssRorDEOXc6vt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rdus82OLPcd1oa10xxfgy2XNKYl0H6lvRpm6gAWIAhw=;
 b=WNDmrlP8qzBSxGGwrMjFRLNPaWbGn/rPImncpNj1LokhL1p++PfP9/BEgRHIlmq3xNRzacmtJdWkE53RqT3G5e7HBPdgIS2iJsN/x7plMwLriuRdVg94nIzhDyRpN603XQc/KL2p2XsS+J5+0xRdl0SJLgYzgMdX1phLxa9I9qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7325.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 14:32:29 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 14:32:28 +0000
Message-ID: <4faf5846-9aa8-4396-84fa-8d36c9b4fef9@prevas.dk>
Date: Tue, 24 Oct 2023 16:32:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] imx: spl_imx_romapi: boot loops
Content-Language: en-US, da
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "festevam@denx.de" <festevam@denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
References: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
 <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
 <1f86cfc30009f2a04c131ddc06a1d8300dcb1453.camel@toradex.com>
 <e4821c38-ead6-4a51-a442-2c782e638024@prevas.dk>
 <2832e90451ce39c3c7cef34ec5d5c20f02d3a652.camel@toradex.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <2832e90451ce39c3c7cef34ec5d5c20f02d3a652.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::27) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c83ee5-2411-4aa3-2cd5-08dbd49e0cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJ/DaC/88jbyU+h+yRhzncHtq9Srddyn1PJ/KMX3ks8z14PQj64vSrn/cxB6nMTasbi+RVrci+2LGTTKTv1Hj+cHnvxs0anPy+Srq99DaoQDbUjzhr/kTg99AaNd2s0TT7J7h208x35YtUGMJrP2g41ZaCHDQO3p3wuf15Y0Z44b+qar6TqhkNlkNUTr2bZRapiv7LE57PcH++ff6TNRH2r/lVIqWHThaDkNHzrKEbT1Pxcz/P9oR68Z5+hQqdPFH2S1encVSM20w/VRbr6xMrr2Tx8B1LRi4sIEHxGz7dn+tYFJt/DIXfBCvnlsDahOc//tXbxtxnx+e0SM+QX/GAcDGKennWvjUnimBjJk9JZjL8Qq2CbdHClFK/NHSp2xh7d2IARgExvV6JvLU/fkoKrTpTTzzf3QWoOD8cJwpzbSkXV4HsJvaz5yMJO/TDQzdnLEnuNsOhx9dVVTUW+W/68/7nLYwoYjLTpnWnlTCUnwpGiGQNN2J3Bul2gq+LWjBJkrzBvJMbEeLPNqzsykWvb1QHUzp1qdZj+ixEHfYsFyxzitAy/Ap7tpTfx1W4Qh6KhWCrPyqMM5SY0YfHZ8XHa1PJ0j9TEREOWf84UAVVKXUM+yEWRg4pmGyPGNuuBdfA9UIynveqSJcA1U0x4pNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39850400004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(38100700002)(54906003)(66556008)(316002)(66476007)(6506007)(2616005)(478600001)(66946007)(110136005)(6512007)(6486002)(83380400001)(36756003)(4326008)(86362001)(44832011)(41300700001)(31696002)(5660300002)(8676002)(8976002)(8936002)(26005)(31686004)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDdLVmtWMXBGQ2FEZ3BuRTdQbnRGTmRtVzhCcXRjT20yaGV6RWtRbWFmYThP?=
 =?utf-8?B?RUN0OTRpRmIxTnBNKzF4S3diOW5sMnc4K0loMDJoaWg1NHFOUHduRFZUWU02?=
 =?utf-8?B?SXVucmpsMmFqMjBPM2piamgyNmY3Yy9iY1NZMmxrVXdwVGNPZTA3MWNMQUY4?=
 =?utf-8?B?b2l6NXRDVmdyVjZUdzdTNzVnaUpHRmZxN2RheWlSdCtXVU82QWtTVDVWMG43?=
 =?utf-8?B?bEEwc3Uzc1B0MHBtYmZVdFU4bGFmemJRWktkb3BpUnZ1ZHp0ckN2RlFLQ2hl?=
 =?utf-8?B?UllQZTNiV3BHUUNtN1dCejBBU3FHbWVoSHNYK0srMitjTmFDWU42R01wZEdQ?=
 =?utf-8?B?ZHBDb2RvNkFDc2dEMDUreTN0anFveHhJdUFFQkRiTkNpMFVZVmxPSnZtcGxo?=
 =?utf-8?B?ZElSaUx1T041UVNtSEUzcmlyb2NuL25YMTJGSlMreGxJVmJQTVFTaVI4NG85?=
 =?utf-8?B?eW9LRUFaSWJuOUhOUHVVSVdXcGdXcGYrbktvRit5b1UrcWYrTEF4ejFWUWh4?=
 =?utf-8?B?YThQd1grTnpmeTJ1S0diYmNjd0liMEhwemp5MkkzQms1ZE5ROC9ES0VVZUpi?=
 =?utf-8?B?RlVNWndGZHBSbUQ0SE02R2V1Z3dFUktqQlJZR1crN2N6WmlNNGVPVkdLcHEx?=
 =?utf-8?B?K2IvemRiYlpuUklTL0FaaExuMG1ubExMMUpsWkpkZlh2d0lWR05qT2FIRDF0?=
 =?utf-8?B?OWI2aVRidER0czBWNzJUR1hLYUY1Vnd0dUVMTUFZUVpuUWV1RC9acVNmK3E4?=
 =?utf-8?B?cXIrSThiVEdYRUVSMDhMeS9sdmhSalBTS1YzejNpUDBCQmtkRWhreWRyeXpY?=
 =?utf-8?B?b280SDVseiszb1dWS0dVVGUxd1ljdHpTS09BN3pXWDBZQklFdnFtU3lSOTFn?=
 =?utf-8?B?SEp1N0tVVHFUT2RLbjY0ZUZNL0FjSnJNMGRDYXUxbHg2QzkvMXVsZWZmcnRi?=
 =?utf-8?B?bHhmZ2JOOXE4S1hyUHAwUkhpcFl3MjVPUW15Tys5bVBScFl2NGx0SkdzOHhz?=
 =?utf-8?B?aEdCbVpUdGp6UTFOQkdQb0FBU3JLeUlSOGg3a1IwNWU2cVFlekNmUGErWWs0?=
 =?utf-8?B?OE9wUEIyREZUZWt5U0RNL04wTTlnL1dncFc4cnljODB1UFVFVHU2OVVtYXJp?=
 =?utf-8?B?VUd4dnhZT1liSGdUc2kvS3NPTUJyYWYrckNIZFB1dGVFTlMzNkY4dUd0WDZ0?=
 =?utf-8?B?R2UxZlc1ZGZpK2NyNWJVRWlVM01HUXY3aVBNSkplRDRiMVVDcXRuSGl3eDJB?=
 =?utf-8?B?THh6K3JqdVBmTWpnRmtNSGxZSTlpTTIrL25Ea1JwQ3JoK3BsM1pLcm56YjVa?=
 =?utf-8?B?WHBaaVlnY2gwVTVjVVVNTitjWEFPa2NtWk96YUlBaGhSQjZmcy9qbURnTndl?=
 =?utf-8?B?WHpWdmVWcXpXSjc4MWhsd0g1WUJqQWtYVURldldyYnV6bER1cUVBL1JlY0Vj?=
 =?utf-8?B?NzEvM0xoc0NnQk15aXozaHNMd3RGTnQ1eFdiZGJ2NjlENDZTS2xCVWJyRy9y?=
 =?utf-8?B?Zk5ianlFNXZ0NDQ4Nm82cmp1ZElWUkxBSGpOZDMvVGVqUm10bmp3Ty9KRUVB?=
 =?utf-8?B?NDdmRkpiM3FSUVJGdW8zSlVsNHdZZ1UwOG40Z3o3L2lUZCtMTktxYTI3U3ZF?=
 =?utf-8?B?dkhkZU1YaHpEOUlJMmxnM3c1bGlxMXFZazBTUTY0Vjk0SmYxeEhSU1ZhMUU3?=
 =?utf-8?B?ekFqVDMwMkE3d3o4OTlRSEt1UHptYnk4RVR5ZzJ6RCtEa3lLTHhtN2NKVVhQ?=
 =?utf-8?B?ZC9EUVhkamxydzZEeFJKcWNqcUk4NUtMTzdIY0tkMkFYTktxblNzTENjdXB6?=
 =?utf-8?B?cVVJbURtN3IzTm1ScVYzWC9kTWMwdlhPNk1LRE95YzI0cGQxT09iK2ZOSElZ?=
 =?utf-8?B?VDQ5cVQrbDByVkRCTDV2UHBZUk1GUWR3LzdrY0JhNkFnWXl6MkNIQnJUMnZ6?=
 =?utf-8?B?OG1oVk16WVNCSmhZeVFacFRPNUxpbUZvQ3NTeUptYkI3MFZYQWpXNUF2RzVv?=
 =?utf-8?B?bWN2MDErdllNK3FMakNjdjQ1Y3lQeXVyMlJJNFZkUTc5bjNqTzhDOWZlUXR2?=
 =?utf-8?B?UTJ0Vzk4V2xOSXZ1SE93Y1ArRW9Yd3BsSys4VEF0eU9BQnJSV205OHNnbFps?=
 =?utf-8?B?TjBvb0NlNDQ0U2ZRUzlGVGRxYkp3eHB1UEF4bjNWN1B3emtuazhXWjIrSnU5?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c83ee5-2411-4aa3-2cd5-08dbd49e0cc0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:32:28.8062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmvLHJTRSOJ1DLqUswepCGYIvRbQSuspnkJYL0vrSvyREah45iEVzNWXVxjpkz9NoU6a0gxjydWVZ7dvC5AgDW8AmC4Qe9uL2m/zJwgQRFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7325
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

On 24/10/2023 15.15, Marcel Ziswiler wrote:

Hi Marcel

tl;dr: can you try

@@ -330,7 +335,7 @@ static int spl_romapi_load_image_stream(struct
spl_image_info *spl_image,

                ss.base = phdr;
                ss.end = p;
-               ss.pagesize = pagesize;
+               ss.pagesize = 1024;

                memset(&load, 0, sizeof(load));
                load.bl_len = 1;

and also put 1024 in the binman node so u-boot.itb is also 1024-byte
aligned?

This will likely break usb boot (where pagesize==1), so if you want the
binary to work with usb you can make the RHS instead "(pagesize > 1 ?
1024 : 1)" or something like that.

I don't think it will work, but OTOH my analysis below doesn't find any
other (fundamental) difference between the old and new code.

> 
> On Tue, 2023-10-24 at 13:17 +0200, Rasmus Villemoes wrote:
> 
>>
>> and this works just fine. But in my case ss->pagesize is 1, whereas you
>> have 512.
>>
>> Just exactly how are you booting? It says "Boot Stage: Primary boot"
>> whereas I'm doing serial download with uuu (i.e. "Boot Stage: USB boot").
> 
> Yes, regular eMMC boot.

[snip]

> 
> At least I am not aware that we would be doing anything special for eMMC boot.

Well, I/we usually do boot from eMMC (except during bootstrap where we
use uuu), more precisely from the eMMC boot partitions, but that doesn't
end up using the spl_romapi_load_image_stream() but instead the expected
spl_romapi_load_image_seekable().

Perhaps some NXP folks can explain the logic behind

static int is_boot_from_stream_device(u32 boot)
{
	u32 interface;

	interface = boot >> 16;
	if (interface >= BT_DEV_TYPE_USB)
		return 1;

	if (interface == BT_DEV_TYPE_MMC && (boot & 1))
		return 1;

	return 0;
}

Apparently that "boot & 1" is an indication that "eMMC fast boot mode"
is enabled (not to be confused with fastboot which is a USB protocol
that only becomes relevant once U-Boot proper is up and running).

As I've complained about previously, the ROM API is almost entirely
undocumented. There's something in imx93rm.pdf (which is where I have
that eMMC fast boot info from), but I have no idea if that applies to
imx8/imx8mp as well.

Are there any alignment requirements on the destination and/or the size
parameter? Is there some timing requirements so that if we read too late
the data is lost? So could e.g. a bunch of printf debugging break boot?

Because I really can't see the fundamental difference between now and
then. Both before and after the commit in question, the code does:

- read 1024 bytes at a time, search each chunk for FDT magic

This then gives the "Find img info 0x4802b000"

- make sure the leftover within that 1024 chunk is a full FDT header
(usually ok, so no output)

- read the FDT size from that header, round up to a multiple of 1024,
fetch that - that's the "Need continue download 1024".

And then the flow deviates.

The old code would do the fake spl_fit_load to figure out the maximum
offset (thus the real total .itb size), then take that remaining size,
round up to ->pagesize (512), and fetch that with one final
rom_api_download_image(p, 0, imagesize);.

My code instead does a number of rom_api_download_image() calls, where
each size argument is rounded up to the ->pagesize from the boot_info
query (i.e. 512). So it's possible that for one of those calls, the
destination is only 512-byte aligned (because a previous call fetched an
odd number of 512 byte blocks), and that doesn't happen in the previous
case where all but the last rom_api_download_image() have fetched 1024
byte aligned chunks.

What am I missing?

Rasmus

