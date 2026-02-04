Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09078E9539B
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 13:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B34D83A36;
	Wed,  4 Feb 2026 14:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="h/97Mm+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E6583A5A; Wed,  4 Feb 2026 14:19:49 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E260F839DF
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 14:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLBT4qmbTrpgfIi1HTWfJWQ5AyelqtiezQ+UzhyBX9NkPIQO2a6ppOW63CJlLw0L6CyVkcwA7QCzDjn2ng1crqDSeROpCi5d29mexaW+Kktz6xWGN7DcqE2upXL28gKxXRtMD+Lqdtacf8VH8F8V4ndDLqRNYOFbMQK3AVc78YP7VPlajb3snQrIq3dPAxqq1s/yOiKkN8ngNrcwyHgi2IQSpYbsJHBC8XT2tbJdkBscYuU0sjml/Rc0DhglA04O4+sR8d1r0v8vXeZU1XmuVmn1O4LXGjwtrnAQwYmAB3OoJoh+oCJq9TQ37gWLZW+6Bk6nd35r0xy06vBKCXQfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6cydyFfjSNQoCmv59rTWFgRjiT6/ILhstlIthSmrN0=;
 b=SW4u95FQziv307T9nzFtQOZBUCR7pxevqJctRCnV40NuvmKrqH2/IGDcZ6hZwcldnGcS+2+vBQu8Ebp001hT0MHnZRgtz1zC4tth2noh70bAOvg8i6DCB8hpm5Y7VcWQf7I4IiJL2UsKwmT1xU3W8ZIOasSl7lK3uQcnkgfUGUDX5MI1/mG++KyGMdKUrZhUmN0MnufLli06ZU4H1xSIXQkp6zuun6xOU3s3YBeZtgQ6nGO8GqtqmolkFJ5zGsQqM09jt/20lItgxh5URTTRzMs39h9FBDTVKxLRFyk/OF2IdSWfPNxFZeGOnHKAhAKl1s+Pwd1ZHrqJ7UkCxoHAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6cydyFfjSNQoCmv59rTWFgRjiT6/ILhstlIthSmrN0=;
 b=h/97Mm+DnFARR4v5SWluqQcoqyZHfB6obUb/49AHPOmK28KvH+02ajFFv2iJpjsBFoMysAD1W89NF+nvLm6xlZyKC0e6uuP40nLICnYd/0wNVN1njHkTDMnVd04UJZlQEWTXHyNsEZ0V2d6tiYz20s+BcygWdpG8HjVC4tYV3J1eOpZfYrE0R6QvIl8a7ExsriNgx1K4BH+VJDucPH1x+FmnAaUjp5E5N078fTXeWF8lbxKWVH8hNEIMsHfEhrsTKpOgthKzyWc0V8llcdfzY0acFa0FOSg1XyN6Z5P8o8OWVMklc3wpbwVNmRfqDfIdcjeh5cg+Lpf5U+GiQ1hdjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by PAXPR06MB7872.eurprd06.prod.outlook.com (2603:10a6:102:1a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 13:19:45 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 13:19:45 +0000
Message-ID: <acd8c0a7-98a8-4ce4-a991-4768a56cf2aa@vaisala.com>
Date: Wed, 4 Feb 2026 15:21:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bootcount: Add missing count value masking
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260203144404.12093-1-niko.mauno@vaisala.com>
 <20260203144404.12093-2-niko.mauno@vaisala.com>
 <20260203161333.GL2603314@bill-the-cat>
Content-Language: en-US
From: Niko Mauno <niko.mauno@vaisala.com>
In-Reply-To: <20260203161333.GL2603314@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0019.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::13) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|PAXPR06MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 14db8b46-53a4-4bb1-af0e-08de63f0102f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFd0cWFTcEhyWGxDL0ZKKzRUZVkzQnFkWm1OUXp2V2QvVEpjS2VibzllNjBz?=
 =?utf-8?B?NlZ3UzVrcjVIb2g5aFFqekFBaXZ3NWpFSHFwR091TyswUElZbjlWUVNycTM3?=
 =?utf-8?B?U2pXNjNKOEN3R2kwNTRrUkQ3N0JabUFUM3lSLytickw1ZHpYWFc5RkFjRjc2?=
 =?utf-8?B?SUkvWEh6M0FTM3RjM2hWUERVd1ZJVEw0b2s4Tk9iTzc5T2lQd0dhcHVacStk?=
 =?utf-8?B?cVFLakp0WmRzY3ZoTDc2OFc4ZjIzWmJ1WlRoL3lsOS93dnFHRHlrY0t2Kzdl?=
 =?utf-8?B?b21kQ3RndXY5WGN1N3lJMTB6WEFwaENDSzlWZ0NRUVhtdFZCZUVZc0k3ZGlI?=
 =?utf-8?B?RmpUbUtyb1VQYmVKaEN6SWRGSjBzU0FNcWI4Wm1BUmxQczNIQXlKSm5qVVdF?=
 =?utf-8?B?c21XQk1kZEdSdmVrWHIxVE5FMGtKZmZQVUltdVNaeXZTdnBnQXZ5Tm1DT3I1?=
 =?utf-8?B?NE42SU9qdFltdmF3RS9MNXNxRGpSWGd4YjBQR2JNMUVzVVJwSVZoMVRhVVlU?=
 =?utf-8?B?V3RXTndIVktRRW41TEdjdWlRSUZhb2VST0JZdUNWeHp5RDVrRDNNNXRmaTNB?=
 =?utf-8?B?WVhsZnJpbjd2TWJxT3V3K3B6aDJ6OHVTSnc0YVBtU29VTDhxTXE5ZnNHcFBO?=
 =?utf-8?B?cElkUlVHVmJ3WHA5dlM3azRQRmY5ZktZc0szNllVQjlVNVFxNG91SWg0RWFP?=
 =?utf-8?B?Z29HV2IweENQdE10Ry9URVBhc1JOR0ZHcWkyUWFaTy9QN2tnZWMxT2VsR21P?=
 =?utf-8?B?d2RwL0xheDRQcWFXOWs5c1Fna3NLbUM3YjNZY1NuRHUyWG5kbUFKRFJqbGY2?=
 =?utf-8?B?Q2dOUVRYa0tvZmNQRm5HVFh0MGtFRmFkYi82Rkh5Uk5RM3l4R3pLVktWaXhs?=
 =?utf-8?B?VmVOd0RzLzNJVkNHbkM0QTNhd0xXNWg5K2MrVS9jSnAxRUNSeGNKSzJNUnBT?=
 =?utf-8?B?SGhNWmpQbS8vVXJ0Q2h0TS96Vi9CSm9CUWJLUm9KY24rTGdjdWJMMG82eXNj?=
 =?utf-8?B?WkxTQzJRZXM3b2pRazVZQlBBM0lkakZlQmg5ZU9mVFQxa2NFSThmOUljUTZJ?=
 =?utf-8?B?S3pmV09BWWRXTnNXdFdibXVPc3FKWTE2b3RIT056NkVDQWY3UmsvdmduZ085?=
 =?utf-8?B?eXpFdGRBRHNOdk9NQlpYcnNhdWpEUGR2WmhjS1N3bmtSTENGMWo3aURWVmNU?=
 =?utf-8?B?T2dwK3UwYWVseXdjSFEraHQwTE1GQU5xK01TaDlGODk5d092ZlYrdWprUW05?=
 =?utf-8?B?RXVUMHRMUUc2NGNUTDhwRER4a2VpVElqekMxbE9vNUs4ZEhxR0cyUDRmdTFM?=
 =?utf-8?B?Z0xHZG92V00ySFpoSEppQVY3Wkl6N0FlMWhBRUgyUkJDSjViSGs5RmNhOG4w?=
 =?utf-8?B?Qkkwc3dDTU1qdUVWd2swZURNWkVLaHU2MERmcGRQL3VLSVA0VkxlOU1TR0Jn?=
 =?utf-8?B?NVo3aUZCbTBLMjhaWXBqQVVYSlhTSXF2cWh5NzBabTd4SFZnWlkxUHUvang5?=
 =?utf-8?B?LzVKdFVQYnBYc1V2UW43bmltQm1iWGVNQUtUc1ppRytBMTBQMkgzUUtWMWxQ?=
 =?utf-8?B?Z3VJSVk4VTlQNTIvRCtZNmQwTyt3dCsvSEpoTzVkYWE0SzJiaVZjeVNlbk1z?=
 =?utf-8?B?dTBtSXMvM0tOVlNDbnhDb210TmRMMGNselM1bG0rZElhVHZBZlJPMTBUcWlw?=
 =?utf-8?B?SXdTS1RnblE2WXpicWZnZ3hUbGFVemNTN09VcXkzSEVsaWlFMU41dDUrMXZK?=
 =?utf-8?B?eHhNN2FhamkxNDNUTFJUeDN6M1ptSHk0RHVJUk5JT0IrZThLSDc1RU9LMjU1?=
 =?utf-8?B?K1N6V3lPZkZkaG8rVTlrMWlBYWZLWTJxMXJEd0xhbEI2bmN5dTNNSnRYLzJI?=
 =?utf-8?B?aGNrN05uU04xVTF5SWs2T0tvVHBRYmlNb0pDcGZ2K09PTi9Od3VORS9ydWVS?=
 =?utf-8?B?Q1NWTkduL1VCQ0xTVkRwNDJyUG9hYmVYMEZzS0FrZ2tyWU12a04xa2Z5NmM5?=
 =?utf-8?B?SjJpZksvRWV2VWN5NFpjUXZUY2R4SERtY250WkxHZUlDblNHMkpSd2FxZTVq?=
 =?utf-8?B?RlhoN0ZJdWJkKzZGNVdnOXpOSUdvazJ3RWgzaW5LbkgzVGIxRkJUc1hYYm0y?=
 =?utf-8?Q?Hxsc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVdNbXJNd0c1SXZRWUJsU3oxVVF3Tzl4Q2l3eFNQQzRwTVl3d1BsZHFrRWpo?=
 =?utf-8?B?alNNTHc4OTFEVWlDTDZzakFld25oNEUxV1NwcUdia1Vna0R2Z0x6bkpRMUVn?=
 =?utf-8?B?K0hWZzJGWjlMcnNmVzRubVFaMGh4MTNuUnNBaTkrVFVaUjZPeGUvbEgybUpl?=
 =?utf-8?B?YnVLcXJhNVFVQ1RyV3o3c1Z6SzRTNHg5d2p4WFkxeXc5VDlBd3diOW92ZU55?=
 =?utf-8?B?NmVUeWJEZE1mYVFJWkFvWm1FVVBRUmx1RjFzbTRsLzhrYWFRWk4wenBDUFVa?=
 =?utf-8?B?aHBsU2dLMFZWWGJqQ3lZZEhYTndsVzVYVjlzNzdMTkNpV2F1ZWtDZVZ1RXlI?=
 =?utf-8?B?dXZlUUU2REVGZzlGM2t5NUhNWG9EOGhBVi9uc0xCOXE3QW5uSWRLSDU4ajkw?=
 =?utf-8?B?eVAyTHBJaDJyYy9pSjJEcDNWY1Qrai92TmpjNklUdktHQkNXVDVCUXlFcDJm?=
 =?utf-8?B?NUJUM0MwNTlqNXZIQkhNRldzSjAzUSsyTWV2S0RWdGdiOTNiLzlLZkVMcTZx?=
 =?utf-8?B?cTR4NytKa3l3VFpLRkQ2b2RhK2d6OHFQWVpqTUhJT2h3bVBjaGk0MEg0ZTFo?=
 =?utf-8?B?ampRdmkxcUFPTndIWW1mdE53dWRsWFRINDJpN2lOREhzUURHRFB4RFNSOXg1?=
 =?utf-8?B?NWsrODM5aHI4OW84NlFDZDNVL1crcmtEOWJXSlh3SEhQSUM5TW4zQjlQZWRF?=
 =?utf-8?B?eW1EdFNYNk9sZ0JGTUJOOFdRM0Rxak5HK3N4SDRwUWtISnkrbXJOMzZyQ01B?=
 =?utf-8?B?ZlFTNzJiMnZvMXhXc20yajVRZ2tJVVd6UElBMTNPUVdvRXo1N3d1N0hxZVBD?=
 =?utf-8?B?RnJWbk1CdzIvSGROWkpuZkptZG1VSXIvQXZjc3BIMGwzdmxvM2dkUnNuR0x0?=
 =?utf-8?B?Njd4Q2NiU1llVlU2dUpyNjlIcGNjLzhmQVU2NnpZL1pEdE9QMlRpNjlYbDVx?=
 =?utf-8?B?Z0FpMk5DU09Vd2NtQWM1c1BoQytndXFHQm0vQWpIVmRBS3BxamdSU3V4Q05j?=
 =?utf-8?B?ZUdSb1dFSWdvTTQreG5yWnJWRFR3MzJTVmkxWjFJRjNoMk45RytlYlRIZFdJ?=
 =?utf-8?B?RHBvZ3dPczVWbWZWcENEaUdDNHVqOVZkNjh4OWZtREZzYnBtRE9NTitkSXVM?=
 =?utf-8?B?Nyt4cnFaaHd6ZmVzNXF6ZW9Ja0xia1Q1KzdIdmpjbncrZXF2WEI5OUNXTEIv?=
 =?utf-8?B?bGVKQ1JyUnRMbTdwOG1RVGV2RDBWQU5vRDZwd3RmNXVJN0piK3lzQVdWUEVZ?=
 =?utf-8?B?RkgvRTFHZXdrZHRZbmFsNGlQaXNyUGdYVkVaT05PMTV4WEFhenZ1amFyZnVk?=
 =?utf-8?B?L2V3SU1lNWY2ZVVHeS9YejZvM0xCQWZxQ2M3M0lmdEpFS2dpNzRsZ3hxT25V?=
 =?utf-8?B?S01OV05neUVCaHU2RTd3Ti9UNDdqRUxLcnE1dnV0SWwxdzJYSGFjNkZHQjZF?=
 =?utf-8?B?ZXRMcmVpMFhpaXVSLzR1UElPa2R4RUxPc2FuOXBXVHN0RkhobWpqWWJPekRV?=
 =?utf-8?B?dTdpZGVobjlCa05iS2hkdC9WRjN3eDZ4bEt5K1g1eXlvN0xhN1NuZjZ5Zldy?=
 =?utf-8?B?SXRqdk9YSWhXVk1yZGJ6YTdTUFduOHJRc2RCcFpuUGRsemhTV01IeGZLZ080?=
 =?utf-8?B?YTNNZVFhZHAyQVFBZXhnYzF2ZFVmQUNRR0JadjZwVDIyaitLK0IrdmZtdjNn?=
 =?utf-8?B?eEd3VXVRcmM0Uko1TU5CU0hmM1BNTFVGUEtMQkNyRWp4MjFCYkpwU0RHcmFV?=
 =?utf-8?B?dUJvV2Q2TWMyb1lwRms0ZVFpbm0wYmpnb1BqUFdNMUpnYStzREhDMmdOTmt4?=
 =?utf-8?B?ZHRscmIyd3ZYdGNQUjRoa1ZNeDluQ2pMYWNkRXFXem0wN0tTUkR4blJmNHA0?=
 =?utf-8?B?QVhnc2tIR2xIK2VDb3ZubHhPcU8zaS9Oc1NVbEdncGNTVmI0N0pTYWlieEVL?=
 =?utf-8?B?QkNKdElqZVZRTHFXV3RYOEFQQTI4dHJta2xyclRLVi9GaTVkMTM5UzJmbHdV?=
 =?utf-8?B?OTgvblBXMWFnRERvVkpabDRZaGQzcDA4N3kxT2V2MnVZeVdXajF0dERuT3Jm?=
 =?utf-8?B?Mzg5bEpxQkNqRVhkajBkOWVzUXc1cDhqazRUUFpIM1ZRdUJNSklUUmIweDUw?=
 =?utf-8?B?M0hTRUx0TmNWZFVJcDU0RDZ6MnNRa3orSGhSbHQzWjk2amNFUE9naldpdUNP?=
 =?utf-8?B?ZzJRaERXVHlscFBjQWhta3pjemEwbEdGeDQ5ZDg3eWQvQVNCUjFGc3ExMWU4?=
 =?utf-8?B?NVd0K3pvamdGL0tuR0t5YXRWMG5wY2JkOHVXZ2lHaFM4K3JyNkFWSWduMHRr?=
 =?utf-8?B?WWcyT0VEdW5wWGR5T0pSSXdBOVdoTXpzV09NYU0zcW42ZnB3bExCc1JCUlVn?=
 =?utf-8?Q?z8/KkxLDoXvmo1PA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14db8b46-53a4-4bb1-af0e-08de63f0102f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 13:19:45.0528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ganlcqo9DoNgGu+/e2clQUgsRRuFM2iZFkj+cTs1h2b7HL7YnwJYogMpWNbUweY9ltv26/etIzUDGwDlJwQFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7872
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

On 2/3/26 6:13 PM, Tom Rini wrote:
> On Tue, Feb 03, 2026 at 04:44:03PM +0200, niko.mauno@vaisala.com wrote:
> 
>> From: Niko Mauno <niko.mauno@vaisala.com>
>>
>> When storing the single word bootcount value, add applying of the
>> bootcount count mask which seemed to be missing.
>>
>> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
>> ---
>>   drivers/bootcount/bootcount.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> A cover letter for the series would be good. I assume you found this
> problem in practice as part of doing 3/3 and so the wording here should
> be more assertive that there is a problem and this is the fix, rather
> than passive voiced.
> 

Thanks Tom, now submitted v2 which adds the cover letter for the series as You
suggested, and tries to improve the wording of this second commit's subject/message.

I did not encounter the problem in practice, but rather noticed that bootcount.c did
not seem to be consistent with respect to the clobbering prevention comparing
to the other existing single word bootcount storing implementations, therefore I
proceeded to propose also this change, along with the other two commits.

-Niko

