Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2179CD4F59
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 07:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3BA88C47;
	Thu,  5 Sep 2024 09:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XG+5e012";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E202388C47; Thu,  5 Sep 2024 09:50:43 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A38E988C78
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 09:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLkSXWIY3eKs4fqyk07LLUqlCWLkFqsGHcCwPt6+wW6pfmaVHO0F4azZhRFgH4OAsdTlCdpLpW4FVi67g8bpqUATsOaJcsUtyQCJZMHILHMCIiVDRgbRmjmz1eDSmV/S0wezrpWMMZX6CKu7tXIkgK5Ejk/yE7Lpci7+OF+diiGy+wI//v96J/oeWJJ8KfG7D6a7rIwE+NAFKC7kIS74qAbxOlGTeSzFLUPKUPBfSKA97WG4iueLkRmRatfBo87O0ra3cYekFu7e1HKIKQ0KEMoO92FRTLjbdbDGRwLIrxDXdMAid8oy+QE1CmZ33vYEX0x9tbrEYh8QixVL3Ftopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7NO4d6dkMIvmtn3pwcUhE5PFTSxLDmiJt6bcaraHvM=;
 b=BCqwBAyODX7TmC/Tg5c2hoJ73qz67Gum+WSUEuVVwA+gJ7BVUCmFzLd+YvyDxS7Dyjq2wfzoAZeSkuwKuLH09BKn2IoHYTq5rXmU5rp0xrifRxHj747wPK2BBBR0Q2h0Yk1P4izCrAiGecIubGGjWaAu6A6B1ZTrqI8TPRmEaX5+lZsoexLJ6KwmqZRHdA+VsR/0lX/1F4M6n8RgR41s+tJw9eroXRtqxSaxj4tkUwqVlVORc3kgpydKAu5/rRz9QM16BzKQAHU3wD+cWN2s6nLz33R20jN9csau6rYWH8S9CLQmUZnD5HybYyzmitugmISX7a8fDR77f9MTp7RENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7NO4d6dkMIvmtn3pwcUhE5PFTSxLDmiJt6bcaraHvM=;
 b=XG+5e0126lEpwP0MicZDm1hg7q4rl0dRgGvM46nOJuwJD7+3g+1G8LHwFg+9LOt3AjTkVyMzakge3UknM6jsr6k00g9UUW4lc09YVqb2DRAV//ysG0ZYZbgPTb7dF+3EmVXZ34SQGos8++BBgj0+X5gB5IxtH5ZDUOvdZLdQ1NA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 5 Sep
 2024 07:50:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:50:36 +0000
Message-ID: <41f4766b-7861-4608-905f-9717e6fdc230@amd.com>
Date: Thu, 5 Sep 2024 09:50:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
 <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
 <6f1e9198-e9ef-46e3-afae-62b3f84d97c6@amd.com>
 <CADg8p97A+CJjmEtiVVU3S4GLvEie2FFNi6nN2Ho4ZtAceddJ=g@mail.gmail.com>
 <17fdf962-20b7-4bb9-93ba-bdb7335c4762@amd.com>
 <CADg8p979GVQ+bk4RYUmE94Fnd1jQ6sv41V82ZRW=+gjRhn6dwA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADg8p979GVQ+bk4RYUmE94Fnd1jQ6sv41V82ZRW=+gjRhn6dwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ae1040-ed3d-4325-9126-08dccd7f6d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkhYVGI5SUNVVWErUERhTXZKbFQrQ1g3TVBlWDZwazgySnJETm40RjE0RzJT?=
 =?utf-8?B?cXMrQlFxU0tEbXNsZ1FyUHpvdW51Q3diU3JFRXRJWDh3YzRiS3NRMVlwYVUw?=
 =?utf-8?B?UXlDZlBPZFoyOXBXYmwxTnV1YmoyUWVkcEdxdW9kdzZ6UXdvTzZxbGN0UTlD?=
 =?utf-8?B?bDB3NWdVK3VFQW16cnN3WUhUekVZZUxwMnJYamc1bGVMTzhKQmVULzUzQjNa?=
 =?utf-8?B?S1VIenQ3MkVhU0pSSkV3T09TYVFwelNiczVQQ1lSbVZCVXlRemNsMXczZDRn?=
 =?utf-8?B?VTIvVjNxZURnekljaThBdzBsTVV3L0E0cUhRd1JTN2oyOFJobVg4YW9mb3V4?=
 =?utf-8?B?UWdWc0xFMHUzRjA3Wk0zRnFuUGVLT29uNFZpTkk1ZEZITFFFZ08yU2ZrRjdy?=
 =?utf-8?B?T1U2a2pnZFZqVndaeDNaTmZJWGdFNmVwSkVVV2tWMGlCRHdaM3AzN0NYWDlu?=
 =?utf-8?B?RTg3ZTVVVmpZSFB6NHcxN1VPczM3UHVKL1lxbTd6eDRNakdtYkVKYzY1WDVW?=
 =?utf-8?B?SXZNRDA2eGtxWVp0TndkQWMxbFlSYVF0T0Y0a21LcldZeDVxWWR2cnZXd2pT?=
 =?utf-8?B?S1A2YXlKRUxkNmJkU1BhVnRrdE00TjlYRjE5cHFaNzZoUEIvdHFnaGRnYlRq?=
 =?utf-8?B?QThNNGNmMk0wSFhoSXNkSXVsMjYxM0NVZ0hyUkRUT0xNdDRockd4dU5pbGhF?=
 =?utf-8?B?N1Q0L0U2UUZGbTEwSERNbnVVWkhkTTdkb3pMRHhId0dtRXpOVTVCZi94cmlp?=
 =?utf-8?B?M3VUZ2VPNFdDY3dhTG5NemV3V1UxMlJrU1hLdHJ5dFJFTFoxNkRCa0VpNnpW?=
 =?utf-8?B?VnFCT2FGTWM2K3ExV3R2TzFzU1djemxEdWNmZ3ErUzk5WU5BcXVPeTBnMXcr?=
 =?utf-8?B?R0M1bHREVFJUM2ZJZ3dsQTNRQU9yT2hmazVQZHVJK2QxNU1yR25ZbFpYOWJ5?=
 =?utf-8?B?aXpBRjdFNEVlSUQ3QkgvTTRmd0pXc2IxNGwvTk84MVB2K1lsUUx4dzFyTUl5?=
 =?utf-8?B?MG5Pa2YwaFdzeGRoRFNhSmN0bEdKcktEd0g4YlhudjlTdEZQSFlMWWhJYS9L?=
 =?utf-8?B?djdTdE52aGhzNWl4ZFJqUXkvWFVDT2w5ZmxXbmpPbjM0U2lCVk0remRaWHNF?=
 =?utf-8?B?WUwvcHpkWXpQWDkxbmpzSVdaaW5sZmxMdlVOU2h2NHFiTW5TRVQvbHNaVi9w?=
 =?utf-8?B?cnFIb0FvUGRSTjNkZitDMncwZkhlMnFRcUJ6bTFoK2YvWVlRalFoSjdlbHNh?=
 =?utf-8?B?dHhxSldOWUltdG5XTEFBdzZhNi80Mkxycnc4Y0d3Y00wSXdrSEhIY1ZubkNi?=
 =?utf-8?B?aUN4a1Rmd1J2ZDVBWWc1c1gwdndJYTl4QXljZHoxaGdEa3FHL3ZTdXB4eWtK?=
 =?utf-8?B?dHVjUTUxRVJiaGtzQ05ENXQ3OUREOHYzdFkySHBtd0o3VEVJcnl6M2cxTTdn?=
 =?utf-8?B?VHpiclY0QzRzZmlGMjV3U3EyUG82bS9qS2d5K3ByV1hYWlNTTFhXTFlVUjAx?=
 =?utf-8?B?dWFrQXdzcFE5SUlQUjNIR0lRNGdTRnlUOGhTTnl1enFvMHJ0Y3E0UmQ2MWk4?=
 =?utf-8?B?OEJ4Z1VaVDhhRmxXbVEvakhiT3crNW83T3dhZVVVQ1VJSFZKVDBQTXJoZWhD?=
 =?utf-8?B?MC9yR2hURTBxRG1qYjNxVlB1akJUMElIQm1VVUI0Vm1QelhBUTNYYWYvU3RB?=
 =?utf-8?B?NVFOQkhqdmRYTUNmTGd6WXBKMUR2NjlyYWYxQ1d0S0dqSHRXNXh5UWlUQUM3?=
 =?utf-8?B?ejc4VTVHVmtPdERrTWNUWjJCblo1R3dBSlk1NDIxWDB1WlhTUVF4WjQxNkV2?=
 =?utf-8?B?Qzh0bXRnSlJHT0VxMzBwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEx6cXFDSnVIR1V0NU5PWUtXTEpMaXVJSkRRYW4zT3R5Q1lmOC9JazhxQ04r?=
 =?utf-8?B?OFdKSldIMThPQ0MxSWVrK2taMjNTWHIwSGtwbytlSmtKbGMzaWN1dERiSkhH?=
 =?utf-8?B?c05LSEo0QmkveVdWQ0NWTFI4K0xGQU5nMkNtZWEwdEllK3AxQzlXbVNQdmJX?=
 =?utf-8?B?ZFhvVFh0UnhhMno3d2twSk9BY3VHdUJrQkprLzVlYU1NYi8zM0FLbE1DUjUr?=
 =?utf-8?B?cVlpYThpTTZ3cUJ5NXc3YktHSmo1RkdWejRJREYzQ2IyenVrd0ErY2crYmFn?=
 =?utf-8?B?dXZjVmdHTm1nUXJtY3h3M1cvRmRRR3YrbnNTRkRTVXBPeDhsQWZKQkNHZUp5?=
 =?utf-8?B?aUNtQ3ZLcUhUcitITGU1eHplU21RZmQvL1VydVFDT3V2Ylg5WjZxOFdKZTZD?=
 =?utf-8?B?YmJLUVl4RGJMbHYvYWE4ajdNcHI2T3ZnMmtMWVBPWGZZZVZGa0VLZFdNajVB?=
 =?utf-8?B?UThvWW50ZmFPNjI4WkgyekFyUFVseGNZK2VQQlMrczNITlRRQjFha1FzbndZ?=
 =?utf-8?B?akZBWTFCUkZZYlMwUFd2WjhvcS9wWk9DZmVmK1VRY085d2N6NTBROUMyVStq?=
 =?utf-8?B?dnpvUjRWTG9JUDhhVEMvbEhMbFRCWHVveXhGV1dTUFNSZDVtYTZOdFRuYUF0?=
 =?utf-8?B?MFByY2VoRVBLVlBEVGVpUk5WUzlKSVRoVjFVaFZhWjg3by81UGdReS9xd0Zk?=
 =?utf-8?B?ajJuMnpUYVI4Ry9pbzFnQkZsRUJLcjZyVXBZcjVHUVQ5bHhLcHF3eEl6R0Nn?=
 =?utf-8?B?SGJPSTZ2UE1uNHFZRXFhY0cvWU1tT0FwaVZDTUVpVktCWWwzL09wWHNsMWRR?=
 =?utf-8?B?amtScnk0QlFNSUgyV1FQYytoUjB5VVBWSnlmd29NZGRUL2daSks1OFFUbm1t?=
 =?utf-8?B?YTNvWldMWHRreXFFcDFUa0FRMTFqeCtlZ1J5TnlmY29vYjc2bmxUR29zY3or?=
 =?utf-8?B?b3ppMVFuREY2SE9aNkM0MnJpRW1ZQTFDcWVZc1RaV2RkTHNwb0NMelpvOVlZ?=
 =?utf-8?B?ZW1zQkY2ajgvaFdLbU5LZFVNeTVlQTVHek1QbzFvdmZWQTJmTm9id1VUaWdD?=
 =?utf-8?B?RHFpUE8zaEJETk9TYVdTRlhzN2NkdFN0YTMxb09YNXd2aXJobXZJb2hkaHlj?=
 =?utf-8?B?WDFsdnd5MEE0d1ZsemNzU0hWQ29rRlVRZWt3SnFEOU9Xa2c2ZlkrQ2RKVDVp?=
 =?utf-8?B?QjFCM0NpZHpmdjIvNGF3cWVKOVUwNHV3L1U2blJ5NE9SMEEzNm43UEVaaDVu?=
 =?utf-8?B?UmdEUE02NDF0WU5nL2tjdmlZdE95d3IvdjNrSG1YV2locDlHTlQwK3c4WFJC?=
 =?utf-8?B?NkpvL28zVzI4RHFGdFdtQTU1c2dxSWtudk4xV1c3eHNQUXB1SWVVLy9nTkND?=
 =?utf-8?B?VHgzTHV1QnF4KzlmUGJrZ0U0enZrMEUvaVUwWVdHZWhYcVBSNDd6cHpDZUZ6?=
 =?utf-8?B?K2MrcnVmWm9GckRkQnBZbWZGTnhXck0yVUZrcG1KMEl5c1ZlQmtyQWxrNjZn?=
 =?utf-8?B?bTFlNnNnekRYK3UxR1JyYU1lRzBESGoyRy9CZ1QwSnd4ZVdVUVFTK0wrQUhr?=
 =?utf-8?B?eHFGVTlKMFBuVjlvdUl6dk5tRUNaUXhweWhmRVlpbkFJUjNHTXJFRDNSN0lr?=
 =?utf-8?B?L0FrTGsrN1JWQW1lVWZhZXVSYVU1UTl5TTJkakZGUjR6V01IckpJWnhMK0tU?=
 =?utf-8?B?eXpuOEFmZjlFQzhyMlFsZGVPRDNiQjc2elpjTVJrVkRZV3hsei90RnpsSlpW?=
 =?utf-8?B?aTY5NWM3WkRkeDZjMHFuS3dUNi9vZlNvc3ZkZU16MnFoS0VRMVFRVzRuNURM?=
 =?utf-8?B?Q3FuTFN1QnFISVFhMEhpZWVpRlpMeWphNUIydE5xVldmRFVWTlpHczgvekZo?=
 =?utf-8?B?WjJOMFpNZGRJMkR6V1pkTHVIU2xvdmgyNUxCSnpPUFl2V0cxSmdic3VTVEpJ?=
 =?utf-8?B?b3JFRHVvS2tTVDFaS1FXTG42OERxV2NHaFlncUdsb1ZuQlQvV2svSFlwZk9a?=
 =?utf-8?B?Q0J4ZkNuaHFLWkg2MDRWbis0UTE3V1gzQWdUS1dUWEQrcWdKOE5KcUJScHJy?=
 =?utf-8?B?UHpSUS9LcCtiV1Y2SThuTDB1blpnNWdjVERyZDljblVyL1Z3OSs0cUIvZXBZ?=
 =?utf-8?Q?ZbUtYw19SAdmsaxyBrKi6/o5S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ae1040-ed3d-4325-9126-08dccd7f6d7c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:50:36.6598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6l65mmaIfvSHjzx6wMONbNNuVkKGesOiDXHH7ol9Jdf2zPws3/cKd9yWaPzPv20
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287
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



On 9/5/24 09:43, Sughosh Ganu wrote:
> On Thu, 5 Sept 2024 at 13:09, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 9/5/24 09:38, Sughosh Ganu wrote:
>>> On Thu, 5 Sept 2024 at 13:03, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/5/24 08:24, Sughosh Ganu wrote:
>>>>> On Wed, 4 Sept 2024 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 8/30/24 13:40, Sughosh Ganu wrote:
>>>>>>>
>>>>>>> The following set of patches are miscellaneous fixes and some
>>>>>>> hardening of the FWU update logic.
>>>>>>>
>>>>>>> Sughosh Ganu (6):
>>>>>>>       fwu: v2: perform some checks before reading metadata
>>>>>>>       fwu: v2: try reading both copies of metadata
>>>>>>>       fwu: v1: do a version check for the metadata
>>>>>>>       fwu: check all images for transitioning out of Trial State
>>>>>>>       fwu: add dependency checks for selecting FWU metadata version
>>>>>>>       fwu: do not allow capsule processing on exceeding Trial Counter
>>>>>>>         threshold
>>>>>>>
>>>>>>>      include/fwu.h            | 11 ++++++
>>>>>>>      lib/fwu_updates/Kconfig  |  1 +
>>>>>>>      lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
>>>>>>>      lib/fwu_updates/fwu_v1.c | 18 +++++++--
>>>>>>>      lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
>>>>>>>      5 files changed, 99 insertions(+), 42 deletions(-)
>>>>>>>
>>>>>>
>>>>>> I found one more thing.
>>>>>>
>>>>>> I did this change
>>>>>>
>>>>>> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
>>>>>> index fbc2067bc12d..dab9530e499c 100644
>>>>>> --- a/tools/mkfwumdata.c
>>>>>> +++ b/tools/mkfwumdata.c
>>>>>> @@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct
>>>>>> fwu_mdata_object *mobj)
>>>>>>             struct fwu_mdata *mdata = mobj->mdata;
>>>>>>
>>>>>>             mdata->metadata_size = mobj->size;
>>>>>> -       mdata->desc_offset = sizeof(struct fwu_mdata);
>>>>>> +       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);
>>>>>>
>>>>>>             for (i = 0; i < MAX_BANKS_V2; i++)
>>>>>>                     mdata->bank_state[i] = i < mobj->banks ?
>>>>>>
>>>>>>
>>>>>> to break desc_offset location. I generated mdata structure and write it to
>>>>>> primary mdata partition.
>>>>>>
>>>>>> This has been spotted by (my debug) which is the reason why I did it.
>>>>>>
>>>>>>            if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
>>>>>>                    printf("mdata offset is not 0x20\n");
>>>>>>                    return false;
>>>>>>            }
>>>>>>
>>>>>> But I got one more message below which
>>>>>>
>>>>>> mdata offset is not 0x20
>>>>>> Both FWU metadata copies are valid but do not match. Restoring the secondary
>>>>>> partition from the primary
>>>>>
>>>>> The reason why this logic is in place is to handle the scenario
>>>>> whereby, during the metadata update, the primary copy gets updated
>>>>> correctly, but due to some reason (like a power cut), the secondary
>>>>> copy does not -- this is because the primary copy gets updated first.
>>>>> In such a scenario, the secondary copy of metadata can be then
>>>>> restored from the primary copy. In the scenario where the primary copy
>>>>> is corrupted, it will show up in the crc check, and will get restored
>>>>> from the secondary copy.
>>>>
>>>> But in this case - CRC of primary is correct but data inside is wrong because
>>>> offset is at 0x21 not at 0x20.
>>>
>>> How will this event play out ? Am I missing something ? When the
>>> metadata is getting updated, the offset will be written as 0x20, and
>>> not 0x21. And in case the metadata gets corrupted, the CRC check would
>>> fail and the primary partition would get restored from the secondary
>>> (assuming that the secondary copy is correct).
>>
>> It is not after update. It is initial state with incorrect mdata structure.
> 
> Well, if the metadata partition is being written with incorrect data,
> not sure how we combat that (or even if we should). After all, the
> spec clearly states that the metadata cannot be protected against
> malicious writes. The logic that you pointed out earlier is to handle
> the scenario where the primary partition got updated, but the
> secondary did not.

I don't disagree with you.

Scenario here is that primary partition is updated with incorrect data content 
(but still correct CRC). This is correctly detected that data is not right.
It means primary partition is wrong and shouldn't be used and it is not used.

But because it has correct CRC syncup code logic is doing syncup.

That's why I think we have two codes which have pretty much independent logic 
what to do. If primary is wrong sync should be from secondary to primary but 
that's not what code is doing.

Thanks,
Michal

