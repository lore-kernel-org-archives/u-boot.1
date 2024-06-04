Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D305EC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 09:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493D388470;
	Tue,  4 Jun 2024 11:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="OKLGSRTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B95E88470; Tue,  4 Jun 2024 11:12:23 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0721.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::721])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685E388400
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 11:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmW/FSSz9iMY7isrDeI5iSpaX8bzWA+6xVBBkB8tmf6ML/Y/n95kbEPF3tvfO9v60Ig5C7FNSrD2tRem2S6hAr+BtekzuxWzW9k/gSW4ZutN+x9uBZGf6Kr8grlx/r6xi/4v0vkbd51b7XCJlORPuF24h9vnVu1uL9fABdOp1ABSLElnWHiZWwLQaf6kzKGroqjnXaJ7gjtV+IpKQUsNvVkZD726sY8cLpgC0iur5293oIvEowhjnM/kstqeefLUH50V2TZ9l2CHLaPgUWw1nEYrmqdqPcG3JMOab7hjKpKLoMqoWlwtsQWnGMzzjzEk0Qw78a5Fyerph7IchU70wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkvx/WrH2HM7g81cqCGCGJn1zn3HXU+Abo0a253XpIM=;
 b=FRj85aVHN8vi+wueWOLPXPRWdCqtv/xJXNQd/FKhpji4Q9ejSQE6q7VuI1BEOfz5JIOlQGGPwk4T20N2TXUVm4GMuJVRAp7RYsS6WIeypGl1zHqRClkr0pdngtEKEJiUKNanNADYkaRWb1/zS3jdQsMpY5w5i+mo5NpK63kDkQ7qQtKsZCoghcSz6QXL8yMJUDPeDxZYEafHXjEQLuLuwp3QIEAIgfMAWdJTrl7AbhLLwVqI57PdLJD2WybyLiAhEGN+FVuuQXrIoipO+I3vGuqKGEBCux4Fv3KBNJG5rxyWEbOsDP1E6mGJJRwpFZJu2FvSX+bq/0a6Pen31YEYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkvx/WrH2HM7g81cqCGCGJn1zn3HXU+Abo0a253XpIM=;
 b=OKLGSRTW5OF2SzkZdSI6uNfq8P3zlw7mIdVmAtiZFvL/bx5suv4B4zN8rlR0wb+qRPzrY0TyW2YhnP2SoifabESatrkn/gAnSNJNb5DmF5zIM49Vb/1e5IR6bwgTx01FHbtHqdJfNT3FjVjdAyS8SSHN1LlTUOuYZfxnByFecX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS2PR08MB9126.eurprd08.prod.outlook.com (2603:10a6:20b:5ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 4 Jun
 2024 09:12:18 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 09:12:18 +0000
Message-ID: <c8e8f491-5ac4-4133-bfb9-9051542bd192@weidmueller.com>
Date: Tue, 4 Jun 2024 11:12:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xilinx: zynqmp: Enable reset_cpu() in SPL
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
 <20240603133447.173402-3-lukas.funke-oss@weidmueller.com>
 <d0489c83-7225-4127-9ba6-e9b29165d2b5@amd.com>
 <efaa2184-d082-41c6-8e8f-682d60771e8d@weidmueller.com>
 <aa82531a-3629-497c-a442-1c3a2715ca51@amd.com>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <aa82531a-3629-497c-a442-1c3a2715ca51@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::9) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS2PR08MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5595b9-6dfd-4538-ea99-08dc84766ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkZYWXJ1L3hmSTdTM0FSV0JmUk8vZkFnelNXT05vSzVJMkkvMkFGcUZFL05R?=
 =?utf-8?B?STA3Q2FVL0lTaWEvajBWdFFRRkRnKytzU1haeEpZb1BBRXN6NW9ZcjgxWEx4?=
 =?utf-8?B?WTlwR2Rjc1JPWjArQzlWUU84UStxRUxOQnVrbFhlMjhDaTRKbG02dHQwaThh?=
 =?utf-8?B?V3o0ek1nSHVCZExJTndjMEYxanpmNXpZMXd4UnJsYU1pRnZHSWwzMG81aFBy?=
 =?utf-8?B?UVc2cXo5Q2pVMlNZeHNPc3NMSlBuQkZiVkp6NHM5TGYvbWtuVm9jd1V2d015?=
 =?utf-8?B?a0FXRU5ySVJrNXVBYkVKMGoyY3BYRWJ6bjhvMGt2Z2xnZUt1MzNpSlo3S0Fw?=
 =?utf-8?B?cmZaNEhZVWhydmlJTXdodkV2ckNiK0xqMnJnY3dvd1lyNGRLWUljOUVOLzRJ?=
 =?utf-8?B?RUpyOUJ2ZUJyUS9qQmVzdE1ycVRidGlaSFBOWEJTYm14RGpzTi9yOTBFanpH?=
 =?utf-8?B?Nno3UG9HaWZ1N0R0cmU2RGJuWGNWZk1hZG03WVhDV3UxalBqYUs5dkJYM1Bx?=
 =?utf-8?B?UkNwdzZuZ3FEWnUrckhsbTQ0R2pTa0hWczlOc01wby9zM3RPQTdWNUxseWFM?=
 =?utf-8?B?SStPS1dteWpjZytuYUFWbWdDVE9FOERKNUdwS24yYnJjais3VURYSXlOMkVU?=
 =?utf-8?B?NEl6U2hsUnc2WTluNHIraVA2TTNnVVBEdGxuRTNDc1BSWlNkcG5kYkRHb0dD?=
 =?utf-8?B?YkMxY2phSEhUbDlPWWNWemtRWlN4cVQrZit2MTVXY0UrcVdmM1VQL1hPY2NL?=
 =?utf-8?B?eTVSM1B3NXMrYWQ5aDk3bmJENkRrRlROR3h6NWkxNWxRc3hBa2FZaTVZaDh6?=
 =?utf-8?B?bi9oSi9Fb003cUFhaVNxclp0Vklqa29wZWFVbklBcUV2aDB2TGY0eVRFUnBI?=
 =?utf-8?B?djVSbWptL3kxQmxXUTNhQmZ6U2lLWFQvdUZMUzVUYisyRnVHV2VCcjc3MzdJ?=
 =?utf-8?B?M2VkaVhSaERUdDdCYWVuZFd3Z0JiTlU5YW83Z0hvNXg1SU52bUdZcDR3SWtL?=
 =?utf-8?B?WGxJcDB4RmdaeWZIYVJLblRtVXBZZC83NTJDdlp6K1A3UTcybEZoaXNwclY1?=
 =?utf-8?B?MHNrSDZtdWhvV3pyMnQ4c091c2ZJd2VrYmNydE8vWTg3SEsxQTFIQWxaL0FE?=
 =?utf-8?B?NUVreFQxSTFlb1ZDZjV4UTJLT1BFeTBXV2I4R0JnZlVSWlBhNVNwa202NUxL?=
 =?utf-8?B?b0F3Wit4OXVXWjUreTY2SGVMSnp2bDdTZXVpakhITEU1TFVIcTNTS0l3alJ1?=
 =?utf-8?B?T0VTVXBwa0xvOXVUTGFmdmlYVDl5WEJvZ3RPdWE5YkgwLzBoYjBkNVZVUEwy?=
 =?utf-8?B?aU5FUERRYnZaV3YwUC9tNkM3NXB4a0NtTyswdTV1eFQra1ByVHdJT1lRMnFu?=
 =?utf-8?B?aDFieXh2Y0M3d3Y3S2ZRQVBHLzZ2R1ZuVDdON2ZXT3hiaXFaRWk4L2lCZzN2?=
 =?utf-8?B?eTNWbEVIUHZwRTI2dVdFM1FaMHBwdjVMckY3NUJxai8yNHV0SkRyVkVKMkFF?=
 =?utf-8?B?a2M0dmNiQTBnNUgvREswMzhmd1kzMDlSQmp2Rm02VTdyZmowY3RqcSs3K3Bk?=
 =?utf-8?B?RWdyMW13M2dNdEV6UVFPcU8xUHg2SUU0T3FHN1I3NlVhNUpWSXlQdGo3KzBV?=
 =?utf-8?B?MjgxTFpYSUxQaCtsbkJ1alRKRjZFZ2ErbDNLOEUzRUpIWmowYUpuZXlKZWRQ?=
 =?utf-8?B?MGJzU1ZNQUpJSFQyQTF2MmtpVDVCYlpkK0gzL3pRZ216bzhYSVJEVFRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0Q0V2dkb2dULzZrNnppVDd3SDc3Q3FWUURvL3RsQVh2N0YvQitRR3VrcThZ?=
 =?utf-8?B?ZkJWbnhDSmpLSi9HaS9DNU5SaWZzOVgyd1AyUG5WRVVCdllDOFJ4cWZ6S2Z5?=
 =?utf-8?B?elVtTXJMYmpsTjdBODlGWTU1NVgyRzFMVFBVb1k2L0hFQnpRY0Z0c09mS2Y3?=
 =?utf-8?B?ZWRJZHBOdWdoNW9UUVd0MThxWm9VdFRSVTdHWkMwWEdOcnRKWnV3WnFxOG9m?=
 =?utf-8?B?ckpCQlcvSTlTOGt3ckZvVzhNQjFpSjNuY29Ec1lGcnhRWVQrUTlZRzhmQkNo?=
 =?utf-8?B?czVPNUQxV0J6UERoTlQxeWhVUDVTVjhpTG16TGxKalNoMmtnVkZpQzg2Sm4w?=
 =?utf-8?B?VXpaMmo0MUZ0QUFkay9XN05sVjZHUHcvWk9IK05YNWluYktPd0M4WWFNajlG?=
 =?utf-8?B?S3VYV2NOT0ZqTjA4M3FFN1lJM0t6ZjV0Z0JoRElYWE03cm56cDRycDI3V2hY?=
 =?utf-8?B?TWhTdlhZaGUrL1R5S0FNTnNDTFQwMUVTbWpzRUxmemxXOW8wUzhaRElZRDNw?=
 =?utf-8?B?ZDdwUXNsY3cybTFTWjVXbVV0MGxHbkhaa3o4SmpIY3RKaTNMVU80TitTdFZ4?=
 =?utf-8?B?MGQvQnBHUmtuT1JadFM3Qmg3Skl2ZWlvMlV1d3IycDFXUEVoZld2Q0xhUXlC?=
 =?utf-8?B?cGY2NXFYY3dJMC8zTG1WNDVRYXRHVExaeVVPZHJnU01rdUhMcUxzQkxvVnZX?=
 =?utf-8?B?R0gzcUIvb3c0ZG4xeFBKYUY1Q0dubkxaS1dBbXhKUUh5bTlPbDZmVmJIZjNZ?=
 =?utf-8?B?aEIwTnlyOUJvMWRuc3pCTUtJWVdCQ2JlVWNmcEN1SzJDZlpxNUhCQjE0V0o4?=
 =?utf-8?B?Y2VWMFBqQWoyZXorbnBFb0xsaXUxWU44bHVQcVI0UXExWjhyaHUvdEdqSmFv?=
 =?utf-8?B?RGZReXo2ZVM4V2tSWFhkTGU3VHpXUGZvS0xXYmlZN2Q5M1ZRQnFsNFhNbThT?=
 =?utf-8?B?NW02d0txak1FZDNUcW1FZ2gyUm8rVTJwNzlzWmg0VW5ZSWtkSGN2OVEwKzVM?=
 =?utf-8?B?aENvVTVPUERycXduc1lVY2pRNTlJMkRkQ1cza1JKV1gzV0NMMFZUNnByUU1R?=
 =?utf-8?B?TjNmUk9JN2lvMUxyN2xVOENQaWFsRkF0ZnlwdDlmZVBFSXM3OXQzRnZiY3hq?=
 =?utf-8?B?UGlpK2FIb0RPeSsxa1NhT3VQbGNETG9mVE9yVjlrUGRvRDlXNy9Qa2lNN05S?=
 =?utf-8?B?L3hiandhZGNtRmM1TFZLYW11QlZTaVNodWRGMW9QTnJEZ3hoTUpWclA4emdQ?=
 =?utf-8?B?bXlWc1B5SXFLU1VQckN6UEZEbUxESTVnK2pjL0xiVzJmejNmY0VQay9ITTNZ?=
 =?utf-8?B?UzAxNFRnOGZqN1VHemtWbWlFU2djeXVOejBRaVBQV016ei9JVlEzVkZwdm1Q?=
 =?utf-8?B?dUpJRjY3Z05KbEl2SWd0dHVaR0JVSU1iOFJEbTU3VFN1RlJhR0xLYUFoMDNJ?=
 =?utf-8?B?RXRLNU1wM0JqTWF1aXdKd3hCSXU3ZFJid3p3Qkl1UGhndTBFaG0vZEJ1dllM?=
 =?utf-8?B?NlFwMDVhelE3aDVPSWlBeTRxSTdEbG1WbSs5QzdPcWdwOXNGdkp0aDgzek8r?=
 =?utf-8?B?eDJVUkpoL0Yvc1VMb1AwNzlyL2hDQ2JXb2ViY2Z5VW5CcFNUT3NnaVJnWVZD?=
 =?utf-8?B?UW0wL0o3R2ZJT0lEM3owU21aZ25EWnc4NHUwZ2YyNGFOZXNWdFRkL3d5WHpO?=
 =?utf-8?B?R0JJVitUR05YYittQ0pMb29paHJodHIvVEhmSkw5M0ZFS0NlcHJWMmlBQTNO?=
 =?utf-8?B?aWc1QzFLaVZBaHhTa0hOQjkvbjN4YUZsc1hiQS9UUndXa1owWm1TakY5QTk2?=
 =?utf-8?B?YjFnUW5BRnMzaFJpSy91SEpxRTVHdTJlMVNJMlB2cllGV0oxRC9ZVm9JTVp0?=
 =?utf-8?B?TWs3M0lLMmRyeDlRUjRETEtrdjlSWHVEdWNrUDB1M3RpWjJESjFxb0k0c2lE?=
 =?utf-8?B?R1ZwSWtxdGkwSEJ4QTd5TkhubUI0QzRpZWtYc1kzbWhlWFJ4TlAzdWpHeUIy?=
 =?utf-8?B?OFd6UGRQem5FTC9KTVlMMTJsUUVwQmdweDhPMEJUQ1pVQ3ZlUUJURHhlZjFP?=
 =?utf-8?B?RjlmWDlRaTB2OVZmRTI5WmZZQW1WMkVIU20vTnVpVjUxVzlTWHNreGRNRUVx?=
 =?utf-8?B?RVk0UHc3cHJtY0hkcFNDMWZRTDNVbDZZcCt2dUpVb1cvOGgwTlZFbDd2WkVh?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5595b9-6dfd-4538-ea99-08dc84766ecd
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 09:12:18.0760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6p/4CFRwNjDYmxRfe3wVL2RQLhiUhRVGgvRt6y96QKLXw70yWr1FE6AeEp7cGuGEpGsIQsQb6Fejq0TON18OPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9126
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

On 03.06.2024 17:08, Michal Simek wrote:
> 
> 
> On 6/3/24 16:50, Lukas Funke wrote:
>> On 03.06.2024 16:32, Michal Simek wrote:
>>>
>>>
>>> On 6/3/24 15:34, lukas.funke-oss@weidmueller.com wrote:
>>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>>
>>>> This commit enables SPL to reset the CPU via PMU-firmware. The usual
>>>> reset mechanism requires bl31 to be loaded which may not be the case in
>>>> SPL.
>>>>
>>>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>>>> ---
>>>>
>>>>   board/xilinx/zynqmp/zynqmp.c | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/board/xilinx/zynqmp/zynqmp.c 
>>>> b/board/xilinx/zynqmp/zynqmp.c
>>>> index 95a134b972d..99f5c178c1d 100644
>>>> --- a/board/xilinx/zynqmp/zynqmp.c
>>>> +++ b/board/xilinx/zynqmp/zynqmp.c
>>>> @@ -40,6 +40,7 @@
>>>>   #include <linux/bitops.h>
>>>>   #include <linux/delay.h>
>>>>   #include <linux/sizes.h>
>>>> +#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>>>>   #include "../common/board.h"
>>>>   #include "pm_cfg_obj.h"
>>>> @@ -285,6 +286,14 @@ int dram_init(void)
>>>>   #if !CONFIG_IS_ENABLED(SYSRESET)
>>>>   void reset_cpu(void)
>>>>   {
>>>> +    if (!CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
>>>> +        log_warning("reset failed: ZYNQMP_FIRMWARE disabled");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    xilinx_pm_request(PM_RESET_ASSERT,
>>>> +              ZYNQMP_PM_RESET_START + ZYNQMP_RESET_SOFT,
>>>> +              PM_RESET_ACTION_ASSERT, 0, 0, NULL);
>>>
>>> If you disable ZYNQMP_FIRMWARE xilinx_pm_request() should fail.
>>>
>>> we should likely fix it in drivers/mmc/zynq_sdhci.c:114
>>
>> That's an odd place for a default implementation. I'd like to move the 
>> functions to a common location but I've no idea where. That's probably 
>> why the last developer moved it here. Any suggestions?
> 
> static inline to include/zynqmp_firmware.h?

Sound like the right place.

Currently zynqmp is not buildable when disabling CONFIG_ZYNQMP_FIRMWARE. 
I'm not sure if it even makes sense to disable it. Maybe this should be 
enforced!?

However, I'll drop the 1/2 patch and convert 'CONFIG_IS_ENABLED' to 
'IS_ENABLED' in v2 to get finish this series. Refactoring should be 
addressed in another series.

Best regards
- Lukas

> 
> M

