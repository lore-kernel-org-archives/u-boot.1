Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A896C369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2D982E66;
	Wed, 16 Apr 2025 13:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LAROoIsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6672E82E76; Wed, 16 Apr 2025 13:54:34 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C9D82E34
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTeg3dF0D13GfTH+Dqqs/xPzeOuyZyS4aNbaF7UHdFblCLrT0e2mgsLJ3/v8WXX67ef6seViiHeuuMC5QfDdpqLmh0+EfdEOYUnPk6w7r8J9l4uoB93Hj1UIgvp1IfhVlutSsnPFMDNus0JC6sF1hO4BDirjCDHgm/hcv6icJPzMAJESv8zPzgLQ3g5nEA19eqhCkmw9O3mR+1u7Rs9AN8GSYmUTaOP4gvdniRg1E+3KPh9kyw4pQk8Ch821E44UGxsvjy8qbetAr3OrZ6wgObGZW+CmRq3gZN8AcPXQsZy7reu+Kf/MFVoJeMAn17tR4mwxsazt4AonhlKIOaGm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeKRVcKiZuBsQwcWFuIpTq9w3at2uQH6tzO2Myw19S8=;
 b=anWnEb+WhTShuI59crh/S8HtpPSzOnSkQV1paXBHb1IfUFis+qsyQF1E+UsDc/WJAYhQwdsgXI/XuQ8vS+Rk+9FIoc1aLhYH3XamPtIrdLcLFsoY7ASDCuieMmHKimhz+hnXluRG4kefJTVj9oIhjpOdGmCvi6/JkPF4R+M87F/syt4SlYQwdEgVzgBwfL9RZSvHefQLonx4Vh42w30FhbpC4WVpi8mbSF62+8EOqOhJQCrZEVza1Nj3+RI3wikzmit0KozABByUGha9cDbWn2bZSKAb2q6mZIrn+KDQ36UrJy2pCQZf3oeeWyhmqUvt+w5EHC5fE1GfV3B+8bX23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeKRVcKiZuBsQwcWFuIpTq9w3at2uQH6tzO2Myw19S8=;
 b=LAROoIsSb2h2sP7gh4Eyz6qiq8oFrD0oG2dAymCu1Y2P+Bt1vhd54QMRMZP3V1Xdsbzg1l+XAMnq0uejYQJubxQw0yrX51pc/DmHQJHmX1lUd1aBKOdTzh/+IH3LPuRbuujJXP98Zs9PRua5phUkKzOYegZu2PZ+p4uM+PBBbSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 11:54:28 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:54:27 +0000
Message-ID: <fe06b4d3-4f9e-4f84-b7b8-7ffcb2f5550c@amd.com>
Date: Wed, 16 Apr 2025 13:54:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: versal2: Read an eeprom
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com
References: <20250409162639.588487-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250409162639.588487-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: c32953f4-dd67-4177-289b-08dd7cdd7099
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGl3bW1KaXdUZjNNZlgwVDcxSGt3S0xoU2Y2ditnNTlheFdWR1V1V0NMU1FN?=
 =?utf-8?B?UXJIaXcrOEtDaVdzalNrUWxjNW4zaVVlOFZMQkd3S3J3TGtPYWYzV1N0ZGdU?=
 =?utf-8?B?YkdNNU1xNG5FSml2bTBzd3BCV3ZRcGVvMUg1YmZMMDZXS3NnWTZNNFdvdWdt?=
 =?utf-8?B?U0tPY1I2ZnhiVURYdVFoWjFWRTg3T2lhT09SME10YTJuMkN0ZkQ0ZHU5dURV?=
 =?utf-8?B?Uy8yc21rYWdPMGRvYWxOckFLT0g5MTkxMDY4S0lIbE50MVR4RDdUNWd1QUVC?=
 =?utf-8?B?WUNCT1pRUU5IRnhlRHpwV2ZSSExNTHFMQkxGL3hYTmI5MnRUWUdSRzBkVndU?=
 =?utf-8?B?Q1Y4azdDOUJBbEpDY1JHOTNFMU5kM3V5SWFRZktZb05VU3E3V3BkY0d4UWxx?=
 =?utf-8?B?SjkwYlUzTFUzQmpLcHJIWFhKMVB6bUowR0RJYWVXOGF6ZDVzK1BZNk9kbHJT?=
 =?utf-8?B?YlRZblZkT2c4aVgrRmNESW5YQTYrYmJ2ampUaUVjbnJIR0NocUt0eGRYZWhm?=
 =?utf-8?B?RkcxbFZyd2VtM0tsQkc3akdKOTFLajduMGFCNGZLMUdXSlFXazlyQlJIWkxh?=
 =?utf-8?B?bjVkdGExMEc2ZWtOVWZTWGFUbndrMVJ6aFJJdTVuL3BEUnVITnZEWllCek5V?=
 =?utf-8?B?V05iaC82K2o5TERjRkg0VExiWWI4QzdSU3M1S2xTT2RCQ2xJOGFYS3Bkc0Y1?=
 =?utf-8?B?Z3MyTGRBc0pyMWl3Mml4b1dvREpsWlpaQUgvL0RteFFPK1lhYURSMmR3Y0I2?=
 =?utf-8?B?bmJoVmF0bitEZEM4c1NBV0gvUW8wMU5ZMTdmbHpncERhdWRxQ1M1ZVdrcndE?=
 =?utf-8?B?NHM5eGtHcllJRHRzR3c4bXpnVDhXR1RJdTg3RDR0L0FSZGFJM05oQWlTTHM2?=
 =?utf-8?B?TGwwNWlSc3ppcms2aVE4d2VuM2NMbGd5cGxMZ2sxKzdqdmdRWFpNb21jV2lX?=
 =?utf-8?B?WHF1V3hRUDRpcmZSV1VOcjR0OFdEQ2Y3WHdDQnViWE5LWWI3SXd5M1ZUMFRp?=
 =?utf-8?B?SEV1VC9QL3EvOFlDY1RvcXNXSmpoVHRidVU5K2g5K2svTllwTUhPVi85a1I3?=
 =?utf-8?B?aE5FSWFQS0cwSG5xd1dkTEdsYlY0anVwUG1vSm9kR3AyK1IyY2JoUU9CMW8r?=
 =?utf-8?B?OHlmb1h3Q29WK2ZSOGwvVGJsUnovUkVaNjZTbkJiNmg1NHhxTG41QzhPVHVZ?=
 =?utf-8?B?Z00wYnAwSmgwY3QrQS9YSWdSVjdZTkhuM2FzQmxhTkROeXRERW1iaDI2TE55?=
 =?utf-8?B?bTRGSldYVjl2Wm5TdnJhWDVyV20rZlc0a2VweUxlb2YydDF6YWg5OWpqZWpL?=
 =?utf-8?B?aFpRUlRWdnU3UUl5MDN1dE56U3JWdHFxUUkvY2h5M0FyRVI5S3dXOXZhcGlk?=
 =?utf-8?B?OFVLMXlUSGR6aW9jYmF1dmNveE8wYzl5Yit2a1R6d0FTeUJLd0dXWTgwUktt?=
 =?utf-8?B?Uit3YTNZaTczL0dUVnExLzhqT3RDZ0t2b2FHdEV6dU5zZ21KeDNxYVpMTE9V?=
 =?utf-8?B?bTVCK2NVWGNHZHlBZzhRVjNjdDd6ODVUbEtMUlhSVFh0K01Ca2NNRjgzeTVF?=
 =?utf-8?B?T3RlTTR2SmpnNkJHNzl5VGhEWlZoV1Y0UTRQb3pGcDlyTXpzd3l4R1RVV0dX?=
 =?utf-8?B?Y1NuOEE1WW9CdjdadDhiWmlQaEJ2SlBacjJmdUxnMEJrczlIRHIyTHU3ckR6?=
 =?utf-8?B?V2FyQkNMZzgyS3lUbTM3Tlc3ZEt1d1htL0lPcDJtaFZPS2FEMGVUZ2pwb01Y?=
 =?utf-8?B?eWNIVFJ3VTErcWhGeERLNU5VK3dlQllQR0lVMGxSMTMxdXlRZVp6cXFUd2lm?=
 =?utf-8?B?QTcvWDZMWW9Ca3lLbUVQQnhyOHloQ0llQWw5WTFJd094eXByS1ZKTnhpMCtN?=
 =?utf-8?B?L0lENVJVNnQ3WTRBTjJJQ2RSZFBvSW5tWElCN3J3VVV0KzdNeWViUDhDeDA4?=
 =?utf-8?Q?9wcY2XV99Ao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmh0cHhNeUVTU2taNXZQLzhOa2pPQmtUR21WQ3E0Mk9DRkJYYUNlTDhNYUNS?=
 =?utf-8?B?OTl1aHlHa3cwY0FUb3NQMnY2WWQ2S2JjMytoK0J6TmxiWTlOc1RObW5tbU81?=
 =?utf-8?B?ZHVmU1VHTGdLeFEvTndwUnF1bURGNUprK1FGQ1lLTzdRampYNGNUbzdUZmxC?=
 =?utf-8?B?SG55RGlLTXN3WmU0RjJHaVVwN1BLeW5ZT3U0R3dPMFloOWExWGFLeHlFazhO?=
 =?utf-8?B?MlZXeUYxaE9NeExhZkpKem1ieEppdm96UG1oc1cyOElhZy81TTlMTjRxWUNr?=
 =?utf-8?B?blgyOE51VzdnNkdTMzNwNENpTGdCRlBvSXZmMTloTXhibWl3ZDhhTDQ1K3NQ?=
 =?utf-8?B?TVFLWnNXVExhajhmZGxhNjlBejFIdEFNV1pXQ1ZtNkM0REhHdk4wNE5nMXM4?=
 =?utf-8?B?eE1ZdjZIek5JcENtbFU0ZEFpbG5JZlhyMGNRS0lLQ0kxTkplTGZFVFdJUEM4?=
 =?utf-8?B?NmJLbTJJUEVuY2xyYzZUZ1JSUHQrQ3o3cFdWNHNJZVVORDE5L1cwMENpdXVq?=
 =?utf-8?B?YW1UTmdPSU9TckhoamZtdnlkaEE2OTBBS2Z1N0JDOUhVOU1lRmZrcUpObmwv?=
 =?utf-8?B?S2lrRHNILzdBaW5oVzE5ZFNIYzV0eTJCRGkrbG1XbFArUmdNNFk4dGhFa2Rl?=
 =?utf-8?B?aU02aFN3dE81Qy9ZYjNRRVhzNkV0SDZEM1ZaaERUZ09RNTErREN3Tkt5a0lV?=
 =?utf-8?B?SjFyeXk5RWRTdERnd3EzME1NVVFhTCtZODIrS00rcncvYmUzMEtESlR0NCtR?=
 =?utf-8?B?NjZaNkFSQVlFcVdmSmVmeDFmQTB2TnF1MjVySGMyb1BrcjRUQ3gzTUFqWGxM?=
 =?utf-8?B?cWhzYXhPOTlRa1hGaUNuZDJCL3NRaFlaS1l2NlIwUGlUVGxyUkNLa1dWM3FW?=
 =?utf-8?B?OEp0cEVIdWJudXk5ZHlkbTcxQ0VlQjcxbFhkdW4rOTlESUJjUnFKWFo4Rm8r?=
 =?utf-8?B?MmJMbUI3NWdaM2hlbzNoY0liY1VYM2xydEtuTXBDMnZrRnUzNTNQTU9GRWNO?=
 =?utf-8?B?RW5IOTNsclRyR0hNN3cyeFl3N056d2VQb09aWFUrK1VieGdyaUQrV0pYR1dJ?=
 =?utf-8?B?VGJuY2NHYXFVeGViV2p1ZWNCYUZRMitqRVo4VlRqQ0l0WDVleXFKSi95Wml6?=
 =?utf-8?B?YzNTU2pmUGc2c1dMcWE1Y2ZjYWVBU2xVazRoN3dIZlI4YU1FUzlQWitRV00v?=
 =?utf-8?B?VzlVQVUvMUZlV3cwS2Ntd2YxUjVaVGNoRm1YaVcwaEtkZkQrcUlWQ0hrcWQ2?=
 =?utf-8?B?MlFmUjBQVXdKbDBoZWtXR05pbVB5eU5BWnVaQkxVODJOUlpLUUhybXR2YldF?=
 =?utf-8?B?a25vN3o5YjFNOW1QeDB6STRCTnRvQ3RqUnVPdzM5aHl5YkxIc2w4UFNuRTl2?=
 =?utf-8?B?L0k1eWUvZEtJbnpsM0p4aTNPQ3FvV2xtUHFldVA4bjdYcFBLeGt4d3N4ZFU4?=
 =?utf-8?B?bjUrTVVjWVVLWG5GMXRMZGxFcU1oLzViREpNVGV4Y2tkUXJIeC96VzZGNmJU?=
 =?utf-8?B?NVUrY04zd2ZmbFZWNDlmVXdKOExFN0N6SkpHaWkyOFd0QklSOXp6LzBPVmlq?=
 =?utf-8?B?VmJ2c1NMczdLbGNjcFhEaUZjVXhIV2wxT2hHWjU2VTlTWmRrNndIZXI1MGlQ?=
 =?utf-8?B?SVpBd1JpeFZremcwNjgwd0hVNnQ2T3pncTdPNC8xcTVpYWRzcU5SdkZmb3Vt?=
 =?utf-8?B?NzNWM0NEdVJnQzBhZXdtN0hCanYvTFlPaW94RUpVS3YvclpkUFpiOGFTMXZz?=
 =?utf-8?B?NkhhYzlIcjQxVDJzRklYbVJlSHNTUzJDa290UEUyb3d5UVRaOG15b0dEbUpW?=
 =?utf-8?B?YXBneXpCWVhUZE1IMm5GdWtVampXUngwRXl5bjJiTXl3WkxLcGkySzlkbFVm?=
 =?utf-8?B?M0RaZWh5SUI3WTFGMzF5R0tnc0VKU0JzeDZUUEtpWGs3NytFbVdaZ0M3SnNq?=
 =?utf-8?B?QkV3TnRiTmZIaHg1UUN5WjBZb3gzeWtkYTZxZm9xb1YvbGVnYXY5bjVsTWdC?=
 =?utf-8?B?ZUFBMEIrSVd6citCRDcxNUxKcFhORzlaZm9RcjRVcWtHbzRNcDExWkFIU1g2?=
 =?utf-8?B?bmY1ejVpd25NR2F1bVFybjZVNFY1MUdSVUR0d3BjTUZsbFBpdkdnQWJvQ0Zt?=
 =?utf-8?Q?YF7dQtam3aZkEGHeTBgG7idDs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32953f4-dd67-4177-289b-08dd7cdd7099
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:54:27.8667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1k9UUe2K4RGdXR6JAhz7JwWDbHagjzubBQJKd0whSnEhayoi552lOa8huDgf51p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
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



On 4/9/25 18:26, Padmarao Begari wrote:
> Read an eeprom after relocation if multi dtb's are disabled.
> 
> Padmarao Begari (2):
>    arm64: versal2: Remove dtb reselect and multi dtb
>    board: amd: Read an eeprom after relocation
> 
>   board/amd/versal2/board.c          | 3 +++
>   configs/amd_versal2_virt_defconfig | 2 --
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 

Applied.
M
