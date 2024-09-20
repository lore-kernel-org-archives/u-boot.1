Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73003C7883B
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 13:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDEF3892B3;
	Fri, 20 Sep 2024 15:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gns99zVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF7C8939D; Fri, 20 Sep 2024 15:07:22 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AD489163
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKtcPNur/N2Vy+/itdljgeOqzkkcMpoIqHYdnXmMoyoYaqKcOnDr3Vrj/BM7I6KKtu8vbXxtCIW1LNkoVPT7mV9ZQu8ojRZe75SW8WNbiEvOedTGGbhSdFPQSf4jqJjNO5H1rdCIgK90iZ9FkYUnjFBkg5v+bUXZIldSq7a08wJUrKUot6yhNlyhPb9RM2loOpiZ68mxMaxJvfBl8X2Z+GThQRD9UDwV8JlqXCOyz8Y1eWrLiqVWQSIB0g6uuXT6D1yJTABNov69w/MvEIBEbrtV4tX+QEcB6pZJur5YvTxF8/GN+ZjshuUNxBInYbpqqgOTnvHU1Wy5RrZexTbw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fk/PFH1a1RBXYRk2eg48Vb3x0lRvPtwYQrndRaabdM=;
 b=IXfCYTkSVf4Xj67VUJr3sSiyhh0i7xzYWJBA+xZpT3mTIKsyrnobN2rCC+zWNVsK4yonkDCyMZOz0HtMPU5+AKv0diVnP2uzbLuVIaYCyeKLHrUR3jpMYee9ACRry22FsaV3DUcCTXMY8mSED4eTU8X4sqxrClKSpdE8AJu3gCqLzu5exYi7m42tH3v0xtT4wIVcRT9rYhIe3gCDI/CsCPtHQnmnAjmXas08+BdcbYTJgUpRh0PGcYCJyX3OqlfUqDkFzcSTioJOp5JhqG3nA0Ee8U18IK91wmvzmbvzHjy+wiGEYv525k5ajfC3LMcagM31iET3pyCl4UhBZR6Yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fk/PFH1a1RBXYRk2eg48Vb3x0lRvPtwYQrndRaabdM=;
 b=gns99zVUdNjrjFcziuM6yMiQQHGiDnSNxaTZ+h2a2d7NGwXl1nVZElXZRypNe5gk2NbD5poAIoDOzM7ENfaIEhnW8sO4tDkKKxp6dpUfWAlhbVLN6qmgZWwgDimCjgNKVN1bCxDQD2IaFUGH/f8DC8e239WMPSyUdFsJI3sIbqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 13:07:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:07:14 +0000
Message-ID: <c7c59ffd-0c65-4b30-a438-3e83be38855a@amd.com>
Date: Fri, 20 Sep 2024 15:07:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: Remove conditional check for Microblaze
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 git-dev@amd.com
Cc: venkatesh.abbarapu@amd.com, Prasad.Kummari@amd.com
References: <20240913093231.2343528-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240913093231.2343528-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0214.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a89666-d705-415b-59d4-08dcd975258c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjVsZkJhK2diVk9DRzdxUnF1aFI5ajJ1R21hV1RoazRTUTBQL3RCb1VCT1V4?=
 =?utf-8?B?NTFzZzY5K2hwQnBDY3VHMHhHQnZ6QU41cGxZcEVYd0dnSEZFbzVFS1VXbEp5?=
 =?utf-8?B?ekV6Umc1UFlFaU9NL3NMOE1RVHA3OFRBQmdOYjdRcTRxSEZMcmtjMzIvZlBy?=
 =?utf-8?B?SXEwNytYaXNCN2djNnNLTkVnSmc5QXNuc0w1ZXcrb3JoRjhQK2RvY3orRE1C?=
 =?utf-8?B?Qzd6R1VWeGY2RC9zby9TTUxSTld1a2diWTRLcC9TY2F1b2JqMzJNOWVTeFN0?=
 =?utf-8?B?Wk8zdjRXcFhJWUFiUE1yWGxiTFpzTER2OXVXRTFKcWpQMUFnNHg1KzhMb1pD?=
 =?utf-8?B?VGw3OHVGSkh3RUFXaEZYNkxaOFEzU1g0d0lQMEFtQVNxYXVTeVhiZU14bXVC?=
 =?utf-8?B?MnVqMWQxQWdFdW5FM0lCb2djZFlGSHZxVVVxQ1gyQTBhYXFTS1FZOFdMaDZp?=
 =?utf-8?B?V25ya1kvN2hlRFQwa2x6Z3g5TWpSdWx5WElQVXNOSS9laGxCOVA1NmxLdGVM?=
 =?utf-8?B?bGpycmxFQnhueXBpcFU3SENHTTV3L09DQTI2c0lrTTRiWnphS3NiWjY0THVZ?=
 =?utf-8?B?VjJac1ZzWTFQTDBSWGRnTSs2NkR6Q3U3TTBiVTBnekc5a3JZWWN0eEVSRXdn?=
 =?utf-8?B?VHhiNW54R2QwRjVOYWtsVjh6bVRobTRHNmlXN1hCNlM5MHZ2VTJmckdSZitJ?=
 =?utf-8?B?THlRR0Q2bzZpNUF6eEY0eWtIcUkzdlVha05Fd1k5VmdIT1NOWHhISE40MzNz?=
 =?utf-8?B?ZWVBZUxKS0dJTXNZUmx1VTQrSkk0bmE0dzhnWlZhbWVnWE5MUzA3RnhoNTlz?=
 =?utf-8?B?TEdYYWdSYS9kQlI1OURTVndyKzR5L2ZudU80Qy85L05uT21SMnF2bGtRekx6?=
 =?utf-8?B?UmdxYVlGVEZkTnhDTDlaYXplUGVjTDV4VkRweC9IMTk4cnozeTlWQ0hVb0E1?=
 =?utf-8?B?VnRmMFZJK05QWU9JRjFES05wbTUzaHYxcjlNYU1BazRONE5YZjA2RmZzenRi?=
 =?utf-8?B?S1dhSUhEZktSMTBpcWtEWnNpS05PbGQwUlFTZnp6MGNRaXhEb2hWK0ZYdElo?=
 =?utf-8?B?bDgwWTJhRnBRRXBaNlhjdlFYUDB4VUZuRkpjZG50cTZBUm45cUllVmgxbmRx?=
 =?utf-8?B?UFlXRXVEWWFQN3dEclllUGFxNWRkUmhwYjYrd2RGODd1TVd4ci93SzVoaXJZ?=
 =?utf-8?B?S0l2eXZpY08rSXNiQnFyMzRkTVh5cGVLZnZHS0MxeDJUbmdYUExsQUs3cjFZ?=
 =?utf-8?B?L2xjbFZoRU5hTmdZZHMwczBEV213S20zMFRSZityVUlsZzJmRVJkM24ydTRy?=
 =?utf-8?B?TUVDY0dsa2l6ZlJDRUZmOXVaeko2TWd1WngraDNBWCt5RXVlT2U3cXIwT3pB?=
 =?utf-8?B?aDNSbnQxTWdCaXFiSHh4emFPUTJHbnROdHhpd2oxZDYxTXB5b09QemlqN2sr?=
 =?utf-8?B?WElkREw5R0k0cGFRM3k0RnJ3Z1pJMzVIa0xoOXFtUlVxQ2tpQ2pwdnZSM2VT?=
 =?utf-8?B?WTh2T2tKYTQ0RHRKZFI5ZkNYanZpSWs2c3Y1S1N4NWNIS0tNcjl3WHhTV3dw?=
 =?utf-8?B?STRJQzdpeFF1aEJCRW9MMXNheWpySXJZOUhqVVBPcHZMODdPT29IM3Z1My9v?=
 =?utf-8?B?clRzelQ2dTNmTEg1RWZLSzdPQ0ppaEx1aVF5d21MSW9lSDUxdFdpQ0NQNEpI?=
 =?utf-8?B?QittcmVvMyt4b28vM0IxalFqZE01dG56dWFJU09wQjF0L01ad1R5NTZzT3pD?=
 =?utf-8?B?K0xqNDJuZE5GdVRKWHVFTkEwMFFVNTg4WkQxMXo4OCszU2xpeCtMQk5JOGt6?=
 =?utf-8?B?REpmTTVTSVVHRU5sMkh3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTA1cVJrVW8zOWJYQ25DWXpDc3V2bWlIQnNqaXJHYmdIaHhPU0pNQSs5bDJo?=
 =?utf-8?B?Q05lbjB4M1JQWVVBdWlDdEJ4dTB5a0VxZ3ZwN1BqSE5wVnRFZHZWMzZ0QmhX?=
 =?utf-8?B?MUd4dTA4S0pMZWExWG4vYjVHWGtMQ01McEZyZ1pOcWhnS1p2d0hWUEZWZXVh?=
 =?utf-8?B?eUFQaXB4U0FwVmU3YW1ERk9Hb1FEWjRKS2w3SXp1ZWxhZmYrSnhHcm5oM1Q3?=
 =?utf-8?B?OHo4ZGVuRGQ4R0lZQ3BjeVhzL2t6cUw1aW9ZbHlMSlJhenAreWt3Zjg2dHo2?=
 =?utf-8?B?TGk5L0o2QVFkWlVVelB1K05lQ3Z1TVZLNm5Lbk1oWll3cXdFV2kzdHNqQ2dH?=
 =?utf-8?B?UWFhWERXMVh1ZVNiVFF2d1Nrb3lDOW1EMks0RWdNUEdZVWxyTUZDVFJQVGVG?=
 =?utf-8?B?eVFSRFNPWDZCMURQQUZsQUxETnROUVAvRUJaa2ExdWdaMzd0NE1COStEZzBE?=
 =?utf-8?B?aXB5YXE2M0NUcVRWaC9neURjTU5wSGtZZmU2RmZDVUNqY01YY2F3blRFK3R6?=
 =?utf-8?B?RDJlWUJ6VUVOTCsvOGhadDZwNVR0TWJxWktqOUNLRUVkMlVaS2hwN2FXSllQ?=
 =?utf-8?B?QXJ0djZEUWhER0tUTGRqVWh2RzZzTjBoSGh0L0xzS0RJOTB0bE9Ebi9jV085?=
 =?utf-8?B?dVNFVnFKTjhBVHhaMnRQb1BzYUtlREtvYXRqd0l4VkV2UUIrVS9OUXBMb3lR?=
 =?utf-8?B?TEJsc2FWRG44WlErU1kvaCtaZFczTC9QeG02TGFIYkFKTVFiMFpDbTNaUkhU?=
 =?utf-8?B?Nzc3RUlnWm1SYUpzd3owL2xJNGJTelRsZzF5NE1lQ2VpQXBNWHREazExcFQ4?=
 =?utf-8?B?cEV5ZUtjUGdYaEc2U3hQUWRzTFNYZUxzeGxxNkxGcmVmN2xBSkZTdkp6b25P?=
 =?utf-8?B?ck9UMmxXQUtlUDBGUFowcDYxTEdEYytXekd0SGd2RHdCNUxoajJoYVhZanlx?=
 =?utf-8?B?UUVSR2Y1SXUxOE0zOTJOdGFOOHZxRUV4cGJvTWQrTmlkU0w0S216YnNzWmZO?=
 =?utf-8?B?UUZBWGVXM3dXN1F3cm15MTFRazl5Sm5rYVZXeUxaRlE5ckFNNVdtZW1xcG50?=
 =?utf-8?B?TkJISzhOa1AyQ2d0b1l3M1V2M1g5dWJpUDBxT3Njc29palVWbi9UQlpZQWZK?=
 =?utf-8?B?OHEvdU50NVNvQ3lDRGUyTHM2K0lYWGdzdkViNmMwZU92N3hjazJ1dGdSTUpE?=
 =?utf-8?B?eS9UZ2tCTUxDYXZpYnJDK2hlZmo2clhQWGV2SUw5Q1I1ZTJhRjNTQkUyU2xU?=
 =?utf-8?B?clk5MGJ4L0tMMXJVdFBZNkl4ZVlJdTdVL0FYWVdYZHBnY3E0Wm40eDRTU004?=
 =?utf-8?B?VEthQkR2aHNPVHdhQUtxamRXMjFGdVN0VVlHMlpVdHh5b3oxUDJSRkZvY0pB?=
 =?utf-8?B?cFJjWk9hZXdaeDU1amZQb3psZnRmU3JHUEQ4WE1GdVN6M25zLzhKMEg0TXFk?=
 =?utf-8?B?SkZGdWV4ajlGK3FuZCtPN2c1LzQvZlE5ZWlWRlEyaHlEdWduYTZZeWZicmF2?=
 =?utf-8?B?anc0OEt4aWlsNGVVVXBLblZ1TmdvbHVydTR2d1hsOXh2LzMxS2Z5WEYzNkx3?=
 =?utf-8?B?cTdHa3JreE1QRlgvZ0hXNUZycWZXL1VObHphVzZGb2JNVG5LaCs1RUhVbVhR?=
 =?utf-8?B?ckpNSDJISmQyQXN6NzhYd0x3SVBCMCs1SGtsMFc1SG5rcjFtNUlnRVNwdWpm?=
 =?utf-8?B?WXZaRkQxd2FDempaY2RpN2pNanlaaEIyQkdTUHk2MGg0TmxURVMwYnFuQ1hj?=
 =?utf-8?B?bUhzaTBIWmtPQW5jZ0JKTUNhc0FWdU8yamJ2ZDZMRDZWSWphUjk0bXBtMFpN?=
 =?utf-8?B?ZlcyOEZXUDcrbTNnL2tmeWZVRVpuckhxZUgzK1ZLTUhmRkNEcDBYSnV5SzFs?=
 =?utf-8?B?aCszMFhBUkJZM2R1THRITFEyYmFCZDRkOWNUVTFNVGJOckh4Sk0zcmZEZGNB?=
 =?utf-8?B?ajhuSTRBLzZVemY2K2NBWDRPRTYxbkZzKzBSNzU3QThrbC9FeTJyM0NnUng2?=
 =?utf-8?B?K1ZoYkE0aHRDQ3JMTzNyQWdHTkhhaVdwdGI1Z1VnQ1dPSThxOEtaN25BTUhI?=
 =?utf-8?B?c2Y5OTRUZjJCb1BTeFBhcG44U1EwOVZpbXg4Rmw1enRlRlJKSWNaazhTZ0Na?=
 =?utf-8?Q?eacXtVnQX/v1hVsjDa9VIoSYK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a89666-d705-415b-59d4-08dcd975258c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:07:14.6272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h971ZiiTc32xlWpA3O3+GZRRM6LF29MRI/UgGvDQ01LhM/EEnTT2LwUjvVqRFVbg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
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



On 9/13/24 11:32, Padmarao Begari wrote:
> U-Boot is not picking boot.scr script address from device tree
> rather it's using default address for Microblaze platform,
> and it's picking for other platforms. Remove conditional check
> for Microblaze platform, so that u-boot pick up boot.scr script
> address for all platforms from device tree.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   board/xilinx/common/board.c | 39 +++++++++++++++++--------------------
>   1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 0b43407b9e..a217b39df6 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -426,28 +426,25 @@ int board_late_init_xilinx(void)
>   	struct xilinx_board_description *desc;
>   	phys_size_t bootm_size = gd->ram_top - gd->ram_base;
>   	u64 bootscr_flash_offset, bootscr_flash_size;
> -
> -	if (!IS_ENABLED(CONFIG_MICROBLAZE)) {
> -		ulong scriptaddr;
> -		u64 bootscr_address;
> -		u64 bootscr_offset;
> -
> -		/* Fetch bootscr_address/bootscr_offset from DT and update */
> -		if (!ofnode_read_bootscript_address(&bootscr_address,
> -						    &bootscr_offset)) {
> -			if (bootscr_offset)
> -				ret |= env_set_hex("scriptaddr",
> -						   gd->ram_base +
> -						   bootscr_offset);
> -			else
> -				ret |= env_set_hex("scriptaddr",
> -						   bootscr_address);
> -		} else {
> -			/* Update scriptaddr(bootscr offset) from env */
> -			scriptaddr = env_get_hex("scriptaddr", 0);
> +	ulong scriptaddr;
> +	u64 bootscr_address;
> +	u64 bootscr_offset;
> +
> +	/* Fetch bootscr_address/bootscr_offset from DT and update */
> +	if (!ofnode_read_bootscript_address(&bootscr_address,
> +					    &bootscr_offset)) {
> +		if (bootscr_offset)
>   			ret |= env_set_hex("scriptaddr",
> -					   gd->ram_base + scriptaddr);
> -		}
> +					   gd->ram_base +
> +					   bootscr_offset);
> +		else
> +			ret |= env_set_hex("scriptaddr",
> +					   bootscr_address);
> +	} else {
> +		/* Update scriptaddr(bootscr offset) from env */
> +		scriptaddr = env_get_hex("scriptaddr", 0);
> +		ret |= env_set_hex("scriptaddr",
> +				   gd->ram_base + scriptaddr);
>   	}
>   
>   	if (!ofnode_read_bootscript_flash(&bootscr_flash_offset,

Applied.
M
