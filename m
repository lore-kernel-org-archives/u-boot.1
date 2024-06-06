Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEE8C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A74E87E1D;
	Thu,  6 Jun 2024 16:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sIoPxGjk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C593A87D9B; Thu,  6 Jun 2024 16:30:06 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589B688335
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1kITy7bzoX18RSAxQwrKNgxsmJavrHRHNMNexkEPKjX30d9Uh+B7rSTyy7QxNhfVT5fiFXpeXlXRZZowSO/ymotc9l3zlt9nL6frPJOkmPwS7o4vtz0YjsdZF8cl0uSGNif41HEzHhlZHmde3af4xgjnWUVj+sdY27Plxowt/mMbJTKvymiJCXVb50CCS8khTCe6Fmj/NLvhSVqeBi8LXM9+VhPNd3WCzE6kSli5cxGtwGnvtZJbHFh3riyvULQgWQsEL2IAab472eP3/MtQj7h+9SIja3k3uGxt6oM/UTtoStoQcCdKPFy28KbyIImPKkQxbIpEdGEsAXhF3ABnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Lc0vUgRE5RdFnVvTW2MhDDI3jNXWvCRzIe64wQxfuM=;
 b=JzFzrT0r0Rya7YlcDbaLql/6uS6FsiD5hs5BpcFqa6tX8wPAMIln9aETQk4yBTzYeOjnoHDhXAPZ/DyRcJSlri52m/XhfqFq8NI6STnJJiHR0wnqZeN2J0cGNHtj+jDD+rKsBa9KOFBRji+qb/4yDmBNs16q9wCGBPaiSerOLk/WtwA/JJA9UgeJ675FAow71ons+cv0Pt1f46ODA6xTg7Y+6/0I+ltmtu5tT8VuYD7+xYYQ3CHJ0NYoXYsKDeKEZMzcRrA5glr2bSyq/Y1dQ5AjYWLOAp7eRqxvPMRdC9v4GUl+M/HoE42vhuNg0THUts6HmTnY0OhQYd2zH35c1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Lc0vUgRE5RdFnVvTW2MhDDI3jNXWvCRzIe64wQxfuM=;
 b=sIoPxGjkhWCm2pPv4KLr/nlBShgfyPkc5Jh1M75nwUZHScjjsIgKlP91kJv124RYYj/b/I9brMsLBfZRKvxd8b8YJdrE92YJJ8vvhIb9FQGuB2fxS9R3gTn23FDh+5ON+UsnWdnN401DgBtZChOmdHhwWUD5Q3BHhDYc9A4T0Uw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 14:29:56 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 14:29:56 +0000
Message-ID: <d4aec6da-2c5b-4b6d-a2da-2ac955b4cde9@amd.com>
Date: Thu, 6 Jun 2024 16:29:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] drivers: misc: Add driver to access ZynqMP efuses
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese
 <sr@denx.de>, Lukas Funke <lukas.funke@weidmueller.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
 <20240604142741.425307-8-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240604142741.425307-8-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0125.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7259a3d6-29d9-4926-a8af-08dc86352328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGNIS3VKKzJlaWlZaWZzV21oSlhOK0M2M08xK2l4Y1B6aGpZUFZscjYreGdn?=
 =?utf-8?B?YVFWcmhhWlR6V1ZrQ2VFYmdITWpDY3BwOXQvb0VrZWR0OFpycVVYVVFINjA1?=
 =?utf-8?B?M2YweDZxQ1pTVHp6VVdpd3Byekdla2wrQjE4VHVkOGk0RHRiSlBqbUxScWQ3?=
 =?utf-8?B?WHR0TS9rTTRpS2lNK3diZTV5RUhISlN5c055UUtnK0dNRjRzZm5HV3hIeVRW?=
 =?utf-8?B?bzJtbTR0SVZzVlRwK0g4K2wxYUxCL2JMU2oyYU84VjFocWtQdjJKcWF6R2Rs?=
 =?utf-8?B?VVRTZHFsaXR5NHpGWk9kR0R0Q2l0RC9CM2J1NTdsUlVpUVFEOVd0bW53cGpn?=
 =?utf-8?B?T3Y1QzlGYzZtOXdVclcxbEJDMG9QUklpdlYvN3drUG9sanp5bUN2UUhJM0xu?=
 =?utf-8?B?dzRWTlZtdFNlOU9vZXNwcFBaMWFpeWhLd0NOTldabzVWRDRlSVNsV3drUDRO?=
 =?utf-8?B?cHFCK1JhT3hMN1o3aU5CUFM3QzcwRWlHTlIwQncwVWFhLzJjSVhrVmlpOEdM?=
 =?utf-8?B?Mysvci9SbjFXQ0sxbFE2L1ZJZkZtaGpXRmNwOXh2WFRKcXRHWjVtN1pPR2hh?=
 =?utf-8?B?cHFDS29yS1RETDJXaUtOakZpTklJZjZMV0E5bjRDZlRlNTlWaC9EZlROZjlt?=
 =?utf-8?B?OTVzVlZoTEtjazZLckFVUDA3bGNTSHlpVjl0NkFoN3VUMzM1V0FYS1hpcnVi?=
 =?utf-8?B?ZWkyQlEvbzZrN2RaR2NPTUpjQjUvMUxVRlhDZHlCM2pUcG1hS0Mwbi9FWm44?=
 =?utf-8?B?TmFjajVCZmx3Y3ppb1FGSzNlVGV6eU0xWW9SS1VRTnZ6Q3NPK0Z6b2laN0U5?=
 =?utf-8?B?OEtwejdFaGpKZzdHVGFWS05aWDlHaG9TTVhSc0ExRTZOSU4xc2N5TjNKS0lL?=
 =?utf-8?B?UXZMUzNjcEhUWlMwa1dmaTB3bEFnS3l4WExEVTR4NnpNQmpOb2JwY2JpNXFp?=
 =?utf-8?B?MWhmUUw5ejhtbHBmdzlYcUI0WTZCRlZCY3VwYWZYMTZycWR2blBYSklocmxp?=
 =?utf-8?B?eWFSeVU5REc4NDFiM1MxbWxHOHE5Z3hHMERVcG9nb1JZTWNxdndRUFpzd0pJ?=
 =?utf-8?B?dmJNaUNGMnFxNUZhT0lnaUhESk1WUUszL05FYWtsTXQwTU5KL29wK2NGczFR?=
 =?utf-8?B?YlgxUUxDZVVJd253TGJwQzllc0J4OGhWWGROTnZnOS9oTU5TN0xHZFF2bnlV?=
 =?utf-8?B?b2h6cS9RNlphc3c4QnBHT2pIRXBrTjJDZ1VlV2s1MnF4d2xZYUJVeFVTeEhD?=
 =?utf-8?B?dTF5UTRPc25VOCs1cXlBN2pXV2doV2pvR094SkFQeEt4dE9URnpnTndydk9k?=
 =?utf-8?B?a01oMlVOMlJRUnhnKzZyMko4U0pGMytId2E3SUpyTnloZXRnRjZCTnJtdnpa?=
 =?utf-8?B?ODFpd1lsVTZEbEFGNi80V0pZQWYwMEsvemRvMFNpRVhFbVU0bitaeVM1d204?=
 =?utf-8?B?UUlsZzczSGY4a2VYc0dRa2M0M1FnRTVlbnVQT3pDaHZJSjBDT3ozckZjcjlE?=
 =?utf-8?B?SWVJU2xBUXRlcjFocGtwZFZ2OWdPZHhiNnoxQlBqMkdOT1Q0TklkZ0xHZFI2?=
 =?utf-8?B?Y3E3cGU4M0JjeS9odzk3T09FcTA2SDlZcXREbTV2SFE1Szk0S1NOQjhTMGg1?=
 =?utf-8?B?eXhJeHdISysrUzU1WEszUTlqbDNiWDh1MjduN0x2aEpHaWFMN1lZY2N4dVNw?=
 =?utf-8?B?cm1Vbyt2cUJrZGNVVk1WOG5zVzFRemJ5SWcrWTA4dmVCdDF5RGlETlJyOWZv?=
 =?utf-8?Q?dHiPzrzB2pS0b4ywOtzHVWQcrjN9Q6CYHnPsnVW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzhTREFtQ1E4SzI4dVFtL2hSaHNxdEZSdHMwSm5ZZkRnU29tSFd5UXVRWlJm?=
 =?utf-8?B?Z3pmQm1ySlNHaFdVU2FrbUl3VktOQUpDUWJjU2ovSzF2L012eFFaWDJZOGhZ?=
 =?utf-8?B?YkVIUzV6WTJmbU1IcVZja0ovaEFaNk5yOE1yMmlrK1JOQkFJM1ArTUR3Y0xu?=
 =?utf-8?B?UmFSYXdyQWZZUnVyMzBFZTA3anNtZnB0T3ltMjVzbmpjN1NjNUFsU24yanVy?=
 =?utf-8?B?NUhuUTI4N1JEc0dBWjdObjhFS2ZTYlRPczZZZXl5UGNGbkd0YU1tOFhXcEhX?=
 =?utf-8?B?dStrN3cxMlJQK2Z0czgxM2FIckQvVEFwY2ZUQ2dnYlpHU3ZlY2ZnU3VWbmhu?=
 =?utf-8?B?RlhEbENuUm9takxtMkhkNlp3OFcrM2ZmajFLSWdPb285M0NZUFlZdDNuTXdQ?=
 =?utf-8?B?bzVEYWFNSk5xV2ViNGhqVERIaGZtVnVTSWN6Vk0zc0pIOWN4bTFsVW1DTkti?=
 =?utf-8?B?REIzQlp4UXRJM2pBMWtQNytOdGIxSFl0akIrcWJQTkJZWGR6K24yZ3cwSlpU?=
 =?utf-8?B?d1MwazkxaGRpWGtIMElVc0V4M211T0NJcFQ2ZHJoQ3pPL1QzU3ROWkRhOVYx?=
 =?utf-8?B?UUlHOUg1RzVhcVNNMkFvZkkrU2VxQkZKKzM3ellxSEJDdU1lVkk3ZkJUREVJ?=
 =?utf-8?B?VU1ld3BNU2U3RXVkcVF5a3ZraXFha2hTalZsU2N1dDRMeXg3N1cyVldxYjUy?=
 =?utf-8?B?Wlp1bUZZZ3I0VjNzY01NSUZmQUxXZGYxWUdyR3J5UEY5dHVQMDhxSm0vQnVl?=
 =?utf-8?B?T3BUUnNqYVJydTY1Qm0vL0ptVEh0dFpYd3hYaGc5UWJiVTNYaW8wWERGZHNT?=
 =?utf-8?B?MHAvSmErc1N3M0ZrbGVTZFRDZit6K25hTkVobnZwQnhxNDFpMUhIVzE4TGNM?=
 =?utf-8?B?UnFrVWlXblRwa3FmdlRPNzJ2b0FvWWNjQXFWNGJPbEg4ekdXQkpQamdWZ1lj?=
 =?utf-8?B?czhWbEN2czJHN1UwZDQxVzFNZ1VHaTZDelNsd3pHK2c2R3FZZWozRS92bmFH?=
 =?utf-8?B?ajVXckgxdmZHMFJHZ2dXd284TGJZRm9ST3FtazFvRGhRcmlMTFd0SzFsdDU4?=
 =?utf-8?B?OUdFR2t6NFlOeEdrVmR5elBPaTZBakFIYWNxZmFSWVc0VjNkVzJrc3BoZWJw?=
 =?utf-8?B?RFU1QytPTkFVU2NVMFBOYzE5c0FNajBMN3dGRjAwbWhDRmVySFYzTWpsNC9T?=
 =?utf-8?B?QTRGREdKNTR5Y3RpOENTM2lWUzE1a2xyazhEdnBVV2t4cEw5cTZpaEM2ZEJY?=
 =?utf-8?B?bEFLOEo5blZqaUJXMEkvTDZnRFdCUG00VzN5ck5STzFnTVhjaHVmZ2hMQXQy?=
 =?utf-8?B?akFBSlE3M0Npb2I2b2x4REhHTUVWMitGeUh5aEk4ckdxc2RnM291RXhKM29l?=
 =?utf-8?B?NHBKQlFWbHVkOFdVV0Vra1UwWERaUW1vVE1sT3V6NFBzQWR4QVFwdDZDV2hu?=
 =?utf-8?B?UGFiNXExUVBXUU1FTittbkZYQnNrSVRDK1BiU202QnRrR01RTGNvNXZ0UEMz?=
 =?utf-8?B?KzBHYkVZMit0N1NHRXJQN3dOaUk1RGxGYUNKMnJXWWJEcXF5SmZBOXM5a2sx?=
 =?utf-8?B?Si9qNHRJbkl6KzdqUjFKQUtUVG50aFE2cnZVTGdNZjJNMUQyYldBQkJna2lN?=
 =?utf-8?B?Ni9NM3Z0UFZyYk5xL1dYNEF0NXVtbVNCZTVFVjlkM212WDV2UzdnUlhwZ0px?=
 =?utf-8?B?eUhaRzJOODNjTmhGNE9tQkM2UGtLRWh6S2hLNHdmcTFiOWlUeVNGUEFiRHE1?=
 =?utf-8?B?bWNOVXRyNzZWWlhDQkxXL3AvcFR6NkR0Z3RreldKeUpCKzdReVpIRTZYRnBY?=
 =?utf-8?B?UUpHbUlvOTZkMnJZV2NMd1ErcEVxREhCL2FtZjZMMzIxNGQ5TWw4MndXWDVO?=
 =?utf-8?B?dU1lYmlpeWdqcmhrVjJMZnU0NUY0Uk8vWnRnaXkxYlUvOHNub0dHUDRxMHRp?=
 =?utf-8?B?ZXpwdXhSTkFMU09BbGgvMXB5Zi9LdVBFbmxEbENnZmU1NGdCWjVWOXE1U1g4?=
 =?utf-8?B?aTVrN2hQOUxGdTI2QzFTR1J4dERWS2gzYjgvY1V5Z0U3eFJob0JqSFFvbWRt?=
 =?utf-8?B?cElTUXdDQUUzWGg0MkdsZk1LUHoreVBLUWNFYmlNaWhwUjJ2UFRTT0VoNFMr?=
 =?utf-8?Q?3JWLxtWRBE22EdGKSZcZZg06K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7259a3d6-29d9-4926-a8af-08dc86352328
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:29:56.3354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AD242NzkZ7XzFgJnFryKhiJvZPwo0FMv859KZhMm9u5wMBRbkf/ZouU0uiKiONO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
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



On 6/4/24 16:27, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Add driver to access ZynqMP efuses. This is a u-boot port of [1].
> 
> Note: Accessing eFuses requires eFuse access to be enabled in the
> underlying PMU firmware.
> 
> [1] https://lore.kernel.org/all/20240224114516.86365-8-srinivas.kandagatla@linaro.org/
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> Changes in v3:
> - Align ZynqMP eFuse driver with Linux kernel
> - Adapt versal, versal-net and zynqmp to use common chip-id function
> - Enable CMD_FUSE and ZYNQMP_EFUSE for zynqmp_virt and zynqmp_kria defconfig
> - Use 'dev_err' instead 'log_msg_ret' if possible
> 
> Changes in v2:
> - Drop vendor specific fuse cmd, use existing fuse cmd
> - Minor code refactoring (reverse x-mas tree)
> 
>   drivers/misc/Kconfig        |   8 +
>   drivers/misc/Makefile       |   1 +
>   drivers/misc/zynqmp_efuse.c | 360 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 369 insertions(+)
>   create mode 100644 drivers/misc/zynqmp_efuse.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 6009d55f400..c07f50c9a76 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -298,6 +298,14 @@ config FSL_SEC_MON
>   	  Security Monitor can be transitioned on any security failures,
>   	  like software violations or hardware security violations.
>   
> +config ZYNQMP_EFUSE
> +	bool "Enable ZynqMP eFUSE Driver"
> +	depends on ZYNQMP_FIRMWARE
> +	help
> +	  Enable access to Zynq UltraScale (ZynqMP) eFUSEs thought PMU firmware
> +	  interface. ZnyqMP has 256 eFUSEs where some of them are security related
> +	  and cannot be read back (i.e. AES key).
> +
>   choice
>   	prompt "Security monitor interaction endianess"
>   	depends on FSL_SEC_MON
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e53d52c47b3..68ba5648eab 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -92,3 +92,4 @@ obj-$(CONFIG_ESM_K3) += k3_esm.o
>   obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
>   obj-$(CONFIG_SL28CPLD) += sl28cpld.o
>   obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
> +obj-$(CONFIG_ZYNQMP_EFUSE) += zynqmp_efuse.o
> diff --git a/drivers/misc/zynqmp_efuse.c b/drivers/misc/zynqmp_efuse.c
> new file mode 100644
> index 00000000000..d12de7494d2
> --- /dev/null
> +++ b/drivers/misc/zynqmp_efuse.c
> @@ -0,0 +1,360 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2014 - 2015 Xilinx, Inc.
> + * Michal Simek <michal.simek@amd.com>


Not sure which version you used as source but please sync up with kernel version 
you used. I expect there will be much newer dates because efuse were added 
recently.


> + *
> + * (C) Copyright 2024 Weidmueller Interface GmbH
> + * Lukas Funke <lukas.funke@weidmueller.com>
> + */
> +
> +#include <compiler.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <zynqmp_firmware.h>
> +#include <asm/dma-mapping.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <misc.h>
> +
> +#define SILICON_REVISION_MASK 0xF
> +#define P_USER_0_64_UPPER_MASK	GENMASK(31, 16)
> +#define P_USER_127_LOWER_4_BIT_MASK GENMASK(3, 0)
> +#define WORD_INBYTES		4
> +#define SOC_VER_SIZE		0x4
> +#define EFUSE_MEMORY_SIZE	0x177
> +#define UNUSED_SPACE		0x8
> +#define ZYNQMP_NVMEM_SIZE	(SOC_VER_SIZE + UNUSED_SPACE + \
> +				 EFUSE_MEMORY_SIZE)
> +#define SOC_VERSION_OFFSET	0x0
> +#define EFUSE_START_OFFSET	0xC
> +#define EFUSE_END_OFFSET	0xFC
> +#define EFUSE_PUF_START_OFFSET	0x100
> +#define EFUSE_PUF_MID_OFFSET	0x140
> +#define EFUSE_PUF_END_OFFSET	0x17F
> +#define EFUSE_NOT_ENABLED	29
> +
> +/*
> + * efuse access type
> + */
> +enum efuse_access {
> +	EFUSE_READ = 0,
> +	EFUSE_WRITE
> +};
> +
> +/**
> + * struct xilinx_efuse - the basic structure
> + * @src:	address of the buffer to store the data to be write/read
> + * @size:	read/write word count
> + * @offset:	read/write offset
> + * @flag:	0 - represents efuse read and 1- represents efuse write
> + * @pufuserfuse:0 - represents non-puf efuses, offset is used for read/write
> + *		1 - represents puf user fuse row number.
> + *
> + * this structure stores all the required details to
> + * read/write efuse memory.
> + */
> +struct xilinx_efuse {
> +	u64 src;
> +	u32 size;
> +	u32 offset;
> +	enum efuse_access flag;
> +	u32 pufuserfuse;
> +};
> +
> +/**
> + * struct efuse_map_entry - offset and length of zynqmp fuses
> + * @offset:	offset of efuse to be read/write
> + * @length:	length of efuse
> + */
> +struct efuse_map_entry {
> +	u32 offset;
> +	u32 length;
> +};
> +
> +struct efuse_map_entry zynqmp_efuse_table[] = {
> +	{0x000, 0x04}, /* soc revision */
> +	{0x00c, 0x0c}, /* SoC DNA */
> +	{0x020, 0x04}, /* efuse-usr0 */
> +	{0x024, 0x04}, /* efuse-usr1 */
> +	{0x028, 0x04}, /* efuse-usr2 */
> +	{0x02c, 0x04}, /* efuse-usr3 */
> +	{0x030, 0x04}, /* efuse-usr4 */
> +	{0x034, 0x04}, /* efuse-usr5 */
> +	{0x038, 0x04}, /* efuse-usr6 */
> +	{0x03c, 0x04}, /* efuse-usr7 */
> +	{0x040, 0x04}, /* efuse-miscusr */
> +	{0x050, 0x04}, /* efuse-chash */
> +	{0x054, 0x04}, /* efuse-pufmisc */
> +	{0x058, 0x04}, /* efuse-sec */
> +	{0x05c, 0x04}, /* efuse-spkid */
> +	{0x060, 0x30}, /* efuse-aeskey */
> +	{0x0a0, 0x30}, /* ppk0-hash */
> +	{0x0d0, 0x30}, /* ppk1-hash */
> +	{0x100, 0x7f}, /* pufuser */
> +};
> +
> +static int zynqmp_efuse_get_length(u32 offset, u32 *base_offset, u32 *len)
> +{
> +	struct efuse_map_entry *fuse;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(zynqmp_efuse_table); ++i) {
> +		fuse = &zynqmp_efuse_table[i];
> +		if (offset >= fuse->offset &&
> +		    offset < fuse->offset + fuse->length) {
> +			*base_offset = fuse->offset;
> +			*len = fuse->length;
> +			return 0;
> +			}

nit: wrong indentation one less tab for }

> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static int zynqmp_efuse_access(void *context, unsigned int offset,
> +			       void *val, size_t bytes, enum efuse_access flag,
> +			       unsigned int pufflag)
> +{
> +	struct udevice *dev = context;
> +	struct xilinx_efuse *efuse;
> +	ulong dma_addr;
> +	ulong dma_buf;
> +	size_t words = bytes / WORD_INBYTES;
> +	int ret;
> +	int value;
> +	char *data;
> +
> +	if (bytes % WORD_INBYTES != 0) {
> +		dev_err(dev, "Bytes requested should be word aligned\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (pufflag == 0 && offset % WORD_INBYTES) {
> +		dev_err(dev, "Offset requested should be word aligned\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (pufflag == 1 && flag == EFUSE_WRITE) {
> +		memcpy(&value, val, bytes);
> +		if ((offset == EFUSE_PUF_START_OFFSET ||
> +		     offset == EFUSE_PUF_MID_OFFSET) &&
> +		    value & P_USER_0_64_UPPER_MASK) {
> +			dev_err(dev, "Only lower 4 bytes are allowed to be programmed in P_USER_0 & P_USER_64\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		if (offset == EFUSE_PUF_END_OFFSET &&
> +		    (value & P_USER_127_LOWER_4_BIT_MASK)) {
> +			dev_err(dev, "Only MSB 28 bits are allowed to be programmed for P_USER_127\n");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	efuse = dma_alloc_coherent(sizeof(struct xilinx_efuse), &dma_addr);
> +	if (!efuse)
> +		return -ENOMEM;
> +
> +	data = dma_alloc_coherent(bytes, &dma_buf);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto efuse_data_fail;
> +	}
> +
> +	if (flag == EFUSE_WRITE) {
> +		memcpy(data, val, bytes);
> +		efuse->flag = EFUSE_WRITE;
> +	} else {
> +		efuse->flag = EFUSE_READ;
> +	}
> +
> +	efuse->src = dma_buf;
> +	efuse->size = words;
> +	efuse->offset = offset;
> +	efuse->pufuserfuse = pufflag;
> +
> +	flush_dcache_range((ulong)efuse, (ulong)efuse +
> +				   roundup(sizeof(struct xilinx_efuse), ARCH_DMA_MINALIGN));
> +	flush_dcache_range((ulong)data, (ulong)data +
> +				   roundup(sizeof(struct xilinx_efuse), ARCH_DMA_MINALIGN));
> +
> +	zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
> +	if (ret != 0) {
> +		if (ret == EFUSE_NOT_ENABLED) {
> +			dev_err(dev, "efuse access is not enabled\n");
> +			ret = -EOPNOTSUPP;
> +		} else {
> +			dev_err(dev, "Error in efuse read %x\n", ret);
> +			ret = -EPERM;
> +		}
> +		goto efuse_access_err;
> +	}
> +
> +	if (flag == EFUSE_READ)
> +		memcpy(val, data, bytes);
> +efuse_access_err:
> +	dma_free_coherent(data);
> +efuse_data_fail:
> +	dma_free_coherent(efuse);
> +
> +	return ret;
> +}
> +
> +static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val,
> +			     size_t bytes)
> +{
> +	struct udevice *dev = context;
> +	int ret;
> +	int pufflag = 0;
> +	int idcode;
> +	int version;
> +
> +	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
> +		pufflag = 1;
> +
> +	switch (offset) {
> +	/* Soc version offset is zero */
> +	case SOC_VERSION_OFFSET:
> +		if (bytes != SOC_VER_SIZE)
> +			return -EOPNOTSUPP;
> +
> +		ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
> +		if (ret < 0)
> +			return ret;
> +
> +		dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
> +		*(int *)val = version & SILICON_REVISION_MASK;
> +		break;
> +	/* Efuse offset starts from 0xc */
> +	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
> +	case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
> +		ret = zynqmp_efuse_access(context, offset, val,
> +					  bytes, EFUSE_READ, pufflag);
> +		break;
> +	default:
> +		*(u32 *)val = 0xDEADBEEF;
> +		ret = 0;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int zynqmp_nvmem_write(void *context,
> +			      unsigned int offset, void *val, size_t bytes)
> +{
> +	int pufflag = 0;
> +
> +	if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
> +		return -EOPNOTSUPP;
> +
> +	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
> +		pufflag = 1;
> +
> +	return zynqmp_efuse_access(context, offset,
> +				   val, bytes, EFUSE_WRITE, pufflag);
> +}
> +
> +int fuse_read(u32 bank, u32 word, u32 *val)
> +{
> +	u32 base_offset, offset, len;
> +	struct udevice *dev;
> +	u8 buf[128]; /* maximal size of efuse is 0x7f (pufuse) */
> +	int ret;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(zynqmp_efuse), &dev);
> +	if (ret)
> +		return log_msg_ret("uclass_drv", ret);
> +
> +	ret = zynqmp_efuse_get_length(word, &base_offset, &len);
> +	if (ret) {
> +		dev_err(dev, "Invalid eFuse word offset\n");
> +		return ret;
> +	}
> +
> +	if (len > sizeof(buf))
> +		return -EINVAL;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	ret = misc_read(dev, base_offset, (void *)buf, len);
> +	if (ret) {
> +		dev_err(dev, "Cannot read eFuse @%u: %d", word, ret);
> +		return ret;
> +	}
> +
> +	offset = word - base_offset;
> +	*val = ((u32 *)buf)[offset];
> +
> +	return 0;
> +}
> +
> +int fuse_prog(u32 bank, u32 word, u32 val)
> +{
> +	u32 base_offset, len;
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(zynqmp_efuse), &dev);
> +	if (ret)
> +		return log_msg_ret("uclass_drv", ret);
> +
> +	ret = zynqmp_efuse_get_length(word, &base_offset, &len);
> +	if (ret) {
> +		dev_err(dev, "Invalid eFuse word offset\n");
> +		return ret;
> +	}
> +
> +	if (word != base_offset || len != sizeof(val))
> +		return -EINVAL;
> +
> +	ret = misc_write(dev, word, (void *)&val, sizeof(val));
> +	if (ret) {
> +		dev_err(dev, "Cannot write eFuse @%u: %d", word, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int fuse_sense(u32 bank, u32 word, u32 *val)
> +{
> +	/* sense is not supported */
> +	return -ENOSYS;
> +}
> +
> +int fuse_override(u32 bank, u32 word, u32 val)
> +{
> +	/* overriding is not supported */
> +	return -ENOSYS;
> +}
> +
> +static int zynqmp_nvmem_read_compat(struct udevice *dev, int offset,
> +				    void *val, int bytes)
> +{
> +	return zynqmp_nvmem_read((void *)dev, offset, val, bytes);
> +}
> +
> +static int zynqmp_nvmem_write_compat(struct udevice *dev, int offset,
> +				     const void *val, int bytes)
> +{
> +	return zynqmp_nvmem_write((void *)dev, offset, (void *)val, bytes);
> +}
> +
> +static const struct udevice_id zynqmp_efuse_match[] = {
> +	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
> +	{ /* sentinel */ },
> +};
> +
> +static const struct misc_ops zynqmp_efuse_ops = {
> +	.read = zynqmp_nvmem_read_compat,
> +	.write = zynqmp_nvmem_write_compat,
> +};
> +
> +U_BOOT_DRIVER(zynqmp_efuse) = {
> +	.name = "zynqmp_efuse",
> +	.id = UCLASS_MISC,
> +	.of_match = zynqmp_efuse_match,
> +	.ops = &zynqmp_efuse_ops,
> +};

The rest looks good. When that small things are fixed I will merge it.

Thanks,
Michal
