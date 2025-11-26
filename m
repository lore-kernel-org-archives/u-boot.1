Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD80D1038B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 08:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC22D8419C;
	Wed, 26 Nov 2025 09:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QodL3gng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C7A8419E; Wed, 26 Nov 2025 09:10:11 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F1584142
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxUXUYwmgS+HiUApn14f2XB1fu9ct+1g56bywzh8i9WHb35hzd0yAQ5xdsY0HWZTcGmfgB1VDHlXxEUG+kXkCiZZRaoephgH72tN72gm2uFfvg1sSFLzncs+CVK1qhW/9124pz1cxXsR7nm6oYaBvgMzNKbeR8znlQk/+OT6EpuDLoRN6gh48J1R9F3BdZWPJ6Cq7rfBWlYxXfxqW0kVvcVViaWKaZRYL57LRf3WZrHAK3o8MC2Rai6V4Gh2WhiQd6Q1RAGXvWmoFRd7bRN6r7n1g/K1z7AGYP+Pwuv2xviiy8aGm5tGSuehsacrQZ509kAqGPX8l3pfeETENrNrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnfodrHRlY7pL1gUohyoFKep++NYnUWG6gLWfKnu3xs=;
 b=McTH/qMW8vnPNTSF2aD9FvHFvVlB5mnGCLzUXEG9Qp2PIbT0V4BhOTbAY0DTy50Qvaclc4qJ6EIUSVQs86s/MiqGdOuTwI/Z26HVHeS/l4UHJPogeTM2dQp83Brf/EAeKWoUggTobvfWKlKy2fn9nTGfWCLBfoR+amKqbcbH9e6pJqLtSWp1rR0Ha1fehO3uvu9sKzZcyhP1UhmMzKJpQkzJxGURx/80EZQ3yvF7gUXHsz/3HlzZbfeI5AoV3/F1in+Gx9s+T61yXJTgO7r9mRCQoyEFRNk/uY7dx6iDXgJh6Nm4H1jI+AxIOr6FipFSoURvVcqW/y2uYpdX/m8Qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnfodrHRlY7pL1gUohyoFKep++NYnUWG6gLWfKnu3xs=;
 b=QodL3gng9ugEF4yKbbCh22dUQ+EVs35cpvBRO/GBxNi0sqLHdEs+w+zYkuOP09AueaCvXI2IJg9sne/fruEnOQPK+WB5pv5IYLGT2cMpctxdGRVVLS0U955PqNAL8F3733HG5D+Svd/c9/QFnD+VjJ+rod4MI0jGzKuFPBV0JgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 08:10:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:10:03 +0000
Message-ID: <bd88e554-d652-4162-b6d7-fc1cf8572329@amd.com>
Date: Wed, 26 Nov 2025 09:09:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence: Remove cdns,is-dma DT property
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com, e@freeshell.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <f109829793900e57558d98ed22caf80c1a72b232.1762787994.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <f109829793900e57558d98ed22caf80c1a72b232.1762787994.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 149b2fba-354b-4edb-3bce-08de2cc33415
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUZ2RjJIbXljNW5FSWovYkJ2MWxON25rOFlpclJyTmVlZXpla0diWE5VaDJX?=
 =?utf-8?B?UVlNSUY4MFRBTUJqQUZOODIzS3lGUHNZYWVCV2N2alE0c3plWTZpWU1YR0dS?=
 =?utf-8?B?b0JwZkRiWnRVQVZLeTVlMUZOc05hQVJKd2tFVTZ1S0tLUzFTOVV0ZXJ5MklE?=
 =?utf-8?B?MmZOaG8xZGQ3NFVoMnIrN1NwNkRrSHFtczhBSUdmOTdsdHdzSDI5MitlZUhW?=
 =?utf-8?B?a3loME5KR2tZR3ljRWppQm43dWwvTnN6SDNhTWRza0dSSGVTbGcyU1cvUjlm?=
 =?utf-8?B?R1JGRDRNRzhMWXo1TERCRzd0ajkwcDdzTmovelgxVFp5WjU0Z3NTRFlEbFhH?=
 =?utf-8?B?NVdscE5jWEd1N1lXQlB0MVFFMTJyak56TjZSaXN6dEVnNVRPczJabXd2QmNP?=
 =?utf-8?B?SkhaSWFWVkFoOSthTGRQY3VMdENFTWpMaWh0MGJjZDMrakpJSXh5U0V2Vlly?=
 =?utf-8?B?djdBZ2lFYkRSN0JNeFMwWVRGcmlUb3RzYi8zUzZjTC9mcTZIMFB0YkwxOVBP?=
 =?utf-8?B?QkEvWTA1MFpGYlJmRmtJUGZScjdTQ3pZdDlrODdUcXBpSmNyQWJ2M0d1VG5y?=
 =?utf-8?B?bkZJamZ2a1JpQlAxazRUa0tEaDBFemcrN3RmMDNPQlpISitmMVBPcE5oSld3?=
 =?utf-8?B?ZEYxSGErMTRYNGl6UkNVbmNFZXVoWGFHK1p6NVdGSUZMOWREREJyc1hUdCsy?=
 =?utf-8?B?TTVBQkY2OUNMNWwxaTNjaU92Qm1nbjdZcGRLN1JubnViMWZjWG5QQ2NVOWwz?=
 =?utf-8?B?WGNpdXdDZ0hrZ1BpczNldGI4UWZJaHEzOWFlbUxra0ZmOWJVN0NzM3B1TGRh?=
 =?utf-8?B?ZkgxL21Odi9PVnNaWWtUZEoyVDFUOHpWR1BpeG5KZVJJdWZVaUE2NjN2RGRY?=
 =?utf-8?B?ZmpybUdLM1J6d1NSUHNRWS9RQ0c4Z2wyNzhrTU14bnU5SWo3Tlp1UHErdldG?=
 =?utf-8?B?YXkza3E5MEdjdDQ3bnJHdUpkckRoU3JQMGd2cStDRVdLNVhiZ3hJKzRRREV4?=
 =?utf-8?B?QmtWa3UvRlpvWnhJSUNkMlR0QXFseFd2VmdLWWVMOWJiRHFBRW1wdDh4RjJH?=
 =?utf-8?B?V3JYUHN3R3hiOWNMZ0haUzhaeWNFT3p2WFRTNU9xa0pwTlVXSm1DZTZmMDMw?=
 =?utf-8?B?TVZFQTM4MEFXV1AvN0dWWEw1STVEdkZwbk5pSXNWR0NWa0RuZGFZa2c0VHlT?=
 =?utf-8?B?aUk1OGNRMUE2UWVzTUE4TVdVYzNQNk5nQmhVN2c0TzZ3OEpKOEJrdzZiV3dz?=
 =?utf-8?B?c0J5ME5EQmJlVnNWWjdXYVAyVEZ3bS90YkxsMGZRUklqR2hkQlIzbEZEU1My?=
 =?utf-8?B?T1FEOStEOWdidUlpR25CNFhna0p5cWRLT1pxd2NPVHpIWTQxaWVDV1FWYUZa?=
 =?utf-8?B?cWhhL2YxZEZnY2N0N05qUGI2dmxRc0hERVV1OXNOejZQK3hMeHJXMXRWTUpO?=
 =?utf-8?B?NmJBSFVLcUJTM3JndGlCVm90QllkTkJ2LzlUdHhBNlJoRU02SkdISHE0bmNt?=
 =?utf-8?B?WDZBcjF3NHM4Z2ZxQXhhR1FPM1FQZmw5TmZSQmFIUmd6S3J3RDJtVzdOQ1Nt?=
 =?utf-8?B?VHo2djVGdVdnb3BpOEFHbUp4Q0ZOZ1JiaExCcngrd1FnMlFIampQUUtuUncx?=
 =?utf-8?B?cStMbldPMDMwLzlwei9RY0g0V2M4UXF5aFhOV0g0ZFlPUUM3ZWVLQXNKWXRM?=
 =?utf-8?B?Y2JEYlpyWmE1aW12eU1vRlVoTG1HekJSQ3hUOFZ3RmoxblZ6dDhXT3lxTUxM?=
 =?utf-8?B?MU1aV3p6anhGZzlRaDZzVjNCNnF2UmZma2ZkVjRSRGVoZVlNN2ZPdjF2SDNL?=
 =?utf-8?B?MDdzUUw3Sks3YnB1UkJtaVU2MGZMQ2FQY240TTA3TDlxc0VOa0k5anhEZzk2?=
 =?utf-8?B?VUorM2pwNDR5TVVBWi9GWTB1eGE5V0FkNGZEYlJ0bWNLemlhRm1udndZL0JZ?=
 =?utf-8?Q?kAIc9oZy9gYP8kSO3R9YqHtNEWzlm6aU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDJmUGU3VTdXNk9vZm53VEsyTmVMVGNQYVdDVVpKWDI1c2diSWZBQk82YU9Y?=
 =?utf-8?B?dnpJamQzMm8wSjU0YVVwTVIwNklsRjlqazh3NS9odFk2cHhkWDBDbGNZVWxD?=
 =?utf-8?B?UjRnNG1IQkpYZTZ0M25nNFphRi9INkJHTEFEREtSOFd4c1ZTaWZsY0k5TzRy?=
 =?utf-8?B?dFhBM0l5S2N4aE9uWHpzUHlrd3JXUnFSc1FmRDYzbmlWUFp0ck9zZTRRdWkr?=
 =?utf-8?B?YklUZ2U0T2t5V09jLzdlNWdPdW5ncHk5eGFpRUthRUY1clF3cE8yeTRCM1F0?=
 =?utf-8?B?cEdsYlBpNFQrOXp4YXVUVUllNFVEYXFnMjZkTklhQ3JwQU81YTNtY1liZm83?=
 =?utf-8?B?TTMzb0xObDZaSFd2bzVPZCtNdi84eWJqaE52R3R3Qnl3Z0Jwa3ZHaDhvZlBO?=
 =?utf-8?B?dXRFYVpnRjBOWld2YnNmWEFXMElXaEhISWxMZXEyY1N5cUcramZGbnJBTzhX?=
 =?utf-8?B?d01adHR0MldLN2FxZnZQWXVXYnJDMjZhc1RqeVdIdUVZV1N1WjcxZmt4Nk9U?=
 =?utf-8?B?R0VLTWpuYlFVWjlFMmFZWk1FaExwYWJzb2ZzSzZNTVZJYWlyQjN5ZFFMZjRQ?=
 =?utf-8?B?RFhhcGxDL0d1TVNoKy9Ea3NZQnJ5UmIwWDdtRXQ5dG05Z1FxQVBMMkRGL0wz?=
 =?utf-8?B?SWVSVFpydjBLN25QNWdKQ0d4anNRV3VyNWVaRktGRk1HNWd6MENBZGJuNS9i?=
 =?utf-8?B?OFlrRjgveG90VTRkSHFDQVZIZWpkdHd1UjZTZjZjNytCTTlaK09lZ0x4U28v?=
 =?utf-8?B?UFM5ZjVjekNjQlkrQ0JaUnRNbkhKdTcxeUZHN0R2aUF4eDVoMlB2UXMxUjN2?=
 =?utf-8?B?QWdha1EzUVVIdU5wOU1qb0JlVmllT1VGb3FjY2dQek1HbDRvejZZWUlMTXJZ?=
 =?utf-8?B?Y2p2SzRVajZhVFMxNkhZOHdaTVdyQ042RWQyVlp1NVAxNHFzK1BSaThScEtL?=
 =?utf-8?B?VGhoU2cyb0F3WnRhV1NiWjV5S1AweXFFdXY2YmxhNGVuR3Znam5VK3ZDNUlv?=
 =?utf-8?B?RnVTd1NLcUVRcW5wZGV0aEJqQllBYkxrYjEyK0xFVi8wekZDcU5sOWQvVVM4?=
 =?utf-8?B?MHp0MzdNSjdjTG10cXB6SVcvUk9nR1NzRCtOU2p6b0xmTGhPQmNDYVlpMXNr?=
 =?utf-8?B?VDJFTFBXY1dhTmc2dlFYeDdlNi8wMll3SlVZOHhQeHpxYWZNT0FXNExtbDFR?=
 =?utf-8?B?TUk3VDl1d1dFcktZc3BUK3BZOWdaVXczNTV1a0pNUWRQNzVLMlR2MzVzbkpm?=
 =?utf-8?B?anFSeDBLbjRrci84UC8wQ0tRYjlBSEJ6emEyWmR4TDFTaXJsbmNhSlFOTEgy?=
 =?utf-8?B?S3lFTVhGSFdoM1JNRjRRUHRnNVJkR3NILy9wY3IzeHZFbEV3ZERKb2hhMlFX?=
 =?utf-8?B?N0NnWkFzdzZFbS8zNVBrdko4SVFpSlprTXZCODgxMHR5MXo3K3Eyc050bzJn?=
 =?utf-8?B?eHUrYnh6NjhIL3hTQmhBTjJ5V3RPY2JqT3FCMkxoTFB3S0tRVG52bFlYOUFV?=
 =?utf-8?B?ckNOWDhCN2RPUWl1ZW1MLzA4cWMvT2RzTDRsc1NnQklIOUwrTkJWeFR4WDE4?=
 =?utf-8?B?dDB5QzFYdDYwSTBKeTk4emE1R21GUkQzcmgzemdYWHpMb3Z1U2p0c0F5OG5L?=
 =?utf-8?B?SnI3V2sza1IzN1d5RmZId0tFTHhiTkNGNlA5QjVsT21nRno3emJ1NHVhZzg2?=
 =?utf-8?B?TVRpai8rN1hDZWNjWnRUZkFDczBhVlNCV2FTOERJK1hodjNRQVVhZWhYUENN?=
 =?utf-8?B?dXlBTFI3SzI5U2hNYndZd0hYa0lLWHltTlQ0Qy9LbUExSFBwb2dpay9ldGpI?=
 =?utf-8?B?QTNMRlRGbElka3RyZ2g3SE9LdVZiQkhVTnJpaEI2ajhpT0ZRbE1HcnVsYVN5?=
 =?utf-8?B?VVJXMDNDLzBVc2cvMklzTGtRaHJWb0prNHdwY2c0bTk1QWRSNlhZWTNTaGRs?=
 =?utf-8?B?U3FFK1hQSzJtV3FxZjdwVHdpeU1Qc01kQWoyMHA1QnBtamdFd05lTFd3N1A5?=
 =?utf-8?B?dGgzeWFhMUxHcmVQcXNTRUJsbTl6NG5aaHlJVExPQ3FiNXpIZlpuSWVQZ2RM?=
 =?utf-8?B?T0pUajRjYlE4WE9YNXQwV29lRmpDSkdkdkorTjhZU1JySUUxUUI0bFRVTEYw?=
 =?utf-8?Q?B1w/+864wcrBNnsEtwZkdh253?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149b2fba-354b-4edb-3bce-08de2cc33415
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:10:03.8508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyV0vSXwuX1sE3HFsLH6j7RKIWkJ1oSPN4QxyZHOwSRB7MHxO+ASwxd9vRiAxu5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490
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



On 11/10/25 16:19, Michal Simek wrote:
> cdns,is-dma is not documented property that's why setup CQSPI_DMA_MODE
> quirk to enable DMA mode based on compatible string. And also change
> compatible string for mini configurations also with recording compatible
> string in the driver (Compatible string is already the part of existing DT
> binding).
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/versal-mini-ospi.dtsi     |  3 +--
>   arch/arm/dts/versal-net-mini-ospi.dtsi |  3 +--
>   drivers/spi/cadence_qspi.c             | 20 ++++++++++++++++----
>   drivers/spi/cadence_qspi.h             |  2 --
>   4 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
> index eec2a08e7c70..8429dc585d51 100644
> --- a/arch/arm/dts/versal-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-mini-ospi.dtsi
> @@ -29,7 +29,7 @@
>   	};
>   
>   	ospi: spi@f1010000 {
> -		compatible = "cdns,qspi-nor";
> +		compatible = "xlnx,versal-ospi-1.0", "cdns,qspi-nor";
>   		status = "okay";
>   		reg = <0 0xf1010000 0 0x10000 0 0xc0000000 0 0x20000000>;
>   		clock-names = "ref_clk", "pclk";
> @@ -38,7 +38,6 @@
>   		num-cs = <1>;
>   		cdns,fifo-depth = <256>;
>   		cdns,fifo-width = <4>;
> -		cdns,is-dma = <1>;
>   		cdns,trigger-address = <0xc0000000>;
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
> index 1c94b352dc97..78404960f2f3 100644
> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
> @@ -43,7 +43,7 @@
>   	};
>   
>   	ospi: spi@f1010000 {
> -		compatible = "cdns,qspi-nor";
> +		compatible = "xlnx,versal-ospi-1.0", "cdns,qspi-nor";
>   		status = "okay";
>   		reg = <0 0xf1010000 0 0x10000>, <0 0xc0000000 0 0x20000000>;
>   		clock-names = "ref_clk", "pclk";
> @@ -52,7 +52,6 @@
>   		num-cs = <1>;
>   		cdns,fifo-depth = <256>;
>   		cdns,fifo-width = <4>;
> -		cdns,is-dma = <1>;
>   		cdns,is-stig-pgm = <1>;
>   		cdns,trigger-address = <0xc0000000>;
>   		#address-cells = <1>;
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 9b45cab9c04c..892dc3557a5e 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -29,6 +29,7 @@
>   
>   /* Quirks */
>   #define CQSPI_DISABLE_STIG_MODE		BIT(0)
> +#define CQSPI_DMA_MODE			BIT(1)
>   
>   __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   				     const struct spi_mem_op *op)
> @@ -210,7 +211,6 @@ static int cadence_spi_probe(struct udevice *bus)
>   
>   	priv->regbase		= plat->regbase;
>   	priv->ahbbase		= plat->ahbbase;
> -	priv->is_dma		= plat->is_dma;
>   	priv->is_decoded_cs	= plat->is_decoded_cs;
>   	priv->fifo_depth	= plat->fifo_depth;
>   	priv->fifo_width	= plat->fifo_width;
> @@ -227,6 +227,11 @@ static int cadence_spi_probe(struct udevice *bus)
>   	priv->tslch_ns		= plat->tslch_ns;
>   	priv->quirks		= plat->quirks;
>   
> +	if (priv->quirks & CQSPI_DMA_MODE) {
> +		priv->is_dma = true;
> +		debug("Cadence QSPI: DMA mode enabled\n");
> +	}
> +
>   	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
>   		xilinx_pm_request(PM_REQUEST_NODE, PM_DEV_OSPI,
>   				  ZYNQMP_PM_CAPABILITY_ACCESS, ZYNQMP_PM_MAX_QOS,
> @@ -412,8 +417,6 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
>   	if (plat->ahbsize >= SZ_8M)
>   		priv->use_dac_mode = true;
>   
> -	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
> -
>   	/* All other parameters are embedded in the child node */
>   	subnode = cadence_qspi_get_subnode(bus);
>   	if (!ofnode_valid(subnode)) {
> @@ -473,6 +476,10 @@ static const struct cqspi_driver_platdata cdns_qspi = {
>   	.quirks = CQSPI_DISABLE_STIG_MODE,
>   };
>   
> +static const struct cqspi_driver_platdata cdns_xilinx_qspi = {
> +	.quirks = CQSPI_DMA_MODE,
> +};
> +
>   static const struct udevice_id cadence_spi_ids[] = {
>   	{
>   		.compatible = "cdns,qspi-nor",
> @@ -482,7 +489,12 @@ static const struct udevice_id cadence_spi_ids[] = {
>   		.compatible = "ti,am654-ospi"
>   	},
>   	{
> -		.compatible = "amd,versal2-ospi"
> +		.compatible = "amd,versal2-ospi",
> +		.data = (ulong)&cdns_xilinx_qspi,
> +	},
> +	{
> +		.compatible = "xlnx,versal-ospi-1.0",
> +		.data = (ulong)&cdns_xilinx_qspi,
>   	},
>   	{ }
>   };
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 879e7f8dbfb8..1e9081c2d17b 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -223,8 +223,6 @@ struct cadence_spi_plat {
>   	u32		tchsh_ns;
>   	u32		tslch_ns;
>   	u32		quirks;
> -
> -	bool            is_dma;
>   };
>   
>   struct cadence_spi_priv {

Applied.
M
