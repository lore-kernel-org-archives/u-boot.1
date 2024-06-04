Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BCDC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 10:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 062CF88456;
	Tue,  4 Jun 2024 12:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5JV5T5Xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CCF88456; Tue,  4 Jun 2024 12:21:06 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26BF8841E
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 12:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYoRgU8Z++TOPpSNtGRdKCEDqQBfrafyJ0sCXfIeok2fgqBqpDyhxqnl1ugkeFphFNytL08D6Yv+YabzYRFzgppNuuJDTFIsAVUw3IoDgy1vFcn/V5PQWfck4l+k945aFWL3+M/JUJPZvuVewk7qVjk/BBUvSVeADH91mRTU8Q3f+G8/fjYggfRyyumYwfe86y/EQhoAI39b02dAgHwfSk43OKo94BUfZsDPU81NWCycRfqvD1jv6gtGL+uAGIvuDCQTUcDJHp90sBpQ5y4EZUqIChTrfJwV6EtTL7oYXinbxgcqcjbicwaLIQlekfuKpS0gWcTqqqZ7nanESM0piQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjOHk/oCsOIakjZqn9n+gzlEHj/jD52tpwxBRxNb2Qw=;
 b=eKlL3Mug6GAjsFhhDJYQ0qbmq6cVyKrc6QUn7uhoARPU+vBwHLW1Wz5l7zOWUoc4bL/SksyqrxnlPLmRj1MF7z/9Q2hxcX+so9LBLpIUpE0raE/NdQVIuVHjTURT1GybBe2TIQlDFi1tgbcjR/eP45GXfUWb22tPjAgLuKyipCTxDxX083rUxq2KVZ1o1YXzFtB7k0liKWyz7zSwqk6rQEQjCcD5w6NTc7od+H3uVN58eMN8cho54VQcbkOamEUp0TOUlPUWBFvjzA8g+zWaY1YTiyHDcwDB4dC6yisGQtBqDauIDmV6uHUKSc26DSeGBGNvM7u/0QT6vGa3BePwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjOHk/oCsOIakjZqn9n+gzlEHj/jD52tpwxBRxNb2Qw=;
 b=5JV5T5XeiI3rUwvQBU2pHgIC9il8V5a4itvQnVvA8Mw1htbS5pKV36TZWCBXfjMT1DWU+rjj6V8+noWejRG8E8OHOP1Ts6nZVLVR0K3RsSL59PoSdro7C4HrKpg4UejI3Hc+Ur8s+CykliyXFrUC7j5MCq/4rJcnCU1OgOr9yU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 10:21:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Tue, 4 Jun 2024
 10:20:59 +0000
Message-ID: <7badb905-2d52-474f-85a2-4bd1cca08b25@amd.com>
Date: Tue, 4 Jun 2024 12:20:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xilinx: zynqmp: Enable reset_cpu() in SPL
To: Lukas Funke <lukas.funke-oss@weidmueller.com>, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
 <20240603133447.173402-3-lukas.funke-oss@weidmueller.com>
 <d0489c83-7225-4127-9ba6-e9b29165d2b5@amd.com>
 <efaa2184-d082-41c6-8e8f-682d60771e8d@weidmueller.com>
 <aa82531a-3629-497c-a442-1c3a2715ca51@amd.com>
 <c8e8f491-5ac4-4133-bfb9-9051542bd192@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <c8e8f491-5ac4-4133-bfb9-9051542bd192@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR02CA0067.eurprd02.prod.outlook.com
 (2603:10a6:802:14::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 828e9cf8-fe6a-4208-d3da-08dc84800781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDRIdUdFMGxBU1ZTSXduZWxISEFWY2J0bmh3TThxL2lxQlFhWlUxaDROeHQv?=
 =?utf-8?B?L25WdHVENDZ4NWI2Tm1sYTZlM2tLbWdBOVQzQ0ROQUJJbVFLTHZrUzcvNGZP?=
 =?utf-8?B?UXpKbUpzQ2hia0dQVTlGRXhUeGFxZjRWMGhNNTI4YW1yN0twdmdQY05aS1dE?=
 =?utf-8?B?eDNQVXBCTFo5eXVzY250RFdoaWNXT0NsMU1NS3BOUG0rZHhlMDNpWklOZHJI?=
 =?utf-8?B?M2pzeTllQ2d2NklqQzdacWhZdThaZDlETENqVlE5OVMzanNhdzRPb1FFRUd2?=
 =?utf-8?B?UkppMFlBVi9MbVo3SWFQWWtxdUdwUU1xdkpycnRsQVVsbFVRTk1zdFFLRzRS?=
 =?utf-8?B?RnR4d3dTRXhuVy9RNHlNZ1VGNFEwWFdZaXJmMmw0WUZCNmRFLzh5OUo1bHlL?=
 =?utf-8?B?ZmNDUmRZYzJDeHlKY2ZKU2w4LzViWlZJcytsVENxckMwYTgzUy9RWFpYQ05H?=
 =?utf-8?B?bzlsSlBKOXF6bFBsT2Y2MlZjNWhlU0xXbmxmRUV6SnhtUHhXQWpXZ1dLT0xR?=
 =?utf-8?B?c01tMGdjdkJDcDNXakdoejdzNmVJcUJHQWNsZVZNTkpNb2cyR3hJMnIvUldp?=
 =?utf-8?B?SzBJenRUMnlWbi9GQ1ZqQXU4b1dzSjM1NnQxNGcrNlhXaHNKaWxKb0NZSTg2?=
 =?utf-8?B?RG1tN1Vrc1M2ckx4V2tXRmRIODZVZk04ejhYUUFtSHZia2ppMEgyT0M1NmtH?=
 =?utf-8?B?RTY5RVNLSFFzMVd2UW5vSjhhQjFKSi9MVms3Y1VRR2p3eEVocVo2cTZpWlFX?=
 =?utf-8?B?ODFucDZwMktnWDB0bUp4bysvcFFOU2RpQ1VZSTZOUGNnVm00bnZUU2lId25C?=
 =?utf-8?B?WkdRUUpaVFRndXlKamQ2dXRQdk1ObEtSNjZRUW9ka0Y5ZzRkTGwvL1p2Q3Js?=
 =?utf-8?B?ck9TWS80OXJLVnVXZ1RJaEdJdm1IdUdMbkJZQ3lkellwVU00UU1aaG9wTHBV?=
 =?utf-8?B?bjV6OWRnK2Y4eWZwZW1LVm00SVZuSHhhY0pZQTRxVDd0bWtaclVySjk2bWY5?=
 =?utf-8?B?REd1bitQYTFZM1V5blV6TjNqOXFIUlljN2Y4ZWFPYWthSStOZHdvS3JsRkZ2?=
 =?utf-8?B?SlJCT2FKUmxmVy85SW9vclJpOFVhTEI1aU4wSlFOOUdUUGlCMyttait6YkVn?=
 =?utf-8?B?WXVDbDFZRW1XakdKbW53NFVlY0VwVjJPRENRV3VIazQrN2cxdjFjQTE3Z01F?=
 =?utf-8?B?bmx3Y00vYXBVelcrd1Y3bVpGYzJTdDhackE1M25wV2N4ZkZVdVI3UUNtMDhW?=
 =?utf-8?B?V1RrRk85VDBUSEYrcmRMVG90TmhNNkE1SzEwVXBxTTdBSGZrUTZRSGFpdjly?=
 =?utf-8?B?NVF3QUxvSHZwamUyaTJSZkxmNHBZUFpIYzVycFJCL2k5NFE0RmlXY0RzSnFz?=
 =?utf-8?B?dGtKdS91RHM1Z2JTRVZKSGVYSFcreUVINS81bXNUa3FScDA5KzdRQyszYnZv?=
 =?utf-8?B?VmQ5VlF0OUxPd2Q2YmU4YVYvNVJJZmxtM25uLy9yU2ZSVVBCdERLZUczMVJV?=
 =?utf-8?B?NXNzNTk4WVkrZGI5MjQ2RDVHZ2VmZmI1Ujh6SlcwR0dTUEdWR2NDczhsaEJx?=
 =?utf-8?B?Tk0vSUZOdTVkek5aWnJWcUsvdHZjZ1NPQ2ltMnB5c1A1bS9VRk5xa05pcTds?=
 =?utf-8?B?LzNjK1ZnL2Rxc21qYzMyS05sQkFWWVU3aXF4MXY4UDZuSmhEalNoNHZZbTNa?=
 =?utf-8?B?aWVBTG9Zb3FFODJlYUdrdzB2OGVjdG8xWXByT0FCSVVPajZhdFg3UGNkUFVE?=
 =?utf-8?Q?tRlUN3ji3N9EOCJerwrtMh5wxD/mbhJumYsRP8M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlpGeHFaNFpYM2pPWDF3dFhWeFc1WTIrUnROd2E2L1JPeXVPZGpwcFNMWDIy?=
 =?utf-8?B?RU84NmNlME5GNWFJaDRCa1pLNmdaOUFDWWMyUWJETFV4cWVDa05CU0tKNVNL?=
 =?utf-8?B?ZUdNSDlkU25iMTlVYVNNRHFpUTQ3VFJZY2lKNGYrMzdvS3BpNHpYL3RZclZ5?=
 =?utf-8?B?ME5LZVlKbFppUGdWbFRiYnJaT3NPUFA2TVRaTWR4ZWoxQmxEb2JTSzh6S25Q?=
 =?utf-8?B?QjFtT3IxTTJ6aDBZRFk3TUc2cWRjZll5aWlmbjVReDk0RXowWWFSRlFGZ2Zx?=
 =?utf-8?B?NjcrWW9ETzJsVnZPODhBWVp6VGJ4bXBSb05nK3pNTC9OeEtyR1Voa28wdU5F?=
 =?utf-8?B?RTJGSEtUVGtBaTVkdUNlNWFkM3Bqc1pHNE9BWVVHTE5vLzJHSHg3ZnFsWU1L?=
 =?utf-8?B?cTdEL01UbXVCZHJtMzFYUnAzQVEzY2ZKOTRNRTNlTHpmQ2RsWkM4a2p0OGk2?=
 =?utf-8?B?a3pXQm9QSkVkMFFEMVh5V0FJdE13dFJpTTlxN1Y4Q1RwVDJiNEUwSzlUdjRQ?=
 =?utf-8?B?aTI4YTFaU0JXY2dwdHlIYVArTWhuK1c4L1BSQTZmUWNHR0ZwOEpVVktwWjho?=
 =?utf-8?B?SmpncWZycDJLUnBjWVlwUGg1OVFnbHppT2RldDQvNmtBbklGR3ZFWmJxYnJY?=
 =?utf-8?B?NVd0Tm84dUhvTzdXUmFiTVFSVXJORnloNi91U0psa2gyWkRGMGUwdm5zTkpx?=
 =?utf-8?B?THdiWGg3dzNnOGdLVmwrTG5kUzhrVjVYVW5JZG56NnRQUVBPZFhHTTVqUVR5?=
 =?utf-8?B?MTlZWkNwUDh2VHB5V2E2Vll6a1owRGtxVk8wbGxpME0xTnBGd3ZVOWJlQVht?=
 =?utf-8?B?eURmVVJVSXE0bW5zUE5qK1UvYTdxcnlEY3RnMThmYUUwbURwTGg5MU1OVkZx?=
 =?utf-8?B?cTltNkpRNWxXM0pMUkVHSGlPWDdZamt2NFEza3ZiSUtUbjB4Q2xhOUZXQ095?=
 =?utf-8?B?aVlSa3FOQnNwSmNVQm85bTlWSm1TdStma2g0RHBydUc4Ukh2K2xlT3JEZC94?=
 =?utf-8?B?T3pNcHdNOWplSXpPT1hIZWN1aGloNlI5ZXN2T2xOOUFob1FpaGRVWkszUTlK?=
 =?utf-8?B?UjVhRnhFTmVuN0dKNGVNemErOFV0UkU5T3JwY1QvUGFidVJYYjBDd3NPL25R?=
 =?utf-8?B?UEE0eWVOTk9GMEEreXNWYUFSamVjMEJnSE5wSHN2eEdQS2YxTmZHZWZXMFMy?=
 =?utf-8?B?TE1HRUw5VDhIazRld3VyVFdiODJzSCtaTFpGZlNGdmJrMlNJbWFmUDNadkdL?=
 =?utf-8?B?SXZGYmlmVkkxTEY2SXh6NlFLdXlVQkhXQkt4QnIzTzluMW5PUUpFMDY4Zlht?=
 =?utf-8?B?VjltMSthOVkrdk9Gb09BWCtkMUlScGRFY0tCOFVZSnJvL25ZTVVubStsMktY?=
 =?utf-8?B?bVl5ZFV6NnB1dTRYN2p3T1pMWEJsS2pjcnI5cHpVOXArSm9FTnpzRDg1VURl?=
 =?utf-8?B?cFBmUHQvMm9Nanp3S2tud01Wc0R3bFNLMGU2SitTT1VvL0k5OUlyTEZVRXRR?=
 =?utf-8?B?blNpOVkzRm9sYlBiczlEWGJJcFpXV0JDQktUTVAxMi96bGR5U0pDMEd0S1A2?=
 =?utf-8?B?ZlNHdmdWWkdaeUIzd1J2QzhGM2VpLzZITDhtenh5a3I2OHZIOVF2U3VoeFd0?=
 =?utf-8?B?eGlWZ3pWL05XWWdJbnpNNFFBdld6ekhMVVRKNW04OE9GUDZnQm1IUk9YVXpB?=
 =?utf-8?B?MzltZzk4OElNQ0F1RzhVNW5QNkRCSFVYTEdPY3VRVm55RUZKSlNhbE9pNTFx?=
 =?utf-8?B?RmxsMTFDNEp5N2lvVFRaazY0V2Q4d0o4THBxZFdyY1hRN01Oekhya0NhTnN0?=
 =?utf-8?B?NGZTWjFDekhQSFBPdmFncnFMUkRub0hMb0o4VnpxbldxT1hpVlZVUGRGQzFu?=
 =?utf-8?B?MDNZMWhDWFlkM1pOLzk5YW40NzJNUU9NMXg1VTZkK09MRjJTMzR1M2t3TThC?=
 =?utf-8?B?OGRlMlVESld1QlRQNTZpTGZOV2RrY0dTNWtFdHY1Tk9zd1RNTmZRUS9qRjYz?=
 =?utf-8?B?OERYaFJYYlcrcEhoZFp3Z2hFcmZZVzVDSCtUSHhTb3J6TDhieTlLam9iRXNx?=
 =?utf-8?B?emI1VDFoQlpQYWlKMU43ditDQ2cvSktmMWlNU1EycjJSMEFodnYzUER1Z1k4?=
 =?utf-8?Q?yug3gg0DCDT3nyqAjr076UESi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828e9cf8-fe6a-4208-d3da-08dc84800781
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 10:20:59.8784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0W/LH9RjP9MpYbqC2VHTXTLxkWHN1kj9PtpgtGMQWLj3jqgV+8wt1RHHj7NWldx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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



On 6/4/24 11:12, Lukas Funke wrote:
> On 03.06.2024 17:08, Michal Simek wrote:
>>
>>
>> On 6/3/24 16:50, Lukas Funke wrote:
>>> On 03.06.2024 16:32, Michal Simek wrote:
>>>>
>>>>
>>>> On 6/3/24 15:34, lukas.funke-oss@weidmueller.com wrote:
>>>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>>>
>>>>> This commit enables SPL to reset the CPU via PMU-firmware. The usual
>>>>> reset mechanism requires bl31 to be loaded which may not be the case in
>>>>> SPL.
>>>>>
>>>>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>>>>> ---
>>>>>
>>>>>   board/xilinx/zynqmp/zynqmp.c | 9 +++++++++
>>>>>   1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
>>>>> index 95a134b972d..99f5c178c1d 100644
>>>>> --- a/board/xilinx/zynqmp/zynqmp.c
>>>>> +++ b/board/xilinx/zynqmp/zynqmp.c
>>>>> @@ -40,6 +40,7 @@
>>>>>   #include <linux/bitops.h>
>>>>>   #include <linux/delay.h>
>>>>>   #include <linux/sizes.h>
>>>>> +#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>>>>>   #include "../common/board.h"
>>>>>   #include "pm_cfg_obj.h"
>>>>> @@ -285,6 +286,14 @@ int dram_init(void)
>>>>>   #if !CONFIG_IS_ENABLED(SYSRESET)
>>>>>   void reset_cpu(void)
>>>>>   {
>>>>> +    if (!CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
>>>>> +        log_warning("reset failed: ZYNQMP_FIRMWARE disabled");
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    xilinx_pm_request(PM_RESET_ASSERT,
>>>>> +              ZYNQMP_PM_RESET_START + ZYNQMP_RESET_SOFT,
>>>>> +              PM_RESET_ACTION_ASSERT, 0, 0, NULL);
>>>>
>>>> If you disable ZYNQMP_FIRMWARE xilinx_pm_request() should fail.
>>>>
>>>> we should likely fix it in drivers/mmc/zynq_sdhci.c:114
>>>
>>> That's an odd place for a default implementation. I'd like to move the 
>>> functions to a common location but I've no idea where. That's probably why 
>>> the last developer moved it here. Any suggestions?
>>
>> static inline to include/zynqmp_firmware.h?
> 
> Sound like the right place.
> 
> Currently zynqmp is not buildable when disabling CONFIG_ZYNQMP_FIRMWARE. I'm not 
> sure if it even makes sense to disable it. Maybe this should be enforced!?
> 
> However, I'll drop the 1/2 patch and convert 'CONFIG_IS_ENABLED' to 'IS_ENABLED' 
> in v2 to get finish this series. Refactoring should be addressed in another series.

In past it was mandatory and then it was changed by this patch because mini 
u-boot configurations don't need it.

commit 71efd45a5fc70e29e391e0b57c700de8708ae6d9
Author:     Michal Simek <michal.simek@amd.com>
AuthorDate: Fri Jan 14 13:08:42 2022 +0100
Commit:     Michal Simek <michal.simek@amd.com>
CommitDate: Wed Jan 19 11:36:11 2022 +0100

     arm64: zynqmp: Change firmware dependency

     In case of mini U-Boot configurations there is no need to enable firmware
     driver which just consume space for nothing. That's why add an option to
     disable it.

     Signed-off-by: Michal Simek <michal.simek@xilinx.com>
     Link: 
https://lore.kernel.org/r/d439399160ff3374f2b39f54f7dd70fa8c8bfea0.1642162121.git.michal.simek@xilinx.com

Back to your question. Even if we skip mini u-boot cases there could be still 
value not to use firmware interface but it is not tested or used at this stage. 
But if you simply used fixed clocks it should be possible to use it.

That's why imply has been used not to force everybody to use it but also it is 
necessary to say that I don't want to block others to do it.

Thanks,
Michal
