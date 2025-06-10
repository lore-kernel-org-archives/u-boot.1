Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE7EC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 08:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC2B82AC4;
	Tue, 10 Jun 2025 10:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Svp56zUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6977482B07; Tue, 10 Jun 2025 10:03:47 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BE982A65
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 10:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tccjx0d/WVlaxv0jdZXlxVu2JKQuAx5anKWMf2r+Ig3QiP77PR+BaEuQXHaq4TMnExgOCzkplXwa7RhC4s060A7PBgqR3xFOAkKLyImIQcAvHk/6vX+qzh1KvrZgkb8Tc+e/TFp5H/i4DSyDCmLhMYmJU9dllCiwI57B4o8v/YCfPcfaNmhTOkfnTh+j4i50ZB3bnHZtq0zK4053Ks+3mP2wr6lzrIcTK0tO85qoNrRq5N37NyMp+1wFYfyh6X0ylDJEJ8BBFDlmZZs8cPNf39RkSSj5lAr6EIZ3PUhw6nYyIZ8EZ90LO/8NJJmXc3efrsUPfJyqOuqeb1jKM4taOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaICCehGa6Dm7BpQYHU8OEGlx0G784Av/dV1bea0ABU=;
 b=TTcQCQ3ErB4NHBj+9MftnGNPXhr0ruXdVm8yGOtql5lFSB4iJWBxTTkRCxFW84koFdz/K0g7FST9M1VakRFAMhIMonrtWF2yiP4J+ZtBdd4gubU/i4/L41YGauXJJaYNyTthEMLDyvhuWjstEqm90XNh99llwgCf47l3mRX85dpYstHmF44NeqoE+2WORZ96LLdw0o0LdC0XrmkKzu6lIcAE7gNXnAaOqKycG4yghmE0C4WmD7IBP2BUiEY+z6vrFZ4tIK+HQJK5PH9EbSMKvpGeV3SkM0Gfw2w5K22OHzm/PAMs3V8Qx99+V3uXxkEC9RHRt8RpJJ8uAyLwbxrS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaICCehGa6Dm7BpQYHU8OEGlx0G784Av/dV1bea0ABU=;
 b=Svp56zUcEdyOIVLTTOS+RoPzEkj6D7nNrHlvjga9WX0D2Ma7CxLB9YFwXK7YkQRnzlIkbq99AZUFYky0QQQIHr+5586nfj5AOJ9vlCOQVNc/fhZoC4G/cut5vX4QJbAjg171SlVg0o/xY3IgjbT/8XuUQExvnc2iDa/CPZCDLlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Tue, 10 Jun
 2025 08:03:41 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 08:03:40 +0000
Message-ID: <14d65e6b-90a0-4363-8f81-9ae0bbffca2c@amd.com>
Date: Tue, 10 Jun 2025 10:03:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: onboard-hub: Fix return type for regulator APIs
From: Michal Simek <michal.simek@amd.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, git@xilinx.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <a2d520f14efc30fc28ec59881205e156dabbfcd9.1744350937.git.michal.simek@amd.com>
 <fd4fb3ed-5988-476d-aea8-2c5a58bda9a3@denx.de>
 <5895b4c3-900d-46f7-b3f9-ad6f6f5c4609@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <5895b4c3-900d-46f7-b3f9-ad6f6f5c4609@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0252.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc057ed-4d98-4c67-ddfd-08dda7f54fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDlDc0l0djlXTTZhR0xGM2tKVy9jT0w3VGNsK2hXY0ZNVXpqUWN3QTZ3Q01s?=
 =?utf-8?B?bXZiT25vU1JaWWdRcWNVNW9Xc0ZDV3hUamlCbWpmeEpPcTRIa1lBZUtCU0pD?=
 =?utf-8?B?WExnbDhOY1QxUjRXVWlBdjNzaU04Y25tMnljQkRCYXJ4Z2tRWnlIOFRaVFp6?=
 =?utf-8?B?SUU3Qm9IemNmZFJMdyswTHg2YnErOGVTV3BKaEVmYmRsVmc4UjJ1blhOTDBE?=
 =?utf-8?B?ang5TDVEeTlvZU1Kek1xOHVROEZUNElqdjl2UEtnODlvNm1YKys3SEdkdEVo?=
 =?utf-8?B?UkZHeHhPVWQwM3I1WlEySk4wc0ZsY054bHJMZ0VMUUZkS3lDRUZ1eTkxeXpl?=
 =?utf-8?B?aHNvK1dzVUFsTDBGVlZwWHlTbXE5amliSDdaWkorOXd3WlVBRGRjQjhNWHZC?=
 =?utf-8?B?TUJVV1dsUFUrRXUycnkzWSsxVlFLZHcrcXhGNHdBTiszTUg4ZWZDY1JNb3Fp?=
 =?utf-8?B?dDVTN2UvTVVZbm53QU1nN2ZPT1I5YU02WnBDeHp0SytER3NCck9xaHdDb0dN?=
 =?utf-8?B?eDQ5TjJNTVJzdFcxZUVqSjlkaHpWR2VYV1g4UlBjdkdIZ1ZrRnR0d0o0emRS?=
 =?utf-8?B?TVlLWmZYZU8zTU1UdzBVUENyK2VHeDFiazR1OU9QNmNpNTV2cXltUng3TlNl?=
 =?utf-8?B?TjBOdG9Tb1FOZThwaVlOOXZQdVJzSkxWRytRWlkwT0hBTlVJNTZrNHh1NXdv?=
 =?utf-8?B?SU5UL3d0VForWEY5WWxqNkRjSGVlQ09WMXd6WHZuMFdpbXp1R25Ga3Rwei9K?=
 =?utf-8?B?bldVMEdrTHoxc2xIZlFZUUFSeGJYTnNwczJpWXkrQmhRa2p5UHV0OS9zbFpV?=
 =?utf-8?B?R0svZ3FmeVNJZGhHK095Z2hxWXdaWGtZbTRPVjg4UUhOM2NLTHhiajhidXhD?=
 =?utf-8?B?UDB2ZjhTc2JCbjBONHhiU1pDcVNtbDlXb3lYODZUWk9jZndiTzQ3Q0FEUmlF?=
 =?utf-8?B?VmJUVkk4NmF3blpHZnYrc2ZyUlBYZmtoR2IwYlV2NXVTTzFIeWlGYk95Wnha?=
 =?utf-8?B?aEthMU5MUjBjR3JhS3U1bldURmpjZWJmSmNvc2lyTThqbXZ5OSt2aGVRSjNZ?=
 =?utf-8?B?ZFI2RkRWU3RLQ2IrL0NoT3BMbHpqbGE0RVhoZDRBZ1dsemRuWjJVSFU0aUh3?=
 =?utf-8?B?U2c2YVdaRnZsQWtWaGkwTnA5NEZHS0w5WE1uVlVtRlVpVERhWXBzZU1rUG5W?=
 =?utf-8?B?ZDBCYXZBTUU0OGdCaUNPUDdBWnYzaTJGeUM4UEN3UlAyREFLWmk5b01aclZQ?=
 =?utf-8?B?YnhRZk55bm93aUw2Y2pqbXN5TE1TMWxibzZuK2hqVDQyalhQTGtBTXo5bFlt?=
 =?utf-8?B?YmJaeS9Qb2xZM3JJWVNmRjN0ZHY4RU93VjJtdDNKVTlJbGpDb2lkcjUrZnI3?=
 =?utf-8?B?d2k5ZXEvSGU2ZCt3VjR3NTBWcFdlWjVzd2hQV09Ua21HUzgza3VoTnBSZ0hh?=
 =?utf-8?B?WHZwUmJZUXZ4L2lMWmlYYU1GUFNOTWJRZHFaWjV1cmpIU1ErZGVXVUhoTGdt?=
 =?utf-8?B?QXhjaDBTVzYxN2FPWG9XM1Q1S3JFb1Z5MW5rZTdST2lSZk5GVzZxaWhLRTND?=
 =?utf-8?B?NjB1eVk1a0lhV3dNTmROd0xNSW4vWVk1Wm1yQ0JCclI5a1hveGthcjViRWtV?=
 =?utf-8?B?RlI5bG90a2hNbi9TY2p3R0ovVW9FU0hza0lGdWQrLzgvN1d2R2NBOFNRNUk3?=
 =?utf-8?B?dTEyaXh2YTVTTk50azE0N3pHRjhnZUZuOWtRTVdaeEpTeXRWWXBVU0xVSkNn?=
 =?utf-8?B?eTVUYkM2ajdOZzhwc0VqRFlCZThUN2RJbnZNMGEvcThRMk5kZldlNGRTWFh1?=
 =?utf-8?B?Q3I1ajg2ajhmR1l5WkRUditEME1YcENoS1M5Q2JZQ3U4RWZTQlhRTUtaWnRQ?=
 =?utf-8?B?a2lkT1k1REtHS3VmUmJOMllybmdlbWJCS2JnN1Jqa3VWWXFNNVpwaW9kUllG?=
 =?utf-8?Q?7/j34zhG+XQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdFYmVVWEFRWW1SRy9EQ0hlVjk3L1dqOXFIVzZaL3J4RHpRbFAxWVZHc2x0?=
 =?utf-8?B?OW8zcHFRZjFNcGQrbmEzZmlDRmVjdTJya1FTaGtNSlV3YzcwbHlrWHNlcEM4?=
 =?utf-8?B?cEdYNkRiYjQxMVZtd1RORDhudllJK3JiRzNEZS9nSjIyL2NDQ1h6b1Jianpl?=
 =?utf-8?B?dDc1QXIxYk54QzkvUzNmMkhEVmpIaDFsN2dqby9ucnpRWVFobjZTTVZTZjlS?=
 =?utf-8?B?eExMYXhORjhEdUJjQ0lkY3N6bVJLNHpmeGhBTlMxZUhIekxDd3BiazYrbWph?=
 =?utf-8?B?VzFyMWQ5emV4bHFHRkpOenNoQUdhTjRqSUhPbE5rdnJhVndGMTVPaXBSTXJt?=
 =?utf-8?B?Z0QrU2l0dW5TRHltQkIwSFBSUmlmdWZoVThWaWpiakRyb1k3c3E2OEwvWDRT?=
 =?utf-8?B?VHUwRnY3Y2pSdm1JZ1JVTGljUi9HN3dMTmw2WG83WkhRL3pMeGNzZlJFRFFH?=
 =?utf-8?B?WXhCYi9GVnAzL0NKWm16RXdBUElvd0VTOWhrV0JlM3c1emhpMHBPeXVYTFl4?=
 =?utf-8?B?WHhJMXd4VmJjNWlBM3dqUWVEWldNaEhIWWRJdG11Y2xqOUhDRy9Qc2RoS0RI?=
 =?utf-8?B?ZDN4aE9rMmk2WHdBWWV4cG1PQ1JCdkF4TThWcXN4WUltSExiOE5QbzBmZmhK?=
 =?utf-8?B?SlRJNjIvODJXTjBXK2M2TDJEYkNkL2VTNENtMTlyUmh0VCt0NU9VZ2ttM2pV?=
 =?utf-8?B?b0krbW9SSXA5N1pjek96UHNwUkQ1WllYTkx6YXhXa0JDRlc3NzlIZGRBSmFr?=
 =?utf-8?B?U0xEQ0dvNjdwa3BobElKUmxhbU5HYzM4MnB2T2JIRkJRSHhUY0lFRjNmcWhF?=
 =?utf-8?B?citmbjYrdXBBTDFjUzViZHZ3ZFRIa2FZZXdNOHpRbEhDa0FQNXViWmpXL2Q1?=
 =?utf-8?B?WDlIdlBXdU1kdTlPVnQ3U1d2NTVuSlBvVnJmSWdCK0FlUTR1UnVnT2puK1hT?=
 =?utf-8?B?ZVVnc2d0bTlDdTZyeTltbitOZXFRY1hWdVV2TFJjam5FK2tLWFFLMmlEVjNZ?=
 =?utf-8?B?VGFXYUExVWtsNDBaZXBYaUp2ZUp4ZHlmbmZQZm1VaDBibi9EOHFobkhyZ0hB?=
 =?utf-8?B?N21TSWVkTWhvYWRjTFlHS2RRNXhkRUpmdTdIT0ZOYk5HUERxcWZDSFFPYTV4?=
 =?utf-8?B?emNNQXg2MjR1UEVZY3RLdkMvZzVsaHdCTlJURHZBL1V3TmtBaE51dkI3VTd5?=
 =?utf-8?B?TGRYaXdZZ3ZMYjMyRW5PZC9TdllOdkNCWjd2WFVobWVqekNiWTd5UzBrMDNy?=
 =?utf-8?B?ZWpSLzF0dHhFbit1L3JjclpaLzA1aXNBMXIySWlVWC8zUUorMGFjMXNnWFRa?=
 =?utf-8?B?NDdRWGtkOWo2NHpha3d0THd3ZUI5QWljZzRKcEpGMVdlRjMvRW9pUDZwRElx?=
 =?utf-8?B?Slk0YjlqN09SdmZsU21VY0RNczJRZzVPZDdZRUxYVFZOcmVDRHd2eFduVFQ4?=
 =?utf-8?B?VXNSMDlOSHIzSWNVczNOK1gyeEJXcEJrdEViQlRpTnZqb3RteXJwQ2lEdU1Y?=
 =?utf-8?B?WGRtOHg5TlJic0FOcStSQkFuaHVwQWQzRzRGdzE5SUhJVDFYZytZYnNOeW03?=
 =?utf-8?B?V0xSOUo2TmVFa2Q1MHduZGpvUUIzK01NbEM2ZysvK0RCQkptQThCZER1TjhX?=
 =?utf-8?B?Zkh4NGN1VUYwT3BicXF2UWZPL2FsRVRoSm1INEpBMmZhRm8wRXgvSkIySHFQ?=
 =?utf-8?B?NzZYVUN2eFJMNjlNb05LUGJxODBvSDByN3NGN2VMb29hTC9tbFdGdmtWM2ky?=
 =?utf-8?B?cGkzOEhnWG44ci9nSEs3MG5GNmxLcERvQkNZbEZWY3psM3l4RWc5K1h1K3di?=
 =?utf-8?B?cGVNNDhKRmJVWHBuU2NiZng1SWNCRkV5R1VocnBSUUJoZ2N5VCtzeXJzZmJL?=
 =?utf-8?B?YzNmcktnOWdJbW4xTWZkaHdmY3NsVmZKQkpaS1Y1SlAyYVhOSnJPdmMrSitt?=
 =?utf-8?B?OFNFMGZPSWhNS2tIMzBvTG1USEZEMEVWTlZ0by9RRzdacU15UzdEUzYxaGRC?=
 =?utf-8?B?SVI4ZUdmZG1Cb1psR3hlY1d3MWpIT2RQaGp4YXhJbnJMOG9RM1dEUjZuWjRp?=
 =?utf-8?B?bmxrZUV0Tzg4ajZtOUFpV0xxbWt0UnJ4Z3lkUm1rWG1rOXo1Z1RJbk5mVEZU?=
 =?utf-8?Q?yO1tauukRbWjoepRMj0sN67Tr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc057ed-4d98-4c67-ddfd-08dda7f54fb4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 08:03:40.5713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItufEKyhhGCW2bPsrJ8cta9fb20cujTNJCBG3LMsIHQR6BI42cN8ToMV97GqXKFO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946
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



On 5/21/25 16:43, Michal Simek wrote:
> Hi Marek,
> 
> On 4/12/25 22:52, Marek Vasut wrote:
>> On 4/11/25 7:55 AM, Michal Simek wrote:
>>> From: Padmarao Begari <padmarao.begari@amd.com>
>>>
>>> Apart from ENOENT observing return value as ENOSYS when
>>> !DM_REGULATOR that's why cover both configurations.
>>> Changed code is not working as operation should be "&&"
>>> not "||" (ret != -ENOENT && ret != -ENOSYS).
>>>
>>> Also fix the remove function where the regulator_set_enable_if_allowed()
>>> function is returning an error.
>>>
>>> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> are you going to pick this up? Or should I take it via my tree?

FYI: Applied via my tree.

Thanks,
Michal
