Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3691CFD3762
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D42DE8406D;
	Wed, 25 Feb 2026 16:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mDhNEc92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825D88406D; Wed, 25 Feb 2026 16:18:27 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D0A584129
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ec+HBhmsy7ONEaQBgD39ZNZFX5J5AGzvX927PB4/9AZyO3bxuSNl0+hFLCocCr9JTBFuxSaBrKycvGj1M9hv7IhVNnJUjZKiLrtjC5oPXlqWxEm/Gc9rurwBRn6v/qtu1aAJihMbav6EN0FSSCwQ7ujdIbXwT4k0bm9kcX7L4e4N/1V96VH2ZycrdCKzEnYEaFye4mZjWIcJOk51BesLT2Y1QUBrkjmoMRD8Y4RvRA9HQsjltkaz6tbMWvYL8xXKdP/ayX5wwiECbUvVGMFIV87bQd7kuDB5WSnE8iHnNydig9vsuTL3xf5OFN6iIQUQEBgZAprybgz1NT4Vkpktqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKVMw6QxMHC4lQ9RMOQVMWOyRXIxgQiOJt8b3mvePoQ=;
 b=b2jvzfF7HJoeuEw+IIx3A2O0qtkYUcAin7jq0IJlL+HVO+QsB+mB9zJo4V+l6eN2ELj3zReQZyXe8/Uw1jozNzoHrQFmw2KknjLlJHUXOF43nHk88tcwdQfkadm123lJx85FGj3BC9AZeQMElydJDkClFZ0O71Hy5W7+2GXHtSOsnjNinil08djcAcGbObsxsKOw182oHRWqnM8e3Bhn012LaPGGFYv5oCwNDJ2ns/7tjZvOV3mdH/6VBRDiHhhX+5Yf3cFIECZlNBQmlyox569JPJ6OQbiG00ECSSrtlrq6jE+2wfJODMC8uFrflSKQL4ylTuPJ+3C1Ho1jdruyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKVMw6QxMHC4lQ9RMOQVMWOyRXIxgQiOJt8b3mvePoQ=;
 b=mDhNEc92xHExgNKADjXrUNHmcm9cJ1GKZw4SWIRU1smnFAFGw4mUFJBxTPdyer0hcJaC0xfowNQmqAD6c2oNVceMJm8CIb/efbY8j4DCT/OgRx++6zIh8kaQvvxcS9RqayNIvBcWzkL7H3OaPWIBsUXVprm4fnli20/T9uJlOf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV2PR04MB12020.eurprd04.prod.outlook.com (2603:10a6:150:304::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 15:16:08 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:16:08 +0000
Message-ID: <80e1ce6f-10d3-4e9a-9fa4-f7b7e613e989@cherry.de>
Date: Wed, 25 Feb 2026 16:14:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: Kconfig: fix indentation of help text
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260219175301.2839586-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260219175301.2839586-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0160.eurprd07.prod.outlook.com
 (2603:10a6:802:16::47) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV2PR04MB12020:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c68a29-c0fb-4917-c2fa-08de7480cd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: hVhFExrULN0OPuR+V5i/pcZUd7fvZ7g7CX47/YW73I640Tce3ew1RkFIBKjI5MAQkihULuPI/gKy3Yib9Mt4VYO7ymZPToaKcYDRka8GnWyMFAt+NV2s3TuUMzqmfc7JISw70foDwTgQODD5PL8LJWSSaBv0++k/FPa3rZ972+LxEVtmM9MRKsDONL5JY1WnXxvFokgnM/o2TaustlNRCt8+g0cj4wHnBQJzfOdRufmEh9pm+EnHqdxCvZXaH58tsQi2Bz7ZmDr3jFHit1n9ACQOTQ3GcA/cu1VAs1FPwTpGCmoQVxrKXcnX4KjNoguQf9QP9TuX36cQUH83sHBDL4Bpq4diJXi8YaXOHOC70+SpK5tZAjwTIrRJEejxqrNwfHtcZXkDw43zxNx0t7H7vPVHbJVsX4/PqpwNt4OlislfrTGb9A/Iekm4j99efphNxKpHLNE7HX9c2UTbrRUNdWNFjXhIFVtyfWR+Wdjyt/9u4aani5PrSTLXW2fATPizIxwwNlqNoJHWrdk9Et6dgAE1RCpep1Z6y3Cs9DtVgI7WE2iP5rM65ncLbOS851w9GcpQp/A+lqbMaNx4UwVjyHnMoQOBFEScHKUSqEzGkZTcH7qGM8dXkD0KHUEL0gHvaa9mwHObiod6TN9pC/83b0hIUWiHiQLviLuxvir/VPxQoqNBim0LLwcus1wgBnsY3AqPgSb2dsczMP7EdHiKCBf2nxz+XB0VWTK/JrnPyZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVV5a0s1NWE4SHYrWXdPaHVGSlNFUGx4V1BkL0dsd0dpYk1EeDV3bnVwOExP?=
 =?utf-8?B?N3JiTVFNcmtQbEpSSDQ0QkcrcFpZZkpDVnBjUlhJTjF3RkdxT0ZqaUh5aWJV?=
 =?utf-8?B?NDV1ZHNQN1crTHNjbEhkV3VjVEU2ZmROZHNPMnlvdGVnY21RM1ZuelEzVy9Z?=
 =?utf-8?B?cDgvNlpnTVBucmt6aGJKSi9zWkIxYndIVVVXQXpqdTcweGxTSS9TSE81RTJR?=
 =?utf-8?B?U05FUkRZRWh3ck5aQ1JCaXc3cThMenIrdjlBVkd0RmorbWVwdHczT2Y5YWVM?=
 =?utf-8?B?TkRsQmp5c01zNmZ6TVVQVFZxNnFhWVZaRFZmOUNrRll2MS9odU54RGVNaVoy?=
 =?utf-8?B?QnkwNmNaUnkwSmtvQmJhZzlacDZjMUd2b3lLZlVUY0FacXgycXBFWC81L2kz?=
 =?utf-8?B?dUpIVnJZZFJqc01OMlJvd3BIMGxKKzI1bVBSRVV0aUFQZGdSZGxXd3ozY002?=
 =?utf-8?B?T3dkSlJFTlRMWXUwY0Jvcy9CVDRSU2diWkFDZXBzMm1UTlllQVFyTytpZk8x?=
 =?utf-8?B?WFpXcnJLNUhSckI1Y0Vyb0NWTnhYWC9saXp1K1dvWVZzc0xuZGhucGpxNml1?=
 =?utf-8?B?cjBDb2JFUUF1bG9nMWZqV2o2ZU11UkhnYjhUVHIyY1AwdERFZFMxQU04Y1dR?=
 =?utf-8?B?azE3TWg3eCttVWYySTIyUHUyYWZpcVZic0pPdnh1ajBDanliMHh3ZjFrVUI2?=
 =?utf-8?B?aWhybTRqQ2ZrNWk4V1ZKNkVYZDhWN1gzMlp6cktxUmJWYldSOGdRWlp5STVt?=
 =?utf-8?B?ZEQxU1o3RHp2Y2FpczN6d0dFN2RNUkJYejZBZkFKK1FiN0Vvc093bkk4aWlL?=
 =?utf-8?B?VzQzV0dDR25wQzEwQnFVdksrN1dTSjQ0Z1RETy9jL3QwaWJ1S0JlazJUMVZM?=
 =?utf-8?B?bU4ybDRmckFlejRWTzFKaHJ3TFhEOXhNbHJ5NW5OR2E1cEo1TVU0c25aLzBS?=
 =?utf-8?B?SmtnL084di9sVFBBRFQ5dXFGa0NXN3VCczlscm5JUlhsN1A2QkZFMnhtZG1H?=
 =?utf-8?B?ZjBIanE1akNUNU5MVk5QMjBFS2tIclloMnBzOG1sL3h6UHd1TWtDV1QrWnJL?=
 =?utf-8?B?U0hkR015R1QxbFEvZjNveE1MUHdZczA4ZHZJNXFwOWJtWHlmVlROeTU0QXMz?=
 =?utf-8?B?bDdLWWRpTStDcGExK2RLa3F3VzV6TkFRdXYyUGpheVNGSjBsN2kzRzVhUzNH?=
 =?utf-8?B?VU10ZGh4clQ0YVJGNUNRTVBYOXgwQklHWFQzVU54d0xhMGkzMFFGUnd6dlJX?=
 =?utf-8?B?QWdMOFVaemRYc2RSKzFhRFVRcGRqSnptbVMwWll5QWUvQU93bjFMYnNhZVhB?=
 =?utf-8?B?cGtDSE1vZ0Z6dDZ4TUpYRXZTWEJpZ1U4aGpVVHMxZFlkckV4RjFiYk1jZEhv?=
 =?utf-8?B?SCtteXp4aHl4a2drZ0RyR0FNZFB0WUdSeXNQcW96dmNxYm9SektpRFhpd1Vv?=
 =?utf-8?B?azRsdXpDZGJKalhoTEhRM0FmeG8wMnNkdEF0RWhpTFJ0TnJUQ1prYk9FcVhY?=
 =?utf-8?B?NDd4dWhYR1pncnp5L3dONkpJQXVKOCt3enRESUZhNTVjVnErb1RKZCt6R0tS?=
 =?utf-8?B?c0t0cnFRWCtTbDduSnhwVFBGOFQ3TnFCM250em8vc2RKYUYyYjZSSGpaam1D?=
 =?utf-8?B?QnR6Y211NjNpUEdrYWJsTW1ZdzB4SkdwRHZMV2szNVJ0eXNoeXRFNjdlNHhi?=
 =?utf-8?B?amNGYjBvR2FRZm1Tc2ZTaDIxWGlycWNFbGxTWDFkMlRJQi9rVGZKUHloS3dO?=
 =?utf-8?B?YXZURTNxVkVtU29NOGU4bXhha1ZMM3J5b2tSK2hpSHo2UTNDdjkwcU5MaERD?=
 =?utf-8?B?U3N4dVk0b05XY3RlTGRmZ0t2YmxkUUJzeEkrQ09mZVZvcWhVN01kU05UMWRa?=
 =?utf-8?B?d3NDcmFVWG1yd1liODYyN2dseFl5OTNoaTRLTHBWRFRvVVh2ekk3SllRbDFo?=
 =?utf-8?B?YXFDbi9uMHgzUEFtZlhjYVdCbWVpa3ZxNndxekRWZlNoOHg0ZlZpaTg3U0Fk?=
 =?utf-8?B?L0xxUUJBMFJGVE96YVNHUjFpb3o2MWZBa2I3RHVYYk5NNzZQeHBwOHJiRWtU?=
 =?utf-8?B?TWx1bjNQSkgrNTB6ektpcnNGc21DSTZBUXcvL0loNWxlUXZoTk1yRm1Nb3ho?=
 =?utf-8?B?UDV5TzRBU3d3SGZ5VTVZZ1lRK25mRVJiN01zejJBblpvd0kxMGU3RXFHV0w5?=
 =?utf-8?B?VUM0c3ZqbmsyUitraFpKeHhyd0RRdmlEdUMvaHF2QUY2MndicGJCZEpmakhP?=
 =?utf-8?B?aUdiazloWUp6c0l4bU1FbmZmdk1TU0lDcVd2NWFoZ3ZXNm1zRitLejhpa2dx?=
 =?utf-8?B?cWRLSkErUFI1ZWNjOXBJbjRxVkgrUTJaMTdHaXNiNUplaUJyaFNaUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c68a29-c0fb-4917-c2fa-08de7480cd47
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:16:08.3730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOqlHIyvzNTtHqUaSAJpQmKwncdWJ0IEsnOAWzZLKA99LjYuHI8WjGS0yt7YJZLBFWEV/a+7IQrQyPE7A3FE28wveAkKS8DfYRsG6jQhqZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12020
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

Hi Dario,

On 2/19/26 6:52 PM, Dario Binacchi wrote:
> Fix the indentation of the help text for VIDEO_LCD_NOVATEK_NT35510 and
> VIDEO_LCD_ORISETECH_OTM8009A to align with the standard Kconfig format.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
