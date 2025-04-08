Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0579C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 08:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F6A82FAA;
	Tue,  8 Apr 2025 10:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FOEIviy5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A621982FBC; Tue,  8 Apr 2025 10:17:53 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6139482F5A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 10:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HePv1tUjGNBnZexPwSmhmfyowa/wZXo9nwz4HMOFrqWa6IB5z2MDqkK+KntFIAQFBv5cX3960jhSWF3Ty1soOIh8OpV4NVRWMJkyBd5sF3DUSRiP0Ryakg1VZkM1YTD+LgoOZOgkTkr8NnPTd0hkNHAdTpiUzzBU3D+SDIOo9QaLNHfdLldRCGHnyioO8/VStoM/B6bhyw1fHkOMlvEAwsXH4P143am+gNY+LsSEtYJcUJL7JVhsEVzec8LpGY4Fp4M8DFAy02gnu0a/KQvdyOioAsr9aB0KAYgvkzbnZE+pNH4VPUrNj6gfxOIpledy6TQpkE7hsqbryxVMr0fo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+6hsgvHeOfkDj7j/j63blAvIWs/Tu6P1oivRgR3L6U=;
 b=hSZg4QNrEc4d7nf4pqDl2rypZgwXPyCeb11rBBxW+Gwi3D9MO2sYpxvNUdiGFX4y5ZFIibxGSxOzxttfb/Qkgp+daYteuzJiqc/CaVb6b13LpIWTEfZvz5tKYNvOytr25sALLJXn06Ye9hVX32H0CjwJomulumC1Shsp6MG1GVH2wt1X4R5B7CGvkvAPROxf7LwL4dRf+LOd4yAebr/riyIUA+qgWeXUtSjYJJQ6V8vzkqM7XSgzKtwzTDiET7McdgDKBg5L6sPgLCPzhmgTBXzKnmRjiLSEeojjqNaP6OxexUXTYyN52B0Vzd0FbN3aDA8m0v6VptTrTjTABr6T/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+6hsgvHeOfkDj7j/j63blAvIWs/Tu6P1oivRgR3L6U=;
 b=FOEIviy56JwDX7OrVOdVpBJ2NTwtBUFweUTYwvSBEYOpQ7hgO3QkodO9yH+xJ9fwRDA2VcXlCyAxgP2CC3yNN2Nmz82Xl2zrOKaVNfIaW8KQPjZDICw2QEd47Hr8vlcPC4Yw6oy1707qvYZyNBKD22CCnUYecurdMp0jkqbLaaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 08:17:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 08:17:45 +0000
Message-ID: <64b86a7b-f360-4064-97d3-65aaae79a35f@amd.com>
Date: Tue, 8 Apr 2025 10:17:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] loadpdi related code changes.
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
References: <20250327105200.1262615-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250327105200.1262615-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 3365134a-928e-4a9e-7f65-08dd7675d791
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU5rOXFJZmFSTUxCaW1NV2JHdkJJTDVJVWF3ayszWGtiaG1Hb2tqZkRPY0hD?=
 =?utf-8?B?WWQzZUpDZ0JBeG9xenNYTFJhRS90QUpKUzg3d3M2R3hEd2dDSGVKSk95T21q?=
 =?utf-8?B?cGpwNUFteVZ1cFo2cXNXUlFzWGVmZkRyMUZXUkczUjRqeDZrNld3bm9FcWlP?=
 =?utf-8?B?MnRwOVFpYmhmc2cyc3dhUWNQdmcwT2dKNk5ySTQwcGxORld1MmFYMm14WG5Y?=
 =?utf-8?B?MFNFYStEaUcyL1VtTWVuWVVaVnJ5MVI4bjIvVGttU3lwZFd4Rm85WVhYd3hL?=
 =?utf-8?B?OXE1Q3R3MFFZZlNNMFFzR1QyeFZMelpYRDYxNDI4QkRQZERWWEpEaXNmdVZF?=
 =?utf-8?B?WGpCYWdqcVJ2RHJBVjVrVTNMcTNVaDhGUFZUSDVrQW95L1ZZZlJteDFUR0ZO?=
 =?utf-8?B?U2VoVnZYNFBKR2Y0WmZiNFZvWXR1NWxrSkV0MW9qNndSMjJSUlhEWFdVN2Mw?=
 =?utf-8?B?ZTgwK3o4dVlDZHhZZ29LbitHZW0ySGVRbGNOVmttbCthRlZkZU5pZGl4OXBW?=
 =?utf-8?B?UWVBUDJLZTFSa01aYlZIaHhNSUJPV2Y4UWx3ZU5XRXZ1R0VkYW5FTHhzZ09X?=
 =?utf-8?B?Zk5rcEdRZDI1OGtWcm5Cc0Z0clp6TFkrSG5IdW5KQTdpdmZ1MDhITG1xbjJr?=
 =?utf-8?B?bnM5YWJqZ3NILzcxdVUrWkg4aFl6YkQxUDdoMHRYTitmQitkYmtNRXFDWEZk?=
 =?utf-8?B?QlBVSDRzSnVKeCtzQXlmclhGRG84TjVuZzFrYWd6V0F0TkNWclN1eGFWSEFr?=
 =?utf-8?B?a3JEMEN0MG5SNkFUM1FhV3R5UitvbVRldDhMYXZtYndxbzhHSnMwZmFZa2Mr?=
 =?utf-8?B?MzNub2wrRlpiUkliYTNHS0hHMloyVzFvK0pZbUdrRHk4RlhSOENPNG1JNUFW?=
 =?utf-8?B?SjRnSEpoa1JGenB3VmFLL0JIdlBxTHBMWG93bm02c1Y4a1pOWWpHa1dEV0xm?=
 =?utf-8?B?S1YveXNxeXZ2dnhTSGV4cmV2Y1ZucWRvNlY2eGFrRzNmTHNQZDRWZ0VUeXVl?=
 =?utf-8?B?NE9LWEJ3NGlDTjdZY1FWUVJ5RERxcGFrem9hUGN6cHBQcWpXRlRsN21wM2hD?=
 =?utf-8?B?bFl1TWpDM0pReGxpOE95dEo1bWI5LzlDZnBGM0s0N1lhYWsyeXk5REJ3S1hh?=
 =?utf-8?B?MkIramFCR0psajlTUGE4cHVhOVpZRTRsZDJBd1N5ZU1pVEU1YmhJZW9Ma1ps?=
 =?utf-8?B?SDNnL2Jtb2xzVzk1TldmYVlpZzlpd0FMd25hMGx1MzRBT1pMTXphc21kSU9P?=
 =?utf-8?B?OEJLM016cDVpTnFDbllyOExxUCsySms3S2d0cUdld2JsM2RDM01LVTN1ekN2?=
 =?utf-8?B?eGU1blF4cVl6bVh4N2hUK3hUS00wMzQvdVFiQXVkK3ZnMWlSem9Vamd1NCtk?=
 =?utf-8?B?NnJ6YUlKUlVVajdOK2FyWS9yR2xtR21MaU96bkdTZXFoMlUxL2VmRHNWc2V6?=
 =?utf-8?B?Y2d4Ylg0YlFyY3JMOHQrWXhLTzNDZDRBYTU5VDV6SEhaK2MrQThjSUl6YXhJ?=
 =?utf-8?B?ak1nTHBRclY5UllicjBvb1FRUGQ4dmIxcTYyWTJ1Z3VjaDlsOG9nVzhKOTFq?=
 =?utf-8?B?M1FBdWRvSWYxYWtoZWdNQlRDNUxUdytkQ3FVblE3d0lZM3d2WVpieXN5elBB?=
 =?utf-8?B?eFNjYjcvbEhGQnRBaFZxOExvKzkxbm5Qak5iTXlWcExISXR6bWV1c1piUHM0?=
 =?utf-8?B?MVJuRWE3RjdySTF1aTVNNXlFeFFFVGdjcUxDbVpBRDlJUngzY015c1ZWaTQz?=
 =?utf-8?B?ZzZFUlh2Y2lDcWZWNzJUcGxwMDJIODlGRlg2eUxIZm5tem5iaHU2THRvQ3Vh?=
 =?utf-8?B?aWY5ZnZjTDhWTG5vckRSRmFMYnVxUDMxU2lJOUNudlc2cFZVVW0xcHMzL0NS?=
 =?utf-8?Q?60O5N+8pXI7PZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JNTjdnZDltWi9DTEdTZnRuT2JjaytNcXdvOXU1V0x3YlFwMlRpVXBGM0pw?=
 =?utf-8?B?WFhWdTNJb1ZPV1h6NzJnZ3VXaUlTV04zZTFzdlBmUlhTOWN3MjE2bWI1WUtH?=
 =?utf-8?B?VHhlVzR2NVBMZEdvVzllR3NmekJXekJ3Zk9CVzIyMUtrUXgxTlNhZ2EwalFy?=
 =?utf-8?B?WFBsNzFrZS9tN3JmV2tseDYxdFhmY0tMb0hBVCtXZWZpNUdrblhqeCtNc2Vm?=
 =?utf-8?B?ZllVd2tHMXN6ak45R01sZHIyYWx2d2laOWpFMlgyaGdiallOR2d3VWdGbWJG?=
 =?utf-8?B?R3NDYk05czc5TEx4SUFyQU1PUFJvd0FRblNhNGk1cVZlZU1pb3A1UkJBQ2Nl?=
 =?utf-8?B?Q1RCdjZ0aGRlT2N4bU9MM05CNjY2VEkzeEJLWW51cU1lNUxXbDdxUTdjelcz?=
 =?utf-8?B?THZ4OVZnYzNsZ3NPZ1RxaFp3RTNsMDdUVDN2VXJ1K1AxYmMwL1Y4bGxBV29l?=
 =?utf-8?B?b3FaRXhWVHRiMVRxa0ZFUXN6M3h0R2UyeHhzemdyLzFwYktvTXhHWVJHa3lt?=
 =?utf-8?B?VVF6NzQ0RlM3VEs5empLbC9lWnpsK0dzaldFOFNqTENmUEhWaWRsUDVJSFdn?=
 =?utf-8?B?T0NoZStocFI3QitVelV2UzVmZWhraVVPZTIrL0VmQ0h0QlJzTXFNZER0NG5Y?=
 =?utf-8?B?bCtuMG1YbmRBc1l5eTdwbWhlMko5T284NjVtRWEwSTEvTkpuRXZ0QzdVbVdY?=
 =?utf-8?B?bnRXQnFRZ2hzWThsUnl2WmppZHdicDFCVU54OFNxSllHc3Iwd0FNWlhPNWg4?=
 =?utf-8?B?NU5hSUszcFlTNmRjcjNZMnk1ZHY5T1F6NXoxbFM5TncvcGFNNTRQOXBUZkYx?=
 =?utf-8?B?eW4wZ2lOc3FMcmczWjMvTzFEZ1VIVHZMb0tDRHlBSVJySGlVR2NNM1ZRNjZW?=
 =?utf-8?B?ZWcydm5IdG12eU9ZOStzSHdrRXNiMEhOVEtNVW9jbkhickFqcVIwZk5vRytO?=
 =?utf-8?B?d2dNYTZVU2FxbUlKeUJIeE0zYlRNVHVvRlNMTm5nNitmem4xNHlMajlhYnVL?=
 =?utf-8?B?cEVnYXF0TENqbkRCcE9IWnZFZWE0MVNhSjUxanRZUFpZeG5pdGlRWmRXYTBr?=
 =?utf-8?B?dWxBbmQzRlYwby9oQjFlR3dPUzhmazh5a1VUQWEvSitGOGYvb0UwRUl4U0k3?=
 =?utf-8?B?Tzd1SFRWc3MyTTJwaVJuOXI3NGhVeWt5bFNaUTI5eXJwNThDNElEaHJUMnRp?=
 =?utf-8?B?WmlEN3RLb3FRNVdoN2NZR2JTNDZxQ0taNUZSUHFPbHZHYzl5UVFLOGNJZUpB?=
 =?utf-8?B?TEhrdFlkRDJINk00dmVpU2ZzZS90T3FtcWs3d09uM1pWejltd2gyRkd3V0kx?=
 =?utf-8?B?VjZVd29GeW5hWXpDbDJGMTh1eTV4VkFoUExCYXE0c3JFTXNFbFJBOTZaUmdL?=
 =?utf-8?B?aGJ5cHJ5bnBEcjRRWk0zMDVWT1ZNUVBnRzVZMUxOK1RQQWFjUDlTS3JoNENO?=
 =?utf-8?B?VnJwcThORk1SU043eGNiRXUvWFV2NE1SZjh2TEhqUTFsWXBrT3E4dk1mallJ?=
 =?utf-8?B?K3FGcFBkR1NXbzQ5VnNMYWVuTmg1RGNsTjNzTzlZSEtKRXdXbEdNbjZQeUdz?=
 =?utf-8?B?TElLSnk0bXh1czUwUzdOZi9BVDFiM0VCVUN6OW9tZFhEZmVQL1dlUnRZTGxn?=
 =?utf-8?B?bGxTTGNUNUlheVM0RUhUTnpwZ1dmamxvcU1GYXErckd4QUIySmNzUnF1NW5a?=
 =?utf-8?B?eXZhVklUQ3BXVXRGMHlwUHBwako0clkyWmdScGdsdThNa3VGcDJuTGJTYmVT?=
 =?utf-8?B?eGc4a0xzdGEvZ3pmaEdYQmtrNnh5UVJZNFRuTElSSEhlUGdJOEhOLzNKZW5s?=
 =?utf-8?B?OUZHUHJudG80RUhMQ3N4YnFDUUZVNzJCS3kxNEVVc05MYlJCVllMSG5GR3lP?=
 =?utf-8?B?Y0UrbWxOOEIxNWJmUk5Pc0xnUngrWURuY3M0b0wwQ3lpS1RhOG16NThkNlNM?=
 =?utf-8?B?cGxuNjk2UFQvRkhkSWQwWjFVZnZNYnVsT2JqM3VHWXN0VldXWFFYQzNVV3po?=
 =?utf-8?B?dW9XZTh0cDcwdVlCdndNSHZ3eUZyQmtoU1h0Mmh0bmMxUTJqL3N2VXcyRk9Q?=
 =?utf-8?B?alNJdERUR2VjQVh4anRWV00zaVZuamx6bTQ3cGluempyenNqSStjM1FPdmNW?=
 =?utf-8?Q?QW6A+qNEI2tCYNYRNj91McMZd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3365134a-928e-4a9e-7f65-08dd7675d791
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:17:45.8826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/BI8JwQ6/G+JfQUy2t0ftf720at3ip9jERDbbUXESLwLvDsDTboW8o8UfrlPmVk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
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



On 3/27/25 11:51, Prasad Kummari wrote:
> Prasad Kummari (3):
>    arm64: versal-net: Add PL bit stream load support
>    arm64: versal2: Add PL bit stream load support
>    xilinx: versal: remove versal loadpdi command
> 
>   arch/arm/mach-versal-net/Kconfig         |   1 -
>   arch/arm/mach-versal/Kconfig             |   1 -
>   arch/arm/mach-versal2/Kconfig            |   1 -
>   board/amd/versal2/Kconfig                |  16 ----
>   board/amd/versal2/Makefile               |   1 -
>   board/amd/versal2/board.c                |  13 +++
>   board/amd/versal2/cmds.c                 |  80 ------------------
>   board/xilinx/versal-net/Kconfig          |  17 ----
>   board/xilinx/versal-net/Makefile         |   1 -
>   board/xilinx/versal-net/board.c          |  12 +++
>   board/xilinx/versal-net/cmds.c           |  80 ------------------
>   board/xilinx/versal/Kconfig              |  14 ----
>   board/xilinx/versal/Makefile             |   1 -
>   board/xilinx/versal/cmds.c               | 101 -----------------------
>   configs/amd_versal2_virt_defconfig       |   2 +
>   configs/xilinx_versal_net_virt_defconfig |   2 +
>   drivers/fpga/versalpl.c                  |  11 ++-
>   include/xilinx.h                         |   2 +
>   18 files changed, 40 insertions(+), 316 deletions(-)
>   delete mode 100644 board/amd/versal2/Kconfig
>   delete mode 100644 board/amd/versal2/cmds.c
>   delete mode 100644 board/xilinx/versal-net/Kconfig
>   delete mode 100644 board/xilinx/versal-net/cmds.c
>   delete mode 100644 board/xilinx/versal/Kconfig
>   delete mode 100644 board/xilinx/versal/cmds.c
> 

Applied.
M
