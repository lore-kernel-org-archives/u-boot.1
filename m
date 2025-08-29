Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C0CCA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 16:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2162D8366F;
	Fri, 29 Aug 2025 18:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NzWL55EK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D30FD83675; Fri, 29 Aug 2025 18:19:17 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C024C83542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 18:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYlfJ7Aww4UWxoA4Kr/C+HgePJzxuq/le8MfNhxMuyiOQsjcbmLQVag/TInd5D1OFf80quUUGLEYqUjVS+w46QkfYMSI3xSPCtDyrK1i+yT2pGJiQZnIWGfIF1uy2GjWvmBqqcYp7OH/nO3M+SiGfzQaeMQPJQcTqqiob/15Fl3us7Q/PTi8wam4THbCdBUP/RPBqsrNpDYkNIyaqR/SOSHUhz0ODSfIvmCNnuA/TUiwQAklZCiVWchmQAtFrzVIT+nSU0hVS2VvT7IwYLnLPVxpqGkeXlbCXgWokUp4qjGnSQernDEGJWrdn5GN4cXf1n5CiXXmcdoDOV7EK1NBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbWiT2U9KdJ0Ib1lx3ZuutaYdKoaQpUvaRmHksElVhA=;
 b=EHdWn1T8RAKmFbDhMesaUrrugexigfIuSuu/8hXZ0zhqS7GFWUn/ngR55PazJ7gu7ij1Z46x/Y8RoVSxG4Fo2KcFEAP93jNN9pch6zvQtEXph8XkTj0KaqlFgHUFwQdgtkjOkkUFW1vbQgrc7kYDt2+8BBl/iZS9+URs4Z/zkh8sqfgRYK2K+arBEB+lWY3WURx+Jlu+j96dOnJYJKDig7LmBpCxaqDylYpVpXo4oJp7e69m+7AZ70Viu1jUi/phbCb7o7c87sU0m4EqlK6DF/rUbX8Aq17DgXxgxy+qEmhhFUGwIxCHkCylF1zbVMPpYFB7h2xXpJx5sR1Ggy44sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbWiT2U9KdJ0Ib1lx3ZuutaYdKoaQpUvaRmHksElVhA=;
 b=NzWL55EK+jpbZUCvxAQO3Kwuqpj6+EGBkb1H6CSlHC5JteLhdgo6sh2qwMrMtwRla6sQVoWKUu871Ek2gSJi+G0KUl+pJLW8Z3KsfMUpULP/0jCkp/8JVdx5bJW2wtZkYAaX1u9QjMh6KBitRn45AVEYUI2+Jms83qWPNwjcGs/HWpXtBNwSMhmkNHG72Xk1tq/U7kvcEiyEQPIzOG/KH4jM9+5mibhlZ1TksS8HAnRe8TQXJE7pVvOlgQpvC4s8HNrqtuliyFdpCVJBRW8vb0zjX18l+6vTZkSoJlxZu0M8ral1LH8aREP+Mbxj8JaWwYabOlffkFPIxHJnxzOwgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SJ2PR03MB7449.namprd03.prod.outlook.com (2603:10b6:a03:558::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.6; Fri, 29 Aug
 2025 16:19:08 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Fri, 29 Aug 2025
 16:19:08 +0000
Message-ID: <69597595-6c7e-441a-952b-16b80fd60aca@altera.com>
Date: Fri, 29 Aug 2025 21:49:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
 <7cfaf6cb-38b9-4932-8904-ce7be12a5098@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <7cfaf6cb-38b9-4932-8904-ce7be12a5098@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::7) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SJ2PR03MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 668a3fbf-2006-48f8-c58b-08dde717c7d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzNueHRiSDlZR2Zoc1hHYTRSRTR2UzBkKzhWd1dGSmo1OVlCK3BDMWNSUDFh?=
 =?utf-8?B?azRjL2FlcmQwTDVUVVFuRE9odGZYMndlUkZRVndEWUsrMmxoeEdhc2Q0bzM4?=
 =?utf-8?B?ZjJiMXpvK1pvZkExeklkZ1ZjMW04eUJXeGEySHE3d2tXNElkalNjSWtVR3FK?=
 =?utf-8?B?ZGFZL094OG1FSW1ZdElBRWJQWlQ4WEdPRWFJeWFIcHlKSVhPUDFmUnZYUzhm?=
 =?utf-8?B?L0xQRk9STm9FcnVTQm4zMUhxN1BTTVFtTEl6eGhWY1dJaG1EOXhxYUIvQ09x?=
 =?utf-8?B?TXhCQ1J4NHJlNHkxcXBRVjVDakN3WDQ0ZHdkd2QxTUxrTXI5WmtJTUg5K2Er?=
 =?utf-8?B?MVBZQjVZZUFKSDNLYnZVSjJ3eE1FSC8xMlBta2NhUFJtTnFEem1tcWx2bXRO?=
 =?utf-8?B?ZnZSWDFuUXVmb29paFRkOVQ0bFFhTlFUQ0JLc3lVSDRoTnVaS1ZYc1hPV2No?=
 =?utf-8?B?U0Z6STkxL0R0Q3RWKzNXWVJPbGpzWkdDUFFBTjllWEJ5c2QxOWNoZTU4c212?=
 =?utf-8?B?Z3ZsQ3dGZ3R0TnQvZC9rNHN3RFg1Qlc4Q3FxV1g1NUw3YWRneXBNTFMvRTJi?=
 =?utf-8?B?RzNZSElYVWlQemVCUE1rOXJKZjNabFBZb01oRWNoY1Y2QytQUzZTWTFpK1Qy?=
 =?utf-8?B?UW5lV05wZVhZZnlmN3dKN1lHUVk1KzJuNnlOTEJzMEk1OWFMR21URGRSZUpJ?=
 =?utf-8?B?OWNPR3NkVHhFRFlIbHAyWS9TY1hlOEtIem1jUGJqb29HMllOZFVoZkxkSzN6?=
 =?utf-8?B?WmNZZlNRNE1mMTVVU3o0S2lBZlBTT0R6S01YeWdPZ0MyRy9aTXJvUzdEVUdm?=
 =?utf-8?B?T1lyUmF2S2Y5a3JaaWtRMFNZSXNVUWNzU0NXOGxGVWJIY1pBaEs3MXdsaTUz?=
 =?utf-8?B?SzdjOVZLOXAxNDcrNXVaUVg1WjhFclAvUG83RUtaRTV0VmF0Wm1iQW1xMHJ5?=
 =?utf-8?B?TThkLzhTVDhqWWh4aEh2eWwwS2o3NmI1SUpLZzFsTkNZOUNOQ0Z6TzRyVVho?=
 =?utf-8?B?enZlZS83U1E2RkdNTFExOEI2R0NJNXoyWHFWUktkYldIR0drY1RTQ01MS3Iv?=
 =?utf-8?B?eWg1aWdkMlRaS2NoTWYyeThNL2VJVSt1RitZNHk3VlpyS2tnUVhwUUh3RmNv?=
 =?utf-8?B?Z0VBdFFNbER0OFdHUVdBK2hNMTVkaGFWSEVTNHJudmJhTVpwTnNoZXdqTTNt?=
 =?utf-8?B?YStZdElPdmtZOStHNHFJZFd5dlJZekptQzJTUEI0ait2STVTSHc5U2krQ0NC?=
 =?utf-8?B?bUxRUURRUzcrUFJDTCt0ZkRxU1U2UENWVTM2Sit5RDh4RmFqSWZmNEkvTElO?=
 =?utf-8?B?QjJ2dk5UMHRDZlEyVjVuY001QkkwaTY3ZG13WmxyTGtLZ1NVWGFTbCtFalF6?=
 =?utf-8?B?aE43NVhZbzB6YkxQL29rTkoyQkwyNXhBYlRXM0RGeUhBWjdvbXAyMllIN2pm?=
 =?utf-8?B?Nzc1N3U4RUF0NzJYRkVCb0F5WExvRmU1eVN5R3RwNDkzdWFFRllBRlJlVkg0?=
 =?utf-8?B?UWNtVVYwK1h6bk1TS3VpTEZVSFp0V0kvNERMalU4Q3dvQXRzeEVQS1ZQNHlY?=
 =?utf-8?B?NEcrcG4zbC9iOXhMQWhEVHJrMVdNN1VaMzRBN25NeVU0N3E1VHl0R1MwYjZH?=
 =?utf-8?B?Q0RRaG1GUWhiQzlYREc1RStxclRCQ1ErM0cxWlkrcG0yOE1ET0d0WW9ONW1O?=
 =?utf-8?B?TG4xRnhncXd3TE50RkRJdFhWakNwMC8wa2Z6YkxSTDZOVmd1Z3dnc2szSDVv?=
 =?utf-8?B?V0F3WjVyOEx1cUNZWmpZU2IyNXplcnFObGp6TzBzUCtKSE5MTjdhR29TUEFC?=
 =?utf-8?B?dGY3SFJxQWVvNWlwVU5MVk5LVmJVcXl5Q1EvYkkyc1lDbHIvemY3VW9aenFQ?=
 =?utf-8?B?MEk0RDNNRlBWQ04rU0RoQ1BKR2kvU0tNbWdzb3ZHd2taMkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVJxb0N4a1l4VUVYSXljb3VCU0s0cmZLSjQrK2RIUFQvR3lKampVam1aVlVh?=
 =?utf-8?B?YzBSRmNvRFk3V1RLZEVXNWxCUG93QTl5S3RQSUIra29KOWE1bVZvTDJEdVA1?=
 =?utf-8?B?UDBGSThNUUo2M2tiRlExdnpYRkQzNzdSU2ErV29aN3NGQkQxSTZXZVV5eGJB?=
 =?utf-8?B?ZDZsLzVuMmRwUnhjWC9qdWo0ZzFnSDBhc2pMQVNTZUY5UzU2blBMbTk0REov?=
 =?utf-8?B?Q0ZWR2syYnpaUXJkTjg1c1NxRHRzUFduZEhYdFZBdnBCWjAvNGtFclZYK05N?=
 =?utf-8?B?OG9xWEM3VWdWY1BOQWxGVnhTc0tTdEJJalZLMFJsbXNXRmFHNjNLQnNOUVh2?=
 =?utf-8?B?MWVNS2ZvcmxTN2lhNjk5NWtQS0pkTjVldTk3NXRpaUNlWFEzTGJuUjFjeTRB?=
 =?utf-8?B?Q20ydGhHQ243OTM0TWE3TEVvM0ZJOGk5dnQvQjVPNERMb3hUS011bFh0TmVk?=
 =?utf-8?B?UkkwM3V5Y04vUDhBT0ZYTlNkR1pEU3c2cjd0Y0ZZYitic2h6QjNtNFJzZEpL?=
 =?utf-8?B?aDhUMFBpeWZwMmVBUksrZkFBTFRxcVhVMUlzZU9XWTVhb0hkeHlkZzltRnZW?=
 =?utf-8?B?bHZNa3hOM1E3eFRnRzN5NmJaU2d6UHVVRlBqZGt4Tm9TS0FZUDZLOHMvWFNn?=
 =?utf-8?B?Wm1hMnB3RW5EYkZVZlBSZWNvWFViT295cnZtK2QydGludjJhNHZUUGc1enhX?=
 =?utf-8?B?dGFRb1Jmc244dVlBdUVpdXRjWDFyQkRsbldZMWRHVkYzNjNXQnd5ZHFkTVlj?=
 =?utf-8?B?emVkTFdQUjNNaFhDV3RDNTFQUjVJU3RGT3JQdzFXZEx6cXZwN2N4d2dOV0lM?=
 =?utf-8?B?QjQvYjZwVXc0UXdVc1QzUzlUQW5LS3laYnNSeUxnNklsT3FtTDROcnJhWCtr?=
 =?utf-8?B?K282ZlJWQUVibHRaeitJY0VkTDJ2cFNVbEgzdzNxQXNSY2tiSlk3WVVKYkUw?=
 =?utf-8?B?dERQd0lvRDdPQmhOZHg0UVVzUjNOb1hyYmxNL0NTQlBmVzFqcDV0b0JTTHdp?=
 =?utf-8?B?ZHFDYTc5Q3hlaUJVYnp4N3UzMVkrRkNqM0UvL2lPVUdyRDVPSVk4SkF4TERX?=
 =?utf-8?B?SmFCQmpDRWhZL2hsNW1CT1NiWm52ekdYWDhVZ2M1bmw4cm9jNDZRL2JxaEV5?=
 =?utf-8?B?cUpNK2pjVHdhWEhyZEJYMWIvV3lpMERJRXRGNXFXV2cvQXlKb1dKcXJQWmdh?=
 =?utf-8?B?R0k5ZjRCVzNjRlR5cFRGajNWYVArYlBxMjRmR2dWLzN0dnp4bUt5czk2MFYx?=
 =?utf-8?B?UlRqWTU3VzRwSVh6VWtuNzhoWS83OEZwK3R6NUVSVGtmTS9xSTYzNGxzQ2R0?=
 =?utf-8?B?V0d4V2dwWmNjcmhmRVd5TTJWN3ltU01pRjZzTS9QZlg3WVROMm1NNS90SGZy?=
 =?utf-8?B?ajYxc1FSc1U2WW1keHVrUUs2YjFHMDROakJ6L0lFRUF6QW1lVDA2V1NxQ2Fs?=
 =?utf-8?B?djUzMEx1Q214VmlnSXN5VndvSHQyNldxRnRXYWtwa21Td3lyZThVWUhFOThv?=
 =?utf-8?B?Q2IwemRESm1idE5oYnVWdHNtYjVQbnliZFpRbWUzTm1uRXpmNzQ1U3ltWUpO?=
 =?utf-8?B?d3ZaZE5YaXUyOWxDOFFwWXV3NCtIMlZOSXFldXZPeHVlNkU3NUJ2aUtMRE10?=
 =?utf-8?B?cHBQV01oMzdLSkplSHRiTEJ6a0tuL3J4Vy9oTjlueGo5dG43dmFBZDRJWTJD?=
 =?utf-8?B?TnhXNkJ5ZnNuUzZ1dCtvV3NBRUVMcHovRFA2bVNTLzB3T2ZLdXJvcjBZMzNT?=
 =?utf-8?B?Ui8wa0l3aUFKR0h4NEdwN1pLZHlNano1bE5TY2tINHkycHFVNHQycUg4Rlpv?=
 =?utf-8?B?eDhvdno1YkJWTXdtamlsNlJsaWpTbGVUdnAyTDhWZWZGa3Y0WThoRlU5L3VO?=
 =?utf-8?B?M2RCWkVjMHpjeGVwWUFoWDFLTm1jU1pjdDIyT0w4Q3NyVG5vbFh3K3V1SThr?=
 =?utf-8?B?QnRMemlJMTZOMW5LTVZPd0lKYkl4cVZQazF3bXdiK2t1Y3NoUkdJNzF6MlZI?=
 =?utf-8?B?YXlYdWR1VE9Oc2xBbVVTaTd0b1hKV01oNmRuK2I0RVgxb0dpUHlldWNHdklZ?=
 =?utf-8?B?eWkvTHBhMnRhOGYzTjVuUVFIRkRvN0JNME5WOSs2Umh5QVUvN3pGNjdVKzlw?=
 =?utf-8?B?QTFWcDRrU1I3OStUVHRaUkxUTzFmOTJ6c0tVbnZ0dkJSVEEyM0FiZDlGbFla?=
 =?utf-8?Q?81kL1O63F6vqGz2eF1iHzHQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668a3fbf-2006-48f8-c58b-08dde717c7d2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 16:19:08.2988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgq8pzN+p2m7/qRFX79n4Com1krOfq12exru4C2abtxOOK3FDrQBLNytDFMSm5FEP9rJyXp/lCOsw17VDV1f5AodK4DN2F4+jh904wPg084myvguZDZc02gGYuCChkfJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7449
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

Hi Marek

On 29-Aug-25 2:11 PM, Marek Vasut wrote:
> 
> On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
>> Some USB devices need more time to be initialized. Hence,
>> increasing the default USB Hub debounce timeout value for
>> devices to be discovered, connected to Agilex5 boards.
> Is this really hub debounce timeout or usb_pgood_delay ?
> 
> Which devices are those, include that in the commit message.

Yes, timeout is related to USB connect/disconnect signal bounces not 
about bus stability during init.

Issue was mainly observed with legacy flash drives. Maybe I will change 
commit text from "Some USB devices need more time to be initialized..." 
to "Some old USB flash drives need more time to be initialized during 
connect or disconnect events ..."?

Note that I am not modifying the default Kconfig value in general; 
change is only made for an SoCFPGA devkit we tested.

Kind Regards
Naresh

