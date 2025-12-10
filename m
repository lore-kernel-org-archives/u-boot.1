Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65959D2CE17
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3D383655;
	Wed, 10 Dec 2025 08:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KmoIx1Hc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3CB383CDF; Wed, 10 Dec 2025 08:43:07 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1BBD809A5
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOt19p6EsW8Ng7RhJZyODAGhyMfEz4yw8+PDBdwR8VAyLww547gE8PAIMsd7jIz+T6hpwydLsucN+EmqoX0puU8I99kIXZ6Q7UKfV97nJ08BzEZDi3nH+WdATmDgCpI6dRL8XgOmpBUSd836uhTyyvlg+4bm9Q3+G8C0mAHYFyxPodEwIbqGTbnAA7CqyWrHvKFC6qEReVvh/bIYP7WFDal/W9cT8ifITB31EbNR8eGGLeQ9iyaLodTCtq9PVPV407eHmd1AuD15uxSp9gSUtpkyPrQkYoaMEet3kl45cDjn8XtrpA7BwVlCKovfKRssqyhpk1FESraam4ED7LKdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai07seHcMOyhVgtzJ9bY6Ugr9vvf0sJxxJFn6e1PVeQ=;
 b=p3+eA4D01T3yv+FOJlcMBf6q/Jt3fCFAIXPuC4BAHNE/mReYkPYbkgzCnDVw+vAp6+JiOC66mkyVAxcj/u6VzwrlTsx+wbq4OWai2OEaTz+YnVfBD7UIh8uoTia4+yOVFqhMH4U/50J1osVGyI4k8xSqLBmSnCJ8xy0IeooW7fBtPPImw0vq4ulqHzN2YAW2xITvNNBmzknTkzDGn2Csa4tZpbNWIkVeY5t8il3q7ryW1APTpkVir8FCCwJRJUM+GZqzAfq3Iuzj+oJBjLmNbTLXWIC9cAuNi4xkto4g2xYpktrReKmYf6B0zB5zEhheXVYN/7HiI8wYXWs1GAEGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai07seHcMOyhVgtzJ9bY6Ugr9vvf0sJxxJFn6e1PVeQ=;
 b=KmoIx1HcWcIu12Ii3Y46QVX8ik35PLZQY3gme6Vx5Ugbroo6KaJeO4nqL7PP4Q7DousYVWsrXcKUBwSAe0PBAsrtPOaGyxQtMIQ80kSnL/UbIZiNTDBz+TkwioQ6yGiZxyZzIfKFXORST08cAkWIub6p1kAsqTAQI+EIfyjYiWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 07:43:00 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:43:00 +0000
Message-ID: <70bfdbb0-11d3-4f16-a60f-00ab9755ccf6@amd.com>
Date: Wed, 10 Dec 2025 08:42:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: mbv: Disable SPL GZIP
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <339520b249a3c69a36faf5432cbd581459563e32.1764747291.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <339520b249a3c69a36faf5432cbd581459563e32.1764747291.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: be20194e-d3b9-4a5e-608b-08de37bfbe12
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnNwdTdzR3ZHTkwzclZyZGNSTmN1RDQ1bkJiWklHbzlPV3p0SjlhWVVhT2t1?=
 =?utf-8?B?SmJ1TXNwUHJPRm5CWkJYZmNWQytwQ01CTFNkT2cvN3hUeVRnY2tweW13Mys5?=
 =?utf-8?B?RnlnSE5la3JtWkw3V1d5Rnc0dkZFanV0ZFlXdjNsUmdJTmtLeTMzci9SYkQz?=
 =?utf-8?B?SHJjQ0htaTBrWkV0SkJoeVpDQ1Y3TmVOdlpYaklKVXE4ZDhmT0YyeVZGOHhk?=
 =?utf-8?B?ejFISGU5R3ZwZmtmbDc4cisweWpMcmJYQnhvcVB1MmwzckpvMThWd3ZxT29L?=
 =?utf-8?B?TGNnYlZZSTJBOTRFcVRWTGNaM2pPR0dPZUthTHVxZmlPazJxZFdBdllMSjVQ?=
 =?utf-8?B?ajRobXBJZ1c1a0dzaFJ1ZGg1Zi93Um41NStiOWJudHB0MjVpQTU3YWtZUjVL?=
 =?utf-8?B?WnJkMzI0bFF4a3BlQ0cvYzFyTTRFVWY2ZVEvTlN0aEtrRTlpR2Zra0NxMTR4?=
 =?utf-8?B?R0VNaWFqazYrTlc3b2hXbVIyNGJVMzFrWnhpSnNKOTZ4T3Y2cU9RTSs4VzRa?=
 =?utf-8?B?ZUNHVCtHajd0THhZZFg2aWFidmtkd0FrNFpkVkw1c295TWlaWXhkcUFDVFFX?=
 =?utf-8?B?OXhEYklvT0JLd1RKTDN0K1VxK2tZZkE1azdSZXpaSlAwcGVXWFljU0thYWwy?=
 =?utf-8?B?VGFVT1UrQzdWYUR4SVhmbEpqdEEzMkM2U1RLY05EdTBtdmV2SUIxMzFMT0Zu?=
 =?utf-8?B?QUJOK2dCUnZOZUFiQXZ5YmhnT3FSN2RWSzdIcWJlQUNhZ2hYS1dhMWpoVjh1?=
 =?utf-8?B?Yk9MT1lzOVErY2dSd3VIQkVoeEFoeTVSRHZaamxOd1NnODkwSWFDakRNVGNa?=
 =?utf-8?B?Q1RPN3dNSGd6a2daNlFCL1VldlF1K1NHMHhyUENPUm1UVmEzdW9NbmNoYXVv?=
 =?utf-8?B?UVEvRG5hVjIwTzlFemtFejVVSG5Pd2xjUUhkYllqZWk1NnNQZzkza2Y1ZUhV?=
 =?utf-8?B?MkdOdUpnUTVrVzBqUW5ManNzQk9VZEdQU2tyU0p0S2sybG16NHRSODhkR3d6?=
 =?utf-8?B?czVCMVE3VUp6eWtuSUtIMEZQNUhrS01RY0Rod0ZPQnV0c1ZiR0cwYVBFYWl2?=
 =?utf-8?B?Sm9qMGVDMVVpV09DU1NJb2Nuck5ZYjNQQjlZaUcyRS9DdS81Z0lueDZ1a05D?=
 =?utf-8?B?M0s4eWZxSDRNM3h6YnVkNkd2c1NLQm4zY0RZNENaVlJvL29WZ1NQRWQ3c2JQ?=
 =?utf-8?B?STZha3pyTUdIVlJmbEpqZHNhTnZ3MTRUcXFxWEk5RFNyMkgvN3lETDY5V29y?=
 =?utf-8?B?QkxiR014ZC82OUpLRm9EekFCK3YzWGIvbXNPcWpzalRwd2Fsbm9abkZCNGda?=
 =?utf-8?B?UDRDY2djR2wxUVdFTU5KTXZHNDZpY0VncndhZGVmWDZXQks3UExTa0pjU2hq?=
 =?utf-8?B?QmRYUkJoTk85c0tVOHBnUWZzTG1zSTJNWWtwWTlZTm5od0dBR1ByRnl4WXlS?=
 =?utf-8?B?RzVmMU9ORE5Yc1oxTnhRT0RUdG4rVDkvaVNCVGwvbS9wT2d2WWZHdDRZMXgy?=
 =?utf-8?B?S3NoN3FmWDVnVTFVRzc5SlJpSkQ0RGxlSjFqRmZOTFpwY2xyZmwvR0ZISjZm?=
 =?utf-8?B?VXFtQnRRWEhTS0hZeFhCUnBDWVNPbFBEOEw5d3ZwOHhER21nQllRNERZcGJQ?=
 =?utf-8?B?NlBOR3NiVkw0N3NkeHZzR1NkUytBSVN5M3JDdjlDVVovL2tEeEdWQ2JQSVlX?=
 =?utf-8?B?L3owRTVRM1VUVndJNzhRNWRHd1ZNZDlXRlBaMnJCOUw0U3lKcGFIMkQvRWw1?=
 =?utf-8?B?T21QTzNTVGxkVFM4ank1RExyZnFtT2RKVXRxL1JQZG9INkl1V2g3c0l1NkNu?=
 =?utf-8?B?eDZVdGlHOHY2VjVJRDZSdEVDTktzekY2bG1adTNGVEJQUDMyaUxWaHdySWlC?=
 =?utf-8?B?bU5LbkVQc1VUbWIxTDRtUUgyK1VzVC9xNGUrNUlRUXhDN09aNmFvbjN1cEdp?=
 =?utf-8?Q?tQHlSmNezNSptsFkL6jTcm1O0gIsPDF/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amxyYWxWVGtBckMrdWxJWllBd2RRbGprdzd2aVNPQlVDbGVFZ0VaOEh2SEdF?=
 =?utf-8?B?S0Z1ZEhCTHNlVllDMm5memtYa0FyMGRMcElxZW5jNHVDUHd6VGNMb1RVbVgz?=
 =?utf-8?B?UUR5M0FQUU1KekVhZE5Ub2Z0QUs1aXNVczh1OTkrajJOelp0UjF2Qmk1VUpL?=
 =?utf-8?B?dmtvOHdXUHRodFRNeXFXb3JRencyMnNoblE3N1hEWVppeGFTdThZdDVDRXN2?=
 =?utf-8?B?NWFIR1lBbUFLQzBmKzhkdEZ5b3R6dmp3cE5uSi9ZSlZzK0RPcmVBVE53OUpv?=
 =?utf-8?B?dGFnVlFPRmgxa3hUeUd4NGQyalNwUnRkUlpXNndGeVJoU0ZpNWk3MnFBQWlj?=
 =?utf-8?B?ZFF5NWdZWXpBZVJ0REJwN29sZnIwdzRhR2JHc0tkMGh5bXl0NUQxbG4yaTJO?=
 =?utf-8?B?d0FYN3c3aUdWdzZZRnVodWN0MWtQdHFicVlheWV5VkdwbnR5QXBaUmRMN2pT?=
 =?utf-8?B?OW43VWFxdUhqblEybFBEL25hMFB0MlZRTkwvUFdJY1ErWEM3SmpmTElxd1pP?=
 =?utf-8?B?NXpURXRtdVpvQis0RHVRYzNFYW5jZU5uc1FFMUlHUWZVTXdINGF1Z0lUVW12?=
 =?utf-8?B?WWFDek9qc1lCVGVNU2swaW5OMGxub0gwdzBkWGEwd3o4TGp4VUNQVW5vTFNK?=
 =?utf-8?B?eEdmSmZJaEJvQXRHVHBrRVZrUlIvTFRVU0huVFpGVnpSMEFoVnQ2OVNETUhO?=
 =?utf-8?B?aGFuSnhrTUZybm9qeTcrU1lsWUN1NDQvSEkreDRzWi9wVk1aVDlVKy9GcEtG?=
 =?utf-8?B?dlpIa20ybmdwelNGZk5oaEVYaTZ3N3JoTmVDUjUxbHE5Q2NRUUhRMVpIR29B?=
 =?utf-8?B?Sjl5aFlaNjBJbno3dmdFaVZUS29qd2NtQml1VHNkRmFDRkJhcTJwUUJpL0xG?=
 =?utf-8?B?VkxMR1BsMDl0K3NHelZ3cTlUSjFSdFEybnpUbkk1Nk05TXJIaDlVZWg1ZGtX?=
 =?utf-8?B?QkZnNTMzNmRvdnhJck9SNm93M3RmaDkzdTdtbTZ5WmhHZnhGcmtHYVFPc1Qz?=
 =?utf-8?B?SzIrTit6M2swdE9jNThKSWVGVUtONkp0WTE5VS8vd0pkU0gvTWJRdHd5N1E0?=
 =?utf-8?B?ZGxEeEZ3VjhuU3A0QlVrTTduTXZ5cmFWODAwTXVpV2tBcUxsZmhZVzk1eFBm?=
 =?utf-8?B?STVQcENPcFAzNmQwem5oeUpjYWlPdUttR0x0NjV1d0h1cndwOWNEL2FOZFhG?=
 =?utf-8?B?and0SDhiV0JEbHlwbmExbGhodnZFQjFXZFpxVGM5SGxNaWE5R1lzY0VKNzUv?=
 =?utf-8?B?SVQvekRIcGV1QmtXVVYxTWU1YVIzMm1XSGk4ZzBBL2txcGc5NXdTS3hFcGZS?=
 =?utf-8?B?b2xxTXV1K01DS2FBQkFGZlNZOVliRkl5blh4c0tURmlKQTZVSVdvUjkzM3Ur?=
 =?utf-8?B?UXhSNnA4Zkt1bnlFUEE0NEFmMjAyek96YVFhVk1oSDYzaThTT3dkZExLY2di?=
 =?utf-8?B?MFN3TkdpN0tpd3V0WFJVWXB5UTJrdU0wamxkVjV5bVROSDZsWEp1VS9qRjBJ?=
 =?utf-8?B?TkErbTNFMkR6YkJBZHFaaysvWXdaak50SnJqUE9BTm1BS0wvTHZGK3VGYnVV?=
 =?utf-8?B?MjhCWVk3cG03R2JQNHd0L3ZocTdLWTluQmlWSGdIa3dwblVIUlZDOW05dll3?=
 =?utf-8?B?WHJ5RGxaVlhDT2dRV0lEVTVhY1VHTVl5ZzgwM3RkaW5NRXdYZm1Rd0ErVklr?=
 =?utf-8?B?WnVSTUZJVTllQUorMGZWbURrMU1xRU4xYUFEVHdtNjI4WDd6RkFsdWlhbXZL?=
 =?utf-8?B?RnVSL3VNNjdYOXJCV3UrU0FaTXArcERybEpsVmd3OG5tT1V0cS81Z2V2dWxp?=
 =?utf-8?B?RzRKQjR1Y0xkZFhBYnU2cWx1VXZCT09FT0w4Q2crMmkxeEM5NmZxNTIxVzJj?=
 =?utf-8?B?YnBmNDlOK0ZyVTBvZTJsMGhtR2JkYzcwVzhKcmxBeWl1Z3FjcVM5Vk1SVEVy?=
 =?utf-8?B?WWkyR00wdUhMVnU2RDdXcnlaOXNMSDRPbXhzZ0RKenZCSStDZ3JDS0ZvT2Mw?=
 =?utf-8?B?a3VzZUcvTTZDbEVnUWhjZURuS1RVb0oyUkIyOUxmQUJhNDBMSlIzSkVNR2Jr?=
 =?utf-8?B?a0NhZHd1YWVTdzBRRi9SUk5kREN1VzdVaVFYZ0pRMTFnSFJPaVd0NHVwSDdX?=
 =?utf-8?Q?efHpgUaABhiB8W7IsQI+EYcD1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be20194e-d3b9-4a5e-608b-08de37bfbe12
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:43:00.2500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVWroPS68L2ZDzWraKgPkcv3AV4dV5O+yXwK2/8xPsl1ZQcEU1OfPVHQbUrIke1t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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



On 12/3/25 08:34, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> GZIP compression is disabled to reduce the SPL size by 12KB.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_mbv32_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
> index 81c0f8e9e936..d10517094c61 100644
> --- a/configs/xilinx_mbv32_defconfig
> +++ b/configs/xilinx_mbv32_defconfig
> @@ -47,4 +47,3 @@ CONFIG_XILINX_TIMER=y
>   # CONFIG_BINMAN_FDT is not set
>   CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
>   CONFIG_PANIC_HANG=y
> -CONFIG_SPL_GZIP=y

Applied.
M
