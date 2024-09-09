Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852F3CD4F4C
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 06:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F209288972;
	Mon,  9 Sep 2024 08:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bmu56XZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41CCB882B7; Mon,  9 Sep 2024 08:51:59 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 153F988972
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 08:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE1qwcsKhAOp86eqNBHuLiRSiNZ5FqsiW32F7coyxpA/JAwYS/tDva31QTJ2y1SD0ZAvA8rd/AaGMocnKenV9Ukgrq8CHKA7bfs/jTe+GSf93Nw9iG77IX/s9CYg9MqXVvLUj0vMiaN+okKjyKW/bpxNd1yG6/Af65t4Tv2iMKjyq9FE/KJAUXB+9yx1TOOpamttM2/ltHPKBTBcUMHGHUvcQUbmEBMz49qehE0F9/8krs+h6/wI+yxl/8IcZNxnrGvqBnQXGQhqwx6WWkP1xgouYZKpWdpTxWm5A1yWPNhyhu/HAloeT0EV1PkaGKLAmCfePQG19M2IvPG7277aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftQQjhIwKIeACv3nOhhDhdyndlU8F6YIKqPz1Gh8xX8=;
 b=saiioRyylZAxl+wmEwAuWr/X9JJO3/0jcC7Fx87NiqTlRnlO/L4A1IaP0xRb5VYhuiwZVzd0GIRgzMHHyKWdInQ8vw99Y0FGk3Q8/A+ihfYOcg/aua0Cufz39stV5/ZteoHqc5tsEp+XOXWUoGqdzFStI0qanJoY1/KitHwbuZ1v8cLhaGgmpGM7BeblIechtD7u0z2at6sgZtBT9p6Q+fiRvnGWDPaC4QfmssCJqZsDQSWAVPYBOVDF7+LTcQ62fsbtHmz7H54Mkpuxdr5JXkyk4v4EqgfEYg3B6xG1ZIv2/uXFRO0oInNxsGoZ+wZHynPeKWDsDE8iWP4Cf380vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftQQjhIwKIeACv3nOhhDhdyndlU8F6YIKqPz1Gh8xX8=;
 b=bmu56XZPYC49ZJVZoDNtbw7O3gMGDcLLyoQZaKrmH+ayQS87U+qI6lLZkuU/m5CvZo/xcS+Sl7fMfxsszxFFD7CmPeXcPVFx3tkn4M31KQIZi61jeG+GUzq7pjoNsG1od2Z13I3yx6wRCsv66cSXL7RKwlGuS9CQohy0yPvEwiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.21; Mon, 9 Sep
 2024 06:51:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 06:51:54 +0000
Message-ID: <46d26fe9-b79e-4fbd-ad88-94f558fc772f@amd.com>
Date: Mon, 9 Sep 2024 08:51:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Deduplicate w25q16dw entry
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Neal Frager <neal.frager@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>,
 Vignesh R <vigneshr@ti.com>
References: <20240906210951.193142-1-marex@denx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240906210951.193142-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f2253d-23ea-4ccd-0aea-08dcd09be3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXR6TElROG9KdlBVY0FzWUlKUVE1RE9ucGxqaVhjZWFPNUw2ZWlmdU1QSWJR?=
 =?utf-8?B?WlArNC8yaXBFdDFRZTh5Qkc2aHQrbWJVT2pQbXp4TjZZQ2E2VnUwREtIM0VL?=
 =?utf-8?B?OUw5Z1BJdG9WQnR1ZTdUZnpZZ3hhZUFxdVM3UUl5V2x2USt0Y0hKYXVTTnVV?=
 =?utf-8?B?Zk1ZakcySkFDYWZrWUFxMFZuN3lKR28zYTRFc2NxUTY1M1hxRlUxMWJUQXQ1?=
 =?utf-8?B?SVVuTVFTTkoxNE1WSFZhTWRVMjFYWlZmT3RPY2Vqb2RYNUc2UktxZFZuclA2?=
 =?utf-8?B?SmNvY3NrYlFscU5BL3h4aHFiOSsxZGlQS3IvWmllVjVzR2tzTER0KzlJRDVx?=
 =?utf-8?B?WjYyejcrMUpMM1QzYXZva3dIVDc5NE5icHFwOTc3N1B3OFAvemc2YmRMZGM1?=
 =?utf-8?B?cTdnVlhUYnpEd1RBbUVzdHo3RERjZmhtazNvd25aaTVSc0xsVlBwVWFPbDJE?=
 =?utf-8?B?S3NxMWpTcXo2QXgvR1pOSlNVZnhxRmpPMGpCTmVCaVBOV255OTRZcFR4MFFO?=
 =?utf-8?B?ZmlhQTRtR0Exd3lrc2VzeWw4MnZIUTdNeVRSZWdNWVRGN2ZnWldkcXZEN0tM?=
 =?utf-8?B?eHFEV1JtZk04MmpwcTM4cTNIbmVWYzZHTlhPOVk4S3NkWHdtUjQ2b1hzbjBo?=
 =?utf-8?B?YWM1L2Vic25nTXRVdGkzWnM0S3FQSXNMZktaTitLU1EzcDhMSWszdmZRQjlt?=
 =?utf-8?B?VVI0UGFZYWd5WVJpQjNZakVJYVY2bVFidVVmejdsRDBLZlhYMHA2ZkozaVZL?=
 =?utf-8?B?Z0wvTEVrWktTd2dpbDUxYndvamFyU2N0ZW5ZQlRJU3AwNmtxUXRTVDhwWkU2?=
 =?utf-8?B?c1ozVjNxTFlMaC9jaEVEcTNweTIrSkNnNzU0NEVjbXFnaEVqdGU4SnpFNDQ3?=
 =?utf-8?B?TmRlYlg3M0VYNkM3cloycUVaN0N5cTQxNUNjVGU4eEZGbWovWGg5NVFValhs?=
 =?utf-8?B?aHJBbkpTQnhpRnlUeFpuWDcrVjVmdzhuNDZPNGFqMFZsOWh2L2pONU4xazhU?=
 =?utf-8?B?K2owdzMvSG1neEpXVTlOMERBWk4vSkdxS3Y2ZmV5VE05SWJYWDlBNWZkOUFK?=
 =?utf-8?B?VzE0bG1wN3FJeVNmZE1kdkVTMUVzc0dQaTFja21zRW56WXVOT2xvTUU4Zyt6?=
 =?utf-8?B?Sm05WTJsNXdYSTFYTm5RZmFpNHhHTTFYL1VUaDVnWXM5ai9xdk43eXVUajV6?=
 =?utf-8?B?VytYTFJiS3JkVFRtVWZTTlJNVThBZko4V2hXVnpGKzJ4bGE2MzdDN29NN2pD?=
 =?utf-8?B?eEJpeEhUQU1SdlhNWmw4U2d2MDlaSmZINWxZSEpudzFIdXAyRHVSTUVIdVRp?=
 =?utf-8?B?UVgvNzJEdEV3ckIyYVVVR2lkeXNXQjZzQW0yYmtaQW16aGFRQ3hMMkU4TXh5?=
 =?utf-8?B?NlJIcE1mL1JWSDRodlloQ2lySDNtZTArcVp4SVNRdWsxcThQcHZiTVpLWU5I?=
 =?utf-8?B?djFSTWQ2WG85NlhFMHdjVzdhaDRkRGVLYW1wNmtTZHVEcnlUOHhoYUJYdnl0?=
 =?utf-8?B?UEpuY3VRQUh3TXg0dWtaNlF4cmRBTlluTldpdk9mbmd5Nnh2aFkyb013UDNj?=
 =?utf-8?B?NlEyR040S2pibk9OTS9pTE91Uk1LdWpFSk5RbjFvREhMSDJoQkZuQk4wMm1l?=
 =?utf-8?B?U2ZZN1Nva1NGQ0NyRkJzR2ZhSDAzRGhPWVIvbXdneEJNUHc2WUZLVnhhNW81?=
 =?utf-8?B?QjJyR2ZScjhqRVYrWHg1ZEt2OFZwUFBxVlZKOXFaSXQ2bFpMeGZQeG5Ddkgr?=
 =?utf-8?B?ZlU4V2lVbkFORll6a1VOdGZHMVlMUnhHUGd0RkFzMWNYMFhZSWM5Rzg5c1Rl?=
 =?utf-8?B?cDFBY3NOTFQyQngvL2ZzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVYrQ1hKTmZkQWtCNTIzU2szUG9wcDFUTWZkd2R3c0hibzNiNnU5SVJFMjVU?=
 =?utf-8?B?Rko5YWRRMmRxTjJNWGQzdThLTG10QkRqU3krSXBvZGF5K3FqY2tuWVlpa3pa?=
 =?utf-8?B?SHNZcWxDUjN5QUluL3IvWnNINGVVazRFRHZOOG9NcCtPQ1RlN3JuQWNqV1FB?=
 =?utf-8?B?RHNyQ3R5SndpMlVqYXBsb1lxM2tGSzZhVlZCMGx3cmtNRzFMUGE5ZEN4ZnNL?=
 =?utf-8?B?T29vaGcxMDJ1VUExMXNQZnIwNXhkVVNWWXA3cCtIUkNseXFkNk5FOC8xOFJo?=
 =?utf-8?B?VlFIM0tUTnFBOHNHTVBjSGhCVk9SYTAzWWJWbVRUYkZpTXFTQ2MzLzY5YmN0?=
 =?utf-8?B?cHBLQWRQeEU3Q3lYVlRBeEdUeFM2K003ZVltYVpTNlB5Z0FkNjY5cW93QjhN?=
 =?utf-8?B?ZUIrdFpjeTlNTEd6RW9oSndCTGxiS2l2UHV2dXl3QzVWZUxZeUNycGsxdnpM?=
 =?utf-8?B?OFZ6T3pTakl6YnZTa0xUVjNUOWRSTm1tRnlUblYxODdkUjhUcDU5MFQ4Y01H?=
 =?utf-8?B?VmczcjJFYkplQW5iNTJVVzQ4RVkrbCttV1BEcmhvTlZyVlR4NUxhK0g2alBK?=
 =?utf-8?B?a0FzcVNKZHJPb2VRekJRM0FrNVhKWWd0SlNzL0tMeC9WOUxUbzJ2Q1owUVZp?=
 =?utf-8?B?SmI5U240YTVEdEZNWElFMk1kdnlWUGNwRnpFOGF6WXZkT3dGTGJTODRmUXBa?=
 =?utf-8?B?U2svV2pCOHZ1cjJXR0RWS0diM2h3dnRKdWlxbHBSWjljYjVLM0wxdDhpMEhh?=
 =?utf-8?B?aXh5ZHBEUE5zdS9wbVVjQTUvNWRsNGl0Y0o2REczWjBFQkNnSm1MOEx0N1JP?=
 =?utf-8?B?NGdxbkdYU0dMSENoUmpZODlyYVhJbjFOMGlhZ1FmaDZQRk5QUlJxaitzTVds?=
 =?utf-8?B?cVJBbWxzRzN2L3JtNUc4cGNDZzk3Vk0vRjdOSFR0QkhON3ZFcEFjV3QxZ2x2?=
 =?utf-8?B?Ylh5TEZzS0Vvc0xBOGZaTVpHV09XaDdpemdnVCsrRzg4NXpEdEtlUmpOT1JS?=
 =?utf-8?B?WVBrZFdHMlc5R1N1U0hkK0V3eXM4amlFQU93T3ZlN3BrZTAzMFp3MVpZcW9r?=
 =?utf-8?B?SzJHMDgzaHUwTGh4bDFYUlRCV2ZFSVFmbjNqbkpvRlZFOHp3dGhFb0RCc3FH?=
 =?utf-8?B?cElkbjd5ZE9rK0NaUXFqU0pmUVRqY0NMaHZialVzb1p4d0t4cXBHY01nQ1Ir?=
 =?utf-8?B?T2NHR1hLUG9ycEJUclhWZnVHdzFmUituUU1BRWQ1eGJkdWJpY0xNWU5rUWY0?=
 =?utf-8?B?TmJYVmpleFNzdHBIS09rZklBMHVpSTQvNkxnTlE4WlR3MjZUZDFKSjJldVZr?=
 =?utf-8?B?UVFsTU9Fejg5MkNYWmhESWEzQTFyNCt3c3ZDUjUzNllLT1JQQlRSUzRibTFJ?=
 =?utf-8?B?aVRjV09iam55emQya1dxZ0JVbEJSQjQ0SEhBV2dsbTZ5MjdybkRqQ09EWjRk?=
 =?utf-8?B?R2k3M3NHWjlFUU9JOVRmbUU5NTlCWmVYOU1sbm1IcGJ4aVVhWklHT2owSjFy?=
 =?utf-8?B?Ni9rWU11Tkh5RWhtV0NiQ3UyMVJmbDRTcmR6N1pDRkVDZTFMVmhkeVl1U2Nl?=
 =?utf-8?B?eElSanhGMDM3bnhzUFlXY2Z4aWZDUGM3cWxraDZ6MVhSUzhMNVJza3N4SERn?=
 =?utf-8?B?TzRZN3Y4NHhmelFCbHcyV29vS0hWOEREb0ZobllLS1ovRm81eld2R3RWZUFG?=
 =?utf-8?B?b0I4WUhUeUdtMlgvblZORkIydFNYU01xZ1hjNjcwZEVMNnlIZzNHVDhQSE9F?=
 =?utf-8?B?ODVvVW5meEF6aHlOQ2FkODRMSlB5ZmtMQk1LOG5yeUdBd2lCOVZ6bDJPek5S?=
 =?utf-8?B?S3BicUJFNTdTL2VEMTltK3c1Wi9EWmtvdnNkMGNDS2NDaXpMUGdDZFAxSG40?=
 =?utf-8?B?cE1VZ0s3ek5jQkF2dUpudWJ1Mnd1cGVGMDFXUncvN1IvM1N6V3h3OTdQNnoy?=
 =?utf-8?B?SGpLQ3dZeWNVNi9GVDR5VXUzUG4weGJPSFRaQVMyeFVrcHhTWlRoV0FEeFdh?=
 =?utf-8?B?NXNaajdHa283OGc1bG43TVNwaHhnbERBL0gvdUI0ZTk3YU5lSTV1ditpYk9L?=
 =?utf-8?B?eVIzN3BnYWtDbEt0VDNqSDhpY1BEQjczVEVIWFpVMFVBQzdIb0NUNWpBSEV5?=
 =?utf-8?Q?1WoqBWfG25j8FxfOKmyicn5g9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f2253d-23ea-4ccd-0aea-08dcd09be3c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 06:51:54.1786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLAgZW+/a+TrjZR7cevIdsAtQNo9Ipkluuk2wepihmb6SrzAQTuw0BNcTjtkb7R3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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



On 9/6/24 23:09, Marek Vasut wrote:
> The w25q16dw entry exists twice in spi_nor_ids, remove the less
> complete variant of the entry and keep only one copy of it.
> 
> Fixes: baef13ec9d59 ("mtd: spi-nor-ids: Add support for flashes tested by xilinx")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Jim Liu <jim.t90615@gmail.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neal Frager <neal.frager@amd.com>
> Cc: Prasad Kummari <prasad.kummari@amd.com>
> Cc: Teik Heng Chong <teik.heng.chong@intel.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 88709a52b3a..d1389e681d6 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -430,11 +430,6 @@ const struct flash_info spi_nor_ids[] = {
>   	{ INFO("w25x05", 0xef3010, 0, 64 * 1024,  1,  SECT_4K) },
>   	{ INFO("w25x40", 0xef3013, 0, 64 * 1024,  8,  SECT_4K) },
>   	{ INFO("w25x16", 0xef3015, 0, 64 * 1024,  32, SECT_4K) },
> -	{
> -		INFO("w25q16dw", 0xef6015, 0, 64 * 1024,  32,
> -			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> -			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> -	},
>   	{ INFO("w25x32", 0xef3016, 0, 64 * 1024,  64, SECT_4K) },
>   	{ INFO("w25q20cl", 0xef4012, 0, 64 * 1024,  4, SECT_4K) },
>   	{ INFO("w25q20bw", 0xef5012, 0, 64 * 1024,  4, SECT_4K) },
> @@ -442,7 +437,8 @@ const struct flash_info spi_nor_ids[] = {
>   	{ INFO("w25q32", 0xef4016, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{
>   		INFO("w25q16dw", 0xef6015, 0, 64 * 1024,  32,
> -			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>   	},
>   	{
>   		INFO("w25q32dw", 0xef6016, 0, 64 * 1024,  64,


Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
