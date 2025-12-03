Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8183D15DAB
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 16:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D48E83FD3;
	Wed,  3 Dec 2025 17:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EMGdkZtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05DA88401A; Wed,  3 Dec 2025 17:23:55 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0463D83FB2
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 17:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFLjJmTwMAQYrmkUnIYjcVZsFXBvhQx+BOyHZi/HW0XV9Cxve+JeCmKD65f/Cj8LTgXv8FpAjxQBf/2QhQMezGPdeIDrulwQsj8m+PDoErgKHSQ2RWdU7HQ97TWbDVxWGni3HMCMbb2wMHMlECHEIjolKlBQsTGPONE/vxajKZvW4szI/QjPeARk6FjjcmIQ+kl/oDA8M9GvneLaIfQl48P5DeCzY3GDrqNH/lnwYVMyOASao+RrIIe1swCBXAMBw0PyDl0vUi4W2Hz2Pc0oBna8QyOc3wuDE+9zEaODX5kbID1c+tn3eEQwQ4+xRcrXxri2tCmT51Kleu4xxGvbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scUomjY4lIwUqdWqg9AV2l6Ii3Mv1JuzD6+219XLdv8=;
 b=c4kEf+e/EaSQToKgonNfRI9szQxXhlb9cjcxSIqMGLixqmNZs5XLKF7FkdNzXac/jNYfqtV7+/CieCMPl1KjCAmb3JJ5bkW7XfZWYq14FFwcFDg2aTjB88SkFzLQmAAbFwMgiym8/QIwTDP1Fl1tzc7+BRkmUH22HFKTZLFXCk4dsrH/ipuCDwuPAMRGCXgAQCvoSG9cLmDT2cKt9pAFvlnhzHY2SbQvxD8p0nWx6MSwUYiPjJLvwaDdL/eysb3Brz+Kizi0umd+/3LTvmHIqj4q/x0c1K9I7Uuk1JPwnvZVhFda0bCjjmIB+4hPqwdCytI4sNF+SH7kYhD0FKDUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scUomjY4lIwUqdWqg9AV2l6Ii3Mv1JuzD6+219XLdv8=;
 b=EMGdkZtGHDDPj26X8xoHV4L8r0miFHL8j7sh3XTwS33tp1lmpCpTDSdY34iTQgKw08w+HN5nwIKnvvVUCeuAOcR0jak89W3Mw18utNxyIqAALngv+bceflGfgPSAK/bIELNykJjpKRwU36hm4VOBEnPnJ+kavOY4MYCmE0ujfLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by OSKPR04MB11438.eurprd04.prod.outlook.com (2603:10a6:e10:9d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 16:23:48 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 16:23:48 +0000
Message-ID: <e25260e7-70ce-41c0-aa89-a8fb5a406b57@cherry.de>
Date: Wed, 3 Dec 2025 17:23:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: single: Add missing free in
 single_allocate_function
To: Tom Rini <trini@konsulko.com>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
References: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <97a3117c-7bab-47d1-a5ed-1a33e7c2441a@cherry.de>
 <20251203161142.GQ303283@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251203161142.GQ303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::28) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|OSKPR04MB11438:EE_
X-MS-Office365-Filtering-Correlation-Id: 3789485b-9d35-43b7-4178-08de328856b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFNJcndBZDZVN0NCRGoxaExKcW82c0t5OVBWK3hTMDcyM0RUcVpVek1jYWMx?=
 =?utf-8?B?ZjlTNWpyUG1UZ3JKbGZVTndHTkpZMnJOSWhGT29lK1VGVEpwcUFSczR3NWZI?=
 =?utf-8?B?cm9iazcwMzZjTGMwdDNuS0lVMkYvSHl1SVZtS1puMm5ZVTJ3RmNtRWgyU0x6?=
 =?utf-8?B?VjZDSVJ6ckpnOSthSjFHRG16bml0OUJiVkhqTWZkdk9lYWRuVlVwdlhBVnhI?=
 =?utf-8?B?dkltV3RCR0p3cVJxVTRVVWdhci9jVnd3bXZvdmpGMjQva3l5N0FpZzVqT3dt?=
 =?utf-8?B?Y0FMQ3UyQ2gwQ3o5Z0ZGcU44RDA2U0NtMksxSWZCSllLUngreUhvMGR0UVlj?=
 =?utf-8?B?NTFjTVNhdDhWUE5SdE4vTEczamZoNTZKTURXNXN6dHhuQ3R3TERHdVZEUk5Q?=
 =?utf-8?B?ZHIrSWZuNlpwMGRZdlpMaEJJMlM3Vlk3Uk91azVMVjdDOGc0TmRMajJsWXVP?=
 =?utf-8?B?VWFXTjJEQy9TcmY4aXFaWWVpa2Jmd3lvUTZWYnZId1c2NFBVSTUyb015RGcw?=
 =?utf-8?B?Tzg5dUNBdXROU0pBcW5tektnZUQrN2oxTzJ3dDh1TENnVndrREZaVUNXM2hp?=
 =?utf-8?B?ZGVlRTI0KytmbnE2YmtFSHBZQVhZSnc4OXdHSnRNZkFWQXNyS0ZIVmZnek9y?=
 =?utf-8?B?dlhMcmFibXU3QUxuUmpZOXdQSDZ4UHBVcTUyR2V4QjZ6V1NuZVdxeEwwK2dh?=
 =?utf-8?B?bmdwanJHVDZIdlRBTEN6K1JReitndUlmWmxmMEFmMS9GTkFvbTBCTFpjd3dQ?=
 =?utf-8?B?alJkcFdCejFhWXdYbDduc2lqYmxrK1E3VldUeDB4dEtvU0grTTB3d24yb0tK?=
 =?utf-8?B?NEp2bkFsNzFCYlFxcEY3VFphL000WkJTc0xMaGZmMDhNLzF2RThQU0ZiU1dK?=
 =?utf-8?B?YUIrRVE3Vkh0cXRsaGtsY1B4QjdQOStsbzFiTDRSZ1JrVFdocmR6QVpyZG8z?=
 =?utf-8?B?N3VWUHJobXozOGh3RTVpcDAvUGd3NnRSZUViYmlxVkp3M25nWHhJTElHK2RJ?=
 =?utf-8?B?MVlSYTJjdW5Edm5pQytSNm5SaVd6YkxGQ3RMUkdGbmtRRWpMQXpCb0J2N080?=
 =?utf-8?B?ZlJjNEZIZUtJeGZ4bzQ5RjdwSFk0M2JSS00xZW9XOUIyayttdWxNckRXT2hs?=
 =?utf-8?B?c0ZsZE54RnYrZnJpMlZ5bE1sWmp3Sk81dFJkaTVnK0t3UGJZK3VFYWRKMmxq?=
 =?utf-8?B?UFBObVhYdjFFSXFhUnNOWnV0eDUrREUxWk9CUFJPMStNVEJrY1hrTHpmKzhE?=
 =?utf-8?B?UUxnREVNNEtpRXlLTVNFYjZqdTl6d3pra0szK0JLS3puQ2ZYVlBuWkxnV2dy?=
 =?utf-8?B?WDU1TWdIQXdxQjd3MGg3V1BOM3VQcTNuSGJGdi9KWlpNMm41ZG11dzFWZHVX?=
 =?utf-8?B?UkYvK3hvWFFaa1oxYjhjSmhLK0NvT08vamk4SUxQME1DejRGSVZueW5JSkpN?=
 =?utf-8?B?dWhxOGY1bkVDMEhWcVh5VVpVZjYrVWxycmpYLzZHaTZ6Y3VSaVpRYlZSZ2ti?=
 =?utf-8?B?Q1RQWEFENWNWYXBtMXVQRzBNek53UHdZaDh1QTBQNGdIbFYwLzNrRzRVTjM5?=
 =?utf-8?B?ZmRnNkNoZnI1UUp1ZXNBTTdnSUJFdkw3dlF3L2JUcDdJdnZ4Y3BQc3BmU3F0?=
 =?utf-8?B?SVpGM0tQcWcvWmQ0OEx6YVgxSSt2eGZlUkQzTTRMc3VjMXhraDNRS3ZMdjQ1?=
 =?utf-8?B?SUtoQWxKZWVwMWJQT2dCZGxXYm5SQ3BOd3VvK2ZhVk92Vkd1ekRsbksrWUk4?=
 =?utf-8?B?VDZOTnAwcmk2eDRna2doRGgrTUlZWXNXaW1Ud0FpQnhHT245YzF1ckRzbzRD?=
 =?utf-8?B?SzJiajdLMXhnR3F1WkhlSW1mR0tlemZFL0RYVENteWxXMkhmU0RSUlBZL1pk?=
 =?utf-8?B?THVFVi9zamNWZVoxN01jakZ2OEJkZUsxMmUvSkdOc3RBT3U3OGkyOWFyYmdO?=
 =?utf-8?Q?Ewq3Ie69gLuaTEnqMu4dCv/avkpT3CRk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2poTW92Mi9CYW52S1EzSTNUTENwYUhoS1FrMEZINzNFUlRkb1BNK2NvUTl3?=
 =?utf-8?B?MzliZ1g2M1JNdkROQnh4NXZYdzErNThCcXdWSDVFWDFHb0lVeVp6b1dpcFhh?=
 =?utf-8?B?MnhMMlY5M1pMQlg2R1djbCtJZHcyNW1PcmVFN1pNRnh1OTdvS0lCbmpLcmty?=
 =?utf-8?B?RGwxdU5GQWNXSGRJb2JHbG92eDdsc1BlOXl5bGRQc2owR0lpK050cUVXczdp?=
 =?utf-8?B?NjhOS1k0VWl3ZllCNnlQcUVYMjhhciszK3hwbzJZYmx3YVA1bFpnVTIreTZi?=
 =?utf-8?B?OEhhOW1SVDVyeG1IUWFVVVcyZWhWN1B1cWM4b2dQMS9oTUpsMDIvT2RtZjJB?=
 =?utf-8?B?NS9WQkx0ZDBETGloT0dNZ00wTTN1dUhmNWtEcnRPSy9KdlF2OC9TMFFWcGtv?=
 =?utf-8?B?SjliWnVRUUZETHJBQm1wZkR3Z3Rqcm1SSFN6dUk4Z2hVUHp0TktlYU5lZFhk?=
 =?utf-8?B?Y0lrNkwrcmJTOXU3U0lHVWtCaVhua0dZNFJkVFhPZkRpbm5tNUdUTmswLzBX?=
 =?utf-8?B?eXA3VTJZK1ZrOC85dStrb093WHlaZmhacE5jVHFaL2VqYkdJYTBXUmx1ZmUy?=
 =?utf-8?B?MmZWRkFzMTdxSmtMV1VnT0JCSDRtUCtyd0dDQXhOUjJWV0VqVVd0SHRrbEJQ?=
 =?utf-8?B?dmIxK0gzN1U1NjIxV09leitnRFhWblRYMFNvbkJnL3NCSWx5bVFpTHJMMVVy?=
 =?utf-8?B?OGNCYmZPWWlGVDNkN1c0WTdUcnd0dG1UNzgxVmIyNXdPb1ArZFV1WHdJaXBk?=
 =?utf-8?B?SVVGOGZoR1BBSVhpM09kbmluTWc2OWp6cVZONStRM2dkejVKcmx3NExBd3l1?=
 =?utf-8?B?d1IxUHE5WU12a0ZmdXczTkQyQk1VVVBkQVFxcU9BNVdPZU9FSE9xR3dpVDlU?=
 =?utf-8?B?bFczemQzVzVGOW1NSVpnNVZUc2JtUWZYQmxQNW43RERLMGdEbEdoM0d2amgz?=
 =?utf-8?B?K2owTWRvUnpjVXJNMGMvbTdMR09XcFVqNzRuZVBkQ2g3SVd3KzVhWjB6cmtp?=
 =?utf-8?B?MDJzeGxEdDJnWkUyaHlKNlYwUUtZUVVub0ZleStJcS9GRHRsb2tzYkhEeVFC?=
 =?utf-8?B?OW9jOXFrMXVUTU9hVjQ1WlhTSTRrNzBoNVEwa3hJb0lXVEd5UjgwNVA2ZUZy?=
 =?utf-8?B?Z0FSQnEwNGVBOWRKUStRSzQzRk9Ra21xSXh3ayswek9ZZVBuNnp6NW9nMXl6?=
 =?utf-8?B?eWNDOGxVN1dXVUx0Y3lmS05ydkhCQlRoNjhUZVBmVkppSi9rcitBSjJhZmpu?=
 =?utf-8?B?dm4rRkgrRE9scXVkcWgrbkZ5cHErNFJOWk1JMXQ1Ym5LN3NtRklqVTU2R0du?=
 =?utf-8?B?ZzlYaHQvQ1F0L0E1NkFOelpRUlZzOHlNNk9KMkJTQ1BrbkdKeXRiVjIrdW04?=
 =?utf-8?B?Q2d1NUJDS3poN3RQSFljUDkzQm5kQWI0d2E1ZFQ2RnZvSmhEc2hLRU9IUGI5?=
 =?utf-8?B?NmZFTmRqbW41NTdjTTN1SURkem9qMEREeUtyUUF1eEJES2lHaU9Lb0xJejI0?=
 =?utf-8?B?Z0RYbXN5amFoZHVBcno3WFlzbGo4RUJGakxmSjd0YXdkM0dRSDJQS3cxc1Uv?=
 =?utf-8?B?TW1xQmJ4Q1BYcWRIcEtjZDdBeE9tZ0RTVE5RRWtxejJUUzEvL0RINEtwREVn?=
 =?utf-8?B?SVhSR3daR0NXTzhLa1lYSzZTaTBTTmFibnl2cUhzeW5VQ3NhS1JhdjBSNGNN?=
 =?utf-8?B?MXI5YkZnd1ZqUkp2VVN1TXlGa2VRN1lvanNkU0VTVEJscDcwUEJqdTJHTFF4?=
 =?utf-8?B?NkYvRGl0dlVjN0RrOTJKVW4remJ4MWpnNUhsL2pLRzlYUlNRUmdpeXpKa3l4?=
 =?utf-8?B?V2dvMW9nMUhHNUhrYlo2ZnI3MmhSN3VFVDc3bFlXL3ZjYXd6bS8xeHhTbEZL?=
 =?utf-8?B?TzVsZ2UrK0VrSHRtTzhtNWdjL3ZwQWhCb1NJSFE5VGRTY2JFZzZSSC9rSmtG?=
 =?utf-8?B?aEVORUtxM0d3Rkw0d2YwUURlaXkwRmg0T3ZXaUdmRkdIUUU2QVQvNzBaYnNZ?=
 =?utf-8?B?Z1RSaTIvRjRXdUdENitlUW8xcm56ZlZpY2tOZ3h6eVIrOWxhWnJZaDFEbk9V?=
 =?utf-8?B?WDMzVEpjT3k0cnMzSjArVDIrNzFTWnU1cnVmQXRtZ3dsUFhGRDdsaGpTK2p6?=
 =?utf-8?B?MTY4V0RBNG9qYXZidFJZY0pGNEZ4UWVGajZWeDgwcnhPeExCeDB0TFNJTTI5?=
 =?utf-8?Q?8Geja8fN5YQDu/B5EQQHT+U=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3789485b-9d35-43b7-4178-08de328856b6
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 16:23:48.6211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOGTf7ONW5lv+5BpBXQQm/bsthx1K6bS3fsd9HWETfoG/ziRXFWxxarcJH34+ywDv20DvJq+9I0dK4GYjJx21Am8lkq9xC8OXWw+0IXPBVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11438
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

Hi Tom,

On 12/3/25 5:11 PM, Tom Rini wrote:
> On Wed, Dec 03, 2025 at 04:36:49PM +0100, Quentin Schulz wrote:
>> Hi François,
>>
>> On 12/2/25 7:39 PM, Francois Berder wrote:
>>> If func->pins could not be allocated, one must also free
>>> func variable that was allocated previously.
>>>
>>
>> Well.... devm_* functions should take care of this when the device is
>> removed (or probe failed), but if and only if CONFIG_DEVRES is enabled.
>> However, in that case, this code may be executed outside of a probe scenario
>> I guess (it is called in set_state() callback from the pinctrl device). This
>> thus makes sense to me here.
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> I'm also wondering if we shouldn't check the return value of
>> single_configure_pins/bits in set_state instead of always returning 0?
>>
>> We probably need to devm_kfree a bunch of other devm_ allocations as well?
>>
>> I see a loop in single_add_gpio_func() we should probably unwind if there's
>> a devm_kzalloc which fails?
>>
>> Maybe we need a .remove callback where we devm_kfree all of functions and
>> gpiofuncs lists from single_priv, in case DEVRES isn't actually set?
> 
> I've wondered, but not fired off a build to check, what the growth is
> going to be on default y for DEVRES. There's only a few platforms /
> chips doing it today and I think most drivers are written like the
> kernel where freeing is automatic, so there's lots of cases like this

I see devm I assume it's automatically freed (or whatever counterpart of 
the devm function is) if the device is removed or fails to probe but 
that's rarely the actual case.

The issue here is that DEVRES is not enough, we would need SPL_DEVRES, 
TPL_DEVRES, VPL_DEVRES, WHATEVER_DEVRES (added and) enabled as well as 
we do compile devres only if $(CONFIG_$(PHASE_)DEVRES) and then surround 
code with CONFIG_IS_ENABLED(DEVRES).

> one here.
> 

I think this one is an exception as the device may still exist if the 
error path is taken, so I think it makes sense to explicitly free it 
here, regardless of DEVRES compilation state.

Cheers,
Quentin
