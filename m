Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D410D10375
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 03:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC8A839DF;
	Thu, 27 Nov 2025 04:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RZGQV8Es";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83802839E8; Thu, 27 Nov 2025 04:18:30 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A9D5839B7
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 04:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiNxt2WadkrgYJYL//FCaHTNUdVTNZ7BqvSrDrOX5dVYLtoP8Ss0/+syc3KccHDPGdZLTbJLDjGO6uzuK1g4hRoSMODvdgBp08e0n3jUOYfBpV3xPxtlkQKGx+pKGbbXaso3wNrMdS053SoVjTCNr8OIMiHAQzG2Cm4/czc/tjj5iq3WCe0MwlhA/wgMUGWvVhBKEJ/+znaLfdw1z5fquWXU0LKjh7KokXa7RgWBnm7vpIEX/grkR6/g67QlWM0nIYythf+tne2h1Aamawk2Lu3g2aizTpQOi2gUWuPt/zz4WzN1U+sMFjcaoVCeq09TT/0aR79zxwKrbDOd4GsxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zODrkUfPRfkkqOg/Hw1Mz3RbimsCBB1G99pDdphxBy0=;
 b=wZgnCJbjq/l1rjkQ2nOkxHIUr15yOytCa7n1E4D+mjcKOTrTJeWw62lHwKDWWm/7SaylqmRH3EYMbuoT4FLMmrDjomw3b/3mcFrBLXA3ZfQ+jLBJfPX8QHASVmKDCPkt13Zvw8aVzghT8IEUXSnLiv5OgEOQJFXP3c/7MWo8GJ7A0DLsdCzES4DN8RyxJa/V3HzzFO2N4UQelGe1alU6NsaHQ7qi5tDcTs0Vs5BGB8lwfcQrIE2zlAAtmJV9vkQd7UWra3eCHOvFZluD6ihqUMLYtWIzkJ4vI8cy3YCn194/ihj8Ia5ymL2LxYgdSXtIhKhjb95PMBW1Yt9CGhyNnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zODrkUfPRfkkqOg/Hw1Mz3RbimsCBB1G99pDdphxBy0=;
 b=RZGQV8EsytWIM/YTHBJcQ77NU+mJGlrZ3sbWXhzn0ELnf7BAWoR8eqxkK9o0admmz9q6RliGZOXpKLnMTrRxus3LlR6MJU4eILrg+FAPJJswWPZve/zww1EgUKN8H7vumATqP1iNFqH3zJjgsqpmjhWmrZYKVcC2jSuRgmJv7zNULUEfr0TKVNkmvdCXPpttXjuNmA80XDy1U+YVZLkzRl1Ow+MKxAZOgkEy6KkpnjALUpKZn13DHavxSDuiGkIrENiYfidckToZrauOtgfbro3AZA3QfbNTwUV2MEGOO1jD7O2tCh80cz+5KSN0ADJWaUOHbxshL5MSbJVN57p39g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM4PR03MB6158.namprd03.prod.outlook.com (2603:10b6:5:399::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 03:18:24 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 03:18:24 +0000
Message-ID: <fcb799fb-4eba-4155-aa0c-46b5279b7171@altera.com>
Date: Thu, 27 Nov 2025 11:18:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] Add optimized Makefile support for SoCFPGA handoff
To: Brian Sune <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251119111653.456-1-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251119111653.456-1-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DM4PR03MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 5574acd0-462b-4e11-60bf-08de2d63a014
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTRjZGE5dkxPbGZUVE5JbHllaDhhU2Z3eTArZUNQRVJ4UGYwK0Z6akF6VWJi?=
 =?utf-8?B?ZitCd05aTG9RTTVRUW1VY0dQbjdicGpadHhwREo3QXhVUkhNY2xVYjA5SXBI?=
 =?utf-8?B?dElmQUZFYTdRSHBPVmRwNEFRVjVFYzA3dHBKTXFjbTVTeCtJYnF3UEV5cFZu?=
 =?utf-8?B?cVBDUnZhekhMNUJIL3ZnbXVaKzVYQnRpK3BkYUlQZmZVclU1MjcxVHp4VXNj?=
 =?utf-8?B?NXlRQzU1cllMU1BBTm5ONzRLT1dCOEVuaVZGd01QOS9uUmxTL2hnaWJkTEpE?=
 =?utf-8?B?cVRMSElERjE2d2dkdGJPdjhramZRem92UCtIZkhMdm9ZSm16c05ibFB5ZXUx?=
 =?utf-8?B?V0xUSVNQaVlxdmZjMWwzMFd6S1l0bjNTNm45cDlIU1o2YlljS3llMzhYQTNM?=
 =?utf-8?B?bU9iZXdZaVdlWGxMUmo5dURKRklWSzhUaUlhUE5DYTZ6VVE4R3N2T2lxd2lZ?=
 =?utf-8?B?Y2FPbnV2UkQxTWlqMThvWm92Qk9rZS9TK3pKT3lyYndCWWVvNzZqMEFsS3hz?=
 =?utf-8?B?Z3NGc0dBWnM2TlA5b1R6QmU3NGdHWUxRanJ5c2E1Z3c5MGFEdktXYk1zUUxs?=
 =?utf-8?B?SVlQcVZGdnZKVWpxMlRWS1V1YlBVRGVqcDJKUEp1UTYxclhoeEhaVis1Qnlp?=
 =?utf-8?B?QmtFMFg1eEZTd0NhY3JSaE5XQloxRjM4M0dPMk5ULzN5WVR2aE1LVS9KU2F0?=
 =?utf-8?B?M0YxVFV6UWQ5WGw1amJxdXBocEh2OElSQmpXY2lqWnczUU1rNGJCMmlpeVFy?=
 =?utf-8?B?NmpsdVJLVnhlY1RKdGFIQTNtUFQ1N1FUZzQrVEhweWpkQXlhL2t6VjIrbDls?=
 =?utf-8?B?alh5QlFIM29jbzg4Qkd2cUtPZlJMcnJJQUFaQ1ltcW1NQnR5cXFJdWx1bzhV?=
 =?utf-8?B?NGpWSlhza0xJbU9Vek4vdDFtL3ZBQ1VKOVNrelljclVPZlpPek9oM09HT3Ja?=
 =?utf-8?B?OGI4blFxSFlYS3c5SjZXNzhsci9oQ3hmSXl4SkV1ZW9XNDUvMG0zY1NnbkIw?=
 =?utf-8?B?UkdSRmhUbnRqTUd0RUo5OUtmU0J3QkpTU3hnTHArL2ZvQU5SVEd0VUN1TGxt?=
 =?utf-8?B?Z3l4OUl5YjFyWXIweGd3OGN1SG9vRVJyOGhrU0d1SlVWU0F1NFQ0OHhjVnIy?=
 =?utf-8?B?TFBWSEtoT3pDOElBS3Y3WWhpaEUySzJwbkZMU0w1LzdZc2tGMjFJMm05cExK?=
 =?utf-8?B?dWxzbTV5VUNCMGduYTlPaldsYk5EemdTU0FCOEZ3b3RDMjFrTWhqR2FjOVQ2?=
 =?utf-8?B?cDBQTUxZWVB2elI3b3AxUnp5TGZxNVdvbk5vNFN6MCtiR3RqMDA0UjFBdGNi?=
 =?utf-8?B?b2VySlpjWFBWN0pIWUllamNWVWtJTFk3RkhxcnoxSnF0aWp0b3ZzcURtdWZD?=
 =?utf-8?B?K2JCTTVaL0JiblQ3OXRnUEJsc0M4WXlVU0lGNnRaY0gzNVBFcnhmOG81c0ZZ?=
 =?utf-8?B?dWVVTEdFZ3VjNSt1dUhsR2JSZTFNZ0J1VDlUTnAyd1VkTE8xcmVrVE1OdHV4?=
 =?utf-8?B?dEo2MVJudnkvaFMvWkdXUUlnRnhPOENaS0h2c1BsU3VqaDRVblU0bEcxZm5o?=
 =?utf-8?B?ZHRPU1V5dGVicGZZYkJyZFoyUjVsZ0dVYmd0T3l2ZEI4cDBMRFJieGZpdmo3?=
 =?utf-8?B?THdZdWcvSW02UDVNeGN2bmpjN0NrWkVncjM0Y3dZZk9xQ285R2NDL2hGa2tB?=
 =?utf-8?B?Yk9USXcxc3k3SVR4aVYrZjZYcjAxTWhCQXBBWVVQMmtiUVdPeE5zNzRudFoy?=
 =?utf-8?B?dDdSMzRYV2ptc1NaYjVrQWpBeDZBNm9rQVpkQXhoUHh6ZzNybjB6UWx0MHQx?=
 =?utf-8?B?ZXgwVXY2bCt5elQ5c3ZBWXB6b2loaGtDY0l0aWVqeW1PVFZQOUtYS1M5N2Vp?=
 =?utf-8?B?WE11L25PckFTMmZaajhBbFFxRkhQSWdyNjFJYWNacU1LSEZjeEZ4NzV4SUxG?=
 =?utf-8?Q?GiWYbwqwjETEAJCMeHb8dKnqa+ZSHobs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9pS2NpUXNMeS9GV1VhYzlsSmkxTEN5dFQyQmxTM1BLWUJzVWJWbm1tM1FY?=
 =?utf-8?B?TEVta2tSQVM4eU4rYXdJdWllbnpnZkRrcmhlU2x5WklFRnk4d1lHUFNUdlBk?=
 =?utf-8?B?WVdObkpaQXBPTmZ5bGw2aWRKNGU1NGhCRkMvb0pFc1VPRUF2ZUZ3aFdYSGZZ?=
 =?utf-8?B?RThkckhGeWpFa2t4K0puamxiSjdNVHl1RTVHTEZjZ09weG1Tb1hseGpxU1Nu?=
 =?utf-8?B?UjMrU3JBNytLTVlyT0gwTXIzNVd6bjNUS3NMczJQVU01Z2lBdlo0VitNN3kv?=
 =?utf-8?B?S1BDQ213aTNOb1J4ZnhKQXhKeTNmc2FYSHNaTWN0emtkVVoxQU1YMHg3VWY2?=
 =?utf-8?B?bUdBWGlnazQ0VThNanhhSWtYMzdVUitMMGdSRUxFd3Qrdnl2SlhEWGc3RG1X?=
 =?utf-8?B?bnMvSlZJRXZUZmhHUkhNZlBDUXRYR29OeW5HNWhCOEl6bW9lUlBId2pjeTJq?=
 =?utf-8?B?dzBoeklrSXkwWTVQc0MxVzlsVEdvZDhaSzhiaUJWQk05aTN0ckE3U1A4RHpO?=
 =?utf-8?B?YmI5aWJXM0dqbi8vQytXd3lWY2prWUh3a2RwM000UngyNEljYVlLRmVDWUY4?=
 =?utf-8?B?UWRzbW9wbWRmZDRQeHZ5b2FwSmdXOW5qTDJEeEowcnpPTmtHU0RkN0NhSUlT?=
 =?utf-8?B?TEprWjJFMWlmZWhqQzVHa1hDbFUrZHIwSnBTK1F5cHlFM1BTQlZJMFZUMXNj?=
 =?utf-8?B?cVlBRFh2cyt1WmNzL1RON0Y3K0FhYU1VTUoxdmJBYXFrZVNqUjk5Q3l0YjRK?=
 =?utf-8?B?dCsrSkp2ak1FMExqc1hkclo3SnJJTkxwR0E2UEpRUVphbnJ0d1lneDZZbzM0?=
 =?utf-8?B?REJac01SOFJ0a2ZXYWFuS1hIMFdkbEZnaDY1ckY1SWMxMHhtVWNXc0FJUkdF?=
 =?utf-8?B?STFNNHdvTjVmdkpGRzhhY2VoczNvbjFVb3ByeG9jRzZFL29PUEdpcVBQOERE?=
 =?utf-8?B?NFBhM2JuUVl3ZllpVGZnRWtVV3pHL1dGL3owQXBLMkdNd05KSldhKytkRStq?=
 =?utf-8?B?M0ErdlRQUzNFNStiZmFnRkFMYWIrTnlYL3hSWnBvSlNLWFFlOXJ4amdzNSth?=
 =?utf-8?B?aVJOUlc3cHl5QW9ham5hTUh3OWMyenJEckx3bG9icEY4UStHYkdvRzBNL0FH?=
 =?utf-8?B?MnZZZUFVYyszaVE5Z0lpUFZzMExjck1tQitCR0diNXk4ano1NDdzZU5MMSt1?=
 =?utf-8?B?aHZlZ25yRDhYRTkvb212T0VlR0xHcm1qODQzTGNaQWNnc2cyQy84ajc1UUl0?=
 =?utf-8?B?Njdham81c1VrdndKMEdxV01MZ08wT2JFYUlSL2V2ckcxREk1Vy9XU3dlS1Bt?=
 =?utf-8?B?VnFnYnh5c0FlWmtxeER1MytMSFpRUHB4ZjU1SUNpZWFNeFg2WStaZ2F6OE1K?=
 =?utf-8?B?WGw0bTMvdFN6VWFnVHRnMmpseEJvaDMvWU1FdnBPR1BVZUgzQmFTYmxGSElB?=
 =?utf-8?B?NkJDVTBCSzB2eVFSZnJDN09Yd1FaL29iLy9rL0dvN3hzQjZWYVpIWlVhOHlr?=
 =?utf-8?B?ZHJKQ3lLc0hGYmxWMzRSRjN0RllBWi9HaVNad3RuZnBwZTdRRGhFYm1iUWRp?=
 =?utf-8?B?ek1mQ2o4T0JhaTIzbXhGWUJpbHJETmt5RnlOSng2K3liZjFnV1ZYZFA3MlA0?=
 =?utf-8?B?NFN5V1RsNUx0K1VPOW9kUDAvVDlJUk9vUzY1bkJ2OUlVMFJrcWhBU1d1L2Er?=
 =?utf-8?B?akw2c3VYUmxqRTUvcS83cjBIN0hXaTVnNU9WUGVHL2ZUeXNSUnFNUnJxQURO?=
 =?utf-8?B?a0FSZHEvZURZVkVpdU9tWWNWd09MRHhEOE1XbWNkUVR3b1RRS08weC93bHg2?=
 =?utf-8?B?ZS81YkxoWHltNmo2c0s4UXBvUHl5bHYxcEZOSGVTUXExNkdtMktldlppVGRK?=
 =?utf-8?B?ZlI1M3hGUWtJNjdvMWQ0VTgvYVd3RmpuZ01UN3FhV3NhUnM1UGJPemNTL2RR?=
 =?utf-8?B?L2I3ektvU0JkRHlPRzFPdkU5TTZJbllUcjFjNG51T0Y5Zk40V2ptQUhXNEtw?=
 =?utf-8?B?aVB6VXJzSDI4ejlNdXlwSFhRNW0wRlR5dG1sdDFZajlpQkxqYi9PTWNacXZW?=
 =?utf-8?B?ZlllSWhwb3U3aVFwWlJ1Y0RvaFRkQUVxY1pIT3AwdUtPYjZHNnZneURLSGFv?=
 =?utf-8?B?d1E3Rmk5ZTkzQy9CWFB6ZEVxeTBlZWhZU1pOdlgyeDlScHllamZhaXlNU0o4?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5574acd0-462b-4e11-60bf-08de2d63a014
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 03:18:24.7606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cL1TE8sizPjFpwNg1nwYrJEkJT05KPQ3fdXUgX5BlR2DgA7ueM4hZAII+6wXWypt01GWer0kHrJ9rqpwbKaNW7EqlvOdMkKmu0IP/bGh3tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6158
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


On 19/11/2025 7:16 pm, Brian Sune wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> Add optimized Makefile support for SoCFPGA handoff
>
> - Introduce socfpga_g5_handoff_prepare target in U-Boot
>    arch/arm/mach-socfpga/config.mk
> - Users can convert the handoff via make prepare.
> - Detects Altera/Intel SoCFPGA boards from .config
> - Combines vendor/board extraction into a single shell call
> - Checks for hps_isw_handoff folder and .hiof files
> - Uses ls -d instead of find for faster folder detection
> - Runs BSP generator script only if files exist
> - Non-blocking: continues if handoff folder or files are missing
> - HANDOFF_PATH user define allows overriding auto-detected folder
> - Minimizes subshells and other slow constructs for faster CI
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   arch/arm/mach-socfpga/config.mk | 50 +++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
>   create mode 100644 arch/arm/mach-socfpga/config.mk
>
> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
> new file mode 100644
> index 00000000000..df1eb909129
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/config.mk
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Brian Sune <briansune@gmail.com>
> +
> +ifeq ($(CONFIG_TARGET_SOCFPGA_CYCLONE5),y)
> +archprepare: socfpga_g5_handoff_prepare
> +else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA5),y)
> +archprepare: socfpga_g5_handoff_prepare
> +endif
> +
> +socfpga_g5_handoff_prepare:
> +       @SOCFAMILY="$(SOCFAMILY)"; \
> +               if [ -z "$$SOCFAMILY" ]; then \
> +                       exit 0; \
> +               fi; \
> +               echo "[INFO] SOC family detected: $$SOCFAMILY";
> +               @set -- $$(awk -F'"' ' \
> +                   /^CONFIG_SYS_VENDOR=/ {v=$$2} \
> +                   /^CONFIG_SYS_BOARD=/ {b=$$2} \
> +                   END {print v, b}' .config); \
> +               VENDOR=$$1; \
> +               BOARD=$$2; \
> +               if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
> +                       exit 0; \
> +               fi; \
> +               BOARD_DIR=$(src)/board/$$VENDOR/$$BOARD; \
> +               if [ "$$HANDOFF_PATH" ]; then \
> +                       echo "[INFO] Using manually specified handoff folder: $$HANDOFF_PATH"; \
> +               else \
> +                       HANDOFF_BASE=$$BOARD_DIR/hps_isw_handoff; \
> +                       if [ ! -d "$$HANDOFF_BASE" ]; then \
> +                               exit 0; \
> +                       fi; \
> +                       HANDOFF_PATH=$$(ls -d "$$HANDOFF_BASE"/*/ 2>/dev/null | head -n1); \
> +                       if [ -z "$$HANDOFF_PATH" ]; then \
> +                               exit 0; \
> +                       fi; \
> +                       echo "[INFO] Auto-detected handoff folder: $$HANDOFF_PATH"; \
> +               fi; \
> +               HIOF_FILE=$$HANDOFF_PATH/$$(basename $$HANDOFF_PATH).hiof; \
> +               if [ ! -f "$$HIOF_FILE" ]; then \
> +                       echo "[WARN] No .hiof file found in $$HANDOFF_PATH, skipping BSP generation."; \
> +                       exit 0; \
> +               fi; \
> +               echo "[INFO] Found hiof file: $$HIOF_FILE"; \
> +               echo "[INFO] Running BSP generator..."; \
> +               python3 $(src)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
> +               echo "[DONE] SoCFPGA QTS handoff conversion complete."


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

