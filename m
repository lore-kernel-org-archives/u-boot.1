Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17065CAC583
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9730183236;
	Thu, 11 Sep 2025 07:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3JpuxHME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1534583280; Thu, 11 Sep 2025 07:40:21 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0484D8319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yum7lPi7XLU2i0C3ofX8FuHN1CmbApaNfkBNt/Yv/sqww77XwAeS1svHcFq4eWF+p+vdcTVYebZItl1EbZqu3/d5ba+2Zv54OQyEBjXNmPN3LCvzkTlHKYA7fS5qcLnvcRhZaLNSXFDdyG3VaXFvtHnLQJrSW40oT7+kSIX7Obz+2vxTDIKB3si3iQ7XGE0XvVWrCp85qkDKZwMAkTAAUNfzx9uPovuKVTd9WK/wkNMMo3it5az7Y8+L2B64XJvXneCOFHZRH7R8Ahf7G/D841eGdBkVsxuCUHwF31S0HLhqeDCByUYvjEIQFvt2A/91tvONRNNI+rpRS7jD1ZB1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykxCvxLbf844FIgKeo1PhXVbjv3m6mycYgmeQqD7Kc4=;
 b=l6Re4NjgK+HEMQum/RGvHH8kV/IDT2kEFo4yBIuqdOdyjs4T9UZeWwSAXBirCrdJmwrM0vRd8zEVSeDNPYqqnCEdOLLCRI5d5whj4F+MRWEtCNfy8pkxs/BuGIo5CxqdbPA+gZXYi66OgwMgP403zEBgAJM4YWDPirOofKOQiHJI5KPTMsgHhNh7nMmBwTWjxJT6v2S6nRIlVlrQHpEe7pxexoTxlw97vuCCHGiz9uVzuhvwM1/oluGaXycI178VtB2HeUKRTSXSWMCHmEvVGXuLTTyyEGagQr5hLErj0Gfv63FcFzsjR4JfzNyv1vRKy6buBSnSMNuY5AoyiqBF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykxCvxLbf844FIgKeo1PhXVbjv3m6mycYgmeQqD7Kc4=;
 b=3JpuxHMER8+LXYR/7ZdGBZisorNilZxPje9y3s0M3HCVQb//zZhor2PPCwAdO4MRSHEjnXpmiC+oYxnxKpNv1PmE2ZWhlSsKNNvUuOOTBgYdeQR5ZS7LGKS87vTOy2x5R5GrDH/eMy/bC4aMGJnc/vtgeq4t0E+ElLTzpvqwJLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 05:40:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 05:40:14 +0000
Message-ID: <39f7c9df-9a8a-447d-8689-4f99676fb1e8@amd.com>
Date: Thu, 11 Sep 2025 07:40:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: spi: Fix gd->env_valid for the first write
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 git@xilinx.com, Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com>
 <1684bd0d-b831-43e6-8713-95a2675957db@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <1684bd0d-b831-43e6-8713-95a2675957db@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ee4dc8-385c-44f6-bc39-08ddf0f5ae7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEtYRkVYRXVXR3ZnNlFQMjlSRDJZR3k1SVVGR3U1UXV2ZEd5VEFneDlXT2lx?=
 =?utf-8?B?dDljWWhkekI0VWxtNXRKdm5pRnFBQ2Y2OXc2SlR0NTZDamNMMzVEVDhaZjVk?=
 =?utf-8?B?K0VKamMyRy9PTEpDc2xLWW1xT1NWUVZ4T0dRdU0wWXRoK0I2OWFUdytXTWVx?=
 =?utf-8?B?eTcyOXBXVjV6b2NiWEF0dVBXdWtncG0yK3hJd0FaTGU4YThhckdobTZqTDI2?=
 =?utf-8?B?RXVuaDNZd24rWVVlYzRJRC8rR2JyTVRhTlE1VEZyakhiL2UzZ1hXU01LS3Iv?=
 =?utf-8?B?MzJ3QzRxUnlpVWZqdE56bk1XY3pYbkNmNS9BM0JoWHNyQXBZcjRsUzJyOE95?=
 =?utf-8?B?U3hIZjkrOGpoNXgwYmFQTklUOXdJOE9IR3J2bExZMTNVVTduUHdHMnc3Uk5z?=
 =?utf-8?B?ZTRwV29UZ0pJRG9ZT1llVnRjUkxJY0IreXQ2ZEVDdzV1SEtjeWY3Q0JIWkRR?=
 =?utf-8?B?QzBYdnNMWDFZem54MlJjSkVUaC9HaitIbjk0UndPUVVEbHJuS3pRYU9JNi8z?=
 =?utf-8?B?Z2hBenBpbmpSUGZWRkN5K29PVUFPS3ZWZEc3b0dIUEE4ckxBY1YrL3NHNzZn?=
 =?utf-8?B?aTFEczhOSWc4SWQyem0zeUUrU0dlNlRoWTFaNi9WWWJZN2cyREVsdzA3Zk9X?=
 =?utf-8?B?eVB2Rnk0d1lXWklpaXFYSDUzS2RhVmdVUnNCdFpuaUJqSGNBcHM5VUpDMTI2?=
 =?utf-8?B?eU44eGlJVnNNbUZmYXEwc0o2SzZxbEFWMjRmR1RiWHBQcmNOVjlITzNLMlQw?=
 =?utf-8?B?amV1eVIyZTZPNEhVcEhjemltNzUwdVRlZ1BaVk0wTXJaeXlJclByNTdXNEhs?=
 =?utf-8?B?My9rTWQvR1lMSTRYS3lMVUwyUmRMem5LWElyNGdXdzZlS0ZoSWtBdXdRSFFJ?=
 =?utf-8?B?SEJ0WWdQZUtYUkdFTitXcVUrVVpyMHBKalpOMkptN3Q0R1VzTS9CWGc2UWhS?=
 =?utf-8?B?Y0RSKzkrc0RiYUFhL0hOMHA1c3l1NGlJQm9EMUpMR1FQOE85V25oV1piNnRa?=
 =?utf-8?B?TkFOV3AwWGRtQUNyOGUwTmZkbnRYV0VxYkZrOTRMMnp1TEdzNmtWM0tIblZy?=
 =?utf-8?B?OFR0M3pWSmZnU0FBVTNsU3A0dTliYVFaOXFhemNqTlV5OWlKUjcrNFRmK0tE?=
 =?utf-8?B?bkNXc3pFZUQyVzBZOXdOZ3RLdDZ4UTc4NXFRcjhhb2FISDA0eWc1enZrRi9N?=
 =?utf-8?B?QlpLcVR1cnBXRkxiMlJFWWFIMWFML0dFMWRKa0NzbjBYcWdtbUpGRE9pTHlR?=
 =?utf-8?B?dDg4TWF5SjlNWFE1anJTVXM0MzB2N0dwQUFtenZ5OGFBOG4vNDJXMkt4NnpY?=
 =?utf-8?B?MWcvalJSWUFLWHB2emliYzB3b1ZFSUs0bGg0RzJOQjNTY2d6Q21VU284UHh6?=
 =?utf-8?B?cXN6clVPOW9sUTk3aDl2OGtWTnlFVTFYR0V6alFiWWZLMTZtL0tweGFmc2ZN?=
 =?utf-8?B?M2svdHUvRUFNOGlYOTlaSnI4WjhqTThTL1RHWmNFc3BNWFNSS1FoYzhqWnZ0?=
 =?utf-8?B?Z0xVbi8wZGRrNzduT1QzTDNnVzNDb2JNQ2hKV28rWXE1dkNMVG5wQnlNR3R2?=
 =?utf-8?B?Q3FMY0FpaHA4NHZueWhqWkZHVG9ZUmd3RjVkZmZRaFZCNTZEM2tUYmN5NHE0?=
 =?utf-8?B?dFF3ZmFYT1VBbW5zYU4zZWpDakdPTk90dW9vaDh3NER2R25EQ0VCWEdzTDN1?=
 =?utf-8?B?TjJaMHZiYStDeTBzbU15MWkzNkJheFVjUTVHa1VFUE11clZzRlV3aHNNV1k2?=
 =?utf-8?B?SjBFd3BRMHBWcjVnN3QwQmk4bzhLUHdEQ0UzNERxY1BXcnV0WlZBOUhlSWM0?=
 =?utf-8?Q?OpWgfVtP8dGhUy3I1dCLWPdlgnplV0aAeRQbM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzk1aWtOQjZFM2ozZitzbzdsL2hSUmZUUldJRDdaMXpXQkYrSlFKcnpKTTNz?=
 =?utf-8?B?YTlNdmxmQXM5VDltL0tVeUkzVWtCenMzQStZRHlLbjhDY2NiY0l3eHNxWDZ6?=
 =?utf-8?B?VmJHN1phMkdTcCtNbEIrZDMyZlZ4U20xQ2Y5dTV3NzZxMElBMEU3cVlweDJm?=
 =?utf-8?B?VlhXRVd2MjNJcHhobXNmR3diWGpQU3dwWTlBa05NOFRBWkNxUHlpdVI2czR4?=
 =?utf-8?B?SWszR245TmkvRW94eGFXZ3V2QnMrTEk2K2U1ckNXd052TFNZMlhJMVZpaS8w?=
 =?utf-8?B?OStaekNRbzhwSDVyQmgxZUZBeUkzUm5LRy9TRzVMSlhCd2h3SzREa1lhbzFC?=
 =?utf-8?B?d0Fpb2FTd3l2N2lGZlhoaW1JWFVFUWgvWldDbnM2NThhUlZlYXEyMVhqSTNx?=
 =?utf-8?B?OWliU1BqKyt6Q0ljMTYzTFhJUXlKdnRBS1hGVkRXMERBaUl5THhyNnZkMzNu?=
 =?utf-8?B?ZWdQTnRhcEVObVBUWWFXbU5LQm5BY1FhdnVDQWttTWRWYko5REVGOXVxOXox?=
 =?utf-8?B?Z1Y0b2pPUU13bVZTWU1PcjhtTlVoZUlVSEhlUERZVWhmU3IyL2hOcXh0K2ZV?=
 =?utf-8?B?VWRpbzhvTlhic3g3UUdDVStZVnBjZW40V01ncDBIN1pQTm1WVjVkYW50RE50?=
 =?utf-8?B?MUtEcEFUNkIvNmg5eExYQThuMjN2dHdYWTk3MnQwcUVqUmh6MGx1VnhxZGZ0?=
 =?utf-8?B?UEExeklRK21xTFpvZ01rVGpKbmxUMnVPL2p0QjNRZE1HSmFQNGpkbHRSYURQ?=
 =?utf-8?B?RnRhZXMyT1Fwd1dxWVpjanZkYTVscWdpaTZjS1daN2VTa2NMVnNKbjB3bVR0?=
 =?utf-8?B?alE5VGUyYk9FUERpeW9DQ2txNkVRa2J1Mm1JdktFcGtYcWtlODUwbDBabXEv?=
 =?utf-8?B?SlRtb1hYZjB2azV2eUdYNmJvZk1SUTdSbDFOZmE1cFdrNXVOR0ZkR2ExUlEx?=
 =?utf-8?B?bjFRcEdpdmdVaDRVTUFWbUk4K0s1MzVDblRsOTBWQWtpbU9ONTVPeHU3cnow?=
 =?utf-8?B?UXI0RGxvT0NOUWNlQnpWNGxqaWIzblN3U3BPREJINTRiMy9QQTZ0YWViU0x3?=
 =?utf-8?B?Q3k3b3gvbGtCZ1VuTkY4VU1nVTQ3a2tOOGFPYk1nUVUrbko2S0FrNzUrSmpz?=
 =?utf-8?B?T2d5bFFUeWdDZVU0eHU0S21CZ1FFY2xYS21RL2VOam5yZ2NPOTl2bnR2Ym8r?=
 =?utf-8?B?ZzNoam9DM3VtcnUvWlFoVmNvK1ZhWkVIbXZqQlJ6NUx3bW9SZi9yT01ra3lP?=
 =?utf-8?B?cElVUEt1RHc5MTRQSG1LWi9CRlM5OWRZamMwS1hJTERPQVVDcW9XYjNxc0cy?=
 =?utf-8?B?RUFRNzZ6OHRGc2NzOW4zRm1idDZlbGZBVE5wUlh5TmJSMmlzSjVub1BoSUhl?=
 =?utf-8?B?SkRrRW9HNjJNNHR4c0hobW8rTTFuWUJINUdOL3FTWnVKV215czJoczd0dDlp?=
 =?utf-8?B?Z2h1Z1hyMGZKbExXRDNpRitNYXhhditYcVV4V21QWitrU3k4eG8vRGtuNERy?=
 =?utf-8?B?L1VhdlpqZ2FKRnZPVGtzY3MyOHBhanE0c3Vzem9iYmdIUTNYRTl6NHlURWlO?=
 =?utf-8?B?TXVRbmRJdklNNlpBazM1RUtFaFNEU3FJenNYT0FrUkJOZTVWUDdKdDdxUjlD?=
 =?utf-8?B?UGVPenE4bHpCOVlORmdIakpwdnRoU2VsRDZiUWxJazdIR1dNbytZc1VkdWZ6?=
 =?utf-8?B?a0Y4TmE2RzlYVlgzYk8wZjVQcHBoN21melprMGxVNFNZcW1tRllrRzB5Tmdi?=
 =?utf-8?B?bHZQZ0txY2U3enQ4ekJjb3RlWG5aek1idDJyNHJwekg0WFNvYjQwZUk2KzJW?=
 =?utf-8?B?Vk1YWmlGUnh1UStLQmZURTUzdzVWR0JxcEVZaUpYRmN5aU5nN1dBbzY4TnRa?=
 =?utf-8?B?a3dZN2p3eXcwU2tHTHFQOXVZbkVTSzBobDgrYTJvSDk1WDMxNk9BMTVXVW1y?=
 =?utf-8?B?VW9iRkMxcXRQL1pkenRJQXpFYnRtMzRHY21rREhPK01LTE83bE45Tk5xaEdo?=
 =?utf-8?B?bFpISkhDMTBlZDNZa0Z3ZUZjY21obGdJTGd0ekJ0cURqK1Y1L0UrZXNNbVpG?=
 =?utf-8?B?MDhZNmpidWt3YkpQNlZtRHdrazVXRkFOMFBhVUR6Tk9mbU5FdXVkMk9zdWtL?=
 =?utf-8?Q?c9GqwVtXxsSYfpIzySg/JgbwC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ee4dc8-385c-44f6-bc39-08ddf0f5ae7a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:40:14.2314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67dKOmmt1y3nbLvWHr77oJWFphVVc2r6+IHdqEYqld/5A2vL6rRG3s1fVfaE5dCV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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



On 9/11/25 05:28, Marek Vasut wrote:
> On 9/10/25 9:26 AM, Michal Simek wrote:
>> In case of ENV_INVALID (uninitialized variables) the first env location
>> should be used for storing variables.
>> That's why change the logic how env_valid is setup to be aligned with
>> offset calculation.
>> This will also fix the print about Valid environment is showing proper
>> location where variables are saved for the first time.
>> And also fixes behavior where the first two writes were going to the
>> first location instead of the first to the first location and second to
>> second location.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v2:
>> - Simplify commit message
>>
>> Origin commit message with more technical details.
>>
>> When both location for variables are not valid (or empty) gd->env_valid is
>> 0 (ENV_INVALID) which is setup by
>> env_sf_load()/env_import_redund()/env_check_redund() calls.
>>
>> When saveenv is called in case of SPI env_sf_save() is called which
>> contains logic which describes new/old variable locations.
>>
>> if (gd->env_valid == ENV_VALID) {
>>          env_new_offset = CONFIG_ENV_OFFSET_REDUND;
>>          env_offset = CONFIG_ENV_OFFSET;
>> } else {
>>          env_new_offset = CONFIG_ENV_OFFSET;
>>          env_offset = CONFIG_ENV_OFFSET_REDUND;
>> }
>>
>> In case of ENV_INVALID option the first location is used (else part)
>> and variables are saved with ENV_REDUND_ACTIVE flag.
>> The second location flag is rewritten to ENV_REDUND_OBSOLETE.
>>
>> And
>> gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
>> is executed. env_valid is ENV_INVALID that's why ENV_REDUND is setup
>> but that's not correct because the first location has been written and not
>> the second one.
>> That is confirmed by
>> printf("Valid environment: %d\n", (int)gd->env_valid);
>> which is showing number 2 (ENV_REDUND).
>>
>> That's why change the logic how env_valid is setup to be aligned with
>> offset calculation which also cover the case where initial state is
>> ENV_INVALID.
>> Then print about Valid environment is showing proper location where
>> variables are saved for the first time.
>> But also it is fixing behavior where the first two writes are going to the
>> first location instead of the first to the first location and second to
>> second location. Alternation is happening after it.
>>
>> v1: https://lore.kernel.org/ 
>> r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
> Sorry for not being clear, the original commit message structure and technical 
> details were fine, it only needed slight rephrasing, in the original form it was 
> very hard to understand. Can you please reinstate the original commit message 
> and only clean it up slightly ?

Can you exactly point me to part which wasn't clear? It has a lot of details 
about flow and obviously it makes sense to me that's why I would like you to 
point me to exact part which should be improved.

Thanks,
Michal

