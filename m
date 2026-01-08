Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739F8D1D480
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 16:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA2F2841F2;
	Thu,  8 Jan 2026 17:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GCdgaIuK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A5A8421C; Thu,  8 Jan 2026 17:37:17 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CCB684158
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 17:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxPstKWWuHUqzlHpuLuyryqj96Z+G/xEFggxu5SuoqHjHG8CC5gqmaVYkacmZ8LkAFTNncUQAo/TiIwxiHe87shhJcrLjF0SNu9noZVfnUIuqvPXNJ6YheQsDTjhh6oOpTkxokIdKeStR7J0da1a2NYQf2GEmqYZ/ROADic3le9FskzsZsN7Btxi953olRoMmdK7Wd+pjPgTHs398rrWFY0EL2J8TG8RwiutkaAuKG1GDaCWrErDWWNRl8O+eU6hBRalE7UHxmyTkAC90XpOR0psQHnzSt00EPjeAwH14lmer6UWlssJ/H2tKIFWwAZ+rXCxKwHjyZayzK9OS/1nqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUrxnMp0JDhOfnFLrhTGnMtEmWg4wBTCJfQNvmSTVBo=;
 b=AareUJBi+Wi+9xgG1qmn6lNfWz11yTbYOKlpnw61TV57wkwJ0XEYUV0WB33ukvorbdImlAAJPn6HUlh7H2EgXlbaOFtq0Z9yVJYNNGQQOBrc8xWoyIF1UNLTg/Dvmv3LePKOa3U6NckOSPzp3MtUs2Cbg8J9FoPI5Hr40Wmst7dyeiRDnZx5fxW0Rg0ci+3aEWQIjACQKhhF8/D0miJswwGyw+cVtgKMlsTvnMTsF1YM0LlQZxKqYun7MQ1RYzGJO/mAJxW/BXzaTQL8hhWc+BlNjO4YYZc9omwhZoH9NBBOXj/BOT4NbBeGvWnJNBRBoXY913IhcL9jzj+PvlCKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUrxnMp0JDhOfnFLrhTGnMtEmWg4wBTCJfQNvmSTVBo=;
 b=GCdgaIuKSmdyM/wcLRKfdPVMfzcAsonZK7J2pjktGd4ydfnsdOXy9ZXQH3bV2/ujY6zPq3yAkTiWDXmnCzdG1MdmuMGqUGYeaJktkpr5dXYLyanpWBPfCyeod2Ei8u6JNaYgBv9FIqRCv3jbmjY0p1gBBi4+6aBfr9vEQIQ4Fbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB11847.eurprd04.prod.outlook.com (2603:10a6:10:622::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:37:13 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 16:37:13 +0000
Message-ID: <68b4f191-65aa-4f4c-bddf-adb6850d9235@cherry.de>
Date: Thu, 8 Jan 2026 17:37:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: RV1103B: Attempt to upstream
To: Fabio Estevam <festevam@gmail.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, U-Boot-Denx <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, xuhui.lin@rock-chips.com
References: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB11847:EE_
X-MS-Office365-Filtering-Correlation-Id: e951cfdf-34d8-4e5b-b492-08de4ed42d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak0vR0pJMkpEYlIzK2ZxNzBQN2tYMWxPNjViajdNeSs2Y21KOUczajdtSkUw?=
 =?utf-8?B?TnltOWRQR0llTWI5d3MwM2VOakwxSWltNVNkc1JSK1B1OEhNK3VOemhwTFJ2?=
 =?utf-8?B?V3RaZTBaUjRBeFJwZVBVWVN0bjhzSkIxTHdYa2JkTkxuTzVlcHdpd0JCeTJt?=
 =?utf-8?B?QmJValA2K3NreWs5dURtdEI2TFNmK0l4Zzl6cHBvQnZ1SzdDbyt3TjcvQXpq?=
 =?utf-8?B?Um9hYWxFa1pQek1Qemw1RFVsY3pnTFZtZGlqSTJrNHhKMG5VL2d6V0UzUkZp?=
 =?utf-8?B?N1RuU3pubkRhRC9rRXNPUlVMOElvN1RMMG5ZR3VEaUM2bjJNK0pYOXZkeVh1?=
 =?utf-8?B?QmREWnpwaWpja3lUR2tQZG1KY0ZBbjBUdDdjcUdWc2gzRjVXa2pJczhpajE0?=
 =?utf-8?B?VGJqMDFYMlI1Y0FKTlZlMUxpU3cvanVLQjY5U01ocGFTRlNvZ2k1UmxqeXB3?=
 =?utf-8?B?VEhMcG8zczNtbDd0QVBJcjNoOW0ya0k1ZndHWXo5SjdyanVpZktlZS9Jc2sy?=
 =?utf-8?B?RzRnOUNlaHk5bFhDUXRWN0NxRnI2eTVxMndRRTFwZDJFT1k5WFphRGM2VEJB?=
 =?utf-8?B?S1hLSkJkWnBPSEk2NXlMYVJHYUM1c2V2UUlYMTVEbEl3bWkzSDBPNnBaeHBT?=
 =?utf-8?B?TWhIeXlFc0hQc0NzQXdsb1NYWEU4dHIxU09sRjRvQTZ1cmwvcDUrTW5rdlk5?=
 =?utf-8?B?OWtJMHhzZHZ0MmtEU3l5R1d2QjJ1ekplbnBLTGVmbGg1QkwrZk8zRkwxa2Fv?=
 =?utf-8?B?TkEvN2hCZTc0NXd5b212TFJLSnBOWVVXR0lILzVzTUJtcmdJQ1V2QjdIdjl2?=
 =?utf-8?B?RnIzRyszM3NmdXFWZ2FGeE1CTjIxY2NVMDlZRVlkSXpodGRBMXAvckFvcThK?=
 =?utf-8?B?dW9wN0U0b1dQTmRBMUtFd2Z2ZU8zeHMzQnJFNXQzUDFGcmRkVisrTUV3Z09k?=
 =?utf-8?B?OWExdGFYNkNYVW1TMzdUc0gxb1E1anBNNnBYMWpOQnBjNmhERmgwT2I4bkxV?=
 =?utf-8?B?WWNoQVpOSFg3T2VVZFhVdnFVVWhJK0VJanF0R24xRkQ5UlpmRFViWnNyTGlD?=
 =?utf-8?B?T2ErdFFoUEpQQ0p4VVVEUTFhTFhXYkNQL00wUm81MTBqQTdGWm5mcHp1NXk4?=
 =?utf-8?B?ZnFoQVFMNW9lOGhFQUJnN29jUlRKTkRIeUJzU0RtQnNVR1J6S1hUYjZ5bEZv?=
 =?utf-8?B?ZDFkZy9vOStOWHI5emF5RFdEL1pVMFBvWHd2MElYNlh3VTZ2Q0FMTE5qV0FO?=
 =?utf-8?B?cVY3R2JyZDZJV2MwODZmRWsvVEU5d3M1YWtMejBFTXJQeU85VmFERGhIRmpD?=
 =?utf-8?B?dHZWUEFkN0tXQjF4L0VpUDlPdEFWRCtvMmRCSnNvL2Vpd0YxWHdFL1BTc1Zx?=
 =?utf-8?B?RUNEMXVvRWo3eXV6M2VVT3BGOE1jTDJYNWEyQnlVekpDQWo1N3FOZlk2eXI3?=
 =?utf-8?B?VHRMaHYvRVgwVk5TWTRURUF3Yk15STB5WWV3dnF2Sk1VcHFvOHJhc2lORFYz?=
 =?utf-8?B?anhvNWtTeVdrak5oTHRyekx5S0JrZ2VMR0JOWmpOa1l6bnZndXVmSmJIaWQy?=
 =?utf-8?B?eHRxK3V0RjBRaG11SG0vdFl5U05qNVQxVkVDN3FiWUMzZDN3L284WW0ramxP?=
 =?utf-8?B?SG1XRHhZY2ZucWI1TVJpb1I1ZXVRVGVXbnErT1V0VnBGVzJvT2lIOVQvYWM0?=
 =?utf-8?B?R0FOLy9INVdZeHM4R2l2VjlkaUU5eFFKd0ZySGdzbHF6YXV6OWpHdEpMaExV?=
 =?utf-8?B?NzIwODQ1T1I5UlptOU12cytHUnNhZjZySUhBbWowbEZ0OFhMR2N3ZFh2K3VQ?=
 =?utf-8?B?bkVzNkNseUlOMHJpZUNpZ2dCMXNoNUV0aHpDekFPMlNxVkxZbE83YTlQRDdh?=
 =?utf-8?B?bEZFZitqWTJYamRlbnhHU0Nrd0VIRTZybVpxYUxjQVFTbWJCM01vTUN2SmZl?=
 =?utf-8?Q?eTuhN4nAiXbmsAfCk/oEOXSYzXnM/I0D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d254aWFrNmd6WmdNMnBBZ3F2NkloQy9xTHBiQmRGcGhhb2F1elVRVHVEdUhn?=
 =?utf-8?B?Z3paNEI4MVF3YytJUE5NdUdLWVBtUE5RdWR1ZmVaMk9ranV0UlpxN05PcjQx?=
 =?utf-8?B?ZkV6UDVlcnNVWHZzUktwcFBlQVlvVUY3Q0ZPeVU4d0g3ai9OeDhUTXNzeTBP?=
 =?utf-8?B?SElGR2xDSTlxblpka2V0NEJJQkhOSCtqY3MzcmU1M3YyZFFnWTdXc2ZWeUZP?=
 =?utf-8?B?ZlJYWU02Vll6VkpwTWJxTldVNlZlcTZIWEc1T1ZsMThwdkdDbWlPNm82TWJW?=
 =?utf-8?B?REN1WHlGUGdiMlBvWi9kellrak5Ta3lUcHlqSnhSSzdYTjVHOFcvUm9mc2Z5?=
 =?utf-8?B?ckVJWFhZVExHUURwM3NoOW50NjJKOTFwcXZXdFRkTERNWm1QUkhqWGZPMVRy?=
 =?utf-8?B?L1JkTVFqSGhPZW9FT0NjMUlxMW9lbElHTUZmUVRzWEpsOTMreWJURlpVMFFW?=
 =?utf-8?B?anJuUmo2cDMrNjl0N2phdG9GQURYSVlaTy9XOVloN1dManBhRzZMMi82dkl4?=
 =?utf-8?B?Vzlodklvbk1MSlY3ejhpMzJPSVJ6Uk9JTmR2ZGsyT1QzQXJpa1FjdEtKbmVG?=
 =?utf-8?B?MUVUL3o1UGRmc21zLzYyempHUjhrWE05SWpxRWk4VWpOOEZEcnA2Wnhmcy9R?=
 =?utf-8?B?VXBYTng3Mmtla05Ja0p1K1lUbndybG5XLzdxQkdvam9hWVRJSUo5UExvTXZw?=
 =?utf-8?B?UUZJcXlkd0VxNWRpSUUwUzJQOHdEM0dZMlhCOGJMaHRaM1NTRDB6SzB0MEJU?=
 =?utf-8?B?Z3JuQ2dnWWMzbXZ2UUljWDh2bWVwZlQycFRBcHBYUHZnc1VaVks3TjM2L2x0?=
 =?utf-8?B?QU95aUE2ZHZiblBOS29DSU44dzZkWFdLNmNmUHFnbW4rWmYrbFN1MEs4QWZI?=
 =?utf-8?B?MEFCUG9mKzFJSWJROUxkNW54Z0IvVVlQK3YyQmRWc2dMTGx5NjlQNXBnZVBT?=
 =?utf-8?B?ZXhoY3c3am9ldGVkcnpCdFlYVWdhak55aXE4M0QzR1RQWTc3SWVja3Q3RG5l?=
 =?utf-8?B?V0IvNVZnamRveTYzQVFmZWZaQXpDSEZaWUpRNG1LT2htNG1WcVJIamx5NzRV?=
 =?utf-8?B?RlZmVlkreDlrWU4raG80by9XeXlJbk44ajFackpwRzdEMGlRWnhZZ2hzWE84?=
 =?utf-8?B?UUdzUXI2NTlRVWFhbUFtS3BuelVUNWkzWVZxTE9laUJ6a0d0WE9WUEZNa3Nx?=
 =?utf-8?B?WnRBMnVyaUZQUXA2d2NiZEtHSkNXaVBGSU1UVzRMcFRReEdXRWtGbFVUUHAw?=
 =?utf-8?B?aDM0UnVFbU9qMGJWbUxzYi9RMnlVVG4zQW53SHRqTFYyNzJUd2g1S1pHcGZ3?=
 =?utf-8?B?Z29jcUE5bXBYQTBZalIxL2VtSVQ5UUVYZUVIc2k3dk1Rck4zQnVQbnNyZUhx?=
 =?utf-8?B?cmFaOFhGUTVZYjAxcFN0T3hVbDJ4WGpMcFFxY3BCUm8rUElwOGw0emRwR2pZ?=
 =?utf-8?B?VnNjVFFMMThHUDRFOERueVdsUnA0dlk2czRtbFZyU0NzU2szNlJTdU15bml2?=
 =?utf-8?B?TXluZlJjR2R1bnhMd29qY1BLZlJwc1ZZaWlJQXdFWEtzNk4yVU1zWFI4Y2tI?=
 =?utf-8?B?STY0YWpYSVpueGRCVFVMQWJnc1drSmNjUkh3ZTRzMWpsYnB3Yk1ENWcxNHAv?=
 =?utf-8?B?eVhBTFZqK2dscU9kcmZndnZhRnN0RXE5TXpDYjNqNTNmcWNTa2lQZjhuZTNz?=
 =?utf-8?B?KzdEVTNBNk81TlowMXNyN0lkMUlCY1F4Z0YyMEpIblVMWVB4dUpGRk5lZ1Jx?=
 =?utf-8?B?WTdnak1qT09aYmVZZzFlTGxVTUNoYlVBeFJ0cUh1SVNoVkFET0xFaDlCaXBl?=
 =?utf-8?B?WGRCQnEyQ1pUWnNTNWw2L2l1NlZlS3ZpdU1WN3RPbXpBOEluR2dZeUcxanND?=
 =?utf-8?B?TjdyWktWQTNJUnFBVDF5eEZ4cmtDS3RHekJhZW1mLzYzNHAwYzF5Z1BaL05w?=
 =?utf-8?B?dC9waFJqTnJPSHZlR0dvR0R3bFVTTitpMU9zSjV6am5rZ0JpRndhbU9XOVkz?=
 =?utf-8?B?dHRTUVFHeHJESVczWkVqZkEvYWVoeXZQSWQvZ24rMEU5ZG9vZitCV1RYMW1F?=
 =?utf-8?B?ZkVLN2Y4WXVIVi9EalF6S1piZmNXQ1RzakZ5OGJROUNVYjJNUnFtWHcwTmJC?=
 =?utf-8?B?ekM1VzZGYkx2YmVDN2dvRlBHWXI1MjdZM0cyeWo1MXNUT0tDN2MxUmxSTGt2?=
 =?utf-8?B?ZUN6UmtaOFFkOG5adUxFWW9aKzVlOUg2ZHZxNzdUZCs4eWxpbk5XOEE1MnR4?=
 =?utf-8?B?QVRocnU0eDhRMXF1UllQL3NieVdGU3ZiQkFMei9CcVM4NjNYa3RTNG93eU9h?=
 =?utf-8?B?anVWcGxMRHVjaVBVTGowcTBrSEU4bm4yZDRzUW9rUCtxOVk5SWVMT0VBT3lv?=
 =?utf-8?Q?V/hxiNmY5KCtuSnA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e951cfdf-34d8-4e5b-b492-08de4ed42d28
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:37:13.1907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vpmw4nuh5OYXhxYb6xzIxZLYYd1OHOO+dYADf1Ypr/TuWQxIZX/AGtjRNtdw+264Sv5QCz14389fNRfDt0XBxCNtJoZd0tBDQbRs7wjzJSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11847
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

Hi Fabio,

On 12/19/25 3:45 AM, Fabio Estevam wrote:
> Hi,
> 
> I have a custom board based on the Rockchip evb-rv1103 (RV1103B silicon),
> booting from SPI-NAND.
> 
> I can successfully boot the vendor Rockchip U-Boot v2017.09 on this board,
> from SPI-NAND
> 
> I am currently working on upstreaming U-Boot support for the RV1103B SoC.
> My first RFC attempt is available here:
> 
>    https://github.com/fabioestevam/u-boot/commits/rv1103/
> 
> Build steps:
> 
>    make evb-rv1103_defconfig
>    make
> 
> However, I am not yet able to boot U-Boot on the board. At the moment,
> the board does not boot and only prints "RKUART".
> 
> My initial plan was to avoid SPL, similar to the evb-rv1108 approach
> (described in board/rockchip/evb_rv1108/README).
> 

There is an SPL, it's just a blob from Rockchip.

> Before going further, I would like to ask:
> 
> Is the evb-rv1108 “no SPL” boot flow a valid reference for RV1103B?
> 

No clue.

> Any guidance or pointers would be greatly appreciated.
> 

Do you actually use the same SPL blob as in the v2017.09 image? Do you 
see something on UART on that image?

I would think the SPL blob from Rockchip would print a bunch of things 
on the UART (e.g. while initializing the DDR like it's used to on 
RK3588). If you are using a different baudrate than the one set in the 
blob (usually 1500000 but maybe it's different for RV?), serial 
controller or serial IO mux (the number after M in the pinmux, e.g. 
UARTXMY means controller X mux Y), you can modify it with 
https://github.com/rockchip-linux/rkbin/blob/master/tools/ddrbin_tool.py.

RV1103 is somewhat old, but I'm assuming it's not impacted by the bug 
that requires us to use rkspi (instead of rksd) format for SPI images? 
You would need to write 2KiB every 4KiB IIRC. You can check after 
flashing the downstream image what is the content of your flash I guess 
to check that.

Usually, the blobs from Rockchip end up returning to BootROM for the 
next stage, so U-Boot proper would need to be stored somewhere in DRAM 
and jumping to it by the BootROM for it to work? Not sure about those 
details, I have been fortunate enough so far that I didn't have to do 
any SoC bring-up but maybe Jonas or Kever can help here?

Good luck!
Quentin
