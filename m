Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39468CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 14:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBAE4843E0;
	Thu, 27 Nov 2025 15:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JRGuUbWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03DA0843E3; Thu, 27 Nov 2025 15:14:39 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C578439C
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 15:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArqTWk3oKP4HVw/21S57nxXekSyvdIk04mTLcdjwLApAB8wFHbetN4OWsNWwq3ObT+mYTLpZQtD4iDBGPW2AcTLTMv2OWIhrlMHtFXELXQChUEb4uV/7F7BE2gprwgamiCtxu0pjEGzT3t6hlP/H3KtVyR9evZoFPkRpdihMylBNZc2Saf8n2NeJ+dCu2wvwoZt/t1Djs1aAC3Yd7rIvudYzhn+5rbA7b+4IeOFY5aX29Ceux6v2Yx7oi1/uYQwT+j0A3leaiImnJDgUH4bmrSzNdKR4z4/FsKXSjKWeY4/UjBuaz3WXPS8vpcparrEp9HRDbjq8O1CX8B0cHx9MIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y77N97WhPyh4rikIHvlHTEaCi8Kvf9vDt32wRFvg1QA=;
 b=v7dnLY+o/xD+Vv20nMt1eusI5WotWcbWZikYOUGMwbdLBEX+i+XsTiRnpek+qLdGnSK+1qCYekOyE4uZL2fF2EFUQDaCO/Yrx0F9E5NDBMs72y0qISO2OG8yzcEQUVsbbSVWAv+UQCrrLG9lvJpmaKcGmqTa31QzWiseT4QFqFLyCzznA+vUWlFYVRVzWNLyeW3BDTYWZo9wQtrRZP2WWa66IJqMg9xNjwCipTFNgZBT+Eyc7IzkJ1AL/2tN1Uzz1mlNsxLlHZ4vF6pdbOK5S8FP0AXHwboKgATL1rEif2RKxEqb6S6eV0KHNTKPYek4OdkCqwpmmbVslqdyFHuTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y77N97WhPyh4rikIHvlHTEaCi8Kvf9vDt32wRFvg1QA=;
 b=JRGuUbWDPBS9ftMCkht+Pr3dJ5+lsAEd06Fq1UPXSIUJzj8Ji2dNIiaLTKSUQYBoYBZ7OqlPIDTBmmp3JtUB2Uewci9CRVR3bz6zA5oyE0n42EJGSDxmePwe1GmvG8wsckjRI+s2GnbEtW7te0QfMXk7+fdB4ei6V2ETmtJNhp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB7904.eurprd04.prod.outlook.com (2603:10a6:102:c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:14:35 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 14:14:35 +0000
Message-ID: <0d4e6f4a-1b73-4e3a-957f-ca9a8470f555@cherry.de>
Date: Thu, 27 Nov 2025 15:14:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <3413832c-3682-48bf-afb9-ca1c6ac9f372@gmx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <3413832c-3682-48bf-afb9-ca1c6ac9f372@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: aaed0e21-3330-49d0-8494-08de2dbf4aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUg5d1Q0MW12b2tnNHYwVFVzQWMxT0dkL0l6bkVZbzBpejZXNzV0Q1NKeDR3?=
 =?utf-8?B?d0daV0xya3ZwZVRVZHFlMXBmT0V3MXcxUWVBbXNhdWplQUFTQ3kyN2x3NU84?=
 =?utf-8?B?RDFRZk5rTTVvaHA2RVlPa0dqbFVWZDVRRjBPc2E0bWE5TDhvQzYwVm0weWdH?=
 =?utf-8?B?b3JaZkhHbW5zVitYbzBYSlVHa2hjc0RDLzZTOVR2UnlON0F1Z1luVjc5YXlP?=
 =?utf-8?B?Q0oxT0lvV3NMZFgvbVN0dWxzbUxNVlNQOU1ZMGFlR3hXMVM5aThzRmVGYkpt?=
 =?utf-8?B?MWErZHI2b3NSTjhxS0ZVQ2RrZ0lwNFJjbWFnRy9DSStLd3kySERjL0hjNm9Z?=
 =?utf-8?B?bDA5WlpIWHE0STkvdHlnL29TVG40M3dTbEZjd2RTWGJHVnlDcU85bnB0K3NS?=
 =?utf-8?B?andrY2x6dUk1U2M0LytJKzZybFFUbWxjZUJHaGhSZHdlYU5lZWNHZ3plZjdC?=
 =?utf-8?B?R3NpSVFQNlgxcENuN280dk53bCtGTGVWR2YxUTNlMENoZEs0aVlOdE91cVNW?=
 =?utf-8?B?TlhCbW1ydFJzWGltY3Zuc0pFTlYzSXU3ZkZvRDRpTWZ3akFESnE2dlpuWENO?=
 =?utf-8?B?MEJpK2dqZXZneG1lL2FQbnEzTkU3dUdoVHdoT1R4bGJKODdNWjJzU1B1QVBn?=
 =?utf-8?B?WEVMaVlvTmNOZXVEQzcrZEtsL3V1aWZjd1E4SWhadkxyaE5HYjNPRUo5Ny9a?=
 =?utf-8?B?aWgwcjhVdnM3dGl3dEJWUFdEOVVvUVlOcWNseUJ4NVIySHRtQ3oxRVkzOTVs?=
 =?utf-8?B?MnRZUkE4MkVQdUJCQ3QvWVpBVFdlUmk5ci9lRm5ZR0ttbDl1LzBOd0xWZ2h1?=
 =?utf-8?B?YkpmVjlkU25Wa1YzQ2hob3YzTjF6Zk5lMmhIWjB5OVFhbHMxOVZBNkVxeFRl?=
 =?utf-8?B?WE9MaVRMbDBBKy9qSFhVdFJEVmd1ZlQwNk1LUDFWellCeFNRK21KZi8zR1Uv?=
 =?utf-8?B?eDNEMVNJb2Q3QjNMRnNjbkpVSy83d3NoL3FINmxJSHNFSzRTcDNyR2hYUkZv?=
 =?utf-8?B?SDl0OEZwT0dMcVhKWWs0MlgvUk56UmtjRGZJeTV1STRLejNteld3VWpqdFU3?=
 =?utf-8?B?K2x1RDh2WXNpanpud2lhMFE1YmhtYitBcmZ0Yy83TXFRT2lOYlkra0ZBeC9a?=
 =?utf-8?B?SnNQMytFdCtGQVlrSWxyUFRsa094U2NZSXpXZnBzU3dXdWRUVGcyTlp5Tldi?=
 =?utf-8?B?NjF6bERKS3pXVXVoYVhXTmpmcGxKWDE5MnFXaFVsTzk1VUtObGxONG11S3Nk?=
 =?utf-8?B?NTd1cWwweGh6N1R4dnZmVTZwU1BtK1JzQmlJSXZLNEd4UlRQUVNyYzhDaGR1?=
 =?utf-8?B?aTB2dTYvVWdOUW5zTmdaTXd6SmZra3h5U1hzRnkrQ01nN3BUVjB6UzZobG5v?=
 =?utf-8?B?VkNHekZQU1F5c1ZIT0hsdk0rYWxBenhIUGgxdTdqTk03eWJXcXFGdWVPR3Mz?=
 =?utf-8?B?NTJ1YjVncWtHcjYxbkx2U3JoUE9STTZFNlVoajdMd3RQTEZXVkt0MnpENCtL?=
 =?utf-8?B?aG9Va2E4cldscWdiTkIzUG1Hd1ltZklCWCtrWEpuUFNmTy9PMlgrcWZ0dWF2?=
 =?utf-8?B?Q2VDNTZlRmRzU2RDZ2N4YjFKN3JIaVF6VFRTSmZhRWRWSU5FKzZ2UlhEV2xG?=
 =?utf-8?B?Z2lUWjF0Mm5OYm5mM05nVkIyOWZVcWhuM0pZZUxoYXdVOUJnQWdWZ0ZieGRF?=
 =?utf-8?B?QjNtZ0tzcWZ1QmQyNUN0TVRhS0xMdjg2eVFnOWxIS3YxVmNadW02STgvZmRN?=
 =?utf-8?B?amY0dTZYbDI3Y0VtSFNKQlpTamd4T3huNk5qY3BHS0Q0ekQwT05STUZyaWdL?=
 =?utf-8?B?MEk5YVh6Nk92TDY5cEo4RW53T0FrNkVpK1ZiRmFRdjh1czJxSGFzT2llL0tW?=
 =?utf-8?B?Y2I3MXFqUCt3SmJWcDJCTVkzbkUvR3VCK3Z4dGRFbG5NVVBVM2lWQUh6RVpr?=
 =?utf-8?Q?bk8LJFqo8i+PQYX6ozXQW8RLMCB8vHY0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1HZis0MTg0TzR2K3ZQWm8wTmptQWgwbU4xWVBmT0N1Wm9TQTNzcjBkKy9u?=
 =?utf-8?B?bTgyY1pTblp0cWFXVE56NkFVdDM4M3pXSlh6dVNZYnY4OWh1Y2tOU25mc1ZV?=
 =?utf-8?B?MDdGRStsdCtWRHFsVm85K0dwNk5CdXJZeVl6VnhSRmVmNGhsdWhLQUM5QlJl?=
 =?utf-8?B?S3g3NGw1aEtqMHRQbWV4OFIySWtDTGFFc0FQUDFwRVpJQ1RBdGtPRVBEVHZ5?=
 =?utf-8?B?K0E4alM0SWJ2ZWI0TmJqZm4yOE52KzgxbE9sV2FsV2t2NHZsaVAxSTFNa0t1?=
 =?utf-8?B?WTFFRTNVTDFmZXhBS1Bqanc1OXo2bDRJOER5Tmt0a1o5THAwZHoxbzhMbnA0?=
 =?utf-8?B?UFNPZlNrL3dmaXE1UnRlblNuNmtuOEZNcldrSkRrRHRSdE90Vlk0RWhYVm1x?=
 =?utf-8?B?RGtTWkhpbHlJaHhYdXRBQ0ZWTzVON1FWQVJGR0hCckdObHF3WHBYWUo0RkxI?=
 =?utf-8?B?Y2puUFdQZHF0aUw1UFJvbkp0MndEemgxQjQwTFcvSXpwanRYd01XQ2xpdUNa?=
 =?utf-8?B?RVQza2xkN0tvSkRZeVNZSTlxbjkxSHc2U1IySHZCTE90MG54a0dtUkRQUVE1?=
 =?utf-8?B?MHdMR2dEUlBFbzJDVVZaUE1qSHlnU2hVR0dxdTBCSHloa29YSUNnNy9JMVN4?=
 =?utf-8?B?RVU5MHdUM3BPdytlQ255NEszcmxaaU50OXQvOEEzT21jMkRuUUd2cEdIVE9y?=
 =?utf-8?B?aWlLeHBaRHA2Lzh5UFcvZlJQcEdNa0VXc1RKUWJxUW9Eb1RSVnFDRU1DZW84?=
 =?utf-8?B?S2Z2Ti9ZS3c5MlhKbzExRWsyZUluajZiSFRrb0FnTGp5Q25FamtLRmhuL2ZF?=
 =?utf-8?B?enNPVUVUNXVXYjNaM0R5UjFYdDNJOWtaLzljWCtBZStZZllqdWFQN2tzcDBn?=
 =?utf-8?B?dXFpY2MvNnlhOFZGR0lBeDR2Qm9yZVpqbEtieTV1Yk92ZzViSzNlNFY0T2Nu?=
 =?utf-8?B?YzRlNkdGODFlZEtNZDhNQ3NvcEh4Y05DOEVXbVc0Q1ZHRjV6L0RQZDloMkFW?=
 =?utf-8?B?RCtWQlppZlAzYVBLQW4waTVnTVhRbWFRZ3owZHlyVU0ybnQ4ZTQvOXJaQUxM?=
 =?utf-8?B?Rk4vYnpKUkRBKzZZSmYwNFhXVWFQa3UyS2syYkYwMlNsbUxPRkdNci8yWUJj?=
 =?utf-8?B?a3A1L1pVQTJtTDhLajhCZE5GNGJZMUtIL3FOYkQyTk55NXJtWlNhbWx4K3V5?=
 =?utf-8?B?OUZnWXpPeExCbEhiQml4Zm8xNVNCc1dUdHVhelYzUEZsaUwwZ05PU21vRGNo?=
 =?utf-8?B?SmlaQXZwMjNWYzVYTzZ5eFc5aVlCaUpLY201Qjdtc24rV0hKWTk2OGJXejJT?=
 =?utf-8?B?cWtQY1hpSGVjTWNhMm5PS1JCaG1lQmVxUkNQdFl1dFZQZ3lST2huN1hSMEdt?=
 =?utf-8?B?UThWWjI4dEYxVUd1M2pOUG5pQ1F3aWVWZm90R3hrUzhPNDBFdHpuMEZpbXEr?=
 =?utf-8?B?cFlmT3dPR054N0h1RFczTis2RzM1U0R0Wkt4R3hoRWh1RVFnWGs4N0NKbzNO?=
 =?utf-8?B?NThpbENjd0thMktWWVhVeEgvSDBQbXkrWHR6dXRwYVZIZjZFUTJzOW5sa2w0?=
 =?utf-8?B?dndjMUttL0pKcUxTN0M4TG1mTThZQXJOUGR3YVBrbHlkSWV0R1ByZE8wMTRC?=
 =?utf-8?B?OWZ5QWliWG5rcHNHS2dlRzNDSWhrZklJZEpOY1liN2pvNkwybEkvRjNDdmtO?=
 =?utf-8?B?OW1LSjhWYW5UMGFmMzdSbXNSM3RaOXVPN0dOK21JM0lrbFd5d0NrczEweWl2?=
 =?utf-8?B?VDg5TGhMNHRlcklFbFZCdVVVM1BnTURFY2JkRXlXZ3FZR3JTL2llZzQ2TFhx?=
 =?utf-8?B?VWJwc2N5bGVxUG1UM1QzTzA5VlVBL1hPVGNXd01mY3pOTWN0K0ZidExNMURQ?=
 =?utf-8?B?UVdwbG1KWmliVndYY1FER3ZoeWxUckpMb2h4Si95cUxKSk9GS1lZSGlLQ3Z4?=
 =?utf-8?B?ck5qcjRtRkwzWk1tSERqVjRDUlY5dmpTNlk4K0ZWUjhEbWhWdy9ra1NsN21E?=
 =?utf-8?B?MEFIbUpFa0VvTlp5b3hhd1V2UlZNYVZ3alFlTzYyWU1INEorSGorblBxSmhG?=
 =?utf-8?B?R1R6UzJTdUxKS2hjNCtWZG9ZbEVKOGh1MHBadlhsMmxkbzRSbjM5Ni9sQnJw?=
 =?utf-8?B?MktvTnBodGx0MWZCa1R1aWY5dWF3WldLdmlrVzByVEh3QjZrb1dNYVZoV3J0?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aaed0e21-3330-49d0-8494-08de2dbf4aba
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:14:35.0238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6AVPtFznEEm9+Fp4mOXFOtncTJcDf8ToKmuj8vBiUDlQwraTnajKbOzMjeu7UrYy2WkCWJ69/3WboiZdxuBDAijQLYIk7S5GnOXLaR7A/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7904
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

Hi Heinrich,

On 11/27/25 1:50 PM, Heinrich Schuchardt wrote:
> On 11/27/25 11:45, Quentin Schulz wrote:
>> On 11/27/25 11:35 AM, Quentin Schulz wrote:
>>> Hi Heinrich,
>>>
>>> On 11/26/25 5:46 PM, Heinrich Schuchardt wrote:
>>>> On 11/26/25 16:00, Quentin Schulz wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> On 11/25/25 7:02 PM, Heinrich Schuchardt wrote:
>>>>>> Hello Jagan, hello Heiko,
>>>>>>
>>>>>> When testing U-Boot origin/master on my Raxda Rock Pi 4A serial 
>>>>>> console output stops after "PMIC:  RK808". The same can be 
>>>>>> observed with v2025.01.
>>>>>>
>>>>>> The serial console works as expected if I disable 
>>>>>> CONFIG_ROCKCHIP_IODOMAIN.
>>>>>>
>>>>>
>>>>> It is I believe implied here but asking for confirmation. The board 
>>>>> doesn't actually boot right? It's not that the serial console is 
>>>>> gone, it's that the device is stuck?
>>>>
>>>> Hello Quentin,
>>>>
>>>> Thank you for looking into this.
>>>>
>>>> The device boots I. But the serial console output becomes mute and I 
>>>> cannot send keystrokes via the serial console.
>>>>
>>>
>>> Uh. That is *weird*.
>>>
>>>>>
>>>>>> The problem seems to be specifically related to the bt656-supply. 
>>>>>> Removing the line below also fixes serial console output:
>>>>>>
>>>>>> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/ 
>>>>>> rockchip- io-domain.c
>>>>>> index a0573c52193..b0d78f2d4b4 100644
>>>>>> --- a/drivers/misc/rockchip-io-domain.c
>>>>>> +++ b/drivers/misc/rockchip-io-domain.c
>>>>>> @@ -239,7 +239,7 @@ static const struct rockchip_iodomain_soc_data 
>>>>>> soc_data_rk3328 = {
>>>>>>   static const struct rockchip_iodomain_soc_data soc_data_rk3399 = {
>>>>>>          .grf_offset = 0xe640,
>>>>>>          .supply_names = {
>>>>>> -               "bt656-supply",         /* APIO2_VDD */
>>>
>>> Reading the code and this diff again, this you shouldn't do at all. 
>>> The offset in the array is the bit offset for the IO domain setting 
>>> in the GRF at offset 0xe640. So by removing this line, you configured 
>>> APIO2 IO domain with APIO5 settings (audio-supply).
>>>
>>> It would be better to write NULL instead, so that the others are 
>>> tried and we can pinpoint the faulty one.
>>>
>>>>>>
>>>>>
>>>>> The UART2 (which I assume is the serial you're using for the 
>>>>> console) isn't on that IO domain. And there doesn't seem to be 
>>>>> anything important to booting on APIO2 domain according to Rock 4A 
>>>>> schematics[1].
>>>>>
>>>>> bt656-supply also doesn't seem to be anything special. LDO5 
>>>>> (vcc_3v0) on RK808, which is using VCC10 (vcc10-supply) which is a 
>>>>> fixed regulator whose parent supply is also a fixed regulator. So I 
>>>>> am not sure what could be going wrong there.
>>>>
>>>> In the schema LD05 on the RK808 is connected to VCC_1V5.
>>>>
>>>
>>> Sorry, I meant to say LDO8.
>>>
>>>> With any of the following values I can enter commands via serial 
>>>> console but still get no output. So none of the voltages seems to be 
>>>> the correct one.
>>>>
>>>> diff --git a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi 
>>>> b/ dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>>> index 046dbe32901..f15b5b63815 100644
>>>> --- a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>>> +++ b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>>> @@ -517,7 +517,7 @@
>>>>
>>>>   &io_domains {
>>>>          audio-supply = <&vcca1v8_codec>;
>>>> -       bt656-supply = <&vcc_3v0>;
>>>> +       bt656-supply = <&vcc_1v5>;
>>>> or
>>>> +       bt656-supply = <&vcc_0v9>;
>>>> or
>>>> +       bt656-supply = <&vcc_1v8>;
>>>>
>>>>>
>>>>> RK3399 Puma and RockPro64 have APIO2 set to 1.8V vs 3.0V for Radxa 
>>>>> Rock 4A. Puma boots master reaches U-Boot CLI with the IO domain 
>>>>> driver compiled in.
>>>>>
>>>>> Can you check the error paths (all the ones with a continue;) in 
>>>>> rockchip_iodomain_probe()? Which ones do you enter for which supply?
>>>>>
>>>>> Not sure where to start debugging tbh.
>>>>
>>>> I found the driver by setting CONFIG_LOG=y and log level 7.
>>>>
>>>> Here is how the console output ends. Do you have access to a board 
>>>> or do you need further debug output?
>>>>
>>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem: 
>>>> regulator-state-mem
>>>> regulator-state-mem
>>>> ofnode_read_bool: regulator-off-in-suspend: true
>>>> ofnode_read_u32_index: regulator-suspend-microvolt: 
>>>> of_read_u32_index: regulator-suspend-microvolt: (not found)
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index: 
>>>> regulator-min-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index: 
>>>> regulator-max-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index: 
>>>> regulator-init-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index: 
>>>> regulator-min-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index: 
>>>> regulator-max-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index: 
>>>> regulator-ramp-delay: (not found)
>>>> ofnode_read_bool: regulator-force-boot-off: false
>>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem: 
>>>> regulator-state-mem
>>>> regulator-state-mem
>>>> ofnode_read_bool: regulator-off-in-suspend: true
>>>> ofnode_read_u32_index: regulator-suspend-microvolt: 
>>>> of_read_u32_index: regulator-suspend-microvolt: (not found)
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index: 
>>>> regulator-min-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index: 
>>>> regulator-max-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index: 
>>>> regulator-init-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index: 
>>>> regulator-min-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index: 
>>>> regulator-max-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index: 
>>>> regulator-ramp-delay: (not found)
>>>> ofnode_read_bool: regulator-force-boot-off: false
>>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem: 
>>>> regulator-state-mem
>>>> regulator-state-mem
>>>> ofnode_read_bool: regulator-off-in-suspend: true
>>>> ofnode_read_u32_index: regulator-suspend-microvolt: 
>>>> of_read_u32_index: regulator-suspend-microvolt: (not found)
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_u32_index: bt656-supply: of_read_u32_index: bt656- 
>>>> supply: 0x7a (122)
>>>> rockchip_iodomain io-domains: bt656-supply: Regulator LDO_REG8 at 
>>>> 3000000 uV
>>>> ofnode_read_u32_index: audio-supply: of_read_u32_index: audio- 
>>>> supply: 0x91 (145)
>>>> rockchip_iodomain io-domains: audio-supply: Regulator LDO_REG1 at 
>>>> 1800000 uV
>>>> ofnode_read_u32_index: sdmmc-supply: of_read_u32_@L@@p0b@HHb```Hp0 
>>>> p0   $
>>>>
>>>
>>> This seems to highlight the issue is rather audio-supply.
>>>
>>> And indeed, audio-supply should be vcc_3v0 and not vcca1v8_codec.
>>>
>>
>> Mmmmmm, upstream kernel has 8240e87f16d1 ("arm64: dts: rockchip: fix 
>> audio-supply for Rock Pi 4"). So it seems it "fixed" something.
>>
>> So before I send a revert to the kernel and start an endless thread, 
>> can you test locally that the following indeed fixes it?
>>
>> diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi b/arch/arm/dts/ 
>> rk3399-rock-pi-4-u-boot.dtsi
>> index 4861574636e..dccc469a507 100644
>> --- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> @@ -14,6 +14,10 @@
>>       };
>>   };
>>
>> +&io_domains {
>> +    audio-supply = <&vcc_3v0>;
>> +};
>> +
>>   &sdhci {
>>       cap-mmc-highspeed;
>>       mmc-ddr-1_8v;
>>
>>
>> Cheers,
>> Quentin
> 
> Hello Quentin,
> 
> With the diff applied my U-Boot serial console works.
> 
> I checked the u-boot.dtb: audio-supply now points to
> LDO_REG8 { regulator-name =  "vcc_3v0";}
> as expected.
> 

Thanks for testing.

OK that's good. I'll send the revert soon.

My hunch is that the original issue that prompted this commit in the 
kernel was likely an IO domain issue. I've seen this happen on a camera 
clock signal on a PX30 device where if the camera is probed before the 
IO domain is configured, it will fail to probe due to the IO domain 
being misconfigured and messing up the clock signal. If you boot a 
recent U-Boot (one with IO domain support) and then boot into the 
kernel, this isn't an issue anymore as the IO domain will have been 
properly setup before switching to the kernel. Of course, this only 
works if the supplies for the IO domains are not changing at runtime 
(but on Rock 4 variants that doesn't seem to be intended or even 
possible). Another possibility is that the ES8316 is missing control of 
its PVDD, DVDD and AVDD supplies in the DT and somehow changing to this 
new supply brought vcca1v8_codec up (which is DVDD and AVDD).

I'll be sending the revert to the kernel ML and we can discuss there to 
have more eyes on it :)

Cheers,
Quentin
