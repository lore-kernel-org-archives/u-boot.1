Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38EBD690FC
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 11:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3878988B;
	Thu, 28 Nov 2024 12:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Qd+VlBeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04ABD89890; Thu, 28 Nov 2024 12:41:22 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FEC98988B
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 12:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xh1sKDx2OMi7djUR3bIyrQFqiI946lrP4dQJgTcfDL+v0Xx4pOHNFaM8lnz5CrvrInVVWJ3VZx6IuCxd5muQR18z17MXZZLuu0AeDxruKldxsdk+oq2RfEl01MN0+yOBtEiILgKZc4Quwr/CKmUK75R06GFEnWSvmk3GpTXx/o5pi37XX2qzGolTicVxIF8NOVlJdfUdmIrQBnkVBjyynP1Cuo+4B04ulEfcSpTi0s7qr0Se1S6GPL7BWc44XXltCevyLCNhRdRVGHWy987tTWegpUew6VM7C/P8fMizDVLd1/ZzKrp+YM1ifQ3ameDlb68FDdLqG+BNUCBCA1RgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6BSiTVKim9YZcd6hGJWGurCitJTECH1Z/lgFyqLAEs=;
 b=Ccfbu76jLr5n1R5xAOLAN6rrVqyQIgWW0p+dFEhoeA9qhQ8PP4UuDks3joIIH5HPk3y21RGWMNghZ84xEDpFyJ/dR6dKLjzIUKzfsLD5uERzlHKijpVR7x8ObB/qm7QBtJ7v3Z6r+0GTHoqwd7U62EYIouR4ajbeIUHkFqThikUHwkYAHSECUtl7JN6qMzKRBuN4oZUukPk1du8KkzEb1MYhKCSi6pI9jAyaV8Y8DhC6bD95gjQh/aYR4TYWzLZBQV6wsOYrOdFjFr7d6OiiAPRGSoXXvP7mOZn8tv3cvSP/Fzu+RXdGX19e1JDpIXK5ba7fdJnzHzs2nqe2dQis8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6BSiTVKim9YZcd6hGJWGurCitJTECH1Z/lgFyqLAEs=;
 b=Qd+VlBeq8yCgaNVfWoCiqkn7E1faY8Gw6vPc+I83cWNnLlwBTdP/4t5/xR0yLdWahdesycAyle0IF84aWgnVFjywhsdtdqiVT5CxDU9VqKUre6C11johsW7MGo12vi0XuFr+886CYk/4towxhrimaLvMkG6QRGNWGRnImBEM9Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10939.eurprd04.prod.outlook.com (2603:10a6:102:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 11:41:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 11:41:17 +0000
Message-ID: <47cc2ae2-aa43-4e3f-8aa2-980662f5e660@cherry.de>
Date: Thu, 28 Nov 2024 12:41:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: avoid non-standard sed expressions
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, marex@denx.de
References: <20241126191214.21709-1-kettenis@openbsd.org>
 <7a713b05-030c-48ae-af3d-e7fb02b2f7c5@cherry.de>
 <87bjxzzjjz.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87bjxzzjjz.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10939:EE_
X-MS-Office365-Filtering-Correlation-Id: b65858ef-5528-4a47-f5b2-08dd0fa19227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzlONTloRVI0d2dKTElJMnFjZ1ZuckRpamUwS2x6R0V1Mlc2MW1lMXlUbHBR?=
 =?utf-8?B?RktENkVIQWJ2Njd5azV2S1Nic1VEOXpMamV3L05mVGY2bUZCVmdHaTh6OW9G?=
 =?utf-8?B?QTRaSGFOL3JOTFdmWVFIQjNCTXMySmRRVCszTGFhNjRrM0YxZzJMUWxleEtk?=
 =?utf-8?B?U3Q4RkFHbVlqL1RodHBYQ3RqWGtUSXRzT1pKR294Wkl4V2I1OSthN29OR2VN?=
 =?utf-8?B?MjNyVDNucVQ5QU5YU1hmZGxBc0RyVmlWUkZabjZPNElSQ2ovenZQOTVqdmk4?=
 =?utf-8?B?YUg1VHRFUXVIRW93K3k0R01xd2Z2dFFmUUh4NEpaVnlocDd3d0NlUEJuWmFQ?=
 =?utf-8?B?U2diNEE0Kzc1ZStVWmNaRWE0bGNxN3ZRelZGK0orb1BaRkJkOVVxNytVem15?=
 =?utf-8?B?VTdxelU5aGQ2NW9aeVJUN3o2ODlVODQwYjJMeStFWHJxYng0ZktQb3FZeW10?=
 =?utf-8?B?YlppSG9yeUJRcjRYWmdqQXhoZDVxdFJVeFFRc01ObURCTVBFSFBOMmpSYk1u?=
 =?utf-8?B?WTFYK1pqWDVNakp5dWc5MlJpVFFESGhxMEJVVWgzWHRPcURsOFZHcnEyWkVZ?=
 =?utf-8?B?TXhtMzVzMmVjTXRWa1doenM1NUs0WlJDUHdrejhoWFJRbGxvdzVDWnBmMElW?=
 =?utf-8?B?VDBOTkhHVllCSmZCZmVCVmtoalpkY2hpK3dNRXk3MWUrUG02RWgzUEQ3d29I?=
 =?utf-8?B?b1RqWFR1NWlQWjR2RzlCZGdzQWFuS0lEQWxqN1lSN096NW9sQWpOZitvVUg1?=
 =?utf-8?B?QVF6NFhzcUU1N0N0eHBhR01QQy9wUGcrYnJQODltMzRFNXBMUWNXWCsxMWZv?=
 =?utf-8?B?VEs2TVFoY0NDZnZxQ01Ja0xFSVpLWUsrWDlDQi9hb1QzL2EybXN3dmNpRTRT?=
 =?utf-8?B?ck1qZDdlNEdaUEN0ZVpyMlVnRTVxL3VCYzJYRUg2SllwUmF6VnNsazF0a3RD?=
 =?utf-8?B?NkVMMGtIK1VFZWY2RThVbTZEMGY4d2szOTZvajNZRTM0ZWhjbTF6UFNaaEdo?=
 =?utf-8?B?VkZtN3ZZZHlJRkdEM2UvdVV3Rm9zbWhSZzZuVzY0TUZQbDU0Q2cwS1IzODdz?=
 =?utf-8?B?V0pDclpQY1dCcFpFOFN6TEJJT0NEZHZFSndGcW9SdjVvdkNEOURvOEFldmtK?=
 =?utf-8?B?OHgwdTdyQ2phOFRjdiszUGxWSkJZdXBZWk5TallyN0ZQcXVSZE5IdUw3S3Rj?=
 =?utf-8?B?TUo0ZndLcGhLTk9JaCtPdEhvTXJVZ1Jxa3RXNngxYkc1bFdVbHNoeEdGYmtU?=
 =?utf-8?B?ZEtzVHNmRHJrSjRZVXBqL20xT3A1dDZqY3p1RUh5NVdnVXM0bFZLQzhrYmhS?=
 =?utf-8?B?aUkyNzF5cnNRZ2lCb2JDTG1vR2dQTnc4bldzcGxRa0s5d09rQ3daRFRseUhS?=
 =?utf-8?B?b3NybUVqeXlDeFlkN0dsYUFSMEtMUHVxUGRQOUJMMW5nTW83VWM4YnE4cEtx?=
 =?utf-8?B?cXVKbDdCSFBXZFRLVG9ZMXM3OTREeHBrSU1zTHI0SDZVcVhJUjIwMFVhU2U5?=
 =?utf-8?B?YjBGS3dpcW5Pa2dqQmx6d3BBVGJKUTdHSDJ1OTFod2pMNVFEZGJqdzhsTzJG?=
 =?utf-8?B?OStDY1FKMHRXSlY3MWNjbTdla3VDNXVOakxLdHZzZk0wanJENG5tTm9oNnlU?=
 =?utf-8?B?WjYwTEpQK0VPZnhHc3RKa2tDTkNxenNQbmY2dWNsVjNydFFJNHV5TmF1c1NF?=
 =?utf-8?B?b2ozc0Q4S0ViaGNCMWhNU0dlQWNXaDg0M2R0bHFUMmtXNXNxMzdmUTJMditp?=
 =?utf-8?Q?KT/ErcranIHCQHjJEg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZsNmNhUkpvTFRiaTgrMXRGYXl0Yjh5QjBabGlPdGdML3hJV1V1eE1MelBM?=
 =?utf-8?B?OWsvVVBUMVpCYk9NN1RDWHBKMXluWUJGVnhmREtreXVQM0ljeHJyYXd3Zlpw?=
 =?utf-8?B?U2wyTHBKTThaTnFuY1ZjT2FUNUFiTzNEUm1aWmF6OTUrY2Z6RVhsOGR2c3lU?=
 =?utf-8?B?T0ZXdUs5NFM4QTdQWGZiVzBTa0d5bTYxRTBvMDFzcUx1aUZPaEVjQytNSE9U?=
 =?utf-8?B?K3VONXd6NnJmUDNJd2t5Vm9oVmtLa082bk84ZHJuS1RoQTArYkc2ZGJzWTBH?=
 =?utf-8?B?dTFkdnIzUWl5dzc1eXFRMFQ2ekJnOE5sQXpBZXl4akF4SXZGODJuTVc2WHlu?=
 =?utf-8?B?SVBld3FadWZJZkxJdkhZb01pTzdLT2t4OHZ1OGUwT0pkRDJMTi9kRjYxNTFa?=
 =?utf-8?B?RzAxZURsUFEyVS8xVlc1cnYyNzlYcnB3QjRzclA0RVlET1BqcHQyUlo1RzE0?=
 =?utf-8?B?WFV5VkZOSk42Tm1TNThoNWxxOFBQV1YvbE5GWjBtcEFrREdBLzRhNVFBbkN5?=
 =?utf-8?B?Wm9VUHpOSVFrQTlyNWNFTmd5bTVuMXVGQW5IY3hrYkxBN3RTVmc0N1FhVHh5?=
 =?utf-8?B?OHhQMXk3N1RpcloxeXZoQ0ozS2RTSDMwcjdhR1dZUVJJektHUkFmUEJNZWt1?=
 =?utf-8?B?a05RRml2ckRUYk9qdUpSWDVDcGVmenQzUW5FVitkdUxNdW1SOURFd3FLS1VS?=
 =?utf-8?B?R3N1RjR3Z1BEN3dxeGNZaWZBYjJ3c0ZEdkJWcHF3S1czK1o1eVl6Z1BrczRv?=
 =?utf-8?B?Vjd6NHU1aTkrMVJNMWpuSWVlRWwra0htemZFS1lhbCtQV2loQmx0aWFCOThY?=
 =?utf-8?B?eWtTVWI2WE1aTTZUYXEyVUEvREtGeVFKQTNMeHZSVjJEdDBIUlIyM0swRUVJ?=
 =?utf-8?B?WDdxeExzaFpkVml2bnBQSFZrcXFjaHhTZWwvdS9keEFNTWRieFA3N0x1U2RX?=
 =?utf-8?B?UWN6RUZqWWZ0Zi9ic0QyZmQwbldjREhob0l0WGRDYXcyaVNQS09tY2JVUjJY?=
 =?utf-8?B?OTJFancwbWNzK2tBSEd1ZjZpM1FOUDQzaW5BTW85ck9mZnNVVlU5OXZsWFlw?=
 =?utf-8?B?YTBzamJiQnpiaEpWUHpsZ3ZHY3YvQ3hkV0RPNVY4RXZMbFJhMy9qVXlCY1NC?=
 =?utf-8?B?R0FtTW9JU2w1b0VEcTNDSnVZMTErdXZ5RkdtSmppNG1tcW41NW85Vy8wWEI4?=
 =?utf-8?B?QVRzbDhwK2E2Y2VDdGZYNWo2SjUwL2xHM0RDU21za29NSzhkZjBYQjczRlJX?=
 =?utf-8?B?Qll2cWtQczF5MjdNdStGVmw3K2QyZ0UxZUYvNlJFaGM4aThoN1NPNVl0YjJy?=
 =?utf-8?B?QVgyQ3BQNzJscmEyNFFUMFJqek1iNFZzSGZkSEY0TXoyc1BseUN4WU5rTHBI?=
 =?utf-8?B?alYvOXVQaGRsc05wbEVwMG9Zd3ZXN2JuQWR6MHdzTTBxSkJpNllXU2duU0Ir?=
 =?utf-8?B?RFk0bHdaWVVUbXgrSi9tOWk4SDYxcjZqbTNieFJQaFJDdk5VZ2ptc1FiQnBo?=
 =?utf-8?B?c2RpRHdFMjd4dXJjN3lwQ0lESTZJR1FvdVZrNnVrNFUybEdWcHZ6SmxjNUNw?=
 =?utf-8?B?bVZZN1orYTlsV0xBcjhPMnZ1aFFjMGZxdW5ZVmlZd0YwMzFGZzV5ekpLQkEr?=
 =?utf-8?B?ZXZ4a3VzUHpNeEw0a1NSNWFKd2o5eXVwZkVwZjMvQndrQkpJSU8vV0dVSXA0?=
 =?utf-8?B?b1ExZjM0b1VFdXpvc2dYa0xDWXEzbFQ4WStTd1VuTjNaNkp0Q1gwSnN2M0Jn?=
 =?utf-8?B?Q3I3ZC91RjFiOC9aR1gwRjRzRk5GMDlZZmxzc3oySk44cVdnRm8yZ2lyT3or?=
 =?utf-8?B?Y1RBNHcrekZHUm5kV2I4ZXFEMEJEWVBZcGh3dnc3SHlodW5IZjNmL2srK2ds?=
 =?utf-8?B?dkQ0TTgrZll6ZW9FUGNzQ01tRkJrcVYrVHZLaHd6cGR5MmdjZnFCeGNMNGUr?=
 =?utf-8?B?Z0lqSHJjUkpTZk9iTFNvZld2dWNNcmFzWkZTQ1I2eXFzbTI5MXJSMXcxRktH?=
 =?utf-8?B?YzJRUXB0YjZIb3VXbWhvMmZQK3I3b25PWHpyU0UrYm9BYU1YTTFTS0VEaktw?=
 =?utf-8?B?V1htY3p0d1FMYXQ2Vnd1bkdCbFo3Q2FKT2w1Mk9YWU93ZXV4bEpIVnlFdTBQ?=
 =?utf-8?B?MG53Z3RaNHdKRmk0dTVnUFZmK2U4STZUeXY0QjBiY0U3N2taNGVLQWRqZ2Nj?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b65858ef-5528-4a47-f5b2-08dd0fa19227
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 11:41:17.4121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjVp07hf1iDZI/8UahpTZ9YoRvR1/rFdmNMtWAq6xASNvAEuPu3IofI09lnvfPn3tRyUnMMUZ3HnUmJ5usOFSPpbXZeOwnvN9kOujyDoEvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10939
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

Hi Mark,

On 11/28/24 12:25 PM, Mark Kettenis wrote:
>> Date: Wed, 27 Nov 2024 13:42:50 +0100
>> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Hi Quentin,
> 
>> Hi Mark,
>>
>> On 11/26/24 8:12 PM, Mark Kettenis wrote:
>>> The '?' that is used in the sed expression that determines MK_ARCH
>>> is part of the extended regular expression syntax, but the default
>>> behaviour of sed as specified by POSIX is to use only basic regular
>>> expression syntax.  Use the equivalent '\{0,1\}' instead as
>>> suggested by the OpenBSD re_format(7) man page.
>>>
>>> Fixes: 04b1d84221d5 ("Makefile: fix empty MK_ARCH when using ccache")
>>
>> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Considering that it's not the first time someone breaks this by making
>> it non-POSIX, can you add a comment just above with a link to the
>> re_format(7) man page so people are at least more aware than they are
>> right now?
> 
> It is unfortunate that GNU sed has these extensions that are enabled
> by default.  Just mentioning the OpenBSD man page is probably not
> going to help, but I guess I could put in a link to
> 
>    https://man.openbsd.org/re_format
> 
> with a comment that only BREs should be used.
> 

What about adding --posix to the sed command. GNU sed has it, would that 
work with OpenBSD and is it enough? At least with GNU sed, ? doesn't 
work with --posix, and I had to replace it with {0,1} to make it work.

BREs don't seem to be entirely supported according to the manpage for 
GNU sed, c.f. 
https://www.man7.org/linux/man-pages/man1/sed.1.html#REGULAR_EXPRESSIONS 
so not sure it's a better than no hint :/

Cheers,
Quentin
