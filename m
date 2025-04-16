Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7CEC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E430E82C96;
	Wed, 16 Apr 2025 13:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lYLIzzsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB51182CD6; Wed, 16 Apr 2025 13:34:26 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48EEF82BA2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFGH9SLtzu39Kx6cFuoeHy8ZYVbG6iz4Kw8tF+28SF11lJPTrV9+ybVT2XxdecGOjcprE3zPgK8nwirleAn1tDAu0ZNagpM59sCe9z7QzCvx8IHRt7FevwkUgW8T6hRMJV/yn/7WKL9uKifCkcmYxVwCB/jRtZjNW2aMe04Ku9sOA5ujRGZp/z63QXvvsydmSxN8SOqAqDE4pCW/oKbZYAWcRIyjk5RQnrteQj6vGD1cZiYheahDoAIL1gQa7rc9ZcL4wyyJH/oXcK2lbY9oLOrfADXN68O0ziJgNboXhJI9kgwoenKNhF+cpwofBeyFe0RxFhbKkMvN4a3E/Bm7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqUxB7q7pGEeqdO6a3bX4vrnSGx5uwZ3SPn0/r2WXe8=;
 b=ppYqg17C55jVWOyy1Digcow/gqueywU3baSPqgQCy+q7BwQ4o3qfjZ37brScEv8WaDqoofw0sAceibVKFttX8XLV3XxWi2Qq/4NhwcTSrboExR558NhqwdbMKM2Wi2jXVFK9iKhS5zM9e8ETprAg8HbTl4LlEqrU0BgyuEoLahH32fNtkZa37BE1KIvaA0fXA1xAUh3EG4I6MLy2wedsCB+fZY6L/1PW/JUnemI7byjXKjPj+vBLl49X5vwI6svtVsh2/8eqk0/q/rJL4efGmZ6CNtMAbDvwhdQ/U+suEls44Okk8s37DTTJ/lOAIRyWLKRMWgTAmdMgWNPJxfI+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqUxB7q7pGEeqdO6a3bX4vrnSGx5uwZ3SPn0/r2WXe8=;
 b=lYLIzzsc1jqxn+y7hzFE/kHxTU+JsVXiB6kKdXqWb6jY2hvDi9D8kZBRG6xAgNLhydW8+wZ88g5H9b4eeSk83VmkaZsYtEuj6GE1fcwoiOSIud3Bh9o5DgIdu15yfE9t8Ym2K7x5G8ezVur3AAYWYgIWtkcsa5HYjaFhd/td32Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 11:34:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:34:20 +0000
Message-ID: <c9814ca9-854c-490e-a370-f9aaf9f033df@amd.com>
Date: Wed, 16 Apr 2025 13:34:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: zynqmp: Use CONFIG_SPL_FS_LOAD_PAYLOAD_NAME in
 binman
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <0f037e62e2d8486c0f68f204b45705be9e996ba7.1744039048.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <0f037e62e2d8486c0f68f204b45705be9e996ba7.1744039048.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd6c91e-ec81-4e66-f8a2-08dd7cdaa0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkpYcG1DM29qUkRqQXFPYzNTek5oUSt5TXpNZ21JNHA5NTBiSU4reEJEcW54?=
 =?utf-8?B?UCsxUzZkeWVXKzBxdXZKZGlTaUhJd1U5TG0xUE56eWNJc0o4dktSeGVYYkhW?=
 =?utf-8?B?b0h5dFdnT1padWNzNWZ0d2wycmFLNWg2dEFROGFUOEsrSWVlRllJRXZWQmkx?=
 =?utf-8?B?UHdkMFNYbDZwd0FkQ2gvRUZhQ0dJbGJGYmlDRTl4cFA3S05nNE9SeG9Eenkw?=
 =?utf-8?B?ZUE5WTRSMWhrYkJ0UHV4Y3VzMEREWDN2SzNoV0FWSzNFa0dXQmF0QmxFTEQ5?=
 =?utf-8?B?eFVLajR3dyt6QWprK2p0VUwzS0lOR0xOaDVjd0x1L0ZDaUNHVllHQ1p3eUYz?=
 =?utf-8?B?UmJQaWpEVEZkVlRoRDFRU1NQSkdFNjRrSXl4bUw2NTNkYXBiRnBpK216V0pm?=
 =?utf-8?B?dW1FTU03QVlBZWJ4TmY1VjRlSWx3SnlvTHcwUGpONWd3QmdyWDUrVUZlM3Rw?=
 =?utf-8?B?Tk9ReWdOOTNnSkVLK1VCVmlBdkliV2xVSU9GVTQ5R0QwS3VyN1U2emtMMnJs?=
 =?utf-8?B?elhRTDI5MWl0aFpyYzM5TEN2Q1R2c0Y1T1RFMS92QTR0MXZxeVdqVko0UStj?=
 =?utf-8?B?VkVvcmM1a1V2VGE5bXU5cDY3dVF1QWlNUldTWlFsSHpOZ1poVVFnSGVDVCt3?=
 =?utf-8?B?am9ET2dPZ045K0RId2Z0a3FoWlVoczNiSjR3MEIvMlZlQlRaYjR2N2FXRWFX?=
 =?utf-8?B?TDNSdWF0alpMa1ZCZ0dPYzUrYkF1a3NLYXBLOWpUTUYydER5czgzSTFHb3Nu?=
 =?utf-8?B?ekx3aGlXQVM2N3JkNWM4UmFycVdpenVvb1IrTjlaRTBsajJ0Y2p2bkMyZGJh?=
 =?utf-8?B?bGxhT3c0ZGljTzEvenpiaGJ5S0dLRTlVUkpDeUowMFhidVY3cHN4YXBwS21M?=
 =?utf-8?B?M3BNTkF2K1lUSnN5RzdWOWlyc3IrV3V3UlZVRVQ0MEhPeTRZL3U5Yk0xQ2Qz?=
 =?utf-8?B?RDNMbklTdDdaT1JGb0RkVVNHWHZaZ0RQckMraVRvVGw5VjRjRnk2SlNXNzUz?=
 =?utf-8?B?UG9KUjIzd1ZXcXVFNStGZUp2Q2R4OHZDNVRidG40WEZoajkxK2NLZWw1ZUpj?=
 =?utf-8?B?Y2d1clJyZkV1SEVxbGljOE54OUorTWNkaWQ3MmhQUlU5Y1pQWjRDenQ3aTk1?=
 =?utf-8?B?SjhCbFFRT3JteHZZdTBQV3Mvc2o5U00yZWk5b2VFMjRtRld3OUwraG8wT0xT?=
 =?utf-8?B?ZndGNWdVYXJaL2hkTGhIRzRJQ3laOVhhYzJVTzRPR3NZU0tmYTV5UWQ3dytW?=
 =?utf-8?B?MFV5emowSW5zTVo3NUEvelpKRmY1OU5CRkg5YTFtbFRqL1d2cEFLcFZQbkhl?=
 =?utf-8?B?c00wTGhGNzhBMFdvQ3llSCtaMEg4WDhCUzNLaTVyMnVhbUs0THp3K09NOWEy?=
 =?utf-8?B?Z3o1d3lEQUNzNWVHV0Q4NHpkMkxiK2M1Z1NmR1IwZ3d4WWhlTk9ob0ZqcG05?=
 =?utf-8?B?RFhPU1hWWGRCVDlRU2UwUW1vR0xPQzhQdzI2MXI2ZTIwQlkzTEdvUDFkcysv?=
 =?utf-8?B?UW5Ibys0SnFlUktaNlNuNHlSWE9yOTFSdjhYRVNtMm85RFRXbVZodmVNRTZ6?=
 =?utf-8?B?djk0TUJacnNRTGoxRGFGNWVRZUpuak9na2hGMExtUHJCZnNORkhiMElyUTlo?=
 =?utf-8?B?R1puT0xja2xndnJjTmQ1ZGJvMjZHOGszSVordzFmblljcjY4dVAzZDd2bHJh?=
 =?utf-8?B?UTJrM3dDMHBTL2t5WGU5djZHOWRMSytxRjY4MzMvaDc3M3ZQQS9YS1RCL1hG?=
 =?utf-8?B?am0xdjY2K04vdnZOM3Z0S3lyV0tyWUJoajZYSU1lUkVFNGw1Q0lsQ2IrZFZL?=
 =?utf-8?B?SVF4QnFheU9xaU5SY3VQcjNrVEpPQmZlN25ZUEUwejFFYXdEd1JOaW9ocFdq?=
 =?utf-8?B?QnJUUjRiOUw1OXBneUIrZGMzbW4rdVA4eTd0Q0dYOUNKS21kTjV6aFNHT2dN?=
 =?utf-8?Q?mqCPI4zADzA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVpDUi9DOTIyT0M2eEVCVnRrWFNUR2d5V2tWNDBMOUxyRVpZMmpCY2F6VjNy?=
 =?utf-8?B?dmhkcDdtRG5Rd01KVmx0UFBtM0JTaGRKK0FwWnpzQzJUTEtpTXZmclV3b0Zy?=
 =?utf-8?B?amZ3bHRzWkxYSjdYSlZSckh6RnBuZmV4cFp6dWNjME5vcGg0R1o3REMreldF?=
 =?utf-8?B?YlFQTmFHcXhqNnlTcWt5RTNSSGRJZCsrSytudHZXYnVzWVJUWENKb015OWE1?=
 =?utf-8?B?MnlvaUlmaW5DUEtSOFVHV2IrOHhLMnhpSkliT3U4WjZzZ3FabU9ubU9NZ0xL?=
 =?utf-8?B?WGlUK0tydGtMNkpheHJEZEptNENQRGE4QmQ0ejM1amFSZ1dTcTJWTmtDMjhB?=
 =?utf-8?B?YU1udkVCT1hpSlBBb2VQSGpJSWtlZzVQbTQxVFNTaEJGWGJNNFdkWU9BQjNq?=
 =?utf-8?B?dXFtMCtSeFNIRWhXTzBWZlE3VVo0TzByTjlvWmZVc2RaeWNqa2NkN3JCSDZm?=
 =?utf-8?B?enR6SVlrNnpON0J0cTVOVVFxV05KS1hwdnFSVERBWGRtZWI0cmgxbzMrNkg2?=
 =?utf-8?B?TVNTVHZZSmlQdzROZDdtblpuREN0c1F1eEMzMmtpNVpQZkhXWm9WQmtIS29E?=
 =?utf-8?B?K1pzdk1PYnlnODh6T1BIQ0N1Qkg4WCtjZkQ0VWdzT3JBeFJiaXNlamI1eVY5?=
 =?utf-8?B?Ym9TZEVoMytjdUpKVkNIWEFZUWl5ZnZlQ1FGWTFGZ2N1WWhkRlUwaURXaitL?=
 =?utf-8?B?dFJBUWZpZVYxL09SR3A1MTJwSVEzSy9ySjlmTTRHWlp0K1kyR3NYZ3NOZHBE?=
 =?utf-8?B?ZHp5bDhmVUY3OXRkeS84RFY0OGtaUjBhRVp3WWtyVzNDcXY4ZnNhMm9oNEJW?=
 =?utf-8?B?cnNmTzFYNHRQVDNNWkFpNE5IMUQzOWliZWFaeDJuZTVuZGhQczJtSm9vWHdK?=
 =?utf-8?B?Mm1LMnV3clpWYURSOHNZT3NUSGwrRHFoQVdKNVJDZjNETWdZbVJFa0x0dlVW?=
 =?utf-8?B?bzE0TGFJbWtBNDlHcW5uSTRwd2dPRHJpL3ZGanJBTXA1ZGxhS3hubldkUm9S?=
 =?utf-8?B?YWRCeTJHdERzOXJaQXFYT1JFTzgzQ0U5c2lrcS9kQnBYa21aL1A4ZVRnZGIw?=
 =?utf-8?B?Y0c1N2RtVFJaRlFCU1FySW84ZFFWNW9aL1h1K3hEaU1RcXVMcTRMRlFFSGFw?=
 =?utf-8?B?aUZTbDQ5cHN1OWxORFZIQjNQYUFGSjl3OVU1Q2ZNT0VmaExobkhPVFdFUFp1?=
 =?utf-8?B?SjlCYXhFUlRuc1NRUVFUb2ZHU1ZPUFJLL25HNnlEKzBya0pxcWFoSkttOUJo?=
 =?utf-8?B?TmRFalFjbkJwazVYd1RpLzZ6T2lBdVhrSDhmNVRzYWs3OC9NSHVSc2N3NGM5?=
 =?utf-8?B?ZjhOYVdPejdMQjJJNEg5bmZjZ0ZDS0JZVkFpTDZzbWZkY3BaN0tGSENHVXp3?=
 =?utf-8?B?M2hvV2lDczIvVWhIZGsxQ3JpMnRDMU9DYzdjZVFva2hpd204UEpRM05YTTZm?=
 =?utf-8?B?c0s0a2ZOQk1UN3U0U0t5RGxVR0NtNi8rM0J6dWhhUGlIbFBzTWxkNk5rVVVL?=
 =?utf-8?B?VUd1S0h0QmpNaEkyOVlZaG5tL0FieTRVWUZwVERaeVdGeitMMkJEakVsMkVI?=
 =?utf-8?B?YnlwK1lFWTgrZDd5ejJCYnZMR0swTE9pVGoySTFqdm1aUC9DckhxVU5pZU96?=
 =?utf-8?B?TzFOTGs0MGUwNkFrTW5qNVcydVNKaDM5VFpDZFBQUWpBVk5RcTM0c1loM1Zq?=
 =?utf-8?B?RkIxMEdacDFvVkdEdmdEM1gvWnBucTZybzJzcHpoQ3JxZnEwamZiMmswMGRT?=
 =?utf-8?B?MVlKeEFZb1JNQXFEUUcyWVZzcHpjcnFObkV2Um1SdXhncGxOckpsd29QTnIv?=
 =?utf-8?B?U01GRXNhQmVtQW1IaTBUelFlR2g5RXNRR1Axa3doMmJZUGhlbWZpbnA1UFhn?=
 =?utf-8?B?dWpFWm5XWjdRM2hFdWtxazJSYlM3YzBXajNMUmVZbGpndktPRzBHemlneFZv?=
 =?utf-8?B?NDB5bjJ3T1d1VTlaWkZ0eE5Fam9acUdvV0dhbGlGR0RaNGd0RzBRcCtwcDcy?=
 =?utf-8?B?NTMrcU13Si9DeXl5TzhKajNqczJDT0xjQkpPUEliN0d5Si9pcDZ4Ti9oV0Fk?=
 =?utf-8?B?c3ZKVzNCSytQcG1YeE1sOGtRRVpFUWJDdWUxNjBZMjF3RVc3d0xBVWFEMWFN?=
 =?utf-8?Q?NtOOV7zqN63dtqnq+27ppY7Y5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd6c91e-ec81-4e66-f8a2-08dd7cdaa0e3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:34:20.4564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Led6sFPo7fdHjr7v0/GIKZGGG8ALmMVD6iCc01bRjXFSX3OVsP9D8ea/CgfcjwGX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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



On 4/7/25 17:17, Michal Simek wrote:
> u-boot.itb name is coming via CONFIG_SPL_FS_LOAD_PAYLOAD_NAME and it's
> change will affect SD boot mode that's why start to use it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Also support image generation when FS support is disabled based
>    on discussion with Quentin Schulz <quentin.schulz@cherry.de>
> 
>   arch/arm/dts/zynqmp-binman-som.dts | 14 ++++++++++----
>   arch/arm/dts/zynqmp-binman.dts     | 14 ++++++++++----
>   2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
> index d5b63ef604ba..a70123feeadd 100644
> --- a/arch/arm/dts/zynqmp-binman-som.dts
> +++ b/arch/arm/dts/zynqmp-binman-som.dts
> @@ -2,13 +2,19 @@
>   /*
>    * dts file for Xilinx ZynqMP SOMs (k24/k26)
>    *
> - * (C) Copyright 2024, Advanced Micro Devices, Inc.
> + * (C) Copyright 2024-2025, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
>   
>   #include <config.h>
>   
> +#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
> +#define U_BOOT_ITB_FILENAME	CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> +#else
> +#define U_BOOT_ITB_FILENAME	"u-boot.itb"
> +#endif
> +
>   /dts-v1/;
>   / {
>   	binman: binman {
> @@ -103,9 +109,9 @@
>   			};
>   		};
>   
> -		/* u-boot.itb generation in a static way */
> +		/* Generation in a static way */
>   		itb {
> -			filename = "u-boot.itb";
> +			filename = U_BOOT_ITB_FILENAME;
>   			pad-byte = <0>;
>   
>   			fit {
> @@ -227,7 +233,7 @@
>   			};
>   			blob-ext@2 {
>   				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> -				filename = "u-boot.itb";
> +				filename = U_BOOT_ITB_FILENAME;
>   			};
>   			fdtmap {
>   			};
> diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
> index 252c2ad552b0..59c1388fb1d0 100644
> --- a/arch/arm/dts/zynqmp-binman.dts
> +++ b/arch/arm/dts/zynqmp-binman.dts
> @@ -2,22 +2,28 @@
>   /*
>    * dts file for Xilinx ZynqMP platforms
>    *
> - * (C) Copyright 2024, Advanced Micro Devices, Inc.
> + * (C) Copyright 2024-2025, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
>   
>   #include <config.h>
>   
> +#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
> +#define U_BOOT_ITB_FILENAME	CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> +#else
> +#define U_BOOT_ITB_FILENAME	"u-boot.itb"
> +#endif
> +
>   /dts-v1/;
>   / {
>   	binman: binman {
>   		multiple-images;
>   
>   #ifdef CONFIG_SPL
> -		/* u-boot.itb generation in a static way */
> +		/* Generation in a static way */
>   		itb {
> -			filename = "u-boot.itb";
> +			filename = U_BOOT_ITB_FILENAME;
>   			pad-byte = <0>;
>   
>   			fit {
> @@ -196,7 +202,7 @@
>   			};
>   			blob-ext@2 {
>   				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> -				filename = "u-boot.itb";
> +				filename = U_BOOT_ITB_FILENAME;
>   			};
>   			fdtmap {
>   			};

Applied.
M
