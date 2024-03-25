Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F215C54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 14:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD1A871C7;
	Mon, 25 Mar 2024 15:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GIQzBr9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0785087E3A; Mon, 25 Mar 2024 15:16:40 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58138718A
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 15:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiGMSmyca2BRxT70CLYYIxz5GKwyiikigDCLdSeKbGDgg/VsqLeav1Spti3jNVSXair1Qa9URDAV0FkoRulm81jACjwYen0CjSMGyTPPD9D/sqUQHw2x/cTh0bDPjEN/qdcB2sNfJgN0KPgwMR6GB8g0Ob2FbVtPTFSa3D89H32y8fB59IYKtm/IB6qGs3I5luVCrgc5JnbgNwho1wUSF4DLmMnzNk8B7CE2NhQyviNcJtRjo+yKP5S+3APWNSj6N7lGVlNHkbFcDMSmYNeEKgRVqSKl2W2yRR7jn8rSq3FDsH4oX7HPAGboP3QAE0+u3ureGD0fcwpRni5PsAcGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA7tgadJZXdF+dKq1F5+VI+kv5lIeAxrnA7Qnq2xO90=;
 b=ocb2KmZ3Gkmpm9sFDXoOiNjPQqx0RL4i5hRiKiXIOlK7Dxl92y1JoUJi652SyrDpf5PNdmHzHKMgUSynRpR2Ak8NzDZGNKa06ZfgL2VsgV2sRnXmENqcgmIEQ6YzJIF6gTHysIYeQX4ZOIQb4/bpJjUckB31FI4ATshBpUqh+wA8PFdNXIwRHEhWHxE20Y5qU/aUDrADzOllLkRcqAb8rKWYE7rnBs30bkKRmockQiAQuPKbOCZvXDUPZn2KqlDJuPYj3kMRTpWr/osngDxmFQe1HedGIPuBrj4yeQztZH9X2kxhPVYgLkIAsWyoX/xB3RAlizpiof6KMzzyunv+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA7tgadJZXdF+dKq1F5+VI+kv5lIeAxrnA7Qnq2xO90=;
 b=GIQzBr9H5+bOS3CWegxlekpTXImjLvbtQHQKSXbvuBcYUdTWTQTrGG+Kb5xVhuIFVwPZlA9NTB/QszgyJVMjbjwVjERHa18FQnUjDFEi16x40mms57I+K4SkGtyDow/sVB/mQIpQZheoO51Gz6QeSJ9lIqSZQnWyeTSCoCO4TYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 14:16:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 14:16:30 +0000
Message-ID: <79074de6-5042-4be8-95d5-5303b1211261@amd.com>
Date: Mon, 25 Mar 2024 15:16:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add bootcmd_usb4 variable
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cb36fe6bd1fef540441e1d8c32636ae6f80357b4.1710933852.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cb36fe6bd1fef540441e1d8c32636ae6f80357b4.1710933852.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0194.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d1ad1c-9a24-4623-6fa9-08dc4cd62ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1HO5OpQxK0tjs5Slqo67bkL16XYDF2UgXVTUfSMtYpimmvu2PbRoMEr7vkghJlIzQ0+0O3TFTz5picRiDOYv6osfW2RfBO0Mt57iAUU0lOQkcadOIbf0i15jZFm31J7DA7ZxqSmrR351o8fVu2VnO4hcw/2y6n+/FTk2HPsCfEvwgjo3pFpVPCCKF95Ytoaa71/ty1LFKEfu8+jC3X09CV9K+YOUUBSUEvvqXJ9RIMiIaGo/XSD2XmlDVCdW43U7euEDSJd05klJAkC5QOeKXZz4Nsd+bY5Ez3jAT9PoM/lHuSwggDE4p7HQMY9K1U0I1Fg46Kj7oQdJonN3S2Cp4de+pan5+T3wXIS68xtFknWUUVuAvAvZ/fZ2Orj7cNoiQzJAyD2zRg0gp+Rx8WjhnihlNLLWzCVlzpMwrd38VOxN4QOgijs81jTrw9XZ62Kdx7DimNLwWJvwZyilxpZxqSNc7oEYgSJRIVckUYuJxsxUXV76thMnAEQwSHnqVPvaq2ZgYY5X+kujHTvg8tShfkejHs39Q9Q0KdqXpUeGmkXAtaTIBS4RG7vFFwp+uK+jVNgt5VxeE00KWwopYXCES8M2RvSaStu6S2PKYjx3Eo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzRieGlFSDY0L1V5bmhreURHU1RneWQvY21ZM1ZlTEk5YXg4OVJlU1hXRHEz?=
 =?utf-8?B?OStTT0g3RWp5b3RBQ1VjU1R4SUpmNU9DMEo0bW0wMHMrQjZEZTAvSHYyeVVW?=
 =?utf-8?B?MU9EUTE1cGZ6Y2JkbVVmdm9Fc2JXbnlhRXFYS1dybXR4RitpWktpV0Fyam1p?=
 =?utf-8?B?MU1MYVRXRlJQZThtVU9OeUNreWZLUmVyMXh3dWVlMHRLeG9PdytaRDB3Z25V?=
 =?utf-8?B?SlkrL1BmKzJQNGdVSDM0WVFSeEk0TWlzMDgxZEJsVWt6Sk1YbGZIQkxrYWhh?=
 =?utf-8?B?OHY4RUdvTldNeXNMMVNIMzM1czdMV0d6bldJS2Z0aDNhcHdpVktXNTVkRTdw?=
 =?utf-8?B?NG1qb244dnpXRk5aUlBIdndQT1FsNE9IeXB0K1UrYWZ6a0FlYWNja3p3Kzdk?=
 =?utf-8?B?RHZEaXNBTWdxbzdnTGdwcUtiaFl4OHFtd2Jld3FSV3VsREgveWI3Mnhvb3ZB?=
 =?utf-8?B?OHRLNytWOCtSaUJ2M0ZuRzdrUjJvbzlHbUJnTFJtcGUwQU9rRktWWVcyZ1ZY?=
 =?utf-8?B?ZXl6Z3Y1TmQ2Y1l1SGJGSTRZYWJocXFTQ0NrcHNHVU1PZ2taNXBpeGZEOWlE?=
 =?utf-8?B?akljcnN4eWZMeWFlZzNhYUlaUm13RkNFMW5TMmMvL2xIK1NwZ2lsT1d6eE9R?=
 =?utf-8?B?QWZEL3JwZ21NYnAwU0JxV3c0eTFYS2VsRVlNR3FkTEl5R3dCakRPMlBIVVA1?=
 =?utf-8?B?aUFHQzJZTld2c1JHYXRvMTVMVitIQlhVdWxDY1diOVczR0liZkFVTU1FNnk1?=
 =?utf-8?B?YTFqeUJDQUVXemF1OFBaSXhld2dUUmxhY0trU0dEeXJ5dXh2TEtNakk0Vkpt?=
 =?utf-8?B?NmFMVDVjS0xHOWFBSnpqVEZvQ2d3ZjJEWk5WMVpWVElOZlRCRG1DWUhUZDBW?=
 =?utf-8?B?TkxlT2VEOGhDM3ZQRU1TK2FPMFBrUWhNQzRBSHZUU3hRL0xrMDh3MVIra3dO?=
 =?utf-8?B?Y0UvNmxRWUpuWTFselZmNUwveS95ZTZab0hpMjZ1Q1NacGNNVWVEN29BUWFB?=
 =?utf-8?B?VkJUdzZUQ0dTV01URlRnRWsrVlM2dlV2ZGxwMGlnMTZFNTFScThyaWNQMWJw?=
 =?utf-8?B?UEw0U240T3NGRzYzTmZhSjAxWDRRRkJReWU0eWtxS2xqMW8rY2RnYiswUFhi?=
 =?utf-8?B?aTZUd0VSZzFSb25vRy81UGJMak1nMkYrRTB3YlpFYUNyaWZIL2F3bmtXVjJ3?=
 =?utf-8?B?M2pIWEFkWHh0eUg0VWw2clpQV1piL01OaXNvS1BHVDZvWU41dEcwN29JNDQz?=
 =?utf-8?B?RkE5MWk2bE9WVUdNKzhlQmU5aGlQbXplbHRnYXVlSjNCMlR1bVBRV1FoVXph?=
 =?utf-8?B?NmdibXhrb0ZvOHNXTmpiVUJFSzBINnRyN1c4OVljdHBmYjFkY0JTZ0NlRE94?=
 =?utf-8?B?SlJQYlB0bG5SaHFMMmt1dzhwYjQ2MnZHckhwaVNwR2lkK0xTUzVzSmUwM3dD?=
 =?utf-8?B?SDI2Q3BidlBoNnpyQ1FpdHpWUEhHNWpwWVU1TE50SXVMUlZ5S1poZFJUTDVM?=
 =?utf-8?B?aXUvbWVaVVNTWFF3MExVRHNyY2dGT016ait1TlJmTEFRenFPNUtsQjVjbHZP?=
 =?utf-8?B?bDRhN1NLZ0pxZWxINld3c2VxV3NKOUxjYU9xcDVRWUlGMDYxclEwTTVNR3VN?=
 =?utf-8?B?NDY5dENHeElIdWNlVjZKUldCQzF6ZjdXTHh2aXc5N3puR0k5cEthN1dQWndU?=
 =?utf-8?B?bUhoUGtQSkVSUkR3OTNIOHpyUk15bkdnV3VPdEk4Ri9JcTFDZTVreEh6bkpC?=
 =?utf-8?B?ekNBeHNYRWxtb1lrYXBtRDgyTnJxSC9DZnppanlmU0pJcEhtMExLTGRMaDl6?=
 =?utf-8?B?UHgxTG1KZkNPd2dNSklEdFRTOWc0SE0yZzJ2WEpJa1Nla1pIdUZvSlM4L0di?=
 =?utf-8?B?Yzk5TlNkMWp4N1B5R1pxQlc2RXpDMnpGWXFZd2lPYW14VkpEY0RTNlZyRUdl?=
 =?utf-8?B?WnBKUUJDQWNIVmdla1NEZ2lPa3o4SDJUMWVvUFVtOUFEZDRSS0ZkdVI3MndK?=
 =?utf-8?B?bmI3LzBUNmZ2K3J0d25hU1V3ZElSeGxEc3pYM3hXdDhteXFJeXNUci83N3pH?=
 =?utf-8?B?RHRsaDlRNXRFU01HWTRiSGU5MUFrZVg5aE05eG0yM0J6UjVRckhlZDNDODln?=
 =?utf-8?Q?gJfRK/Rkxtl8KsBIY7eo+psmp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d1ad1c-9a24-4623-6fa9-08dc4cd62ade
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 14:16:30.8157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JJNqH6ZM+36O1VqCxaWChNROKqEawTiHIIX8JCIlHgBm1E4tUm8IsjjbjPPPjc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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



On 3/20/24 12:24, Michal Simek wrote:
> From: Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>
> 
> Add "bootcmd_usb4" variable to boot through usb4 device.
> 
> Signed-off-by: Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> It should be the part of
> https://lore.kernel.org/r/20240305110256.153308-1-venkatesh.abbarapu@amd.com
> ---
>   board/xilinx/zynqmp/zynqmp_kria.env | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 7d3ad3122605..846eceb0118d 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -17,6 +17,7 @@ bootcmd_usb0=devnum=0; run usb_boot
>   bootcmd_usb1=devnum=1; run usb_boot
>   bootcmd_usb2=devnum=2; run usb_boot
>   bootcmd_usb3=devnum=3; run usb_boot
> +bootcmd_usb4=devnum=4; run usb_boot
>   bootdelay=2
>   bootfstype=fat
>   bootm_low=0

Applied.
M
