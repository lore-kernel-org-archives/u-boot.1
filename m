Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE8FCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 11:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F5983106;
	Tue,  9 Sep 2025 13:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GvSJPSpY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE5A8312A; Tue,  9 Sep 2025 13:39:26 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA114830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 13:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+osxYclZq1KprJjKUgZMlB0b7hgg7e2rnpwMKJJwelzBVbQN3xFzKoNPs9pqHkQkvVX8ez/6nFdFoaU3w7U7GlXwiWdZ8HGme0uNGvm4inyFPLlAFShEXZ11nZDnry86xrWmOMU2RcFZQkd3yx+32ZAySt34Yvgxu9aJzGlRwXAdl/9A9w8zllRDG2hwO7ZvQKxjX8axVqDLI2RKPfabDF+6MYL35r65ae8q3/03ZAEpBJrdzrCwOT3IFFWGoWczEWdepmguH7L9yA2Cn7i+A9YQiW+ck13M/Zd3coJKRGcaRHlb//ASurLmASCt1vk85+piIXfGP6/LiUommxJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ygLTdZlWPKRjzTCbJ8I/WMLNQ5b7fOzl3bSI36ezUA=;
 b=j9jRIFZ5APH2lFQ1iOdVzMTSKB6xtnHx7C9lrntEYQHmi4NP+tX3cT4sASSYy7kdlQXwMV4A5Ir4rUO18Gn/WbutLWI49NGl9Tr6AU5RSumSIe8pPz7THHy0gDxYhXj6K6/YpKwhW2H+3G/snq5uQD2koItrIkhKxe5RK/RdodkbRarscmACkEFhc+zdLA01zCZWd7gVInwAo68PNkxySu6qke1xtXVPskiJO7WTJj8e8mu+jFhbYQ56G28anVLvTvDFkIo/AVoCXPMsV1BtbXY3JyxDfPTNE+MFI8vIw8003sXleeOSQTt7yEYdaDVQj1s8EpJ/ZLYUDoMJRykKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ygLTdZlWPKRjzTCbJ8I/WMLNQ5b7fOzl3bSI36ezUA=;
 b=GvSJPSpYxzFle5k7uK6cQ0dqQikFTZM97YWQ3U9jAxCAENvdGX33O8+9VhLVqNrCr+u1g7Dp4VnwsWizGRrGZITVLnRq2Pia3PR0h//sxGDe2JOX1Gfg8eThOc/lBSCtfVZnvz7C2GY4AXNRx5lkxJHrr3wQPLK08+8hb0wFs1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:39:20 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 11:39:20 +0000
Message-ID: <33a7cd5f-955b-4aa6-9095-93359c983e15@amd.com>
Date: Tue, 9 Sep 2025 17:09:13 +0530
User-Agent: Mozilla Thunderbird
From: Love Kumar <love.kumar@amd.com>
Subject: Re: [PATCH] env: spi: Fix gd->env_valid for the first write
To: Michal Simek <michal.simek@amd.com>, Marek Vasut
 <marek.vasut@mailbox.org>, u-boot@lists.denx.de, git@xilinx.com
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com>
 <5046fa19-eab6-47fc-a740-d8f3268070f2@mailbox.org>
 <a117a5d8-c759-4fe4-bfbc-110e55a99945@amd.com>
Content-Language: en-US
In-Reply-To: <a117a5d8-c759-4fe4-bfbc-110e55a99945@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::15) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f1d05c-d387-449a-7661-08ddef958427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU0rMmsrQ0dEa080NkZmZFpEN1RsdmJwV1BPYkE1eHV1MVNBSTloS0VGZGwv?=
 =?utf-8?B?VTR5am1qQktrNGoxWUxmdnBXODVJSjlKOXk1eDdqNHMwTXlGWXcxVjErUmgr?=
 =?utf-8?B?dmhOZTdESU5UT21teitYZ1J2dlJ3aHVQeWJDWllISmlYZCt2SHVZSXd2TEw1?=
 =?utf-8?B?Tk81bE5iV2R2REdMdm9jbEpsbmlPWHoxZkRpVVNLTC9ZenZNNTJaS0lnQmNt?=
 =?utf-8?B?M1QwOVRyQU01Sy8xM3c3MmkzeDNSZXQ2Q2paRExxMnF5cDV5alJ1U0d1TFNU?=
 =?utf-8?B?Z2ppZmhMZS9jbzdmZ0JWb0JaZ0IxTkN0UWwwcGkwcXNWN1VLUzlMdWdqbU9R?=
 =?utf-8?B?endBU1BEQk8va0NWUjJlSWRPY0RFMGxQWHUyMlg1SzNKaXNDeFZNTWxQajV1?=
 =?utf-8?B?NVJuampkM1ZaSy9aQllsUUxlTDEySVgzK3JEcFdsVGw1VlYwbTBVKzZ0cU92?=
 =?utf-8?B?SmVLL204aXlucGZCMVB2NjVmdTJpZkg4S3ByaGJtUVdPaExXTFFCSzBTWWhh?=
 =?utf-8?B?MlM1b1NsNjRrc1htaVllRFdmS2NoTHFySmk4a052UUJjc2NBZTRLcG1lYmZM?=
 =?utf-8?B?K2wvRStjNjhzcUVnNXRmR21qR3JpRkcrUE9Rcy9VVTZtL0g4VXU1Y1VrWVdB?=
 =?utf-8?B?eTVIbGdXVVl0UVVHUDlLclJyaU95MnZYSGlVMHhKL2RBTlZ0UFlGeXphdnBy?=
 =?utf-8?B?U3NTZVRMdHUwTDYveis0ZlZTdG5UZCtXZmpjaDl2eHZtRFltZUE2aGQvS1pN?=
 =?utf-8?B?QUxwM3lEMC85NjZIMGw4ZVppd3NVTVlRWmhaMWExaTM2eUszajcvMFJYUE94?=
 =?utf-8?B?Mm1JVVZHMGp3RlVjQ2drcVJ6R25kUEZQY1BML1NEWjFCTHJJYVR3aHBoL3Yz?=
 =?utf-8?B?WEwzMnA1cUh3djRtTXVKWkhtbzBMV21zWUFVVnZlRHRWSjRqWDE3cXJxV2g5?=
 =?utf-8?B?cUt2VWFKSVBjVUpQUmoxdTlUL1lEb3JHNHpnc3gvTHlVSmpxbHNOaEl4T0ZO?=
 =?utf-8?B?c0xmYXhEN3JsKzgzVDFoblNkZ0Vrcm54M3kwS0lETXhPS2RVbGJYT0tjRWw1?=
 =?utf-8?B?Z3ZXWjZ5eGQxUnA3RXpPTEQvZFFvTG03ZDkreTVrV1pwdTBIZWZwajdUQmxR?=
 =?utf-8?B?empra1plVDF5RWJidVhWa1V1VUMxK1F0T21aUm80Ui9pc1A0NUFNVmU3SXZE?=
 =?utf-8?B?L2g0VFp3MjgyMWtQNDg1Uml3L2ZtQnlGbHpsSVJhQkRVR2VDc0xhT0R3NjFz?=
 =?utf-8?B?NCtKcnhVbE5uSXZzRjgvbGhLdmErVndHWDluM3JuVG9kOVdTR2NPVElyajA0?=
 =?utf-8?B?bEk1T0JSTkVOUS94NVhBRVBSL3M0OXhkVG4vNDFrd2QwaHBqdHRPV0twclV2?=
 =?utf-8?B?YmxWRnRkYy9palZzYytRUlEvNDZsSWZHZ05Ba05HT1BnYnRrYkEzT0xtbkFV?=
 =?utf-8?B?dThxN3U5czJxM0J5MkNoMGlsMy94aC8waWxBeVppR1o4VFhHSVdZUkRlR1g1?=
 =?utf-8?B?OStteU1tL2NDL3BwRWRzVXA0bWJBWHNNQTdUK1Vsd1BqVTlSanZSUER3S0p3?=
 =?utf-8?B?Q2RmQXlHeDB2M0xFWTFSUVhTeUtNTXR2NllFcTBpMlpEVDZONUtlRTA5TDl1?=
 =?utf-8?B?RnVQbGt5dnFVbGUwUDlmeDUxK01lbkUvemhyQ1N3eVNrbk9XSUlTU3JycXM3?=
 =?utf-8?B?VW5hL2VyT2RlR0J3WVRFclFORytjdE9ET053VXJDWFlsREE2SEVpV0lPUzNy?=
 =?utf-8?B?cFR2RXdMME43UUtTblQ0WjBJNW9yaHdIWWU5SmRITkQvT0Q4YllwUmZTbHBs?=
 =?utf-8?B?SUpJS0F0cGx0K1V1RHVNZnlpY0hyN2w5TWc4REg4aXo0S09PN3ZwNjhKbUM5?=
 =?utf-8?B?d3daZWdEVmNmM3RMRW56Vm51Q3plV2ZsRTlEUzZPODBZTWd4WWtHb1YrMmsv?=
 =?utf-8?Q?56s+VN2nkOA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3k5ZGNDM3pVcytKc1hobllBV0VlSTFFQ2dhQXJvUkhUcnBiTURxdFJFUWNW?=
 =?utf-8?B?Q0R0RVhBUllWOGhHbU1oQWV0Tm5FRmZXOWtHMDJ2WUNPKzF1QlV3cjJ1RUdZ?=
 =?utf-8?B?TzUxN043L21XMGVVcGo2OE10bGpBVC9scXNHUGkvMG5JTnBpTmpIVSsrMkxP?=
 =?utf-8?B?Q29BWXloZWxDc21tVlROVm81UGRxWlQraEkvZVV0RXZ5OEtVNnNFcDNETDZt?=
 =?utf-8?B?UEJrOHlpNktXWnQ2eEluMzNLU0N1VTZXRndoSEJqMjN3SjNZVzA5dnJLQ1B2?=
 =?utf-8?B?c0hHYXV2K3RzdXdNMGRhdE5NNkd1MVhyekh4RXBmV2VGS0xXcmwxUDFPTHB2?=
 =?utf-8?B?OUMxNTAvc09obVV4dTNPQlVzeTVDQnhxYkt0MVNidzZuVkdVU3QyM3l1L2Fs?=
 =?utf-8?B?OGdoT1E0K0E2bmluenFQQUROZW03amhmQmEzaysxSXdtc0pKdVZ0cGorOTAv?=
 =?utf-8?B?RlV6ZEtRVnZySXNZY1NkSlh2azUxcXlJYmEzSjRyRlZVOXNLVHU1aHo0UVBv?=
 =?utf-8?B?QzZ1eXpUYVlWKy9CSzBSOUhwMUNzZnh5U0JnYnI2N2c3WDRQZjE4TDVGd0Yv?=
 =?utf-8?B?MWpqTVU3T1JUZU43d1hmVzNLT1RDOUFPYU9iSGVhYUs5R01uR3hpRWo3Vk8v?=
 =?utf-8?B?NFlkdEZrbTV2cmUrTCtaZi9yMGQzaEFpYS9uUTNmYXdMc2RZNEZiV1AwaUl6?=
 =?utf-8?B?MU1OMzF0NDdBd3ZKSUM4TkpKaUxmeFZQbGg5RjRPQitxVDkvWVdSWmIvNm55?=
 =?utf-8?B?cUlzL0huVmdhMzV1MEdoUk9NTnRobW93L2xBdmJtMkRobVVsb0dmMm5kQy8v?=
 =?utf-8?B?WTN2clJJM2FoL2RWcmc5bWZxV1F1cXdvY3VLQVFtVU81L3kvZXBNYS9TV0c2?=
 =?utf-8?B?cGFmN0dpTWhLWEp1a0FKRXd0T3d5NE0zZ0F0S0NjSnhtTDVpMk85SVI5R09E?=
 =?utf-8?B?dlN6ZnBOY1U5bVo5Q0hmY0RaMnh6MTlHZnhpbDBlVm5paUIvQ0ZjdWhMUHRh?=
 =?utf-8?B?YmhETXhyUWZwM1docUtHVTJ1dklBV2hUUGhhNEtjTTVHS09FZ2h3R3RPMi8r?=
 =?utf-8?B?UVRKNUNOVjZCeFN3aGkzOXZKTVdpL0NUdnV6ZGNmZ1VkYlg5TTNtYXNCZTNr?=
 =?utf-8?B?L3A4enVMcXVUZEFBZXRKejR1d1lNcS9wc0hTay9HOEc0OUgxVGl4RnIvWjdz?=
 =?utf-8?B?Q0FkSlNaOVUwTlZyRDIwL0kydTB2MXUrS1VKQU5JSVVod2g0MSszSWNnR1c0?=
 =?utf-8?B?MlVxbnE5dGlaM05wYWd6Vzh1cEZrMEZXamd6NEJrU1pxbE5LUkdXWk13VzB4?=
 =?utf-8?B?VlhEcWgvV1NSaDl1OXdJVEQ1RGRPbDFFREYzUmlodmltU2xNczlxOTNlK2k4?=
 =?utf-8?B?bUdBbWdTOEhPUzZRdkxIT1lVb2hnbGNTSVI0b3BUdVErSnZyUEJWODdMTGFn?=
 =?utf-8?B?cHdUY2FnclZDTmRld0huUW5sdVhiZUZYeTJUSTZ5YyttYW9EMVpITDFHZ0lw?=
 =?utf-8?B?UEVZMkY0NkFBK21yanNxOTMyMTlDbmg0YjJhSEhTVUQ1YkFDaVBpWGhMZ3M0?=
 =?utf-8?B?MXhqakZQb0lacmZpb210SHFZT0NwVlA1Rmp4UnFYRHdFbWdEV0ZBSGlGcDkx?=
 =?utf-8?B?dDRrSGdSRVZzM1pETm5PUG1oMUoyZWhybi85RjFHZ2Z0UjJlY2JmUEFyTFNK?=
 =?utf-8?B?V1ZNV3NnK3EzSDdBNXVvL1JpZTNxdngxbVcrZG44MHNOTzluUGIxNWJmZmJu?=
 =?utf-8?B?eEpHcUxyWkRvYmJxa3hFU29yM3hSL1pnYXZuczM2bXF0OTY2UW5jem5ROEJB?=
 =?utf-8?B?cGhuUmlkdnB0TkhvVGpmbEdzckhVN2dONmh2TWdwZjFpVVIraVpBaGt3Uy8v?=
 =?utf-8?B?TlFOdU5FbDM2d2M2dDJ1d01hMHRDdXNPd1ZIVGFiTzkrWXBYdlE0OG83VHc5?=
 =?utf-8?B?Ymhod01wQ0htdm5wOGhqSVArU05La0JlUGE0WnkvRFJkQ21BUzFEMU44aEJG?=
 =?utf-8?B?ZStBWVIvNk94MWw1aysxbVBKRTVoQkgzTzBSQjVVbXFQWGd0ejdkaVRaWUx6?=
 =?utf-8?B?WFBLMmlXdzZYY0kwdkMxOXY2THVjS1Urd3J5VUY0TEFDeUNnWGkvQVdFR3Bq?=
 =?utf-8?Q?20MSrv6XYH+vXIvLjt7GSIJ00?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f1d05c-d387-449a-7661-08ddef958427
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:39:20.4779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hG+i9fgHSBXrmZ0D7Y6+FlixyVwUGDJ2zGpnF2Qk/KYRDE9WW/gKHTP08RgH0UXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
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

On 8/21/2025 12:17 PM, Michal Simek wrote:
> On 8/20/25 22:59, Marek Vasut wrote:
>> On 8/19/25 4:25 PM, Michal Simek wrote:
>> [...]
>>
>>> ZynqMP> mtd read "U-Boot storage variables" 1000
>> It would be better to spray the 0x1000 area with pattern first, otherwise, if
>> the 'mtd read' fails, such failure might go undetected.
> can be done.
>
>>> Reading 131072 byte(s) at offset 0x00000000
>>> ZynqMP> md 1000
>>> 00001000: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
>> [...]
>>
>>> ZynqMP> savee
>> "env save" is the modern equivalent.
>>
>>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash...
>>> offset 2200000
>>> done
>>> Valid environment: 2
>>> OK
>>> ZynqMP> mtd read "U-Boot storage variables" 1000
>>> Reading 131072 byte(s) at offset 0x00000000
>> This here looks odd:
>> - Where is the "offset 2200000" print coming from ?
> I had additional debugs in the code when this output was created.
>
> diff --git a/env/sf.c b/env/sf.c
> index 0b70e18b9afa..961e853eaef7 100644
> --- a/env/sf.c
> +++ b/env/sf.c
> @@ -127,7 +127,7 @@ static int env_sf_save(void)
>           if (ret)
>                   goto done;
>
> -       puts("Writing to SPI flash...");
> +       printf("Writing to SPI flash... offset %x\n", env_new_offset);
>
>
>
>
>> - The valid environment is indicated to be 2 , shouldn't that be 1
>>     (primary copy = 1, redundant copy = 2) ?
> yes it should be 1 but this is the code before this patch is applied and it is
> saying 2 but actual write is happening to 1.
>
>
>> - The dump of what looks like primary copy also seems valid, so
>>     shouldn't Valid environment be 1 (see previous bullet)
> yes - dump is valid because the first write is happening to primary copy but
> logic itself is saying that it was saved to redundant copy. And that's exactly
> what my patch is fixing.
>
>>> ZynqMP> md 1000
>>> 00001000: 5d691224 63726101 72613d68 7561006d  $.i].arch=arm.au
>>> 00001010: 6f6c6f74 6e3d6461 6162006f 61726475  toload=no.baudra
>>> 00001020: 313d6574 30323531 6f620030 3d647261  te=115200.board=
>>> 00001030: 716e797a 6200706d 6472616f 6e616d5f  zynqmp.board_man
>>> 00001040: 63616675 65727574 49583d72 584e494c  ufacturer=XILINX
>>> 00001050: 616f6200 6e5f6472 3d656d61 4b2d4d53  .board_name=SM-K
>>> 00001060: 582d3632 47324c43 44452d43 616f6200  26-XCL2GC-ED.boa
>>> 00001070: 725f6472 423d7665 616f6200 735f6472  rd_rev=B.board_s
>>> 00001080: 61697265 30353d6c 42323735 46313131  erial=50572B111F
>>> 00001090: 62004832 6472616f 7465735f 723d7075  2H.board_setup=r
>>> 000010a0: 64206374 30207665 797a203b 706d716e  tc dev 0; zynqmp
>>> 000010b0: 696d6d20 72775f6f 20657469 46467830   mmio_write 0xFF
>>> 000010c0: 30304143 30203031 66666678 203b3020  CA0010 0xfff 0;
>>> 000010d0: 74206669 20747365 61637b24 5f316472  if test ${card1_
>>> 000010e0: 656d616e 203d207d 2d4b4353 472d564b  name} = SCK-KV-G
>>> 000010f0: 6874203b 72206e65 74206e75 6b5f6d70  ; then run tpm_k
>>> ZynqMP> mtd read "U-Boot storage variables backup" 1000
>>> Reading 131072 byte(s) at offset 0x00000000
>>> ZynqMP> md 1000
>>> 00001000: ffffffff ffffff00 ffffffff ffffffff  ................
>>> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001030: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001040: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001050: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001060: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001070: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001080: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001090: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010a0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010b0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010c0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010d0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010e0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010f0: ffffffff ffffffff ffffffff ffffffff  ................
>>> ZynqMP> savee
>>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash...
>>> offset 2200000
>>> done
>>> Valid environment: 1
>>> OK
>>> ZynqMP> mtd read "U-Boot storage variables" 1000
>> This behavior here looks correct .
> yes for primary yes but secondary should be populated already based on log above
> but it is not.
> On the first save you should save variables to primary, on second save to
> secondary.
>
> As you see from logs. On the first save - the first location is used but u-boot
> reports that it was saved to 2 redundant location. On second save it is saved to
> the first location and also said that it is the first.
>
> But after this patch applied. On the first save - the first is used (unchanged
> behavior) and it is reported as the first (fix the report). On second saving the
> second location is used (fix) and it is reported as 2 (fix).
>
>
>>> Reading 131072 byte(s) at offset 0x00000000
>>> ZynqMP> md 1000
>>> 00001000: 5d691224 63726101 72613d68 7561006d  $.i].arch=arm.au
>>> 00001010: 6f6c6f74 6e3d6461 6162006f 61726475  toload=no.baudra
>>> 00001020: 313d6574 30323531 6f620030 3d647261  te=115200.board=
>>> 00001030: 716e797a 6200706d 6472616f 6e616d5f  zynqmp.board_man
>>> 00001040: 63616675 65727574 49583d72 584e494c  ufacturer=XILINX
>>> 00001050: 616f6200 6e5f6472 3d656d61 4b2d4d53  .board_name=SM-K
>>> 00001060: 582d3632 47324c43 44452d43 616f6200  26-XCL2GC-ED.boa
>>> 00001070: 725f6472 423d7665 616f6200 735f6472  rd_rev=B.board_s
>>> 00001080: 61697265 30353d6c 42323735 46313131  erial=50572B111F
>>> 00001090: 62004832 6472616f 7465735f 723d7075  2H.board_setup=r
>>> 000010a0: 64206374 30207665 797a203b 706d716e  tc dev 0; zynqmp
>>> 000010b0: 696d6d20 72775f6f 20657469 46467830   mmio_write 0xFF
>>> 000010c0: 30304143 30203031 66666678 203b3020  CA0010 0xfff 0;
>>> 000010d0: 74206669 20747365 61637b24 5f316472  if test ${card1_
>>> 000010e0: 656d616e 203d207d 2d4b4353 472d564b  name} = SCK-KV-G
>>> 000010f0: 6874203b 72206e65 74206e75 6b5f6d70  ; then run tpm_k
>>> ZynqMP> mtd read "U-Boot storage variables backup" 1000
>>> Reading 131072 byte(s) at offset 0x00000000
>>> ZynqMP> md 1000
>>> 00001000: ffffffff ffffff00 ffffffff ffffffff  ................
>>> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001030: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001040: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001050: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001060: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001070: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001080: ffffffff ffffffff ffffffff ffffffff  ................
>>> 00001090: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010a0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010b0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010c0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010d0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010e0: ffffffff ffffffff ffffffff ffffffff  ................
>>> 000010f0: ffffffff ffffffff ffffffff ffffffff  ................
>>> ZynqMP> savee
>>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash...
>>> offset 2220000
>>> done
>>> Valid environment: 2
>>> OK
>>> ZynqMP> savee
>>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash...
>>> offset 2200000
>>> done
>>> Valid environment: 1
>> It would be good to validate that both copies of the env are actually written
>> where they are supposed to be written . This part is missing from this test. And
>> in fact -- it would be good if this fix did have a proper test .
> I can validate it again but even now log is too long now.
> It is just demonstration that at start you get two saves to the same location.
> When 2 saves happens behavior is correct.
> I think it will be good if you can try it on any platform which this enabled to
> see if you can demonstrate the same problem.
>
> Love: Can you please take a look at if this can be added to pytest?

Sure, Michal.
I will take a look at it.

Regards,
Love Kumar

> Thanks,
> Michal
>
>
>

