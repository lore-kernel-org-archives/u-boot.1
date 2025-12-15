Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45444D5B16E
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 12:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD3080050;
	Mon, 15 Dec 2025 13:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YgR5DDAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B20980077; Mon, 15 Dec 2025 13:25:18 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591A08003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 13:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy0/QO/WwWWQb+j9jRnTO21JbrIrdI4pJWHrq56ZVy/DfdpUpXHyWy6rU2SQwUoVob8slecoNxEEfYmQ7p3DmhDBTDRBAxoIl0lesTWnNDO/5ErMP8JyKMUy6Zuz4n8FRka6b0G7ydDdCuZp66q4Jk+GLKyZSHsum936amsUKz1P5WY5ubR/GK18ydLhqKUel0QhmFZl31FDceQ9+t5qH192nrMGfflAAqVXikRPY18DbZ8zvnwDFdKdsWEEHG/qtwZZdm+wT86vPTNZXRoenhpoSbK/Ce97W9B6opo+kBXARJZhWCTSooCPC/Y907g6rVrmIaPc9RXzPCUx8oyfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSBe4Q71giBxTTy8nDq3qL8fOnPn4vgJhA6xg4QdyiA=;
 b=EEPKxmYnGuLQbVDsmJnEgpd3P4lfntyOt+yPgL517YWEsAA3UUgB7yffO9Z7pU/MVm9yoC6cpyV/nygHkjrZGSGqhcPcHT5rAFa7jh0UvDNJN/9LSLte4AHl0KgLrT0TkAipB6TKYyxRqXAMr4GYR3OPqLNPF0F+AipE60BYrQ584vcfQD+xBkw4KB+KpwwNZZFv3zedKyAbF9YQLKXH91AmaRzA6l1digixpexxAYQFUg9seeVFPaC6SjfLT4bR2OEUQ58SZmkGCKx9Ee0l2ngwDtbYCjDRSXlhitN51ctdSS5RA7YzWH7Z6oWEr5wUy7ifoVhwRylMCUx0tDzhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSBe4Q71giBxTTy8nDq3qL8fOnPn4vgJhA6xg4QdyiA=;
 b=YgR5DDAJIz2S+jQJyOmu3nkPHnaD6rdUT+xplL2wCyRgbhEkvOUCWdlYfNT8Q4kz4/B++eZJHeil5TVYlW6E8go5LP1mm6eWm5ShjoJkCNIujAANXgnRYqWYkdmELjMIJafmE4diKAAhuD/aM/KKG1tnM/S36kfMmPUum9SuGoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA1PR04MB11384.eurprd04.prod.outlook.com (2603:10a6:102:4f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 12:25:14 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 12:25:14 +0000
Message-ID: <8f5fc06e-ffc5-496d-a0ba-b8746a4a4b89@cherry.de>
Date: Mon, 15 Dec 2025 13:25:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: ext4fs: Free memory while handling errors
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <BESP194MB28051D632021995D4D572411DAADA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <BESP194MB28051D632021995D4D572411DAADA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA1PR04MB11384:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef31450-8b56-4c2e-14b4-08de3bd4ff88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTc0TEJLVGtTVlFWRnpTd3hYbnNlRmVGcjZ4WUZaNzhISUdXN3o0bTNxRHQz?=
 =?utf-8?B?bUZXSG9wTHFmYU5keVBpMEgyQlVkZ2RFVlpoL25JQjVMYzRtNEJIS1FaVzBQ?=
 =?utf-8?B?SjdmS3U2WVhZTjNBYUd6YUJzanhLRjM1N1BrZ3A3WCswczF1UUk4c01DQzRS?=
 =?utf-8?B?aGZKVXR5N0RZbmhNaWdTZGhoc1dCS2wwQ3AxUlNoSEtsei9HSXJhWjZCT2hG?=
 =?utf-8?B?MFArRStGTVFoSlJIeFp2REpXWVN5T3pzQnRycWRhTVpSczVkdTNoMWgyME9s?=
 =?utf-8?B?cC9iR3JnakJ5NzVncW53aDNDY2hRVExReWVLdGh6cDBlc2gydzhXWms4MThx?=
 =?utf-8?B?K3FGTWlsNlJZOXpqZGhtSzVESDBobkdQRlROQmowaHc1allYM1ZMV0FRd0FO?=
 =?utf-8?B?bm1aMG1PMWlUMzFUbEROQWRZUlpnSkNYSnZvbkNTTlhNZHNXTmlXVGVnc1NP?=
 =?utf-8?B?NS9qTUZrSjJNL2d3UGV4M3o5eE8rMnZsWlRZTzVlSktpTkJkMFRFa01NZytQ?=
 =?utf-8?B?ZFFwM3cwd1U2SXEwMXZ2Y1BacHVIeVhZREQ2ajZwc1R4RmFYY1NZUldnTmxB?=
 =?utf-8?B?MTdCQmpOYUxROTVKalN3bWo2dWVIUVZQblkyZ3NIdDVTVWt5QzVXR2drVDhn?=
 =?utf-8?B?TkIxbWs0cHZhMVM0aERla3BJZHFlakx4b0NZb0RmV0tLTlhYUlBwekJnR0lo?=
 =?utf-8?B?UkNNT2ttYnNMb3R3bXE2R094UGRYTlJoalBHTVV3Um9ZU1daaW01MUpyTDRI?=
 =?utf-8?B?T2FkVGdTbUJnKzd5S0o2V0pDS2VQU3ExSkN5d0NWbHozazhvSE1nNVp2bEpr?=
 =?utf-8?B?WWRSNGFXaGhjTHhGaWdSYkpmdXh5VzVETGs3blc3OHNtaGRhVVd6ZmRJSW9R?=
 =?utf-8?B?Y3NTQ1JZUGVpR3pIdzJva1ZKK0lHSStYd3Z4ZGdwbWlnYTFjNGx0VDlibjlN?=
 =?utf-8?B?Q3R3cTBheXFrcmVXck1adlRyVndTTElFbHBmZ0IrbU9oZHFaYUY4Y2VnWXpH?=
 =?utf-8?B?NWcvL1Q1cUNzOE1rdW9wbjh2YU8zWENHODY3SXRUU3BadkJrMEk2aE5iUTdn?=
 =?utf-8?B?SkI5L3B4c2RoRUpvVGRQTWozR1VZWnhMRFBqYjg4Z0tXenpObld4WkRNL2p1?=
 =?utf-8?B?NjA2ZFVXU2JKL0YrTTE1SklyYUx2dm1qUTd4dFlvK2M2Z1BoQ21HM2U3ZEM3?=
 =?utf-8?B?YkhUNXBwcFB6eU1IaHB2a2xVWFVKRjU2S2MySml4U0VJaUhrZFRXU0VDM2pi?=
 =?utf-8?B?aUhlMXBhS2RwbSs3bnZYYktpRVl6THFDeHJBMFlOMW9jZDNOT21haXR5Qzkz?=
 =?utf-8?B?c3NKUnIycUJWcDA4dStuRWozblQ5TDE1MGlha2gxZmp5MENucXNqYlhiOXh1?=
 =?utf-8?B?Nk1jdG5FRmd4azllNTZWc0QrMHQ2Tk9MaXY3NTA0MGJTOUZiUHU2bU9oNU1R?=
 =?utf-8?B?YTBzcWJNMHpReWJUL2UrakwzVDlBN0lkUXZ0WUV1OHE1VEJkbG14eUJJNEpk?=
 =?utf-8?B?MUUvdXozTUJkc25tUUkra1U2R3UvM0ZQMXA4ZHp5YjdTTjhrZURrTFVyR2Rh?=
 =?utf-8?B?UHcvUzE3K2pFaWJCZUVMdGNnSEdUZURDZHJ5MWZkR2hNY3BpbGl4Ynk2YjJx?=
 =?utf-8?B?M3czUlhhMEtia3ZJVjk0U2VQZUthZGV2YnBRSm1FVnhUZTFLTVJ5N0REL3VE?=
 =?utf-8?B?NkcxdFphMUo5dTUyeUtWemV2RzNKb2RaNXE3RlpDd3BGc0ZtQWdrQ2lrLzJu?=
 =?utf-8?B?cXlITUZGOEpmSHpEaW1zOFNFemd3cWU3QnNFaG90M2RNSXhvQ1ZHbFpQd3FZ?=
 =?utf-8?B?ZVhrMGxZbTBjbDVpa09WWGh3ZFJ3QW1COUVybTNCRDhFWTF5akdUTVZ1U2dT?=
 =?utf-8?B?ODM0VjlYb3dzN09qWVlPUDJSc3pyV2hha0M2cDB5SmFRN3dUS1o4N1FrOTZ1?=
 =?utf-8?Q?o04MS3Rgx0t3UnSBiccRKyqABH4d3NZ0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHFxU2VnOEZTb0dSclNmZE1aNkJPTGlBUlRkcnc2Snp1TmJYZkNnU0RjOTBE?=
 =?utf-8?B?MjNIU1M5NEhZY01jbUxLT2VWMXptVjZvQ1pBVUdoK0tEU1BmeEtQSmQ0b21a?=
 =?utf-8?B?bzFPNkNYb0kxSHFlVXE2R202WFhWN0tIWk14TEZCT1kxTnkvaFZ6QUVnOCtV?=
 =?utf-8?B?TCt3bGJTbUhVb2ZDSm1NUERwc0JPbW9DRXlieFdDdmJkcDdGNUQyMmRwUUJi?=
 =?utf-8?B?Q3pNMUloaUhLVUMzRi8xdzI5Z09ZVTFCK3dnQmliektJKzlPd1pIVzFTOEhu?=
 =?utf-8?B?djhrM1k0VDZzZlZRSm1RRUw3K0tQSUhKd1l4UG9UT2hvZ2pFSkV3dDZreG41?=
 =?utf-8?B?M2xZYUJFd3NVODNaeHBRZkxzTXc5cDVTazNSeTZ4YnRGYnk1ZEdhWkZIOUxJ?=
 =?utf-8?B?V3BxdmgxZXo1TzJTTUlxZnlIZXYrbEJIdVRQc2hQQjlob0s2azZLSGl6VU9N?=
 =?utf-8?B?QUM5NFFhR0wvTDBuc09zTzM4UVRTeDhMSjJIMkdkY2xrMW9ZRWJlNWtPRENR?=
 =?utf-8?B?SXRxallQMmIvcURSNE1wZUtCTEthMjhiU2lMbDUzMDNOWnpBRCtRczh4NHBY?=
 =?utf-8?B?UE1lL3FDczhoVGFJUVRFWWdLNEdOTVl1TDRJbXhsZzRQOEhHcHpCVk5najAz?=
 =?utf-8?B?SUQvdERoK3c2R2NzUE0xM2ovUkU1VUNMZjc5UW1GVTNaL2RtOHR3a01XaVNX?=
 =?utf-8?B?clgwMExjNVl0dnh2N0pBc2tPUGp0OVN4d3p4ampvb3o3aEV0YXA0WFRJQ3Rh?=
 =?utf-8?B?SGtGMXQzREs2dFhLT29DOUtZQ2phSzhkbmxyWndPRFNSTDNzOHp5cktTUDZ5?=
 =?utf-8?B?UWVzaGo1QkVuWk5PR1RoZi9yaHRKWjlvdWw0U3dMaE5QSzZmSnZpaUJpK0FY?=
 =?utf-8?B?WUlHTTBlRDJNY1BQcm5xUWpYTmY1aFFqcWtxczBnN0FOV1A0MGJHdUs4b1Z2?=
 =?utf-8?B?ODY0Y3BTR3lPdkpVNHVhWTAwMmpFZlJtMDhhblFzQkhPZGRpUjByb0dKcE5J?=
 =?utf-8?B?V2dhMC8xck90ZUdrS044eXZ2aHNPVU0yL0xiU0xQdFo5NkJkWU9mYTBtTzBE?=
 =?utf-8?B?cW9nRUlKNjh0TFJtWDRpRkxVd2FCc050NDgyWkk0bk53ZTMwNzJOenNoUmpp?=
 =?utf-8?B?dkF4aEMzTlV5OFEweWNaK2FieUtUWlowTzNsKzhuUnB4QXFaN203LzEyeDJ5?=
 =?utf-8?B?K1hQWHhudkd6M0tNVFFOemdqM1JXL2IxVS9Cck1KVnZlK0llQkkwNmhXc3M5?=
 =?utf-8?B?QytDOFc1UFVpNFRYR09peXVkeGxWRUFHNDN3Z0FtOFZMMmFCc1k3K0NlbnBX?=
 =?utf-8?B?Q1FWUWVneTJJMHNMYjNBd2JFNmJrOEtsejVOcnJLekwwbUFzNU5yV1pUN2J3?=
 =?utf-8?B?ZTZQTk1EQTRoVGkxc1Q4OFFFZEEwNzlISUxLNlJUYTR1Y2pSVElLWUROMzlK?=
 =?utf-8?B?bm5qWFQ4b3NoSFhXeXV3dU0xdDE0NFlKMWNKaHNzaTJPR2Y1U1lPazJRdW5O?=
 =?utf-8?B?ajc5RldTNE5jNGxsUnpSeEt4MXZwZzRjS0gzWThneUJwWnJxcXczcVBLdFVv?=
 =?utf-8?B?OC9GcUpIcEJIWVBvS0xVMmFESFVWbExITEpxblRBK1ZXMVA3YTFCVXVxNGFp?=
 =?utf-8?B?RG1YM0p4dVQvNlBrK2V1N1J2Nk5ITUFHaFVPMHV2MzA3Z2Z3UVUvNWY2WVFR?=
 =?utf-8?B?YVI0TDdtVm9WZTNIWmlhWXNpK1BteVRmeW0zUHQzOWM1Y3lLbGh1cjIzTmli?=
 =?utf-8?B?K1g5K1JySkRyR3RUeEJHU3N6UDk5QUZPaUJYcjJhZkJqaFh0ZHJZTFlOUFpF?=
 =?utf-8?B?djBBam1ZWkZHL21qb29Hc1lJb0lyOGJoYmxKT2xVbnF4NXE1TWtIaWMxRHlm?=
 =?utf-8?B?dE5oK0sxanA3MkxoaEZNTHlkRzFJU3BoRzlxd2YrQXhJa0YyOWM3RTVDTkx3?=
 =?utf-8?B?T2x4NnBXY1A0aVBhQWRNSGIxTi83djhPbW9UMTFhRjFmb09Wbm9hdGZYd3pB?=
 =?utf-8?B?SXlDbDlaOE51Q3MwYXplVlJQanZDTGlhZ3p0Rml6SGhza21sajllc0h2QTNp?=
 =?utf-8?B?ZHpOdTFuRXE0U2hFR2llajNtMGwya0RBRHJJUGUrenRLdnVYSlNzLzQrR3dX?=
 =?utf-8?B?QUZjdDNXNzdVYXJxaFFoMHNUVFIyZmd4SHV6QVZpVkxIaDIyNk5jWDR4cGVu?=
 =?utf-8?Q?BxgmunYIg/KfD0fsBo2OlSY=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef31450-8b56-4c2e-14b4-08de3bd4ff88
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 12:25:14.1017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsfmt8tyMr6boRERZUK88ilaudcbzZODTpLuCmkyEHZIDjgRzFOkyfrmS7TcBEQIRAZ6RZlkFaKNI2VhvXsGLP13iEhKIUz8XSyqNHz4krs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11384
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

Hi Francois,

On 12/15/25 12:34 PM, Francois Berder wrote:
> If zalloc fails, one needs to free memory previously
> allocated in the function. This commit makes sure that
> we do not leak any memory.
> 

Fixes: ed34f34dbaf2 ("ext4fs write support")
Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
