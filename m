Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EBFD69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6FFA89CE7;
	Thu, 28 Nov 2024 15:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ag8Mp8Eo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B78891F5; Thu, 28 Nov 2024 15:53:33 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B5989D4B
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0gjNCNOp1jC31YVsuT0Bf1u3AuhD5FPpbF5ZB4al/OD2/uN9FoY7u9IQuoh5V3J+cBGc3aIKBjp4QJBnc6bOQW85N03yAV+GjyBToRjy6Uzn6EjYdiS8+aXmAOtJ2fFTB2XQABjUX3LvQzo2H5NRaJrLG87mtGXpkkQOXXDJGHbsBQQe/O2CataAtlDssG7X93ypdU1ZeAF7OYxbrwwO/yghRAc0zNkYFkohVeP6gGTZwjiiKBRynDRSqTx9pupAIGRSl0D2buFv4OMW1t74A5/js7STtXFDrwn68ldNLiC/iYzRmbZolzZQ5G3PCq9UDakUf02l7JBbWOYtysj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QI6HQ06Z/Vk0p82MTWciD0VvT9YFQsdj9KmjvnwjoY=;
 b=hzujD8fH8aPLyCY2+LH6Ya58B1c3+xOqtgR3HQXrD15z7DzjtZg0xy/dKStnAIKSJfYobqfUBKWdsKaTv66Zy/6tMDDyZGUMXVXduwEp6NwgpOUnGzdIQHvAumaus6OlwyVme42KjzXRfBqfhVIu6c4AVFxnB300ZPT6l8X+GBvPwarGqa/tC9hfrPxdJHlfPcKD3zfgTHg7tQvgQiVi+1C+AbxH0VV2uKg1A1fu6lZylDqP8ahJ60+GETRa3bxKa2/1heEdKnBVfphFi52BS9uRYB0RKPM9J0icXTqJYRN/Qv2DZN9YtweYvfOmGglpdySkW28sSNfHGdJ4xLmT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QI6HQ06Z/Vk0p82MTWciD0VvT9YFQsdj9KmjvnwjoY=;
 b=ag8Mp8Eojvo4uJbccoxe03op98mQlw0b/ThZNK1BytGbedgiZBREOA+0aKjEWOn6nXYdc7RTSw1P2SDvFO0eXGC+zBHKUGkGSOr7We3kDqkZ26LbDCAyX5N9Q6TmV3409/1SpZGF2RUwG/SDNAbnU/RqDOHKSa72tONlfIKzcpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 14:53:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 14:53:26 +0000
Message-ID: <d2ac7abb-a5e6-4088-9e1e-c4d18c24d173@amd.com>
Date: Thu, 28 Nov 2024 15:53:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Update the usb5744 hub node as per binding
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20241126041600.1972942-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241126041600.1972942-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0131.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a110c13-2d7d-4374-3e30-08dd0fbc69f4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFVOdnhtcFRoQkFJNk4wSER0Y3N6RStIRjlGQS9sL2R2U1E0RUl5L1dBUVRh?=
 =?utf-8?B?bDIxcHBNMGVNSTlMVktaTXBFQ3ozTEtYVkxIQi9IM1Qvd2kvckNHa1BUeUYw?=
 =?utf-8?B?ai9XTkRSaXovaVlLS0laZnE2eVlmNXRHc05iVVp5dTBXT0VKOTZOQ3NzcVdn?=
 =?utf-8?B?K1F5Q3VoN2o3dFFKWE1SYlBrWnFtMzV2WU5hZ1pwTW8zbVhqUWpIY0h1akFs?=
 =?utf-8?B?aUt2SWo0Nm5pZWJqVDlqQldWRFphUVRVa3ZVZTZkREFDUE5FdktTMHdGdGwz?=
 =?utf-8?B?YThEMHZDZHRTTUdNSmJqQmc0MVFEams2UFdhcGdCN1M4RVhwbXBOK1A4SHE0?=
 =?utf-8?B?Q2s1WHFhMVdla0xVeXhLNm5EQWFURnJhN1RhajhZTW1qd1hDeFhiYXBnMVJo?=
 =?utf-8?B?a3VDTU4vNzh5NGdQN01DNzhsOTZFYVpXSmxDM1BibGJvcEp4TmowRDYzV3FE?=
 =?utf-8?B?NWNwOTdaZm1mM1pmUE1wQ1R1Z3BRaUdWd09QRHZKT2NDNkxucmkrN2xwMGpu?=
 =?utf-8?B?V3NMMUxUcndUWUo2dkNZdXVtcFpOTzYxQUZhTVQxRW1PTEd3TzVwcm14UlBF?=
 =?utf-8?B?RGhienBoVXNNT2JYN2RGbnFnaVZzcTdpNWNHSXY4Z3c5bUZiUXF6ODU2azdM?=
 =?utf-8?B?eCtBSGlJVmhBWTlSVXRZdkxrY1lFYjIxUVZqZndnTlVPVVhGSzY1NEN6TTk4?=
 =?utf-8?B?YkNoTHRzQWdMZWdyTUc0R1JwV0tGQ3o3VzFvUlZZMzNocFd1ZjkydHU4VWIw?=
 =?utf-8?B?UEdqaXRTTkVpZDNHOXQyVUQ2ZWxELzJTZVlMOFErTUxIOFpBU2JDSFBuZGxI?=
 =?utf-8?B?ZnZTUWljQ2ZFUzRoVThMREpIVkdUUUxuclJwcWljMjZZeEk3OVJ3bE9GWEEv?=
 =?utf-8?B?NFgrV1QxUXh0L3pjT284eTBRMTd4WitzbnB3ZlNtaXlkZ3BkeVhEalE3R3NU?=
 =?utf-8?B?aEp3MkN1eUphaFkzUXpLMFIxeXhXRCs4blNZd2RxTks2b2Z0RUhFV0tNQllP?=
 =?utf-8?B?UW9VdEFqVW5VOGJRWWZ5VmF0d1gxTGt1WWtTVzdhWWU5Z2YvVTNqSFF3aGhJ?=
 =?utf-8?B?M3pFRkFrM0JKTWtndXJwMUJpRGF5OFFBVGFSejhXZ3hpa28va1VSVi9MUGI1?=
 =?utf-8?B?aWVyQW8yNTRjNU5NT3NHZERNcjQ4bGZGZmdhcFh2S21kOFAzS3JjZjlIa2FQ?=
 =?utf-8?B?VVQ3QVVKTmxNbytNMm1iNVVmR2ZsblM5ekNQYWxxSXJ1YU5oWStMRWpsYkV1?=
 =?utf-8?B?Zk9CaE1QY2NuTEgwbzBTR3hKK052SDRkQTJsMkc0cW9peVk0bHMwdElCelhL?=
 =?utf-8?B?WVNyRTFmUHQ4Q1NYSmNSUWdyQkJ5UlU2cGxpRnFZUXFUNzVob0ZhM1ZxVDhS?=
 =?utf-8?B?emhkb2R4YnAzRjFRbkFmR3lwZGV5V0xMU1M0WHdEcmEwamdkZW9IUG13YVFY?=
 =?utf-8?B?THNaczBhT1hVQUVBQ3dVdlUwYzVqY3NDd0w1VlJsOUtpTkxsTEtpczJhMm9F?=
 =?utf-8?B?aXQ1RGp5Vi83VXpyWFo5RnpFL3VFUFJhZ0pMS1dJRjJ4U3FhcnlzeTdaZ3g3?=
 =?utf-8?B?NDJJRUhEZ0FqZytaaWc5SXpHcTlxZmNMVVBXRGl3NWVtR0xaSWlLUUpwdGUx?=
 =?utf-8?B?ZmUzRm16RjFhV0RXWUNlSmxsZXRrTU0xc1R5aS9IMzBSbXI3ZVJzUnhzQU9p?=
 =?utf-8?B?bkJCckpGK3UwaDM3aXZmd2tmVTBuR0V3c2E4Wld3QnRKeWNiWFJFdjB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RERGbjZ2MGduSjIwRWFiRHlYRmVlUHdFbUZ4ZFE3cmZESnd2bGFpZDAzR1dM?=
 =?utf-8?B?cjVHZElRUUpKWWhLSlduKytpcFR6akJPRjNGZUhSWHUrRzQ5aTNRSFFUSjNh?=
 =?utf-8?B?ZmRmUWRwakZRUmtrcUgvR0FkdDJhangrN25ERmc1SHpUdjZ5R2o1ZG1vZEdr?=
 =?utf-8?B?TlBEZ2VnekdISGFjUW5wNy9yMlJMZkRnQlBtRHd3U3BVTExXdHRvWWplOTNz?=
 =?utf-8?B?U0FFVjZVblVwekEvbllDZUhHREVZRFQvaEY1dFZ4UDlPR1o4MU9GaVA5d3Y2?=
 =?utf-8?B?VVNwYUpkMm1FRUR3SVVjbFAzb2l6QkVtbFFTRDZhMzJnZVVxME4ySUszaXI3?=
 =?utf-8?B?M2IvTGljQk51YTd2Rm45OS9uaFRwNGlxY280Mm9xVW04UEQxeXhCUzRSd29K?=
 =?utf-8?B?U3BUb2pmUGZPUURmdU9HWUFTVUs2QnR2RGxxNGRaeTI0bWNjYldMOXBrR2tO?=
 =?utf-8?B?NjVQeFAxeUZwa3RObFdiWHlld1pQUEpaRGxmWm9VanRQRHFVV1V3TFBBcCts?=
 =?utf-8?B?eXJWdS82cHRac0owRVlBVkg5anNpQkV0c3FqRG53dHFjcGM4Y2NzV0U3aXI2?=
 =?utf-8?B?eGE4RC94bmxoQTc2bmxyLytmMG5BVDErWmJJWVplLzZjbnVpdVk4Zk83cDhh?=
 =?utf-8?B?dEVQcXV6cE5kR2E2T1A3MFlsbnRpaUZvS20ydnltM0R3NWpxZGloeHQ5U0N0?=
 =?utf-8?B?NDNiUHp0cXNkT0V4Sm5oRnNLZEpjMUJiU01VRTVjWndOOWxJY240WGtIUDBt?=
 =?utf-8?B?T2h2MnZoUUxiWkNHbEdhWFZxVDhVNUhCN2NSSWNmbGp6aFc4T2tpd2phY3NK?=
 =?utf-8?B?cGN1L1pISlh3NGFOLzlTOGo5TXplTnJIRndQT3M2TmN0M1RRQXlZeDZrN0V3?=
 =?utf-8?B?UjV1Q1BPR1JHOXR6KzIxenlTcUY4dXBmaTFFZ1llaXZ0RVBpbDN1RkJRa1d6?=
 =?utf-8?B?R0hRSXdhOXBpTVdNbjNzamNHcDlRVTBNc0lmM2tYbE1lVjhkenIreDlQR1Uy?=
 =?utf-8?B?YUlxbTFNajF5NjZteEdRRUU3NzZ1QW4zNFdpekRVdC9Oa0ZFdzJPN09yYkY5?=
 =?utf-8?B?d3lnOVN1WlpqUnZocUtuSXltbmRNK01HZ0V2NVlab2dBQmFtYlZjRWNaKzQr?=
 =?utf-8?B?T2tWNmZLOTRrNy9TbWFkYWZkNGZGTUdrYUpMb3JTUTZFdjF6ZS9Yc1c2TW15?=
 =?utf-8?B?dWprVTRSc2Z2Q2JGTTlNelJHTGE3S1MxR0dWYzNZTWE4czVEMlpBQjJoQUcv?=
 =?utf-8?B?a202QUdyWHBtRjJaYUNzMmdNb3pGSTN6R0p1MjJkSktIeHFuQnJqSk5salIy?=
 =?utf-8?B?SC9HTm5sYUQ4YkVQTGxXaEcvM3g4ekM2V29pSjZmelRTVjF6RkZWL2tHK1JD?=
 =?utf-8?B?dkNsbXYrb09iUWJOVDhrR1BwcGRPaS9WdmxMaDVCVisvRVFlTEo0eFk3Nlg0?=
 =?utf-8?B?Q21LT3dwQlh6bndzR3ZiK2RzRnA3dkNJVWYwSExrU0pPdFQreFFudGVWS3pB?=
 =?utf-8?B?SmNWL1M3UTl5ZWY5ZWMrMnl6YjN4RTZENnRxL0thczNaanNwdmJsMUFMaVp2?=
 =?utf-8?B?ckZ2NlU1TEhTd0tiQ3RQQm1nY1pFcC9yZDE4Vk1MdnJ1Ly9iQTRETS9FQnk0?=
 =?utf-8?B?N1JoMFlEOGk5NGVRWWd3aWdUSjE3TFh3QnpPL0Q0SkY2MEs4cFdaSWFwTHFx?=
 =?utf-8?B?VUlETm1NNnVPaFZRNk5GZ2s4QWlBeHozNk14SHExNXlXTEs4ME9xTjhtUEVM?=
 =?utf-8?B?NXR3Z1hEMC9qZmpJOUowS0Z6MS9NTnplZmpZWHl0VjBYaDFndWVRRnlNdTNl?=
 =?utf-8?B?bms1TE8wdE1kYWJOSUZMV0ZaRWp0ZmZCcDlFU1NtbHV1WTM0U2hmcEVEUzM2?=
 =?utf-8?B?VDVtWmRsY3d1SjdsZy9tMnZmQy9GSWo0QTRRS1NRZEdBWWJqbjlYM1hIMCtC?=
 =?utf-8?B?S0htM2gxTHBYd3pxZU5PK240bHo4QlQwVDI3MjUyeVJyMXhBcitoZVEyT0pU?=
 =?utf-8?B?T3FqOW1TOGRjdmkzQk5rT2VsYmFEUlE2WkJrek9acitMbEhGd3MzZ3ZDV3oy?=
 =?utf-8?B?Y2FNMi9yZ21PWGhqNkVZVm5Nb2NMT3p0dXpweFA5ODJpQXFvOGd2N2VMM3Vh?=
 =?utf-8?Q?kaM07Uq5ZVLEfeiiLR6pyZ64E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a110c13-2d7d-4374-3e30-08dd0fbc69f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:53:26.6277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSP7xV2EStE4MZpx2iWeqpTMgFpizOM1D74kH6p+drQ8uB00jk1niJSOlNend257
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
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



On 11/26/24 05:16, Venkatesh Yadav Abbarapu wrote:
> Updating the usb5744 hub node as per the latest upstream DT binding
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> tree/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml?h=v6.8.8
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Acked-by: Michal Simek <michal.simek@amd.com>
> ---
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 48 ++++++++++++++++++++++++++
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 48 ++++++++++++++++++++++++++
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 18 ++++++++++
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 25 +++++++++++++-
>   4 files changed, 138 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index 6349a0e108..e40840acb8 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -105,11 +105,19 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <0>;
> +			hub_1: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		usbhub_i2c1: i2c@1 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <1>;
> +			hub_2: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		/* Bus 2/3 are not connected */
>   	};
> @@ -164,6 +172,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &usb1 { /* mio64 - mio75 */
> @@ -188,6 +216,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub1_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub1_3_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub1_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub1_2_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &gem0 { /* mdio mio50/51 */
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index b0d737d3ca..ce1ad2b765 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -117,11 +117,19 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <0>;
> +			hub_1: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		usbhub_i2c1: i2c@1 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <1>;
> +			hub_2: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		/* Bus 2/3 are not connected */
>   	};
> @@ -184,6 +192,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &usb1 { /* mio64 - mio75 */
> @@ -209,6 +237,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub1_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub1_3_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub1_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub1_2_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &gem0 { /* mdio mio50/51 */
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index 561b546e37..0ef0357bd2 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -142,6 +142,24 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &sdhci1 { /* on CC with tuned parameters */
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index 64683e0ccb..92d8851eb8 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -92,7 +92,10 @@
>   		label = "ina260-u14";
>   		reg = <0x40>;
>   	};
> -	/* u43 - 0x2d - USB hub */
> +	hub: usb-hub@2d {
> +		compatible = "microchip,usb5744";
> +		reg = <0x2d>;
> +	};
>   	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
>   };
>   
> @@ -146,6 +149,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&hub>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&hub>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &sdhci1 { /* on CC with tuned parameters */

Please also fix kd240 and there are also some #if 0 which should be removed by 
this patch too.

Thanks,
Michal

