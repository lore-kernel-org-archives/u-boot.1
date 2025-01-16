Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10599C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893BF8022B;
	Thu, 16 Jan 2025 12:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WtdtK7GT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886188033D; Thu, 16 Jan 2025 12:33:11 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F14D080214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c52Yr77J9FLe+ph+O0UQoTkl9S0O3A1X1Wl3/Hba+9iwg/XryUOS2c/TfwhJbhC0kdWHDi7AzZh9+UAiVhwwrHQ3bu5f0iyYLPViUrKTxFDDcvbR88EsmBHNbjAmDB7PBeFP6aQttVLmyS97aj7XNBdxXwr6BxMrEL7x32VeS7VaUA8mpxiF06bjScf0h1SQm/Z4XAc+zmQQPrpm4FZ/CMSTPCkyoL7TLJgGpQ+YbmxEoOEtx1b90+7tZKlfVjon1QDnIjAVdAWaDXN7NuJB49LE8QjDPUfAMUDeyEi7SjHwtg0BIWSWcplPQ076p4rfV0OepHDZCA1Hpb8bc8921Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPjYk1JnDZ3TEShP2OLtNI4QRJ5jQ3pPzUZDTgEVAXU=;
 b=gwfci9tV1T58k4uB0pa3xbOfIL6IN9mc5lulZfnTjsqLKiDlbLZCsXt9JTwc1wSPoHhG///yZPgRjIxvsKbNh0s/tLc90Nh6ISuamu7F60EK/kSLEP9LyuEpN5Hucp6HhnLB/xVwOGHSkAS88yM8apcVTnF8qAQXe70eUdX0iRsfbw6xoDIzBOotx/UX/uFsfXZa31n1b101ZI6rUHbltjJV/5ysVF2qdRD8eovsZL/gD6ECR0+w+Ev0QccjnLrQGoNj0sz/sZvj1rc80/+q3lLaUKj0Xx7ZhVjvf0mx9KHVcZkbI0kOGu9ZB7RhxCx0KE+3afB2V8DuHP0mT+s+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPjYk1JnDZ3TEShP2OLtNI4QRJ5jQ3pPzUZDTgEVAXU=;
 b=WtdtK7GTpmaDo43096WWdEd0CurtM0zFIRQ2+NDqh6fOZ1S8mmlBbOEpvhU/znBxG8OS1+CLYYf79HvbFNr345BQ7ZaeAc7HPnrXr7F5stYwOl0sIRHR5+ozuMD7c/BfGRydU0lH+GD5t1NbogaGb1HsxMdSmrE3wIcQbQkhLxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by AS2PR08MB10033.eurprd08.prod.outlook.com (2603:10a6:20b:644::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 11:33:06 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 11:33:06 +0000
Message-ID: <d823ac5c-560f-4efa-9118-9b9a4596791b@arm.com>
Date: Thu, 16 Jan 2025 11:33:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] board: vexpress64: default to hardware device tree
Content-Language: en-GB
From: Harrison Mutai <harrison.mutai@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com, andre.przywara@arm.com,
 manish.pandey2@arm.com, u-boot@lists.denx.de
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-3-harrison.mutai@arm.com>
 <CAFLszTjS2mY1FrWM9dLAwOZ1soiOBP6GgMOYWwYQP6XPw9L9EA@mail.gmail.com>
 <acbadc6f-9e1d-47e6-b3de-d7bf47a4e14d@arm.com>
In-Reply-To: <acbadc6f-9e1d-47e6-b3de-d7bf47a4e14d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::21) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|AS2PR08MB10033:EE_
X-MS-Office365-Filtering-Correlation-Id: 28785316-0455-4817-e433-08dd36218bcd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elFXTFF5YkFDR3J5b25mbDhVK2ttTCtVb2pDTkJ4UDBCNTFtbVJ6V2RVcXQr?=
 =?utf-8?B?Y2dCTXBITHNkL0tpR0xIYUM5QTA0SVRRSTRRa28zZGcvMncrejJNMVBLVVYx?=
 =?utf-8?B?ZDEwd2E4MlRDUml2R1dMWTFPenNDOFVjSk5keDhUNEt6TFhKaVErbE1nZ204?=
 =?utf-8?B?b3NEQVkzd3orZGZwRndvWmlndXBYS2dyQW1DNUVEMnE5elEyb05VV0RpaFAx?=
 =?utf-8?B?cGNmYnRtVFJLcnZ3OENJbVVXNEhzbU15RVdkNjcvN3FTRGxVVUZXRTZ5bVZi?=
 =?utf-8?B?Z1gvWktGOXFiOTZTNThLU2pzemRhSUhQaWMvTUtlekRaYk1JeVUxQ2o0RXBX?=
 =?utf-8?B?eTVHTXVueDliZm1McDI1V2RITG9ORk1BMldGcTluaVVJUGlDRmRObE9iODBa?=
 =?utf-8?B?N3RnMzJTbDI2ZVRFL2xyb2VENS8wRlcxZ2M2K0hVdndBVk1IYzQ4YnJoSjI3?=
 =?utf-8?B?Wko5ZUFTeGdUM2pmM0YvaW03K3ZtcmFlNW9FMEVVZ2VkdDhLQTZHa3pCUW53?=
 =?utf-8?B?SVM2NFBWVFU3YW9EZ242WGUyVlE2YU5zK2RhVjVISVUwOVB3YVpsYk1UNzlU?=
 =?utf-8?B?bTNzcHdTNXdRM1RDUDRRRFFtem5GaWJXYXZrbHViZHlidEdOa3JlRUpnVVBD?=
 =?utf-8?B?L1RwRjE1VVBGSXdYK3ZrWjNEbVUzcm14NEZUV0FvbTYwc0piRnA3eWg4bEYy?=
 =?utf-8?B?ancySUlFaktoK2dyMXgyY1RBUGFObm11dmg2b2JhZzNUQ1ZlQVUwcE5HS24x?=
 =?utf-8?B?RzJnaXM0SGRUMW1SUzMzVWc0WDJWSU9VcnZ5RHdQbS8zR3lmL3paRjdNRGhk?=
 =?utf-8?B?VkNjVGdZNVNiMGtvRTJvMWhqbWJmLzBUbFdHUUhndnhVdjdKN0JLNU5GS3Q2?=
 =?utf-8?B?Z1NYcDdQVnl3WUJtRlRpeEZZZ3VTdUZKNHRYL3dJMkZzY2xyd0V5RDdKWkJD?=
 =?utf-8?B?UVFTNUFZeEU4SUt0b1gzT3dVb2tLQjJNbE9iZ2diS01POWFzN2lHN2hOaHQ2?=
 =?utf-8?B?NzUxci9UakNLOHZjY1hFQ09mYldPa25IYk51NWs4c0tsZDVaV3NsZUtYMEZy?=
 =?utf-8?B?OXBHdVU2bjdkSXJWRXJUUG8rNGFDZnhrQ1c2eUtobjY1UlU4eW9RQUZWT20v?=
 =?utf-8?B?SXNvNGkzcGhkYklxZHhXZ3JjNWdzajVtcmg1cVpvVTI5VytkT2JEMlQycmtt?=
 =?utf-8?B?U1d1SkNwZTREbjlZd0diUFJjQlgvWTNKNk45cjNqSEVJYlcrZmN2VlJickZS?=
 =?utf-8?B?VFFHNm1LUjZ3TWkrOGZDT0VaU1JnMkNJVkhqNzRsRytka2dWb0RqaUNtdzlw?=
 =?utf-8?B?WFpmK2NsL1pzUFB0NytMb1dkMFIxRkthQi8vQkhWU2NTdWYvd1BCMmIyNUpF?=
 =?utf-8?B?cTFGVG9zaFYycGlQaGZ5b3pKVmR2ZEdDeG4yVGZXV2FQT3JkNjhEbGdWckND?=
 =?utf-8?B?S0xvaUJZVlI4TzNqT29QSEcrc0JwTjJ0SUxxaXBzRkJhQW9Mci9ZLzJoS0pq?=
 =?utf-8?B?QnAwZTNOSkYxZGxHZVVDcVBYMmx5TkxDbzhkL2tJRG5rcVlWaEcyRjFjTlZt?=
 =?utf-8?B?alMyeHNoVFpjeWVzOFVLemJGWkE2WnpkT2FMdzMwN1lRWVloSStYbGhaM01R?=
 =?utf-8?B?MnRlQmJHUVBuVGpOeUNzWmNhNUpGV2NIUlJaYlRvOUgvcy9OMkpwWjRURmg4?=
 =?utf-8?B?Q3E4a2xKM005ODdCYlZ5VFFaVFZwTXNVYnZISEw2MDZZTUxNRlM0OUh4YlBn?=
 =?utf-8?B?Z2M0aUdlY28vM0ZhMHpnZnBjTWJDSU9tZkMxUW9paERGbEdOdm9IT1BKS3dl?=
 =?utf-8?B?Unc5d2Jzby84Um1QL1B0VDhlVFhHTlBwVDJGUVA0a3dNcER4L3hEcUErdzVV?=
 =?utf-8?Q?eAkBBlyZOntmW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFhrRWRqOGJYRnRmdzZ6RURiaUpYakdjc0U1RVJnUWo3MmRyamtLNGpKV2tw?=
 =?utf-8?B?VDJmVHdiOC9VLzZqam1nWmpmUWhTL0ExekR6eWJWaGNiREJZeVN3U0ZzTmRr?=
 =?utf-8?B?NHBXcE54dm8wRGwrdm9MaVJvWGVkM2FDODJoVmtEaHNvOXpIQmZSU0lycjNV?=
 =?utf-8?B?a2Z0ZGhjWFZLVFRtWHJKeVJPVm91QXYxQnNVbGNhaFZHbitjTTEvUWNaTXgy?=
 =?utf-8?B?cGs5eWQwMiszWmhuRlpWbEsxNUZGQ3lLT2Y4NDFjeUovVGhGUlh3YTArRlYr?=
 =?utf-8?B?Y3dOZVhvaFQvbnFoNjJ1K2pVZFVPblplY09rRzZKRnZlVHBQZ1pWQ0hpOExw?=
 =?utf-8?B?dlhPMm5HZEVENnYzYWRKdkxkY0FGckprb3VFZldYaUQrYml1SnFRZ0d5RVA3?=
 =?utf-8?B?b3ZXdzZ1am1Oc1hNZkpOSkg2M0tKS2UxNGN2S1E0MVZyQWNGdkdFbFRXZmMw?=
 =?utf-8?B?RjQvbmIzRTVia21VOXZDdk1QeFdhT1crOEVEWHNrOU1zQ1FUOVp2RndtbGxj?=
 =?utf-8?B?cFlOL2pFUUE2eVZWcitrUWRpU005M2dFcHFpM0llTXFQQjgzbDZtUzdiVVEz?=
 =?utf-8?B?MnZhZFd0d1ZvVXZ4VkFCRVBtUHNJb2RocUhWK0xhUk1LT2lRKzh6enFDMDZY?=
 =?utf-8?B?LzF2QUgveUNBd3p6YzBLbGhDNk54RXVSMmhxRGM2cDV4MHdKU0FvNlpHaVJZ?=
 =?utf-8?B?RE9FMWNxK1lkSm9vK1BDY2pZUVAxaUFqRTBNUStOb3doNVZRS2MvdkpKOFZa?=
 =?utf-8?B?QmJES05Ga1hIcjFDbDJ2TFcwNmZvZXVhRUpnVkNNL3RBUVl1V3piYVNLTW9F?=
 =?utf-8?B?YWo1MXZUVWxwOWkvZk4rUWJ6NVN5NWJsOGM5SzBpMExPem5vMmh3Rjlrb0NO?=
 =?utf-8?B?eEhOamRuclc0RUVmQTg5Z0tCQzlGTW9hVk1rdUN5ckowRzFtQ1lvYmRET0h2?=
 =?utf-8?B?ZUNFcStqR1NTTWgrUXpVL2lBc1BHVUozK1ZqdGhsbnNXZE5XV2xrbWdHQU4w?=
 =?utf-8?B?MUc2TGhtUCswQzY5d3pLUGtmVlFxZDlqNzd3aUNielk5MjJWMUVyZExyaW5G?=
 =?utf-8?B?TlgwajVXRjR0dWdrcTZlQTI1aVI2ZDYxZlIxbnZZNng4SjlHZXVxMG52a3Ix?=
 =?utf-8?B?dnJnN2gvYmhQWVdUSHVDbmVZN2hTZmtyamFka21zTmdZUkE5bVVHdFJQM2lI?=
 =?utf-8?B?MnYyczJWQjZsYTBiZ3BhMGRneTVjMFdvU0xKbkNBYjgvcmlnUFZGZFdCM1U1?=
 =?utf-8?B?TXZubVJxb2o3b0lFcnV4Ung1aE4rbFNvNnRWSEs3THRidGNLdkFrTkF3RnRt?=
 =?utf-8?B?MXJRRCtsRlFUejVHY24vd1FkcnhVMiszaE80Yy9FWVc4MFE3QmFERUxwTmYz?=
 =?utf-8?B?dHAvQ2U3TWtjcEN5MVZoQ2VpeW1IUkpVUkd6cUJZTjM1K1ZMZnlhWHpEOXBa?=
 =?utf-8?B?L0I2OFVNN3UxaE4vd09LVUNGY0ZPakZReHZYV1pTYkFoUllPK2l2a2w2RzBv?=
 =?utf-8?B?cWtJZ2RKUDVIaTVxNklnVWhsMFNRb3VGSlg4dlVMVjhabkpyUXVtckp6RlJR?=
 =?utf-8?B?L0VvcUtNNnpJR2ZlclM2QnVIenZjYlh4bVk3Smw5TlNDWWRpeTlIT1Q0eWFY?=
 =?utf-8?B?QXV6alVwRDZSVUpTTWZYclVvSXVVeHhtZXdqL3dsZm1QVk03NXZTdm01ekc2?=
 =?utf-8?B?TmRPbTUxcWZVNEdacTRqcWpWZHM4L1JKeFJXdUVqWURiNThodXVSQzlKeWFP?=
 =?utf-8?B?L1VvVExoVFlJV0tHakErY1lKaGJjakJUc0JLNndnMHNnTVY0VDB1clpKSzdZ?=
 =?utf-8?B?V3VRMUxOUU1OTVhZdUlQOGpYQ3lERklKRXNDYUYyNER0NzdsWUhkSEN5RkZK?=
 =?utf-8?B?djNCSldJY0pCZm9KdnIyWERxb0lJdHByREFvUmt3N09URlB6aFl1U3kvTUNQ?=
 =?utf-8?B?WXpGQlRQK1F1SGxlMVZwOE01NUswZ2tJNDQ3R2tJMndHZUtWWVBYa3k0cjBh?=
 =?utf-8?B?aHMrYWlTbkN4L3ViNDZHUHZPbHhVbnZTWTZqVmNERUdkcVU3UU9sTmk3YjFE?=
 =?utf-8?B?M1JJVWJaSXZTN0FZbFI0blp2YjVGTS9KYm1MSWNuT1ZObEtMNk96NCtzQ25a?=
 =?utf-8?B?dVcvSGxvK01NcEM1QkpHRTl5LzNQSSt1T0xvSnk1WklYUXRidkpoM0ZjNnRi?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28785316-0455-4817-e433-08dd36218bcd
X-MS-Exchange-CrossTenant-AuthSource: DU4PR08MB11188.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 11:33:06.4830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSZoBgn/IMBuGZ7+wt5LHi1qdj8rU1qnSQVHPtfE5+5HKY9uzvCkelR2Stw321SzZPKO6PFSc0+F6OxveH0EuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10033
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

On 16/01/2025 11:20, Harrison Mutai wrote:
> Hi Simon,
> 
> On 16/01/2025 01:26, Simon Glass wrote:
>> Hi Harrison,
>>
>> On Wed, 15 Jan 2025 at 06:52, Harrison Mutai <harrison.mutai@arm.com> 
>> wrote:
>>>
>>> When booting into the Linux kernel with semi-hosting, use the device
>>> tree provided by hardware unless one is provided in the current
>>> directory.
>>>
>>> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
>>> ---
>>>   include/configs/vexpress_aemv8.h | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>
>> Thinking about standard boot, could we add a bootdev for hostfs? Then
>> we could drop these scripts.
>>
> I have a patch in progress to migrate vexpress64 to standard boot that 
> tries to do this. However, it's not quite ready for upstreaming. For 
> one, there's other boot targets in this file that would need similar 
> treatment (e.g., AFS, MEM). Would it be possible to transition these in 
> a piece-wise manner?

Notably, we do already have fs/sandbox/host_bootdev.c. What was the 
original intent of this?

>>> diff --git a/include/configs/vexpress_aemv8.h b/include/configs/ 
>>> vexpress_aemv8.h
>>> index 8020689e39..2341b3a938 100644
>>> --- a/include/configs/vexpress_aemv8.h
>>> +++ b/include/configs/vexpress_aemv8.h
>>> @@ -169,12 +169,14 @@
>>>                  "  if load hostfs - ${kernel_addr_r} ${kernel_name}; 
>>> then"      \
>>>                  "    setenv fdt_high 
>>> 0xffffffffffffffff;"               \
>>>                  "    setenv initrd_high 
>>> 0xffffffffffffffff;"            \
>>> -               "    load hostfs - ${fdt_addr_r} 
>>> ${fdtfile};"                   \
>>> +               "    if test -n load hostfs - ${fdt_addr_r} 
>>> ${fdtfile}; then"                   \
>>> +               "        fdt move $fdtcontroladdr 
>>> $fdt_addr_r;"                 \
>>> +               "    fi;"                       \
>>>                  "    load hostfs - ${ramdisk_addr_r} 
>>> ${ramdisk_name};" \
>>>                  "    fdt addr 
>>> ${fdt_addr_r};"                           \
>>>                  "    fdt 
>>> resize;"                                       \
>>>                  "    fdt chosen ${ramdisk_addr_r} ${filesize};" \
>>> -               "    booti $kernel_addr_r - 
>>> $fdt_addr_r;"               \
>>> +               "    booti $kernel_addr_r - 
>>> ${fdt_addr_r};"             \
>>>                  "  
>>> fi;"                                                 \
>>>                  "fi\0"
>>>   #define BOOTENV_DEV_NAME_SMH(devtypeu, devtypel, instance) "smh "
>>> -- 
>>> 2.46.2
>>>
>>
>> Regards,
>> Simon
> All the best,
> Harrison
> 

Regards,
Harrison

