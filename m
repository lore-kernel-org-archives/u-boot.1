Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9CCC25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 07:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EBE5881C3;
	Wed, 22 May 2024 09:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sYpzS2Pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795AD88113; Wed, 22 May 2024 09:35:19 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70CB881C3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6SFyugAErGx3P2Xb2LCYhhe5J0DMbF9fxbeU8EapxsB+Ov0yBIX2fGzcOQhoyG95P38UlXg4IqCS4MzqxfduuvvFDYV7B/vsCT7gakydB/aPNtqHZFpsh9NKB5Kzan8NlmqKA0PiizbQU8fKnFbe7YjnGCGdcPmFurJO5FuQFLb84noZvm1YaKWqcRNCIMJP2brJPUZQnwnzj6DwZGT+WnttNrUZqdeM0XDlGTGBEf+ULjIEya285w8UZO8G942GhYngba1qQenR7qPqt7cion4A4O3WhBVKbbUFS9MWTP0I0a0SF3WzvpAVKgQDryaRp04HWO4oSJAFf/G/JgIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUrMICC1MVCsU5SLTvbBZUEtwgOYMv3SwKzdF1v03m4=;
 b=ah+faUu3dFB9MKlugkQJ2FB5qEK8Q7HNv2sXFhWiesiYKa3wn/k6coGAxEU1HII08TDbsamrULE3o59IFkxWiNyNd9L+Ej20wdfT93XOEpKJslajExpJqNXrHDByftEvVe+LHzgbflAg7GwNKA96gua1RrUYUFks60BZdkfFjb4nPAKpBPvqC+SxFzDON+kO5DrM0Z7rhXG//pVUYZgvw8O/A2Y7z+ZS9JsdyT4qfwIOO9fslAQ6puSVlY33gTXs+7pYFYGIRBeisCQGrwFtZx7pUDrFw7Zk8wwgeHnObWuhcCMxSb37Ok7M+9IV0iPbLgGxe3hxinyADpWOJ9FzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUrMICC1MVCsU5SLTvbBZUEtwgOYMv3SwKzdF1v03m4=;
 b=sYpzS2Pno+uYTRj0h/Relxw/fPiyMFKJp7x1IdhVgNksfdxWW/9ttZRFtES6odkkua38PDNtN0ne5g8Xa8cJ7hzTf112l2Q+5zyIjEvtB/7quLaRg9dEakxz65yE94WWQ8LwgIaNL2ih8w//YWXfWJcpubwxd1lWhSsr08u58z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 07:35:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 07:35:09 +0000
Message-ID: <675fa9e4-f524-44ca-8c18-51580fadbb77@amd.com>
Date: Wed, 22 May 2024 09:34:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240521205955.3569600-1-tharvey@gateworks.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240521205955.3569600-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0157.eurprd07.prod.outlook.com
 (2603:10a6:802:16::44) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 7451a137-9fbd-4ba1-128f-08dc7a31b57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFg5eCtRV3V1RENxR1BnV3VITkt5MWV2THljbW8xQzlPT3M3ejloV210aXNO?=
 =?utf-8?B?cTFScGNqOEpjMGMvanBBekt0OHhxNnVOUWdiV3NRb05QTGptL1Y4dVVTbHRr?=
 =?utf-8?B?bnZoYkd0RHJYckw2RXdUdGVRejI3a2tUQW1UUDlESkozMzRpbXlnMnQwSUE3?=
 =?utf-8?B?c0RHRWpjMWRZQVUxM25sQWh3eFlUZThtRjVXRzlrL2NaTEJOU2xuakhqRWxI?=
 =?utf-8?B?S1l4a2dLWE1SeE55Z2w4bUlWNEhsUVZsczl6T3VKMm1VMnNRbTQwZFl0cXAy?=
 =?utf-8?B?Q1I4TDhDeEFOYmx1Sk0xUHhHakJJclNoWEdMREx3M2FUSVl5eVBCUUJDZWwy?=
 =?utf-8?B?Z0VqbTVSRUZ5Z0RYcGp6a3p3bmJIZEZqYm1aWWp4Mmp3eW1lM0t0aHBmTTV1?=
 =?utf-8?B?NGl2WWRobWZTcmVnQWR4WktONHpwdENZSjY0MkplbzViWjVVMmZGcmJhbnBn?=
 =?utf-8?B?bGhJTXN1UUNJcFdIbDBkWUZwRzBka1lnSmVERFNuYW1lN0JTVjFncCszYWIv?=
 =?utf-8?B?Qzd1UVJzdXRaUG9MZHcxaFdZOUN5anNWQjY5d1RZZ2V0VFdOc0dueVRUSjNT?=
 =?utf-8?B?K3hzd1hPVUswSDJoenV0eFV3YUZRczlKenE2OCt5bGNEaVNkNWtLU3NlaFpo?=
 =?utf-8?B?cWJXR0JuSlg4U1Fpb2dsUmJBajliTVVWa3p2OXp5OUF1WHZXZmk4alRuMEhM?=
 =?utf-8?B?RlY2UkVLUkdkaGNnNWhqVTY4dkJpNWVCWnRWaHJIYXNYUjVKcnhMSlRMdXBF?=
 =?utf-8?B?NmtnUU14TDRlL1VmQ203dXRpdEhWZGdUNHdaNVJ4TU1CdzdyUGN5UEhvNFhP?=
 =?utf-8?B?Z3MvRUhRVWNkREtycmdHOVdtL3JsY0trYVgrTDIrdFd2NVd0MDVmeXkva092?=
 =?utf-8?B?UDlVU0hYbUNJOW1KcWFvMzRVajJRZ29KVFY0eVBlb0lTZFpxWnQzdHRyZTFL?=
 =?utf-8?B?K1pYYm9CcjZCdmlobjQ0UkVLeVhyZUI4OXh6aXpIbkcycmludDEzNlljVnFy?=
 =?utf-8?B?cTJuQ2sxR2d3a25KazdaZ1cvWHZrSExlSVdlQUVrOVdlaXdvY3R0cU84K09W?=
 =?utf-8?B?Y2E2SGNLelFjUnpMVmtRSFpmclpnT3BaaS9mQTNKai8xazNCbnF1blhxWGVK?=
 =?utf-8?B?ZWpaM2lWdkl1cTkzQlhpY0hKdUwyOTdkYUNjSThPV0NselJEOVhiWHhTZjdv?=
 =?utf-8?B?RWswWUxPaDJYem9zMS9ua29TVVlNb2xhNDZNcDFueVNsNWdzbWxjVWg0MFJq?=
 =?utf-8?B?aWtvNGk3S2p0dlVXS1lDVWlXV0Z2YjNFSHUya2pqbnhrbzlJdEljMDRSaEJ1?=
 =?utf-8?B?YWtNQjZ3U0N4NFlUenp6TllJaWV5UTFkNk9QZHdHcndwYjhaYUpaVm5na3kx?=
 =?utf-8?B?RGRYVFFhNDZKZnpja0NaclhzQkpjcGlVdVJ4aDVMVlVteGJra2JRVVphM1VZ?=
 =?utf-8?B?YjZmQk1vMW5GU3g2QWtjRmhTaWRCdHc1bjI5UVphUWZVbGpLSUFYRU5FeW5D?=
 =?utf-8?B?U2lPN3YwK0hzL0ZhNTBmZ0ltc3V0aWZRK29hVUpSRnl6M0ZwWmQvRUxQcUx3?=
 =?utf-8?B?RWs4cVBieVRPTC80NlN1emNaR3BrVE1HYjZKemJPb1Y3bjlaampCeDdHcE9T?=
 =?utf-8?B?YXZZZkhCcTFCTllybTJwdHJ1VzBOQkJpcGhpcXh0WVRxV0tvQ0hQSFIxcjNz?=
 =?utf-8?B?THdKNmpVQ3hpT1pBakNMa1dPdXZuckpKT1VSQkxwZTBFZmlzd1UzTE5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3diMDNjMU0yNXA5K0xwbmZSWlBBWk8rTzNHRzFiblhmbDBVcnNldm1QL3B0?=
 =?utf-8?B?aC9uTHBVa09MOVJjdnFjcEJhZTZyb2F6NEltbGMvdjczL245Y0YyT0RBVEJL?=
 =?utf-8?B?cHFKRi80cU9FY3NFbFMycU04Y0dIL2Zra1NJWm9qd0NvQU5Jcllaa2NCZXp3?=
 =?utf-8?B?bUFKbmpiTkZ5aS9IR1VCd3lYclF1V3RiSmtOV0x1SVFCNVVham0vY2thb2Jx?=
 =?utf-8?B?SUhYTTBmRUI5SlR1N0F2eUlyZUtWMllBNkpGZEEyenFoTlpKR2xaSVZMbnZ5?=
 =?utf-8?B?SkNPWm1xWlVLYk5ZUDR2SmlGOGxlbEFHQXM4SkJ4bnpvRFZ0RVRMT2JNRnU2?=
 =?utf-8?B?ak0rL1J1QXl0ejEzQ25VQVRHeWFmM2hnTHFpbENUY1JBLzUrUzZaa2ZJRlNT?=
 =?utf-8?B?R3ByYXFyNndkSklNRnpKMy9CT0lvaDhoZUF4dE1UcXJHaUlIYUdXMExXUFJG?=
 =?utf-8?B?UjFXYXQxSXhkV0Nkeis0YUtnY0xWbElIdnp0aW5XcVVZQ3B4T0FlQnVNK2pt?=
 =?utf-8?B?c0h1WWUxb2hhSjIvZUt3MW4zaFc0S1lzRlI5MjE4b1hCUXhxbEZkaGhMZ2tR?=
 =?utf-8?B?UEdvWXlmM0NrY0QrajkwU09wUVNXdXJmYS84dHRWTjdlNVN3b05GQUlvcktO?=
 =?utf-8?B?OHJGVUdhdVBVdW5oTGQ5NTFpakFRMVV2dWlRSER3WmpYdkNmZFRDRTJ3em9k?=
 =?utf-8?B?akF2VGZldEZ4ZEZRTmNTYU9kVVlrWkFaaFcwVmc2U3lwMkNrL2hlQ3ZOKzVt?=
 =?utf-8?B?QlpjYnZpalBmay96TmM2WWhZVlprdk5zREgySUNOajRpTWlqS1BCQjRob2NB?=
 =?utf-8?B?OWQrVDNHTlBHWTk3QURtQVRJZWx4Zms4aVM1a2RZVUozUk9YamxrSm5vUkpD?=
 =?utf-8?B?YnNKSXlKaEdEYXhiKzVMVGFpSkd1QWtNSUxPcmFoajA2Qk9vQUVpQ3JHbWk5?=
 =?utf-8?B?L1BldFlOcnBFbVQ4RVZQZUpJRFNWMUVqT0RmYVRNQXcrUW52ZnUxZTNGRkJw?=
 =?utf-8?B?ZHIzYnk3RTVOZ09kcWdsY2I5M0dabGpYUVEra0JheTgzOEs3dkg4QWY3azRS?=
 =?utf-8?B?S29wdlBiaTd2MlU2SmZ0OGpNUC9oeEJpOTFtVCtSaFVWNHFFOXkzSzcvMnhX?=
 =?utf-8?B?RGJvRE5ISlEyYnR3eVNBQzcyaWw5aXRFK2pmS25FSFk0TWN4NEdkNENLb0VW?=
 =?utf-8?B?d2hPUnpOVWtSaFo2Vll6dExVd0FYMU5pTGlBQTBLZldiN3ZuSjNjSG5QVklm?=
 =?utf-8?B?b29sVFZ6TDMybVZIeUlhMkU2bWdXZTI2MTdPM042MGRnYzMzNENPaHA1ajRo?=
 =?utf-8?B?Y3dSOG9wY0xRb0xadytWazVRNkVpcVJCemhlRUVGdkhvZ0dCRDkwY1lBWGND?=
 =?utf-8?B?cTk1dmNVYnVTL3FqdCt6L2VjK0hzYmI2ZDg5dCtTR2xMdEl1ZCtVZ1J5U2VF?=
 =?utf-8?B?THM0d1FiazFGZGsyREE1MGJMcDB1SlVxVERmcURaVkFCSUplRTBkdlBNZUUz?=
 =?utf-8?B?ZC9FUHhjb3haM1c3c3BqNnBObit2Z3J2ZWd2Q1hLdmdnS21CQThHRFpMdWdE?=
 =?utf-8?B?cjZvMktoRHZwN2tZNEhCb0NISEpLVC9wMEtOUWJ3MDUybGNPbWtWZEpyN29I?=
 =?utf-8?B?bzc4QkxWRG9CelhDRmRYMUpPVWZTL3hRcmhBTEVhbDJxNTFvam50Zjk0RFRj?=
 =?utf-8?B?Tm5XSEZZcGRvQ2VDVm5vT1hhOHpuYjR0eHJHYy92WDhteUk1TXZSQi9sdkVO?=
 =?utf-8?B?K2tYMmVaOWV2M2FzNFFuQ3NCR0doWUxsQ1ZVR1NGMmhMVnpTRnQ4OE5sWldV?=
 =?utf-8?B?WnhRbXl2VXExUVQwN20wb3R1QUM2VlgvTEhHRHRmV3JyTnZ0S0pBbnowRDFK?=
 =?utf-8?B?UWMwR2lVSENaYVlrSkZSVXNZUGtacGxVaXFHeWpNdmpEd2RmUGtqNkQ5VHZv?=
 =?utf-8?B?VDgyeFFyZGk0enRtUkQ4ek9WRlFQOFVPRkxBTmx0cGNXaHN5Rk5iU1p6OWs1?=
 =?utf-8?B?d1YxMi92Tmd1LzdlbWlWS3NBa3ovY2NtUXpIMFZ2bUh6WFI3N2dhZUpmQ0NK?=
 =?utf-8?B?RTByN2htVkk2Q1MvNmhFeTlWZk1GczFQVkpWU3dyUGRNcjJTTkN4WnBnUmlX?=
 =?utf-8?Q?jkUr1TmHBedx1R8VRcMc3Skwf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7451a137-9fbd-4ba1-128f-08dc7a31b57c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 07:35:09.9098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhgxIuipkvo5fPa3VPOVO1P6/1TEtNluqzhjBToPIcySucM/cTlJ0434EK0pZpn7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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



On 5/21/24 22:59, Tim Harvey wrote:
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> 
> If we have DM_RNG enabled populate this value automatically when
> fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
> is enabled as it's implementation uses a different source of entropy
> that is not yet implemented as DM_RNG. We also skip this if
> MEASURED_BOOT is enabled as in that case any modifications to the
> dt will cause measured boot to fail (although there are many other
> places the dt is altered).
> 
> As this fdt node is added elsewhere create a library function and
> use it to deduplicate code. We will provide a parameter to specify the
> index of the rng device as well as a boolean to overwrite if present.
> 
> For our automatic injection, we will use the first rng device and
> not overwrite if already present with a non-zero value (which may
> have been populated by an earlier boot stage). This way if a board
> specific ft_board_setup() function wants to customize this behavior
> it can call fdt_kaslrseed with a rng device index of its choosing and
> set overwrite true.
> 
> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> but left in place in case boot scripts exist that rely on this command
> existing and returning success. An informational message is printed to
> alert users of this command that it is likely no longer needed.
> 
> Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> randomization and completely ignores the kaslr-seed for its own
> randomness needs (i.e the randomization of the physical placement of
> the kernel). It gets weeded out from the DTB that gets handed over via
> efi_install_fdt() as it would also mess up the measured boot DTB TPM
> measurements as well.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Akash Gajjar <gajjar04akash@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Devarsh Thakkar <devarsht@ti.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> ---
> v3:
>   - skip if CONFIG_MEASURED_BOOT
>   - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
>   - pass in rng index and bool to specify overwrite
>   - remove duplicate error strings printed outside of fdt_kaslrseed
>   - added note to commit log about how EFI STUB weeds out kalsr-seed
> 
> v2:
>   - fix typo in commit msg
>   - use stack for seed to avoid unecessary malloc/free
>   - move to a library function and deduplicate code by using it
>     elsewhere
> ---
>   board/xilinx/common/board.c | 35 -------------------------
>   boot/fdt_support.c          |  6 +++++
>   boot/pxe_utils.c            | 35 ++-----------------------
>   cmd/kaslrseed.c             | 45 +++++---------------------------
>   include/kaslrseed.h         | 19 ++++++++++++++
>   lib/Makefile                |  1 +
>   lib/kaslrseed.c             | 51 +++++++++++++++++++++++++++++++++++++
>   7 files changed, 85 insertions(+), 107 deletions(-)
>   create mode 100644 include/kaslrseed.h
>   create mode 100644 lib/kaslrseed.c
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 30a81376ac41..f741e8957818 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
>   		fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
>   
> -	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -		debug("No RNG device\n");
> -		return 0;
> -	}
> -
> -	if (dm_rng_read(dev, buf, n)) {
> -		debug("Reading RNG failed\n");
> -		return 0;
> -	}
> -
> -	if (!blob) {
> -		debug("No FDT memory address configured. Please configure\n"
> -		      "the FDT address via \"fdt addr <address>\" command.\n"
> -		      "Aborting!\n");
> -		return 0;
> -	}
> -
> -	ret = fdt_check_header(blob);
> -	if (ret < 0) {
> -		debug("fdt_chosen: %s\n", fdt_strerror(ret));
> -		return ret;
> -	}
> -
> -	nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
> -	if (nodeoffset < 0) {
> -		debug("Reading chosen node failed\n");
> -		return nodeoffset;
> -	}
> -
> -	ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -	if (ret < 0) {
> -		debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> -		return ret;
> -	}
> -
>   	return 0;
>   }
>   #endif
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 874ca4d6f5af..b64cdd34825a 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -8,6 +8,7 @@
>   
>   #include <abuf.h>
>   #include <env.h>
> +#include <kaslrseed.h>
>   #include <log.h>
>   #include <mapmem.h>
>   #include <net.h>
> @@ -300,6 +301,11 @@ int fdt_chosen(void *fdt)
>   	if (nodeoffset < 0)
>   		return nodeoffset;
>   
> +	if (IS_ENABLED(CONFIG_DM_RNG) &&
> +	    !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
> +	    !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
> +		fdt_kaslrseed(fdt, 0, false);
> +
>   	if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
>   		err = fdt_setprop(fdt, nodeoffset, "rng-seed",
>   				  abuf_data(&buf), abuf_size(&buf));
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 4b22bb6f525a..35d5b9ed3ecc 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -8,6 +8,7 @@
>   #include <dm.h>
>   #include <env.h>
>   #include <image.h>
> +#include <kaslrseed.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <mapmem.h>
> @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
>   #if CONFIG_IS_ENABLED(DM_RNG)
>   	ulong fdt_addr;
>   	struct fdt_header *working_fdt;
> -	size_t n = 0x8;
> -	struct udevice *dev;
> -	u64 *buf;
> -	int nodeoffset;
>   	int err;
>   
>   	/* Get the main fdt and map it */
> @@ -342,35 +339,7 @@ static void label_boot_kaslrseed(void)
>   	if (err <= 0)
>   		return;
>   
> -	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -		printf("No RNG device\n");
> -		return;
> -	}
> -
> -	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -	if (nodeoffset < 0) {
> -		printf("Reading chosen node failed\n");
> -		return;
> -	}
> -
> -	buf = malloc(n);
> -	if (!buf) {
> -		printf("Out of memory\n");
> -		return;
> -	}
> -
> -	if (dm_rng_read(dev, buf, n)) {
> -		printf("Reading RNG failed\n");
> -		goto err;
> -	}
> -
> -	err = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -	if (err < 0) {
> -		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
> -		goto err;
> -	}
> -err:
> -	free(buf);
> +	fdt_kaslrseed(working_fdt, 0, true);
>   #endif
>   	return;
>   }
> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> index e0d3c7fe7489..958ecd8efabb 100644
> --- a/cmd/kaslrseed.c
> +++ b/cmd/kaslrseed.c
> @@ -9,33 +9,16 @@
>   #include <command.h>
>   #include <dm.h>
>   #include <hexdump.h>
> +#include <kaslrseed.h>
>   #include <malloc.h>
>   #include <rng.h>
>   #include <fdt_support.h>
>   
>   static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   {
> -	size_t n = 0x8;
> -	struct udevice *dev;
> -	u64 *buf;
> -	int nodeoffset;
> -	int ret = CMD_RET_SUCCESS;
> +	int err;
>   
> -	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -		printf("No RNG device\n");
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	buf = malloc(n);
> -	if (!buf) {
> -		printf("Out of memory\n");
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	if (dm_rng_read(dev, buf, n)) {
> -		printf("Reading RNG failed\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	printf("Notice: a /chosen/kaslr-seed is automatically added to the device-tree when booted via booti/bootm/bootz therefore using this command is likely no longer needed");

missing \n here.

>   
>   	if (!working_fdt) {
>   		printf("No FDT memory address configured. Please configure\n"
> @@ -44,27 +27,11 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
>   		return CMD_RET_FAILURE;
>   	}
>   
> -	ret = fdt_check_header(working_fdt);
> -	if (ret < 0) {
> -		printf("fdt_chosen: %s\n", fdt_strerror(ret));
> +	err = fdt_kaslrseed(working_fdt, 0, true);
> +	if (err < 0)
>   		return CMD_RET_FAILURE;
> -	}
> -
> -	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -	if (nodeoffset < 0) {
> -		printf("Reading chosen node failed\n");
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -	if (ret < 0) {
> -		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	free(buf);
>   
> -	return ret;
> +	return CMD_RET_SUCCESS;
>   }
>   
>   U_BOOT_LONGHELP(kaslrseed,
> diff --git a/include/kaslrseed.h b/include/kaslrseed.h
> new file mode 100644
> index 000000000000..7f9911c59fa4
> --- /dev/null
> +++ b/include/kaslrseed.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> + */
> +
> +#if !defined _KASLRSEED_H_
> +#define _KASLRSEED_H_
> +
> +/**
> + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
> + *
> + * @blob:	fdt blob
> + * @index:	index of UCLASS_RNG device to use
> + * @overwrite:	do not overwrite existing non-zero node unless true
> + * Return:	0 if OK, -ve on error
> + */
> +int fdt_kaslrseed(void *blob, int index, bool overwrite);
> +
> +#endif /* _KASLRSEED_H_ */
> diff --git a/lib/Makefile b/lib/Makefile
> index 2a76acf100d0..20a0242055fa 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -149,6 +149,7 @@ obj-y += date.o
>   obj-y += rtc-lib.o
>   obj-$(CONFIG_LIB_ELF) += elf.o
>   
> +obj-$(CONFIG_DM_RNG) += kaslrseed.o
>   obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += semihosting.o
>   
>   #
> diff --git a/lib/kaslrseed.c b/lib/kaslrseed.c
> new file mode 100644
> index 000000000000..29d7ed2e7718
> --- /dev/null
> +++ b/lib/kaslrseed.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
> + */
> +#include <dm.h>
> +#include <rng.h>
> +#include <fdt_support.h>
> +#include <dm/device_compat.h>
> +
> +int fdt_kaslrseed(void *fdt, int index, bool overwrite)
> +{
> +	struct udevice *dev;
> +	const u64 *orig;
> +	int nodeoffset;
> +	u64 data = 0;
> +	int len;
> +	int err;

nit: you can just use

int len, err, nodeoffset;

> +
> +	err = fdt_check_header(fdt);
> +	if (err < 0)
> +		return err;
> +
> +	/* find or create "/chosen" node. */
> +	nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	/* return without error if we are not overwriting and existing non-zero node */
> +	orig = fdt_getprop(fdt, nodeoffset, "kaslr-seed", &len);
> +	if (orig && len == sizeof(*orig))
> +		data = fdt64_to_cpu(*orig);
> +	if (data && !overwrite) {
> +		debug("not overwriting existing kaslr-seed\n");
> +		return 0;
> +	}
> +	err = uclass_get_device(UCLASS_RNG, index, &dev);
> +	if (err) {
> +		printf("No RNG device at index %d\n", index);
> +		return err;
> +	}
> +	err = dm_rng_read(dev, &data, sizeof(data));
> +	if (err) {
> +		dev_err(dev, "dm_rng_read failed: %d\n", err);
> +		return err;
> +	}
> +	err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(data));
> +	if (err < 0)
> +		printf("WARNING: could not set kaslr-seed %s.\n", fdt_strerror(err));
> +
> +	return err;
> +}

Thanks,
Michal
