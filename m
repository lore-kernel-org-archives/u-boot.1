Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A928CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 08:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1362838BB;
	Thu, 27 Nov 2025 09:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="P6JHAjA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDC78334F; Thu, 27 Nov 2025 09:29:30 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11BE84332
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 09:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+t0/ZL3Mxjg5Nd77o4bh0AgRjn9Fk05FjFHNgh6dfX33EsYJnQ3Dc1RaAa9By3LC9sgY9GOfLkh7G79iLeGpqA7t8c7r8yEvuEmE9CiiDTKEKYjHy6RCrC0gm2K+UGP0hc3nE1mKfeQsyD2k4bbk+uBMmjfaH/Dvkr5kxKXVKS9KGuDkBfh71LRy8AJjsoSoTO3ZnYoWAuLbvL3gb0ZncvI3ptvDvin1CZXUcf9gH5jtRW38BMs04N+23NWyeRSqD4I3lkE0UwGRT96/3964pJHqCQbTNJZTlpWH3A6jE47SMT5sXGJuRwMG51WIw1O+miOY4On5bEmRF/Db6xFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs4HH9qIOlgf1fsjYOnV2y3Gd+O5rj+XL7XBcgxdFcA=;
 b=mhMwKUdabNx2WybMVTDkA0jVoD+SYmERMBee0Gvb99CAot32D9yT4HvlK9O73VNP0Bin/UvEpJyjvT/n3ti5/kYtsg58Uu756ocUQGmrt1CEa6Em5cNnYZTPx7+tejbar4FMXC4p5F+VQV4QJTF31Ray+xpEyS25X4kcI6p52Cli2/CuVHymr1b8daPCGu3P5bvuePxVcEyVZ/CVUvjuU/hZvyQy4SYUgTtGOmEf2Di2h/I4E2s5fsusHEsmhFf/en7AGu1XPv/4umyLuER58kPg411692epBjrdj8ux8XVQ+ruScjR9EZWXThDZ9W1nqh2cL4j5t7L+oycRpXfqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs4HH9qIOlgf1fsjYOnV2y3Gd+O5rj+XL7XBcgxdFcA=;
 b=P6JHAjA9MAfkti5E90K9PTB/hQv4RaLlIhXgRGmR/KmZCFDChiN86prm63Ae7mkcDbGHi5yjadyWpHa9K7MqJIKRPcc3HnA7zElre97ZXUksRsxAB7E5VGoLuubn4H4SvRzdO7CzocGhrKhcjECYaTEdgE/pEvyXI9antSlLarUCv0Mj8q/+rx/Hae+rc/+nbI7dOd+zj77g7MqdVZVlqCot7fMA6SwdV5c3CV/NTrxAOjlxJVPBf5+at3GeWIdKCH3WMG21ET+23p2RhAbaJqnAqibCT6lkoFyROFNZXfv+lQK3e2f8EgOIAYtJZOAGiv9XKBbNUd1rpw5SF9nx4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BL4PR03MB8051.namprd03.prod.outlook.com (2603:10b6:208:58d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 08:29:23 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 08:29:23 +0000
Message-ID: <77c022a6-0751-468a-aeb0-9d028ad1fd70@altera.com>
Date: Thu, 27 Nov 2025 13:59:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mmc: sdhci-cadence: Add reset control support
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-2-tanmay.kathpalia@altera.com>
 <aRv_hIwxZshKJQI1@nxa18884-linux>
 <3668b44b-9525-4bad-8d24-de10311a4df3@altera.com>
 <aSZjLjm7saoeQYBs@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <aSZjLjm7saoeQYBs@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BL4PR03MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: ec23c436-97dc-4c0e-2d14-08de2d8f112c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHlISThGUFp3bDNaRnh1TUp0aFp0ZDJXUW9ZbXlrYmZGVlNCVEkwdGEyQmNW?=
 =?utf-8?B?dG1qbjBpUjhQbXlDMnNTR2ZYSWlrVnhWSW1HdHdrdks2TzFCTm9XZ2JTeHNO?=
 =?utf-8?B?OWxKOTQwb0F6cGRjc0ExeFJDSzlsZXhsTmRRSVkvNUtUUmRSb0dmeVZTT1Z1?=
 =?utf-8?B?YkQ5YWRuSTlBQnBtUTVPM2dIMFNWR1RmMGdUbzFmcXBVeXA1K1hzWVk3VHB1?=
 =?utf-8?B?K2dHZk9kbGRBcVpsNFNkVmx5cFZDZW5rZWhzUWhGbG5mcUMrc05DS0VuYy9r?=
 =?utf-8?B?MkUwbU9QaHNPdm9WZlJ3NmdOcVYwL01hYUxlcEZZUmpHNVR3Y0xodEhBTHEx?=
 =?utf-8?B?Tm45bERHZTVubEJIZTFhRG8rVlJqaWlEUUM0VzdjcGpxYk9UNG9PSm1sTklM?=
 =?utf-8?B?c1drRUFwZWpuUXMxV2ZoZjZNbXJzNUZFMjBwZVV0bVoxaGRFTG44WExXeEEr?=
 =?utf-8?B?QXN3eGxIOTFndjJEdjNGMUVlT1ZqelM5SGkvZlpPazNhR2gydS9NY0lQaFlZ?=
 =?utf-8?B?bjRpU0RwaHVTNE5vMjU5SzNYR3FLQ1BmZmdMUEhwUTN2NktaZ2VlcW90WVdK?=
 =?utf-8?B?c1VYOG1kVWdvVlVORHNIZGlMRllENzZMWXcvamg4QllJbWNBK2RGTEFUU3Ns?=
 =?utf-8?B?NmRpclN4aDczSVJmVys4enRsS3hSN1R0dGdvcTRzQUlNdmwyaEcxZjFFakhT?=
 =?utf-8?B?WTVhVUZhb25yTE1Dd3NuWmpSdStKd2VBSWg5YjFvM0xnKzBySWVLUGxYRDVj?=
 =?utf-8?B?OGRpVGxiZVNsWEpabkw5aTVGK1ZEaW1ycy9aVkpqTzRMU1dHUld0WHEwQWVS?=
 =?utf-8?B?WXhUcDBtcFRZNUIwSVVMNGJLbUtHRkEyMmhwcTNSNjhEbG44cHg0eFN6YVdm?=
 =?utf-8?B?bXB3N3JkMGEweitlNUxDWFI5Mlp5OUVuRkJPK2g3RjBBVHdXK3krdHV4TkVt?=
 =?utf-8?B?bHlXc3dRZXVZQkVNSFMwdjNyZ0pwRnV5QWx0M2ExelNYVi9sY2QxUE5CR21V?=
 =?utf-8?B?azZ3aWo5R2dKaDZkMjJ6dXBGRlAvL2llV1JubzUzVXRnejliam1xT2ZmZmpx?=
 =?utf-8?B?eC9vNW83UldMczJ3ajlVbzR2WGF5em5YTGF4VGVucUJwZUZyOFNsT0RsczZ4?=
 =?utf-8?B?RkJ5VGRoRU1wbC9YRVNONllUaXo2SVR0N3llOUhTT2ZlamQraXRUT0svazdX?=
 =?utf-8?B?Qk0wZExNamZBTVJkL2lpTTNCK0FmaUptTWtlWDZRbXdBRXh5QVpqY1kxNjhS?=
 =?utf-8?B?UDgvSmZBNTFGMGMvSmJPUkxCTmVsWW80N3FhdjltaFFZSVMrRFpETFBCTko5?=
 =?utf-8?B?M3BXeWo0N2VXMTczclFEcTQzT1VreEdPRkVzaVA4c3dnTFNBN2FRWnVYOGpO?=
 =?utf-8?B?Wm9sTkZaOW9EWWR0ZGR0ZUZhTnJZdElhaFkrM3RhU2RwTUF2Rm9LbjZ3eEtI?=
 =?utf-8?B?c0YweXhudS90MU5aWTBuMldxblROMTVCVytyVUhpVlhGYTE2cFIzRExVUHd0?=
 =?utf-8?B?bkZvMHF4MHhmZTZPb0hJd1pBa1g0SmpRMHE4bzJLa01pSHVmMDQrU3lBTXZK?=
 =?utf-8?B?V1FnOENaemdjY09WUm56VHdNclpqaFI5aHBNOWhsZ0FtRElHTWxhTDQ3b0Zt?=
 =?utf-8?B?ZG9qZXlLSnhERGxjZDV4bUhNcDdWSnliMnY4R0hCeGpKTjZzVzduRnlZUm5r?=
 =?utf-8?B?M08wT3BvWGk0Rkc4VlNJai92ekdFaVpsbHBhaHlxNVNUTk1BaU05VUg1Ry9u?=
 =?utf-8?B?ZDJHSGdaNHpTT0RJMG1UQjhZNmhLbzRCOVV2TktjR21zVUcvOWEvZ1JXdDJF?=
 =?utf-8?B?VVNZT3lEelIwVHRzWmJza0JiWlhrY3hrWmQ2SFEwWG54TTdBTmFpSExqM0ky?=
 =?utf-8?B?TVd5Wisyam9yQzVKL2wwNU5CU2JtWGRKZGJiVXplSDY0OUs5MGx5dG1HcXF0?=
 =?utf-8?Q?LuYxZYEFqKfLqJZ33X3MuwX+GY/GRSKk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymh4WVhLcG0yWFJRcjZmZUFxdzViWHhvYTA2dFpyZmtJcnViOE1uaFNsc01a?=
 =?utf-8?B?MlZMNVdsUjVubi9ESUxCNHVTbUNVZ1BRZnh3MllFV243Qi9ydWcvRkZxNG9H?=
 =?utf-8?B?S3Y1OFEwWXVWNGdDNUVjUDE1TExvQTVTZ1BibUtHSFdzTDRybDA5SWZnRGlT?=
 =?utf-8?B?dkFMd0gxRnhxUzgzT1RNRUVkMnJvd1gvcHdabU44Z3Q5QW5hd0l0MHUvWXlE?=
 =?utf-8?B?NkFKU21STmFady94eTRMMXFlSlhxWk11ZGY4cldUd3VNaDg5WkZjbmVOcVov?=
 =?utf-8?B?TGU5VnJXSnd4anFGU1dsRkNzZTFLbnpJTjZ4S3pJWjc5MlVmWkZodGFEODYv?=
 =?utf-8?B?MStuaVpQeWRkYWtwNUt6SDZDeDZpVmJhQnpoQ2FzRjFhV0dIVVVKejJNbkdw?=
 =?utf-8?B?NzQvMEt5RDdLSDZnR0Vwdk14QWhYclNvSHJuTUdJSzQ5R25Kc3VKQVppU0NY?=
 =?utf-8?B?TW4rWmlSVlREaTIwRUNmNUVLNWl5NHE1OHJEc1FJb1VoRHBudzg2dkRlaThp?=
 =?utf-8?B?SkpUVWtRSTFOZXhlekwxaEw2VXVGVlVQcFhlbWJIUUxOVU5WUms3eHFONGdZ?=
 =?utf-8?B?WVFuYWViUFVVcVhmN3ZzdUp5ekhycGtBREtBazROMUJZaUE4N0NLVkp6bjVB?=
 =?utf-8?B?NFZKSy9aTmtQNGNmWGxodXpZUC9yaGRtQ3dzeER1MjhKUllkM2haakRObm1m?=
 =?utf-8?B?OEZ1UEFHVDAxMDdCdHhZL3lERVhvMTA0K2k2bm5DT1JXeWlwZEVyMEtGUE9R?=
 =?utf-8?B?cmUwbThYRDk1eHBwWkswRjkzTWJzWlYvejcyOCs3Q01yNE1ia0VSbGJ6SDRP?=
 =?utf-8?B?TU5laWY2anlhSWpyd09naU9sVVR5MVh4cU1oMDZOY0VMaDdtdU1ieENzNDEr?=
 =?utf-8?B?cmdKVkMwY0FCWkw4Qk5lZEZpaGhtUUZsQmowU2NQQVpYODc2cnRRM3F0RHdi?=
 =?utf-8?B?TnpEN2t3RkxjSFRFL3BVNkQ5YktHRWRhZzNTTUFtbFFTSkxidXRVRUR1akRu?=
 =?utf-8?B?WndlNVJsaEs3N3NCNTV3czFieWI5Q2RjZE1saHY1SnZ5VHFUWitKUDFUUFBk?=
 =?utf-8?B?elhjcklxWHEvUHIrODV1dU1lNjJ3M1ZrVHBNNmMxOE1DenM2YWdPUTlrd01F?=
 =?utf-8?B?RkNmL3BQcmIyaEhieWQvaGNyQlZ4SkxOVTZqdTV0a0d1ZERsdGpENVZJRzY0?=
 =?utf-8?B?OFQ3RVVucjlIcXRLbUVKNDdtZzhtc2xLSlRvQzRveFpSRzlhcUtLNS9nNGcx?=
 =?utf-8?B?Q3ZFOTZVMDd4VXRIT3p6L05ib2ZzbXhaSHZDN2IrR1Q2bTJDb21VTGphOG1u?=
 =?utf-8?B?Y0h1MTN5TEtrRERxeFZYYkVRWEdCR3NxWVJOZ1pYaFZzLzFLOEJhUVhnOTMr?=
 =?utf-8?B?SzB4QkJRdC9RZE1OL1MxZVM3dzExRUM3ZjNZR1JmTndkMlQzaU9TbmF6TlMw?=
 =?utf-8?B?MTZjNVNKd0VmMzZzSVNkR0oveGNkQUw1elpQNXlHeWEzRXdDMnZPbzlvSGg1?=
 =?utf-8?B?Y215K2JPMEU2WWt3Z3FqQ3AzenM2UWV6cHRnek1ZbkxhZERPWFRjTnhaYVlk?=
 =?utf-8?B?RDI3VDg1T0lxVGZkWGNUdGx5OThDOEZyWmZCK2x1WHQyZ1NjbFg5SGk3d001?=
 =?utf-8?B?Vm1rWkQvaEVtNmhmM3pSYk5OV1dwT0JMdzlBeDFRS21EOEhERGlmR2pnSXlY?=
 =?utf-8?B?WHVabDFhRlkvajFxYzY1ZlZ5ZUVKUEFIbHcyclFoQU16N0JuZHlIL3lDQmJF?=
 =?utf-8?B?bE9KWHJ1WTgrMlV2QVlpWFZkN0dBeTZ2cUhxT3N4Q2dQMjlIbE5paUMva0s1?=
 =?utf-8?B?cnp1Rk5VQU14akZKZmhDQXI0bnh1T0h1K1FGMW5hKzRHY1pZMTkrZFVGQWh4?=
 =?utf-8?B?VUFVRUcvT3dQVjZ1UEtkVHlYNmNMdWZLSlQwenE2bXpzYXZxZEs1eU1XZTVN?=
 =?utf-8?B?QlVWSUJlV054VlNSVWtscEpuREkyUTh2aitGUFdUemN1SXk2TkxCU3lWQW1Y?=
 =?utf-8?B?L1lpOHJ5NUJUcVY3Z0daZHlnUkxtVFhMcWpod2E4TlFrUjkyelM1TnY5V2Z2?=
 =?utf-8?B?U0ZIWUVib2dqS3RkcnVUd0tzRXpSMHNlOGxaR3lZSkZ6cURGLzE1blh0dTZr?=
 =?utf-8?B?OXFEcmhZOE02VmhFZjIybXFQS3A5ZXBTSDFuOEVCVlBmQ2Ryb0hkSk0rOFYy?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec23c436-97dc-4c0e-2d14-08de2d8f112c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 08:29:22.9904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1i3YUD3OPIH8zqVe6huE/cNSHAbZsA5j3TBr8jDDQcDvvSpUYUdwNyuJXu5TmHXcJFem0IevKZzWCsWcRMOb7wsbaLcJlFaJiryxQOzvPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8051
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

Thanks for the suggestion, Peng.

On 11/26/2025 7:47 AM, Peng Fan wrote:
> On Thu, Nov 20, 2025 at 08:29:11PM +0530, Tanmay Kathpalia wrote:
>> Thanks for your comment, Peng.
>>
>> On 11/18/2025 10:39 AM, Peng Fan wrote:
>>> On Mon, Nov 10, 2025 at 09:37:30AM -0800, Tanmay Kathpalia wrote:
>>>> Add reset control functionality to the SDHCI Cadence driver to properly
>>>> handle hardware reset sequences during probe. This ensures the controller
>>>> is in a known state before initialization.
>>>>
>>>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>>> Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
>>>> ---
>>>> drivers/mmc/sdhci-cadence.c | 8 ++++++++
>>>> 1 file changed, 8 insertions(+)
>>>>
>>> ....
>>>>
>>>> @@ -225,6 +227,12 @@ static int sdhci_cdns_probe(struct udevice *dev)
>>>> 	if (!plat->hrs_addr)
>>>> 		return -ENOMEM;
>>>>
>>>> +	ret = reset_get_bulk(dev, &reset_bulk);
>>>
>>> Should this be optional? Some in tree platforms may not have
>>> the reset supported.
>>>
>>
>> Yes, you're right-some in-tree platforms may not have reset support. In those
>> cases, the code will print a warning message ("Can't get reset") and continue
>> the probe process.
>> If you prefer, I can remove the warning and let the function fail silently
>> instead, or is there any other way you would suggest to make this optional?
> 
> devm_reset_bulk_get_optional() may help.
> 
> Regards
> Peng
> 

I looked into devm_reset_bulk_get_optional(), and I see that it 
dynamically allocates the struct reset_ctl_bulk and adds it to the 
device resources list if CONFIG_DEVRES is enabled. However, if 
CONFIG_DEVRES is not enabled, we need to manually free the memory using 
reset_release_bulk() in the driver's remove function. This means we 
would need to store a pointer to struct reset_ctl_bulk in the driver's 
private data, which would require additional changes to the 
sdhci-cadence driver (since it currently uses the generic struct 
sdhci_host with .priv_auto = sizeof(struct sdhci_host)).

Let me know if you’re okay with this approach, as it would require other 
changes in the driver, or if you have any further recommendations.
Alternatively, I can simplify the implementation as shown below:

ret = reset_get_bulk(dev, &reset_bulk);
if (!ret)
	reset_deassert_bulk(&reset_bulk);

Please let me know your preference.

Regards,
Tanmay

>>
>>> Regards
>>> Peng
>>
>>

