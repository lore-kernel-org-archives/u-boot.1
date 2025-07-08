Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D702BC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C98383323;
	Tue,  8 Jul 2025 15:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lQhKqCN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE9988332E; Tue,  8 Jul 2025 15:02:27 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1DA4830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMuYJleeBZFwoxjhWBN/dZeaTTUf+9UL+XEhrnB6tYsRXaptAqO8vMm1y1FXy7Sn2GWNOa/A5yR8EdA8mojoDB6IssueRXPU229f+uYjiBLPW309MQXGZobbZjQEcZhIXZVw0q0y4NjxWtmsthzMuVA1uTxR9rAIr14px2GeEp9FqddK/TChYuOqavGuNPjutg4Dv1C5C7GzRs0qk2i7iivZct02UKp7KJE5gkui88HBJE2Qro/9zpFDiFww49ryW153xk6+zlWvwYEHeTymjegL7y2HFIFjCGtKsWb/4RVVy4iK3UQgt6AUharAOr0kG4ERmNbmoITdWcPi9L6D9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyAQk7IUE4q0z2Ck3ckF10ARqW3nKRjzfsdAu/tvbB4=;
 b=yUlCObZ87Ni+/sj3sUJvC3VK4aLaYodU6liqhkol19ry47UR2hzMzbANKRZE2Jt2r0TeBLF/434VnFBl0rxtiehbuFLturDlEg4xoWgEbFuKpAW9yK+Oni5cA5gKqM5UEO1KAI1w6NVH96xxgS73vVpxlO49ToFR7ZRijRwKtKUZK1NvLhTBmIO7X/PlZORv8SBdXuhHJuAjcAc2pGeps5g3UiUORnJCvJ8SMw0BAQOCLfMtY7xamBIN1f1parTmbKR1rLou5rBPDNZaHg2XzQQgj7J1jGgqaylmo1iYV2lr06dTbJtbLsccWvPp6G0A/Yu4QHjer2COCA6KLHfSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyAQk7IUE4q0z2Ck3ckF10ARqW3nKRjzfsdAu/tvbB4=;
 b=lQhKqCN4dP6U0SBSNsH7+GaT2w5AVDc3K8x4+GX+4IUe5gklKtuYy9hTI7Ac7LaTs11V6KEjjh01Vjb6AJ8ccpjvyFrXuFr/XiljwO3LMs0vad4yNiezNrCpCs5MAPnMcLLwLPQtykiJ4sPIjUEnwtvIx8ImqbByWMIg23DQkcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 8 Jul
 2025 13:02:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:02:20 +0000
Message-ID: <e1a2cf19-62d2-43b6-82b0-dbe150e793d0@amd.com>
Date: Tue, 8 Jul 2025 15:02:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config: amd: Enable the SPI_STACKED_PARALLEL config option
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250707043037.792987-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250707043037.792987-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:332::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 592bf74c-b8e7-44cb-0c48-08ddbe1fac4f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnVJMk9VWVpRSTlMWlJncjF6SFZxVEFBbzAwUythczJETUplclBKNkdlVk9W?=
 =?utf-8?B?S05jNTBPYU1PZllyOWJDM0pwWDFuT0VNRVQ3eFhqQmlUUGhyZm56bkdHbC9G?=
 =?utf-8?B?UFN4Z2tJYjh6Wi96QW5ZaVZvWFEramJ5Rml4UXpYTkhtcjBUZFc0YnZ2NnZy?=
 =?utf-8?B?Y1poMi9uZFdFbHc5dkhzTjF0ZTJ3a1dFNlVLUzF4S2wvNkM4cFhJZTl4T0tF?=
 =?utf-8?B?QkZCY0IxVEhNbThYZUg3SHVZN0JHQmQ3dTVJMWVZQUxTYldLM01EWEwzeDI3?=
 =?utf-8?B?akVobnN4UjREYVJRa0ZsZ1Z1S293ajdzYUpsYjhBOWpBUFROdHI2cDNIK3ZI?=
 =?utf-8?B?RzJrMmJTSHdPL2RvcmZ0eXVUNHUzdFl2dTRrUmZ4TFJJUVlHbGdwMlI1dEhh?=
 =?utf-8?B?UXM3NUI0dlM3UktMKzJXUWxzQ3E2eUh2eEhYa1NPNU1GOExDRHpVWGFxalJL?=
 =?utf-8?B?QmZOeGlDeDdIUnpjVGNhRXZuU3VPVmV0UHV3K3A2WkpVTG1SRTlKemppOHlQ?=
 =?utf-8?B?aG9jOTlPZ1dzR1pGNEhmdlNkb0NHYzhuS1k0aS9HeWtJa3YwTXFuMzhzdXRu?=
 =?utf-8?B?anBpTzVvdmMrNGxMbEo4SGJvengwckxkV05pdi9CRHY2aVBqRmNTWnJQa2VL?=
 =?utf-8?B?WUZkUzBXVno1cXdCOWc1Zm1BQXI3a2xYTk5NYnM5SjNGdFZkWTdDUms0Rm1E?=
 =?utf-8?B?NWdxcXArQ2xnVHM5WDZ6NFVZcGJ4SlBEYWxaL2tWKzBDYk81c0dPbDJhQ2Fr?=
 =?utf-8?B?Q3NWNHdyUUVuL3pyazRlbzdNWmorSXU3d0J4QnE1WkppSWtBcnhnTFl5QUhv?=
 =?utf-8?B?K0g2ckRHMEdJTE9lTC8zM01SK3d2OHZSbHVDUGduUzJsc2VnWFVjemFwMjl6?=
 =?utf-8?B?UW1mWWVKNm02UVBmSUpDMHJMQXl3d29qWFNHdWkrQTVJR20vQnNjMW85RDJw?=
 =?utf-8?B?eXNGZmE4Y3pJeGN1bWFpSmVuMTNsT1VYZ3RmcFN6TWRrcGdOYm5YaVo1c1My?=
 =?utf-8?B?R3RvNFZyQ2s3RjNFM2xDb2U1MGw0MHoxS05ORVAxeEhabXFVam1EUkErTzRj?=
 =?utf-8?B?UWszd2prbHQyUEdZU1g3ZHNXZUdnOFQ4STZidDlVd3lZL1o4WFdRWDk5Umg1?=
 =?utf-8?B?OXhvc2FoM0VZS3VNaVJzVmI4TUc2S3NMWWpPaXY0c25qenNaREJxK2x5NVNK?=
 =?utf-8?B?bHBZSjFXS0ZkWG5UaU5HaXVIK3g3Z1lBUHFFK3p4b0dIV1JuTmovZ2Y4aFB5?=
 =?utf-8?B?Q3RTUnNrcmJUWFVkdU8relhXQTNNR1FkalpkSDZaR1N3b3krOENzbkkyaXdJ?=
 =?utf-8?B?ZjFKYTFCM3ZwRUplRmZ3YTY3Q2tzWUNXR0hocDZwVnB2dmkvb0QrYzNWNE80?=
 =?utf-8?B?d3hLTE5IQlQ5RHV6NlNza25JWFBzRVdrRmdzaEZEVlNzQ282LzFWTktDaWQ1?=
 =?utf-8?B?NEFwckltT1lCc2tNaFdiYVpCWUI1U09Pa1E5bGUvMEZ1M0V0Z2J6UVkxc0Js?=
 =?utf-8?B?WHd0TTJjcjZPMm1ocG5Ud0VrbWM0L2Nla0g1T3BvaE9idDlpcWtlbWgwN05u?=
 =?utf-8?B?MCt1d2dtSnoxeXcySkFVWlptcEhHWEV0aFlGMHVacmZNSkxPT01nODl2VDk1?=
 =?utf-8?B?L2NwUzY1RTU3M3dxS2Qwa1hweENFU1JzSDhBVFJIWjZ0TUl2WDB1U25kdWlM?=
 =?utf-8?B?NC9FYTdqTlRkeVJzNy9YUTdGZjFlVEdDak9zZTBXZmRaQjZBd2wwL3BEelMz?=
 =?utf-8?B?Qm13Ty8wbG5OdjRGWXBSSThjNEZXTGE0Ly9VaTgyZTVnL3o4em1JN0haMWpZ?=
 =?utf-8?B?eFFMaTZrd25leE9qbHlyQjJZQVc1L3pvYXMwbDQwU2hSSjk2dHZDeUN1MktP?=
 =?utf-8?B?TXJFd0ZYNHRBWGpvUkgvbldIRkhKSUJlbW50TXU2U3UvSVVBd0I5eXliWEhH?=
 =?utf-8?Q?vm+sB+UsL7I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVNDQ0hCZFZLa3pEMVcwaXdpZ044UHVXZEVQUEdrUlJUMFNaMkUyZGpWeHVR?=
 =?utf-8?B?Wk9sVGpBNWtwZzN4aFdlNzV4Sy9jNDBYS0lVSDNSRXdPWktNcWNtTE42c2dy?=
 =?utf-8?B?NEY2RVdIT0xWL0MvQ0l2eHd3QXg5eGhpUU5RdHh1Y2h2dXFRbTRhczQ0cjhH?=
 =?utf-8?B?bHhvM3RHSDJXRG1vUjk4b3lSUUZPRC9OOEhnS0h1OW9JaFIyNlZnakVRaXNT?=
 =?utf-8?B?VzRKV0dNQnM4dUdCMDFFK01saGJCNHB1WWJCd203dzZYbGMwd0RlamFPVCts?=
 =?utf-8?B?bXJuMnd0UzBpeFkwUmY5aU1zQkZtQVNua0ZSOENJNk9xc3F6ZEwrRys5dFpH?=
 =?utf-8?B?Qmpra0xVWExYUXVmVG0vZFp6MHMzVEk3SzM0SG04RXVsTTQ0R0ZMaGZoZEJ2?=
 =?utf-8?B?bm1wdnVhdG1qbVFoaVJyM29TdHhXUU5lTHJLaVBSUHpVbHJ5V1V3WTFMbVk2?=
 =?utf-8?B?TXRsTGREWDhWMmhZbVlqOEF5RjhyajlySUd2K2d2a0JtMmR4OU5aL1daRlhu?=
 =?utf-8?B?b1ZqRmdJV0MxLzRsSzRTeFBOdG5CV0MyeDZBaCs3SU1ZSUNXLzhrSTJOdGQ1?=
 =?utf-8?B?aGZHTFJkbENrTEhIbmRGTnltMlNoSVlMTG5tMzlYVXpRRys4cmxON0wvTHI1?=
 =?utf-8?B?L29mM0xjR3lmeEJlVmdhVjZzM2FVVUxLQW5rMzJqSVByekVzSzJ1L0g2b2o5?=
 =?utf-8?B?LzNKV0ZTUklSY1NQbmNlVllhK1Y2SEt6UXA2MXErSE05a2pLUEJtdG50bTRL?=
 =?utf-8?B?MnhBbVpsdStQTExBRUkzcUlzL2hac3V2OGNEUFE5TjBSZmxkZ1pZN3c5RFFq?=
 =?utf-8?B?ZlkvT3pqSzcyejF6dGFaeFlMTXNvUDg2cUZIN2NhV1Vmdk1oTSt4d01ETEw5?=
 =?utf-8?B?dFBwN1FtZ2ZGb1pibHI2WUNsUTdIb0tCSTdwdWQ1TTNKWWRwdHo4MTJqYUVz?=
 =?utf-8?B?WUw0V0h4UmdldG45OHpGZjhHZEVrU1ZRemRob1hXMWkzZkwvT2s5aDVRRGQ5?=
 =?utf-8?B?aDhtbUFuSE5wVHRTVExDNFNISFJ4cEtHVDdudE1WSGxycWNlY2RhNkpIZjF5?=
 =?utf-8?B?VDBMTFZMU3lXZlE1OTJMSGdUWGRQZUhYRFUwUTdGZHNuVHFYak5UcmdnWUJS?=
 =?utf-8?B?RCt3eEc3RFFnTGdTaFFkcFg4WjhXMEttdUZHRnJzdXlyVlltcFRTZ2xiVGpw?=
 =?utf-8?B?dEJTWGlQV0VGZUhsajNyaGJXWVpBWk40SUFpWDYrdVFUbG4reVA0M214Mmx6?=
 =?utf-8?B?QkdBc3VoMTJ4MFB2d25vS0xaMEdXOXROdGZOMGdSbUJoemtsZ3ZCcEs5V3lX?=
 =?utf-8?B?QTNKVjVhelN0QXhOcHhNVzNXQ3hjUHNwMk5JdXNkVWNvbGQrOTZTeityYVBZ?=
 =?utf-8?B?MWgxc2VvODluY08xNHYrMkU0Nys4cFhUWkNKZVBGQTNoUkNUVlFNREUrdm1v?=
 =?utf-8?B?R3JhVjVXUmt6WUdMT3dvb0hTNFJjSXV4NDZDU1NSSVBvckVHUUpxN2VhWlRi?=
 =?utf-8?B?OEtVdkZSa3BZekpIQ01TSmNSWDVtaUw5Znp5VlNyZUx6ZlhhN2xQeVZENThL?=
 =?utf-8?B?V2czMzZGSUp2RmR0RjZ3ZERXWC9DQnJrR2NzVzJzbGtITnZhN0RYZXhwamlw?=
 =?utf-8?B?RUhEbUJBY1gwOUZTOC9BeklJdXZPaHpVQ25yNzNkM0Jub0tOZWdMalozVkh3?=
 =?utf-8?B?RHdCL0xpejdSRXdFZjUvZ2dsQytDSjNmTmI5d1ZpenNpdEtWYnVQTjliYU0z?=
 =?utf-8?B?bFdDUFMvSlBaQ0s4TkgydEZsMFVDdUtCcm5wMFBzUHNaaGVoODQxTldRVFhD?=
 =?utf-8?B?eVJGMm56eDlWc2szVlJxbzdmajdSVndUYWhBVnp2emhNU0ZuN2x6Z3BSTkZQ?=
 =?utf-8?B?NG84ZDVvNkNtRVdjOFNoSXlBYTYwTGw3c1R2RmM2eG45L0R0NDRJS3FRRDBR?=
 =?utf-8?B?K3JOS0MvSEo0RlVCa0pLSUkyN1JYY3l2TkI0RGFGbmdiaFNMZDZzeElHdWpz?=
 =?utf-8?B?ZG9LL0pMR3VSTzRrYnBMcUNOdHNraHJEWHhJd1I0TW5mRjQvemt5MUVnRFk5?=
 =?utf-8?B?NEV1c1JFSldudzRGTFNvMlNJSi9zMDNqdmtwZGp1VnBWODdkSzcxQlJ6eERZ?=
 =?utf-8?Q?dU+7Rm3z4/u6evc1gDvw5da+G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592bf74c-b8e7-44cb-0c48-08ddbe1fac4f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:02:20.1830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTtIq16XYWMDZxr+yIIK8sagPrAUXBT1ucwDI7gR3fNz9g5rH5rEXxpv6tVUo0Rn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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



On 7/7/25 06:30, Venkatesh Yadav Abbarapu wrote:
> Enable the SPI_STACKED_PARALLEL config option for
> AMD versal2 platform, as this is required for parallel and
> stacked memories.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 15ac0211828..fc4fa571087 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -130,6 +130,7 @@ CONFIG_CADENCE_QSPI=y
>   CONFIG_CADENCE_OSPI_VERSAL=y
>   CONFIG_ZYNQ_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   CONFIG_TEE=y
>   CONFIG_OPTEE=y
>   CONFIG_TPM2_TIS_SPI=y

Applied.
M
