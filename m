Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DECAF506CD
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 13:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA67E84068;
	Mon, 16 Mar 2026 14:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VlAFPdyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CEB984073; Mon, 16 Mar 2026 14:44:42 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBA98405F
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 14:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmW6/KawQpDMxkFaIVod9ivf0rXWsUQZX9Ccyyq+70erWw6il8tCRuIG7ZB4HEuFvXKJ9gu3JjIWKENpULmPPSER71Kht1T/c2j8QdqIavNrTvlSFvILKTpVEWya3qBD/UZ2OOdH2j702P5Y8k1d7JEXXnAvNDouLZt9CdGUTP5yJod3IAbPb8a90uujG2tE3iuZy3gAu0rMrJA/ooe35dVivu9OU70vKJ2cqP2LsiuaW71r//wa+I9tgBz5Q6wPE7pQOc6yrKcg0x+W93+NqhWCNMGDhOh2WUoAvWUpMsUjCxMXLyhoIJBYRf3PTnqnolM5Lbx+DJ4rI0qLtiQpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+/bODDUlFYBm4Zy+8rick//uXBameXXu96Lb0i3WBE=;
 b=VT2a1R1/FNxudWoyCGtN5jV9MW9w+18ZswB/L1DaT0PJAP35sgcQYHr9zDLmRUb4fjDHmSWL2cxaNs2Hey8JHkp0d6/xsrwXOm0PpMPK7D+qLAAoPw74GGM7yzUXDBDF2BUCLcIsE2J6DI8t5p4cpfqF9DcLwnq7xxGP8Q5ylydR2OcrrNXZtGwO/uoeK6c8jtddnbCULjpepHDr4zNnJh5h2X/ggh86mmhhVVK1z2w1jbQ4+vASDCSj0ts9tBHJdFYfTx2rTu8NH2HQ8NORKPfF0zFJu0zBY88jN5RHB/YIZE2hs/mZGL1rvckYsc4n8aKQcQCK583FcQY//Z7tSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+/bODDUlFYBm4Zy+8rick//uXBameXXu96Lb0i3WBE=;
 b=VlAFPdyRZSfm0FfhgS5DxoQqdXt/6Ch3+a03rkQNJghnbZ1aVjUq7F1/ka6SJXkYgOuUUa/GH/WNoDFdFL2hb5Ibrwok7U10GVtOLXf6L4Q9RyZRyZMjuMjofK6STDrXIdH+x84bd2arpvYWTUwnjQrp44CH01vBkxBMVRiAUBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV1PR04MB10990.eurprd04.prod.outlook.com (2603:10a6:150:209::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 13:44:33 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9700.018; Mon, 16 Mar 2026
 13:44:28 +0000
Message-ID: <55f2f0aa-669f-4825-9673-419504e89780@cherry.de>
Date: Mon, 16 Mar 2026 14:44:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc2_udc_otg_phy: fix compilation on non-Exynos
 patforms
To: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
References: <20260316132911.4039-1-m95d+git@psihoexpert.ro>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260316132911.4039-1-m95d+git@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::29) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV1PR04MB10990:EE_
X-MS-Office365-Filtering-Correlation-Id: 284a36b8-f2f5-4c24-1c9c-08de836224fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: tlz4VTALKSdAe00DCJow+H39tetll2BrtKnGjkkuG7HQRABOn268IYpoa+XGLk2WPQDXsJM5+NBEucBreQfjkeFhXlThBuhwucMzX6jKzqm39qwXtIGgGftxwyBkhtk6tiG81Tkyu1tfMCmH1684LzKJWhhQZXLJh0p83lLWicrKOCy9A6S2SiTmgaH6pFNG0SmaG6N+O8mbk7cq7FHbf9UN86kYmdNA47GwvOowjueqHUS/xxRq4z0xrM+e3ncJiB2edx6T5cYAqzGsv4SsufOphYaoIX+5GVVoJP9cOb+8fMk0jQHAABQORumsMM7BAbG1n62cYYn9Jq/sw9Vx3YUzM7Pfxe7MXHJp3PUYhQ41ZFsIRm3uSeBZVc6146to+YICWp5t5xMipYCrynwkKaNKJuRAy86yWrP5YHffWqoICcEvK1S/KpcEw9GPHq6VV9BYI43JxaMKTSpIUm/0NW0RmjfNp/NMi2H/cBcAhgBOZbVhA8/uvcqxydejMfuYI++VW1GYFDwP5p1ZfTEU4JdQTl8uaNtRqi+9nlpzpXMKUiFyLNp7qwgjzWptx1Nv8fPmS33H3ClDFVvLcW0hX7y/1/JJXhRbPTHe/vmfzL6tAkQlkRCQ3cLJZcA+Eh2oYEQCWYZLFd77ikRgvTX9t+N3LI/NhAkKhYNseMQskp5uOZCdkMvKV5ivGSVlrWnUs42f1vmWBAGfyyM5FPB6MPawEX63dh4HxGQ8fZFMEOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0VTMkFZNlBySStiTmhvbmpRaTZ4eE1RMTd0cndLZTkveXN0ditnMlQ5RzZm?=
 =?utf-8?B?MTVSNHh4VE9pakFKWWRuZ211S2JUMklmdlg3czVGSEFtZXBTWEI1ZlhKYldG?=
 =?utf-8?B?dnMvdjFmNWNBaDRjZzAyOTd0bnNEYUF3dUFTNGdaUzYva0R1b2lGOG5Sa0lW?=
 =?utf-8?B?TWJGbFp1RW1CYnRaNGpQeDQwbVNjVTRmazdLekcxTCtWSUIrLzArNURXT3Q0?=
 =?utf-8?B?cU9TOHdtUWlSV05hVHUvejhGMGV3OTlrZTZxWSt0bjlmTXRrL2JYZ2hjUzJr?=
 =?utf-8?B?R2VxV1hXRWVmcFdYMkxXTUlocHJ5aU5zZDlJTmlMZlhaRTkvVEgzeTRNUkhs?=
 =?utf-8?B?WURxUWltU0Y5RFpwbm9MdU9vU1owZXZ5dTY4UzdHcTk2eWVpWkVxekRKRHNW?=
 =?utf-8?B?em1RUW42ZmxTWjlodnU5aEdJL3JwaWFMUFo0VU8xa2FlWFhzb1owNm0ydVJi?=
 =?utf-8?B?R2QvYVRTOHZLN3lLQ09yZ3ZiZ1pMa00xc2E4UXlxMjZmVllQaERPSjdnWitT?=
 =?utf-8?B?K3pabXplN3ZLRjhIVFdNV0VOOEswQndHaHZ4bFVTUXdCc0dFQ0E4ejhNejh1?=
 =?utf-8?B?M3FkcWN5MGEvZW42Ykl6V3diL1k4U3RudmVlMUhhZnEyV3JKSjJlSTdkTmUv?=
 =?utf-8?B?TzNhay9TS0NMblY3ZjVCK00raTBHN043ZHU3Zlk1dmJxNHdSYzNlWUhPNUt1?=
 =?utf-8?B?NzBxOG5uektpSVN4UWwxNVRMUnhsbXBzOXVWOGxNeXNLV1NNcyt4RlptajA3?=
 =?utf-8?B?SzFxTHFkRy9YVC9NT0xmc2pzNmJqRG03dnhYZnErMlQzQWw1RGpoemRoQnc3?=
 =?utf-8?B?ejI5RzNJdlVITCtQRFQ4Sk9MeVdUcEJwTnNsd09kNGFva3lVc1hmK1lVb05r?=
 =?utf-8?B?M0xqQUN4ZG1ONFYyL1F2QTV2RG9LNEZWdndNbElaMHJzZGRGb2M4NjFSajVG?=
 =?utf-8?B?bEk2NllPVUw0WlNBZTRoWFppK0FUWS8zY2hzcWNQeE1LMzA5alY0QlFCYzk0?=
 =?utf-8?B?dnlRWFpMeE1NZUp4Mk01WW9tK3ZzWUFEOVlKRGZCb3B0VEF5NExmM3JCdTM1?=
 =?utf-8?B?TzBVK2ZKKzlLS3RLZ3V4dFNGSUtWaW5BWGtSQ0JUM3RRTGZrNGdDZVEyTzdl?=
 =?utf-8?B?YnpucUc0N1NmaHdXVm9SVGlzaVdvTHdMQ0hGUVhBcnhqUUdWWXI0SVY3dHgw?=
 =?utf-8?B?Yk9yQmttWXdlVWJ1L1ZmVEV3QXAyWTc1U1E1N3g4REhkRUlMbGNpUlFzNHA5?=
 =?utf-8?B?NUwyMnhnWDJQcXFGUkpkRFJGNk14THZjSHJuSGU4Mm1Jc3dYL1FZOHNFdmNE?=
 =?utf-8?B?WEZicVplVWdCNkFQdWd1bU9QR1N1SDlPZHNJUDdydThMK1FLTzl3SUdFNXNw?=
 =?utf-8?B?R3JPSC8xU2VZWkxad2hYQlZTM1V4dFFBbnJ5Wlk2Z1VLaFdsdys5QnZjM0Jy?=
 =?utf-8?B?NWJMNjRTNWtXRXlBRWFjSTBMcTAwdUh4OVJSOEY0Sno1MVNVRWxaMXVJaWJD?=
 =?utf-8?B?T2s0cHRDZFpvb3poWlNrV3dmdUJFOGwrdU80N0pOMTRQbCtQM2xGTzNDaXpi?=
 =?utf-8?B?cjJFWXlBT01aUXVnYUhyd3hOdnF6cVR3c1BXRjdiT2JDNEZDaHJBWFBUdVh0?=
 =?utf-8?B?anViWFd3WW53TVNxQnRqQ3diNEJZdFNUaTl0NlR4dnZLa09wSmlzbm1RWEIz?=
 =?utf-8?B?dXFmQ1cvRTYvME1sSnBrZThCcHpTNlY3SjVOaTY4Q2JTOE9NeFFJTlV5a09V?=
 =?utf-8?B?WkJNdStzbkpWaGpwNUxVU3NBVnQvM3Y4RWlwTlJnU2pSNGNRSDRxMGxOVTRS?=
 =?utf-8?B?V1oyTWxDYStUSis4VkVDaWcxUG1vUDJHNDBJOVVTYXFpNWRxeGRobmpRM2E1?=
 =?utf-8?B?Z3BXUjZCTmFHd1pIMGhjYU9wTjlPSEhBNkROUHVzTTFNSnR4akFDMk9JNDlJ?=
 =?utf-8?B?ZjBSQ3U3Qnd4ZkxMZklpR3c3SWRpekJ0S3RyeVk3Nk9ib0ZhOU5pNlFSV2JV?=
 =?utf-8?B?ekhnUWozajVYcXRGckdEcTd3WFhSVXNsSGZyWnhmdTVFRDBhTS96SUF0U0Yz?=
 =?utf-8?B?djlUajIrL0xwZzM3YURuNExKWmhVVnNjWVQzUzZ0bTBBb0NuTjRqbUErVlg2?=
 =?utf-8?B?ZFVybkNoaHZJVjBjbXVYNEFuZUJDZk8rT0gwZkQxOUg4OVJFKy9abTNLbU44?=
 =?utf-8?B?bkRHMTJ2L1JqUkJ3aE1EVmV4WE9IakNRanhMRGtkTTRHenkwcHNwRFVtNTdw?=
 =?utf-8?B?emJMSis4Kyt6MU8rc0ZZbEFtUGRTSUlFeFNMeE1MMFh5eHNNMy9naEpaS2JI?=
 =?utf-8?B?OWhQTGJKbFpVYSs0ZXNmRWsyeVB0bmllQVBtOVZXQkRmNkRHNDJHQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 284a36b8-f2f5-4c24-1c9c-08de836224fb
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 13:44:28.5615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LS4IQ5vC8gyaOsEPqubfFo205PHYVWcMH1BkkixEvoPymzjogs9SsJy2JyXQ9Hnr8NCxAQ6GG5jYTZftBxv6v8DXKscVtxmUNkHF559cjS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10990
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

Hi Marius,

On 3/16/26 2:29 PM, Marius Dinu wrote:
> s5p_cpu_id used in drivers/usb/gadget/dwc2_udc_otg_phy.c is undefined on
> platforms other than Exynos.
> 

It's also made external in arch/arm/mach-s5pc1xx/include/mach/cpu.h, 
which I believe is enabled with CONFIG_ARCH_S5PC1XX?

Cheers,
Quentin
