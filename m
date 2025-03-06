Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FEBC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 12:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3517F808A2;
	Thu,  6 Mar 2025 13:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sv2f8I3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82867808A2; Thu,  6 Mar 2025 13:23:29 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A72180756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 13:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXSd/k/DRnUtvRJ8KAM33ggy6Tt1J2M5ZR95TVgvVkZNOUru0pZ0CQ6dTeKFwGkw0DgXZd2IXthiCt86uP9VmtAGS6FESaTTdfcg4n8btSjtlIQIwb+uQ6jotnbEA+/DoH3VM2OhMTGVfptHsfCDEpePbfNzEp4V+mMAoIuqHBYhRYFrTaZGuUcp/nIHYKRQ3+Mzq9bMrPd9Ih7p6D5xHA19OnYNU2rFEqqRWHk4Gwent/4NsMdHYlcVqYQFikMSyThzrFluRwjcXob43r4bd23jLUbe7i/s3U/PxK/iwMf1TItnxDOqR1HrFiu1pqdykVy0MXi49JzhreFQp+27hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOznRYKQSDfu709+YTokBUCXH2Nv+H6swNfq6y/V+Hg=;
 b=i4BBk3Z+teIYfVqRUANR+n6yJvFCoOJy5yW3N+MUhzLZXy5fb9AC8hdHH0I+JPV/k9OF3dWh89VR/qRMHh9v8xx81sceJec9pTqWWv5cXLXP8bJYjzyCx68w4iROSIXj5Z9u+ycGsQJN+UzTP2UMG854ET4aaqLaYuVatb+vrg9NG0/yJdDSzHIRTJsGB0NIYzbLn04jKoIyGNvEt0vkL1FoaYqMuRSOquzf3/TeJ9MVjUeaR4OJZoVomy/5oh2n39f4hpuBIiEdLWeYizjedQ9mvLdrMCsEp0lmYMWZZom5qoRahANTodNFR9fVzlnbmLj3t9Xwjg0s5o5CtUywFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOznRYKQSDfu709+YTokBUCXH2Nv+H6swNfq6y/V+Hg=;
 b=sv2f8I3RKeBlqaoPnknCR3KXOMVqF7P3zTd+bzjmgwlkSDHO9qae5CD3IxH2n/vvG4ivzFeHwuxoeKG0xprqjxdewgcz7LLk9SDm3Ni5bY7zg2k7As3hogtYRVXXz0PrgL9H5pMyCxfmyB6uWzepN1bJZAg7+mgqJLCQeQGjszE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 12:23:23 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 12:23:23 +0000
Message-ID: <4e5d7225-663e-4040-a208-95fd8bb0b3c1@amd.com>
Date: Thu, 6 Mar 2025 13:23:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] board/BuR/zynq: initial commit
To: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Fabio Estevam
 <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20250211124957.104907-1-bernhard.messerklinger@br-automation.com>
 <20250211124957.104907-5-bernhard.messerklinger@br-automation.com>
 <de79214c-088e-4554-9e40-b8fce677bf3a@amd.com>
 <DB9PR06MB855954FEBC17BC680E24CAB2D2CA2@DB9PR06MB8559.eurprd06.prod.outlook.com>
 <7d3b9a41-59a2-48c9-a0bf-846890642709@amd.com>
 <DB9PR06MB85594C77AE8EE6D9D5DD70D7D2CA2@DB9PR06MB8559.eurprd06.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <DB9PR06MB85594C77AE8EE6D9D5DD70D7D2CA2@DB9PR06MB8559.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::35) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 2506e7ce-e614-4cc5-bf02-08dd5ca9b03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2dzS1drQ0h6QWNrRlRMVHAvR2JoSVc5ajRKaVJJVnFDWDV0THh3bHJwNDZi?=
 =?utf-8?B?M3o3QmZXWXNkWE9Vb0E0T2RpNit5eXhQb1JMZDB3VDI3dkU1Z0RIZFR3dGo2?=
 =?utf-8?B?aXNVMm83MjVHNllNaUtZWklFUWhucEN6OU5jUlhCcTVWelpwbW5kOEx0Vy92?=
 =?utf-8?B?dVVMWjVoakJpSmY5SDJSWkdpbXBtVW9ycHZxZ0laWFdWVC9xK1NTWTJFNjRO?=
 =?utf-8?B?TjlvV1pCeWRJdjFVaGdkblByNm9Lc2xIaFNFY3MrV1M2SmZ1eWtBb3FHMmFV?=
 =?utf-8?B?R0pROEhtSHBMTU5UR0VseklrcEphaEZ6MDdSQ1Z1R2NLZTNuOEY2OFlPR2FN?=
 =?utf-8?B?VnNDWlF5akZ5QjZIZVB3Z3BuQUhqUW5MSzdLRXhkMHFhdHE0VVNrRnJNc2FV?=
 =?utf-8?B?R2NBbDRYd3NTS0NwbnVvZDZtVTVrRi82Rk1vR2piSUZuTHlVaElSZDlsYXdY?=
 =?utf-8?B?Z1MvZEttVEkyQ2ZTajAzbmMrb1JZSUxZeXhnQ1RGOFBzZ0tpUUk5SDhYMFNH?=
 =?utf-8?B?QlB3cmFsRWZ3QWdvOU1FOTd6bXRIZi8rVEJMUDJFRThvc1VKcjdpSnVkai9n?=
 =?utf-8?B?VGh3aHQ1MDFPUk5pcmVOSUlqU1MyNHp5cU11WVJmaUtGVEhpS1RmY2N4VG5a?=
 =?utf-8?B?eExobElsd3Z1Y1RVa0h0TDU4NjYxS1E4dzJlRnVsWGsvNjl0THlSNFpiOVBi?=
 =?utf-8?B?UXhCMytXa04wTXBWdEpiVm1Edzc4WDBCQVNzSHFCYzRrU2wxTzBwamZHZTVD?=
 =?utf-8?B?SXJGWHVFQ0dFQ2taVFdDdExnaUZ4NVEyQ21Yd2I0Q0NoR3N6VEJFSVQ0YVhy?=
 =?utf-8?B?QlVzdG1OaDVuTVhtL2dwREExN09Ua0VURjEzUTFlNGxNNi9PalBFbzgxTUR6?=
 =?utf-8?B?U2FIdzZsSVdpSFVabnJqeXIxVm5hT25CbW0vOWZsTkFhWDlTRnhtMGtieEQr?=
 =?utf-8?B?V0xEL0tJak9WR0FjUU81Wmt6cmJ4MGl6NytKYk05c2l2clZ2NEh2Zk9qZTBu?=
 =?utf-8?B?VGh2QzVRWk1OMWNhZzdFaW1ITHIrMlREUWdNR25Hb1o5OEwzUndJUU5ZdEpK?=
 =?utf-8?B?QWNBOXJLaEhGcmlTSEwyMm1oNVBtL3FmUklNaDhUSmNVRUtjRitFcmJmMjZy?=
 =?utf-8?B?MUdQcVIrUVpRSll3QVJKMERKb0o4REt2RmRLQzc2L0dJdUVQa1B1eVVucldE?=
 =?utf-8?B?M2ozMGQwZzZwODRHeHgvREYyeU0vampFNFUxSXloWEtEeVhRYjhrbWk3Tnc0?=
 =?utf-8?B?aHp1NlYzcTJuUi9HNU9kWm9qL2dOMThHa05xNTRwYzBIalNaZkladFBoYUdu?=
 =?utf-8?B?NGVoZEdRcjYzVDdpN2l5ZU5wVDV2dzFEN2hoRHBqWGNlUUJ2Q05NYjk3cWVG?=
 =?utf-8?B?dExla0VlbnF4MWl0d2JCQXhQNjVTZkJqdTAzSHhlUFNRbjNxMjVNWWhENXhH?=
 =?utf-8?B?TWlFcCtSYmhVdm9ZSXV0OEN2MXFONEhFN2N4UTZmNXdTUXJKRlNrRCtpUHRP?=
 =?utf-8?B?bTc2MU5hYnFkeHVuRkJwT3N5allWR004SHNPZzQ0SWRGbGlYZFluLzZVZHAx?=
 =?utf-8?B?YmRoa04rKzdIa3NpS0NucWdNaU9Bc1dmNWZyM3dUaWVpQ01vZUgrQ2FLRjdy?=
 =?utf-8?B?cHZrdVpsdHplWFVOYXkyUWI1VkJQU2F6ZS9ydlRLS2JjU3hyTzYvMWh0aDho?=
 =?utf-8?B?VTN5b2dUT25aQXVKdXo2d3dtL3BHaHYvQ0pQa3pFNlY3V0pVRlFJLzlWdkxn?=
 =?utf-8?B?MndJTU43dTJvbkF1ZEMxcUtaKzd5YjJ4YXE0NHlIY1RBYWdjQkUveWhWOXkw?=
 =?utf-8?B?L3Zhc3BCTHQxVUNKYWlFTURqRm5ud3FDVjdxSTA4Z2FFVzZ6OERCSkdlU0dE?=
 =?utf-8?Q?7TtZqIzO6agI2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXd5ckRMNTF3elFldnBvbTUyU3RWWCtVVUQyTmRONkNBMmJBcjdnV2YwUjZm?=
 =?utf-8?B?UWNkK3RMS2d0MUM0VzhoZ0N1UW1UaEhYYStXUVJmU3A1Sy9TSUFISVdZZDc3?=
 =?utf-8?B?VHFWNWpyQWlZSEpiQytYSHhqWFBvdXVGYndzczJ5SERuTDdwYkwvZ0hxUDNw?=
 =?utf-8?B?cTZDOHplTHZudS9wOUdWdmZha3l6clB6RHpIUjRwcFYwYmdLYUNha2JBdnhk?=
 =?utf-8?B?RHp1bkJnZ3RVcFVSWmxoTGwrY0JscDF6OHpwb2k4NEZLZGdsK0R4MVBWeG5z?=
 =?utf-8?B?bUtlV3hEdXNOUGN3MitBaXZXZmZFdWZGYlhFb2hsbTlRaHA1WWRudm1yTGs3?=
 =?utf-8?B?ZzhHNXlJdDRyS1BTbnV2Y3YxTXdIckRlZng4SlRqMVdVamFYbmpoOE4xZ1pP?=
 =?utf-8?B?RitCckhnT0pDNWhuRUpNci9OVXVHYVhwZVQwaXBOV3VQNVVFNTkvbjc1OUw4?=
 =?utf-8?B?eGdUTTduUmp2Q1l6c1NMdHBzVHN0SzA3R25UMjV0Qytuc2oyMDVmcjQ5SDhN?=
 =?utf-8?B?b01tTnlXLy91b0NOVllEUUUybzl4cWFuTXpIZHhudFJ2ZCtvUzFraEtKRUJ0?=
 =?utf-8?B?bzlKbVM5a29zWFZ6WisxRG0vcnNYa1ROcEVIaVFPTGdmTWloRE11dnhsZjFM?=
 =?utf-8?B?NDlMOVNyNDBycDBsa3BYZ2wwVlNFZlNxR3hiZDl0NFE2OUhOUHBJOE5RK0hO?=
 =?utf-8?B?YlUxeHBURCthRG5CK0tCRW43ajg3UzFpWHZuZnhSWCs0UXN0ZTYyRStDcFB2?=
 =?utf-8?B?d1J4aUhROXFrUWwrR1hzb1JsQzVFR05xRGRTNm9ubzZ6K3A4MHE0Z29wRTBC?=
 =?utf-8?B?akYzMldBMER5VDFWSmg4UTZ6bFllVE9YWTk3OStLdVRhMzJkdTQ3SDJUbXo4?=
 =?utf-8?B?aXc4dTVGN29rNmk0VUR3RktLZFp4NDZ0ZE93Y1hGQmIydFdvamFpOUxMR3FU?=
 =?utf-8?B?Y2g1SmNJY1Fya05ncXZRd0JhSzkvdisvSVQ0Vi9rTCtHdXhXOUw5ekN3cmtM?=
 =?utf-8?B?VzRqUFVxTjhJSlZGRk56dEJpSFVvOW96RTJ5WU40RHZlUVBneHF6RWozVnlJ?=
 =?utf-8?B?VTc1VVAxejgyZGc4NWlUNm1ZYnZOZ0pMK0FhYkxOcUl2UWhhYWhPSjY0R1FX?=
 =?utf-8?B?WkV3OS84ODFUTTQ1ZnpMdC8rRUM5bGE5NHN3NEdFZlFPWUhhNk1McUZGbGMv?=
 =?utf-8?B?dnZDMkZXU2hzZWlTRVh6SDhzdTR4blZKYVEvNnp2RmlOeks0dTl4U1c3aUVX?=
 =?utf-8?B?RUkzc2JRWXROL2NiRytmeXU0SHRWYkM1UmVhbVhkVktwSWtmWnpHc3Ryc0lK?=
 =?utf-8?B?Wm4rVDdkaFd5NTVvK3U3aXQwKzAxZ2N1R2tQUVovRDMzSEFiTWQwaTlkQlY2?=
 =?utf-8?B?Q3h1SEhHbVZRQ1RXVUJobWk5bmNrc0lTUXV5Ri9oQnBZQmxoYnlUdVpoQkpH?=
 =?utf-8?B?RjhBeUhKbGNvMVRWSXowYUxBdTN1SFVvNGdwZG81QWczVHVPWWMrSGdzc0lL?=
 =?utf-8?B?cHlyMkkvU0c4c2NEcThrK0w1YjhyYStoZlBBN2xQZlBsU214TENGOUoxdkJv?=
 =?utf-8?B?WWo3MGlpNHlJYmM2Ujd4NlRSZEdGWFZ5VEYwaG95SldEemg0TVJ3am5PS0tQ?=
 =?utf-8?B?eFp3Zm1uRTFWSnpuNitpNGpQajBVUThPZ2lDN2JSbHVkeU1oSzE5Qkg5NGs1?=
 =?utf-8?B?ZlA4Y1l2NytOUTY0TGZnQkhsZElmZGIzY2JRWkJQU09wNDQvcDZjd1plREd3?=
 =?utf-8?B?U0dwQzJ4WFpvTEN6LzBSVm1POUs4UnZXaUxYMU1kL1VGWTZ0dzloTm9SVXBn?=
 =?utf-8?B?OGpWTDhsSys1VG1hSFhIdXZXdCtTU0plelNMdzlDWFlPamxCblBNTHo0eEtS?=
 =?utf-8?B?elQvaktYWEJZdHVyd2k4cWNIMDVocXdxajd6UE1maytyWUZiQXFJbjZkaE1G?=
 =?utf-8?B?YWFiclA4ZXh6L3U2QVdyNGYyN3B4am1SSjI5Y0hXVmNsVGc3TWNrQ1dNZytI?=
 =?utf-8?B?ZExCYjJWWmNxL3ZtQzNVSXBNem05SUpQeTNEcUY0OUplZHljRjJSeXduQ25i?=
 =?utf-8?B?aXVLUWEwd2FEakRwaXJoUjRPR3J1RTgrK1l1L0RPNDRtZGVkUnNqek5WVXll?=
 =?utf-8?Q?Djfmu2P6HKn0/K4l98T3egvOT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2506e7ce-e614-4cc5-bf02-08dd5ca9b03d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 12:23:23.3683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwJ9mhVM3aZlyiWGK7tQhl09vBS/Rq+n8ovTVlLvy+brF6HTZ8ZeG7iQSBdyBPCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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



On 3/6/25 12:52, Bernhard Messerklinger wrote:
> 
> From: Michal Simek <michal.simek@amd.com>
> Sent: Thursday, March 6, 2025 11:35 AM
>> On 3/6/25 11:20, Bernhard Messerklinger wrote:
>>> From: Michal Simek <michal.simek@amd.com>
>>> Sent: Wednesday, February 26, 2025 11:23 AM
>>>> On 2/11/25 13:49, Bernhard Messerklinger wrote:
>>>>> This commit adds support for the brcp1, brsmarc2, brcp150 and brcp170
>>>>> boards. This boards are based on the Xilinx Zynq SoC.
>>>>>
>>>>> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - Remove all unnecessary device-tree entries
>>>>> - Reviewed led names (no pattern restriction found)
>>>>> - Fix maintainers file
>>>>> - Cleanup of code
>>>>> - Move preboot variable to env file
>>>>>
>>>>>      arch/arm/dts/Makefile                         |   8 +-
>>>>>      arch/arm/dts/zynq-brcp1-u-boot.dtsi           | 110 +++++++
>>>>>      arch/arm/dts/zynq-brcp1.dtsi                  | 133 +++++++++
>>>>>      arch/arm/dts/zynq-brcp150-u-boot.dtsi         | 129 ++++++++
>>>>>      arch/arm/dts/zynq-brcp150.dts                 | 174 +++++++++++
>>>>>      arch/arm/dts/zynq-brcp170-u-boot.dtsi         | 113 +++++++
>>>>>      arch/arm/dts/zynq-brcp170.dts                 | 140 +++++++++
>>>>>      arch/arm/dts/zynq-brcp1_1r.dts                |  29 ++
>>>>>      arch/arm/dts/zynq-brcp1_1r_switch.dts         |  30 ++
>>>>>      arch/arm/dts/zynq-brcp1_2r.dts                |  22 ++
>>>>>      arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        | 110 +++++++
>>>>>      arch/arm/dts/zynq-brsmarc2.dts                | 158 ++++++++++
>>>>>      arch/arm/mach-zynq/Kconfig                    |   1 +
>>>>>      board/BuR/zynq/Kconfig                        |  14 +
>>>>>      board/BuR/zynq/MAINTAINERS                    |  11 +
>>>>>      board/BuR/zynq/Makefile                       |  15 +
>>>>>      board/BuR/zynq/brcp150/board.c                |   4 +
>>>>>      board/BuR/zynq/brcp150/ps7_init_gpl.c         | 278 ++++++++++++++++++
>>>>>      board/BuR/zynq/brcp170/board.c                |   4 +
>>>>>      board/BuR/zynq/brcp170/ps7_init_gpl.c         | 274 +++++++++++++++++
>>>>>      board/BuR/zynq/brcp1_1r/board.c               |   4 +
>>>>>      board/BuR/zynq/brcp1_1r/ps7_init_gpl.c        | 274 +++++++++++++++++
>>>>>      board/BuR/zynq/brcp1_1r_switch/board.c        |   4 +
>>>>>      board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c | 270 +++++++++++++++++
>>>>>      board/BuR/zynq/brcp1_2r/board.c               |   4 +
>>>>>      board/BuR/zynq/brcp1_2r/ps7_init_gpl.c        | 277 +++++++++++++++++
>>>>>      board/BuR/zynq/brsmarc2/board.c               |  30 ++
>>>>>      board/BuR/zynq/brsmarc2/ps7_init_gpl.c        | 276 +++++++++++++++++
>>>>>      board/BuR/zynq/common/board.c                 | 231 +++++++++++++++
>>>>>      board/BuR/zynq/env/brcp1.env                  | 109 +++++++
>>>>>      board/BuR/zynq/env/brcp150.env                | 119 ++++++++
>>>>>      configs/brcp150_defconfig                     | 123 ++++++++
>>>>>      configs/brcp170_defconfig                     | 122 ++++++++
>>>>>      configs/brcp1_1r_defconfig                    | 122 ++++++++
>>>>>      configs/brcp1_1r_switch_defconfig             | 123 ++++++++
>>>>>      configs/brcp1_2r_defconfig                    | 122 ++++++++
>>>>>      configs/brsmarc2_defconfig                    | 122 ++++++++
>>>>>      include/configs/brzynq.h                      |  21 ++
>>>>>      38 files changed, 4109 insertions(+), 1 deletion(-)
>>>>>      create mode 100644 arch/arm/dts/zynq-brcp1-u-boot.dtsi
>>>>>      create mode 100644 arch/arm/dts/zynq-brcp1.dtsi
>>>>>      create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi
>>>>>      create mode 100644 arch/arm/dts/zynq-brcp150.dts
>>>>>      create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi
>>>>>      create mode 100644 arch/arm/dts/zynq-brcp170.dts
>>>>>      create mode 100644 arch/arm/dts/zynq-brcp1_1r.dts
>>>>>      create mode 100644 arch/arm/dts/zynq-brcp1_1r_switch.dts
>>>>>      create mode 100644 arch/arm/dts/zynq-brcp1_2r.dts
>>>>>      create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
>>>>>      create mode 100644 arch/arm/dts/zynq-brsmarc2.dts
>>>>>      create mode 100644 board/BuR/zynq/Kconfig
>>>>>      create mode 100644 board/BuR/zynq/MAINTAINERS
>>>>>      create mode 100644 board/BuR/zynq/Makefile
>>>>>      create mode 100644 board/BuR/zynq/brcp150/board.c
>>>>>      create mode 100644 board/BuR/zynq/brcp150/ps7_init_gpl.c
>>>>>      create mode 100644 board/BuR/zynq/brcp170/board.c
>>>>>      create mode 100644 board/BuR/zynq/brcp170/ps7_init_gpl.c
>>>>>      create mode 100644 board/BuR/zynq/brcp1_1r/board.c
>>>>>      create mode 100644 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c
>>>>>      create mode 100644 board/BuR/zynq/brcp1_1r_switch/board.c
>>>>>      create mode 100644 board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c
>>>>>      create mode 100644 board/BuR/zynq/brcp1_2r/board.c
>>>>>      create mode 100644 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c
>>>>>      create mode 100644 board/BuR/zynq/brsmarc2/board.c
>>>>>      create mode 100644 board/BuR/zynq/brsmarc2/ps7_init_gpl.c
>>>>>      create mode 100644 board/BuR/zynq/common/board.c
>>>>>      create mode 100644 board/BuR/zynq/env/brcp1.env
>>>>>      create mode 100644 board/BuR/zynq/env/brcp150.env
>>>>>      create mode 100644 configs/brcp150_defconfig
>>>>>      create mode 100644 configs/brcp170_defconfig
>>>>>      create mode 100644 configs/brcp1_1r_defconfig
>>>>>      create mode 100644 configs/brcp1_1r_switch_defconfig
>>>>>      create mode 100644 configs/brcp1_2r_defconfig
>>>>>      create mode 100644 configs/brsmarc2_defconfig
>>>>>      create mode 100644 include/configs/brzynq.h
>>>>>
>>>>> diff --git a/arch/arm/dts/zynq-brcp1.dtsi b/arch/arm/dts/zynq-brcp1.dtsi
>>>>> new file mode 100644
>>>>> index 00000000000..f1cf75f1277
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/dts/zynq-brcp1.dtsi
>>>>> @@ -0,0 +1,133 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>> +/*
>>>>> + * Copyright 2024 B&R Industrial Automation GmbH
>>>>> + */
>>>>> +
>>>>> +/include/ "zynq-7000.dtsi"
>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>> +
>>>>> +/ {
>>>>> +     model = "BRCP1 CPU";
>>>>> +     compatible = "br,cp1",
>>>>> +                  "xlnx,zynq-7000";
>>>>> +
>>>>> +     aliases {
>>>>> +             i2c0 = &i2c0;
>>>>> +             serial0 = &uart0;
>>>>> +             spi0 = &qspi;
>>>>> +             mmc0 = &sdhci0;
>>>>> +     };
>>>>> +
>>>>> +     memory {
>>>>> +             device_type = "memory";
>>>>> +             reg = <0x0 0x40000000>;
>>>>> +     };
>>>>> +
>>>>> +     chosen {
>>>>> +             stdout-path = "serial0:115200n8";
>>>>> +     };
>>>>> +
>>>>> +     usb_phy0: phy0 {
>>>>> +             compatible = "usb-nop-xceiv";
>>>>> +             #phy-cells = <0>;
>>>>> +     };
>>>>> +
>>>>> +     brd_rst: board_reset {
>>>>> +             compatible = "br,board-reset";
>>>>> +             pin = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>>>>> +     };
>>>>> +
>>>>> +     leds {
>>>>> +             compatible = "gpio-leds";
>>>>> +             se_green {
>>>>> +                     label = "S_E_GREEN";
>>>>> +                     gpios = <&ledgpio 0 GPIO_ACTIVE_LOW>;
>>>>> +                     default-state = "off";
>>>>> +             };
>>>>> +             se_red {
>>>>> +                     label = "S_E_RED";
>>>>> +                     gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
>>>>> +                     default-state = "off";
>>>>> +             };
>>>>> +             rdy_f_yellow {
>>>>> +                     label = "RDY_F_YELLOW";
>>>>> +                     gpios = <&ledgpio 2 GPIO_ACTIVE_LOW>;
>>>>> +                     default-state = "off";
>>>>> +             };
>>>>> +             re_green {
>>>>> +                     label = "R_E_GREEN";
>>>>> +                     gpios = <&ledgpio 3 GPIO_ACTIVE_LOW>;
>>>>> +                     default-state = "off";
>>>>> +             };
>>>>> +             re_red {
>>>>> +                     label = "R_E_RED";
>>>>> +                     gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
>>>>> +                     default-state = "off";
>>>>> +             };
>>>>> +             plk_se_green {
>>>>> +                     label = "PLK_S_E_GREEN";
>>>>> +                     gpios = <&ledgpio 5 GPIO_ACTIVE_LOW>;
>>>>> +                     default-state = "off";
>>>>> +             };
>>>>> +             eth_se_green {
>>>>> +                     label = "ETH_S_E_GREEN";
>>>>> +                     gpios = <&ledgpio 6 GPIO_ACTIVE_LOW>;
>>>>> +                     default-state = "off";
>>>>> +             };
>>>>> +     };
>>>>> +};
>>>>> +
>>>>> +#include "zynq-brcp1-u-boot.dtsi"
>>>>
>>>>
>>>> Why? It should be added automatically when you run build.
>>>
>>> This is not case for me since I have 3 base device-trees:
>>> zynq-brcp1_1r.dts
>>> zynq-brcp1_1r_switch.dts
>>> zynq-brcp1_2r.dts
>>>
>>> This device-trees include the same base file zynq-brcp1.dtsi.
>>> The file zynq-brcp1-u-boot.dtsi is needed in all 3 of the above files.
>>> But the zynq-brcp1.dtsi file naming doesn't trigger the automatic include of the
>>> zynq-brcp1-u-boot.dtsi file.
>>>
>>> My approach is to include zynq-brcp1-u-boot.dtsi manually.
>>>
>>> Also I don't think it is a good idea to create 5 u-boot dtb files:
>>> zynq-brcp1_1r-u-boot.dtsi
>>> zynq-brcp1_1r_switch-u-boot.dtsi
>>> zynq-brcp1_2r-u-boot.dtsi
>>>
>>> Perhaps you have a better suggestion for this problem?
>>
>> pretty much bootp-all can go to your standard files. It is the part of dt-schema
>> for a while now that's why don't need to keep it in u-boot.dtsi only file.
>>
>> And then you have only binman part. You are not adding fdtmap to binman that's
>> why I think map is not added to binary itself and you have only description in
>> DT. I am using CONFIG_BINMAN_DTB and if you don't need to have binman node on
>> your target you can use it too. Then you can simply share this across your
>> boards and you will avoid sourcing these files.
>>
>> M
> 
> I use the binman entries in the environment to get the spi-flash offsets.
> 
> +/* SPI layout variables */
> +cfg_addr=
> +	fdt get value cfgaddr_spi /binman/blob-ext@0 offset &&
> +	fdt get value cfgsize_spi /binman/blob-ext@0 size
> +
> +fpga_addr=
> +	fdt get value fpgaaddr_spi /binman/blob-ext@1 offset &&
> +	fdt get value fpgasize_spi /binman/blob-ext@1 size
> +
> +os_addr=
> +	fdt get value osaddr_spi /binman/blob-ext@2 offset &&
> +	fdt get value ossize_spi /binman/blob-ext@2 size
> +
> +dtb_addr=
> +	fdt get value dtbaddr_spi /binman/blob-ext@3 offset &&
> +	fdt get value dtbsize_spi /binman/blob-ext@3 size
> 
> I also use the binman fdt in the SPL of one board to get the FPGA
> SPI-FLASH offset.
> 
> One way of fixing this is to move bootp-all to the standard files and also
> add the binman entries with an extra file with the config option
> CONFIG_DEVICE_TREE_INCLUDES=zynq-binman-brcp.dtsi?

Wasn't aware about this but looks good to me. You can keep -u-boot.dtsi files 
for boards which matches the name and for others use this CONFIG option.
Another option would be also to create symlink which make this also clear.

Pretty much it is up to you how you manage that files but one thing what I 
didn't like on your solution was that you are including files which should be 
included automatically. And trick you did wasn't really described in commit message.

M

