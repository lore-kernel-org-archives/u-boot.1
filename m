Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1823DF9B5E2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 08:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AEEB83936;
	Wed, 22 Apr 2026 10:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="U3AzD86+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C313083C51; Wed, 22 Apr 2026 10:31:46 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848908352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4r3rpwIbY3hV+H3fupAM1w8Qf08Y2/ENqoOlQdWIrMwGkJycAnlzH3Gex35PrG1me/xZULf6Kq7bh6ekSbLmd9i4FxXo7K9Qw9/iJnagfKA2Im/5e1Jgtyb9RFeYb2an2VhJSlCjINqZeEG1Bsy6ztdPEPhULdI6MuUgFcN5G8VkQ7ZLObEaSxgNKHEJmdOxqZTwd/S9QCU/urWCqTILjw/P97fRTobPzcW4gq7K+xGlyrz09Krh33B5AdTe0HtPehei/0B5OWac+QhOXIaAddPiSbfcdqgcSSDVrr+2zgA+YfqZTqTWuy0DbQNHkgrXiaFgAV429FotNVQ10jukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSnXAkrIPH9p79Dsrg4Ls7pLTLR/r3qpGcbI3EMljOI=;
 b=eO/Ldrsiz+Yak1j+Yt8/ThMru4z7dCIurcW/7oLw8SvAZeIiwoKUf3ksQVH2nkyWfYfoB++yaAsJR4wa2X9Ajplph8d1emJuVzuVE5fJkaEaZACA6r7CUkcV7ZnQcwH8dK21HArPUke+qCtXiogcY4GHRyQtw9CD4vt3Efa3nsRJUNUpcOn94e0YnTEkj6Ij0LLwLz/Uz//ntvQDRU1O0JLoeduzY+FKJrSNWoGFmuXPGotQnVZKbaSvSszDbA2mzGmvboToGKTFaP4o4nWSgbKErZKFQHlUkFYhkJDj0KHI+lrTPdLRcttwosHT8ONn6O/DwPZZPUjgDcRdxB7Dig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSnXAkrIPH9p79Dsrg4Ls7pLTLR/r3qpGcbI3EMljOI=;
 b=U3AzD86+u0PIhI+hpkdorCj2qHfaf+Q8VaHa9vzLoK7sDoucJfE9lrm50dwlXNs+yFo7SALs1fvqkqXFLnyjIOPoJFxDTxw6aQVjaSRSDkDKWOFeadYOQ6pK3+kTW4+AicPqVHZL8EDtVEHWGuhmV+z95mVgghlY5fMiz2zj5MumbJmQaX57hhQcGbiHnruczOf4cKwsWX9vKBJtJZ0iftJdB1FJ/68OUQPd3HYg4Sata3KRYtre4zSoIpISW27FYhJqEw0SwdJRnKTExFAcBti6JXKnKsc1RTxrfCXUXc8/YU2M7U2VzirPDUE+6eYfceON5enlGbWmuhtlOZRbFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DSWPR03MB989106.namprd03.prod.outlook.com (2603:10b6:8:35e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 08:31:41 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 08:31:40 +0000
Message-ID: <5ee629cd-c283-4c4b-905b-fef56e06043e@altera.com>
Date: Wed, 22 Apr 2026 16:31:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] socfpga: n5x: improvements and cleanup
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260318030034.25889-1-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260318030034.25889-1-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DSWPR03MB989106:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e1643c-d3f2-49b1-3856-08dea0499398
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|55112099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: IAnIlnc5wTCoTnHlTbsdHIvJoik9jiLvads+nn23QQg/kvv0vJfq+IYk74kIhBrXqAVZBlAc3/iWVoQS5mYXyqlKUSh/T4Ar9fk2TJvta2xXhZ1iU8dPHgE3S5WWd5ik/Uhd9tVOQHlnCIox1C/ytCgywPj5Qs6tKatWMf/2MwvydCemo03KwpEB729QfZeuCPiqzR6+frRu8DH8GIGvoSjYZQvEI3EkqVuQx5/+Kqt0d6POvwIKWKHZl5/eChXFU7AEXvKj5Ufazx0wL5gbz07y+zVNZqjFsuSBCgm0/fppWdGct3SXfZU/WKip3rBWaS3WqHW4A+lP98+QdfHV7csDEDb/CwSgDKAJcmZBNSQPGTXRgIWHaCsiZ+H+e1Oiap6t939O6Go/HiE+YnQHIHj4i1UjTEQdZAYUYYBgI3AmxX8tX5Sawk3bfjBV+0xZttZY2oMmqWEMmFc5VweAOwTebsJwzYNox53tavcPeawBAJtsOo03kdJS1igigaj7l5zfSUvhACm3G3sqnd81SylTeHEVA6e2LRCNpNFpZr9kZ8oDh1X2xyNTZJXYsD3P+mIh5u5EQZWS3wMspN99CHotBgXeluPA3goLCoTwOWBtgAfRQrDCQohZxGaUXy6pgoaM9Pd9NGBnEgUUV4v7xRclaQMB7DKo6XSX4rEiCiQNxvgkBDX/qSORKHPJcKkqgFACNzXZpaCZ15oktZNQn6BOfzCtd9rWPkxqSwR+bWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(55112099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzFmQXFNL1BQeW1WV2xqTm5NZGlyQS9JN0RoNjZFdWVKcGNsa1crY1htL0lp?=
 =?utf-8?B?Z3V0Qjd6bUFLQ2twb3Zpa29GMzZPV0lYWThLL0tkOGJ4ZHBXajVoblRwUlY4?=
 =?utf-8?B?YWgzbSs1SXR3SlVLbDhaUUpJVnVQcmE4TGRrM1ZEc0ZrUkJXU2FuZXBvWHhv?=
 =?utf-8?B?WTh6eVBDWlp3b1laNGs3SlNDZkNHZ2ZuMUdPUHpvUXY5bGUwMlhsWC9yY2J0?=
 =?utf-8?B?V3h5VGk5c1RrRzNWeExyTEt0cVMwT1NlcEErQytvUERzSW1zdnVWQXRHK0dR?=
 =?utf-8?B?N1ZKQkRudHVEZUM1allQR0VYb2Nwb1dESFV1bTBuWGF4T21sUDRmVHJHZi9P?=
 =?utf-8?B?eFlFV0ovTllCVG9IRS9Gd2pPcWNCVDlNUHZLTlZCUDgycVl4bzBsQ2lKVGZG?=
 =?utf-8?B?dmxNUCswbXEyelp6TFkxOVlMRjlhb3I4a0JJRFhTSkF4YnNLQnNqbGpxeDdB?=
 =?utf-8?B?Skl5N00yQjNtNmxMcDVNdWJJb2JycVhpampRRGxUV0tGOFhLb0o3T0pXajA4?=
 =?utf-8?B?UFJiMHZ0NGZDdmhoS1pyMkRHc2Q5cEhHaUZndUNRaThDK3ROUFFYdkdOZkxN?=
 =?utf-8?B?dFFhdXB4RmJ3SExoMGxrT2oweWlueUllWjRUZm1ZRzVQM0NCNlBMNTBNMngz?=
 =?utf-8?B?SXIyViswSEFaQ1pJbFIrbHRsRjhmanhzZDZod0NkaXhmZXRoNitsZ2Rta1Qr?=
 =?utf-8?B?Q1hmRXNjVjdaVzdJWGRTbk1VSHBZYVRZbUc5blZWU2dkSnp5WVRvYWJIOStu?=
 =?utf-8?B?L1ZjK1RTN2hLUE54cmFXb01yWFNVcno0UXJUbE9iUWJ2YTNtaWozYmh4bDkx?=
 =?utf-8?B?Z1hqR0pGRGY5R2c1eDVUQjZ5OGRpSldkNER5ZWs5VjNidG5DRXZiVEhIT3F4?=
 =?utf-8?B?K2U2YjlkdFFHdmRUSnlKVElxUkMrZHkwZ0NpaFA4TjZ2d0VGU29CMkFZNXdE?=
 =?utf-8?B?czYxVXNVM2RoZDdBaXA1TFczcjJGeG4rMFhnMUpZQk1TM21KMzFmSXF6ejF5?=
 =?utf-8?B?bEFqQ1dxUkVlN1RYanZpUTJpUHpXaG56TVBTOGFFeG1YazNXY01va2dIdmRx?=
 =?utf-8?B?N0xNVk16aWlCa25YcnVrMU5QajVBbGdxekY5OXBBQVpXWENmNldmTzhMenpn?=
 =?utf-8?B?UHpFdXllUS9PaVBEdEFQTERZWXNrWURSZXFmNTVLR2t0M1pJK0k2cTNZMVpF?=
 =?utf-8?B?R3BnMEFpZUlwdElzUC93MFJwdnlaR2l5RGs4cnNkaE9xeDk1SHpsUzV6Zmxa?=
 =?utf-8?B?emh2UHU0ZzB1eG01TjhFTkJqVENkMnl4eGoxcnAzQ21IYjRnNkFNOTY2RTQ5?=
 =?utf-8?B?dnJUMFhjWXk2WlFNTzNhR2s0aCthcTBqNmw0SjNjQlk4NWU0MFlZMHQ2eW1y?=
 =?utf-8?B?cnVmTEZ5L0tuMnZjU0pBM2NuQm5IRDhxcnk0WGtwUlNLSzVZMlQwK2xyME5J?=
 =?utf-8?B?bTNaRG5zVlVrcW9KRDhhM0tQeTFxcUc3aFppR2JlcVZaamVXeUtFK3U5QjdS?=
 =?utf-8?B?bVpxYUp3bjZVcUVZSy8rN1I4NlhPL2hJVDYxOWhtQ3Roc3ZMbG01dW4zSmpq?=
 =?utf-8?B?ak9FSEZMaU1sQ1hIbVJZR1VadjljU2oyRTZlNkRrREJlbWQvZ1F1bVN4QjhI?=
 =?utf-8?B?SllKTTJZd1lzT2piUDRUWVZ2bGRPZnhMNUJzaXBYRmZ6SnFMU1ErSE9tY3pl?=
 =?utf-8?B?NkNoRzBNSFU1NmZaOTlhVXJ4S21LT3duWlc1WjNrcmkxelNoaHF0T3BSVlQ5?=
 =?utf-8?B?b1E2ekRpYUUvMWJER0lzVytKVW4rYWw1bXNubTFVNnVxcTlKTytoRUpsaXpm?=
 =?utf-8?B?ZGdWSE41NGdRd3hjbTFLQWErNXRsSERVL1BpV094YllQeU1rR3I5THBLWlFN?=
 =?utf-8?B?MVhvWGtCRGtFZXVNcm5ZL3FHVWJqMW52c3RzQ01zUUxmV3FMNDgydjEreVhL?=
 =?utf-8?B?RmZCQ1VuTEJiTGJxeVZwc2RWd3lXUjAwdmdOQlppb0ZubElPbk9lTkhNbTlq?=
 =?utf-8?B?M2FNRUZ1VEk3WjZiTitYNUFGdURGSVhUbk9TMUQ1b1BUMFU3blpxa094ZSsw?=
 =?utf-8?B?WjdTWTYxQVZ2OXFuaS9SdU9DZWtmQUdlWG9tclFESVF6U2hTWHBnOFVmWERW?=
 =?utf-8?B?bktGYk5nampKdzhzQTNGbHVBMnQxL2M3d0FYRFpBQmJzdWV2TFNDTEwvTUJr?=
 =?utf-8?B?N0oxK1g0ZnkvbmZzMW1XdWpFRHBkNUJoNFc2YnNLZjhOVVRNdXJOSEJHWjFu?=
 =?utf-8?B?a1Y5R1pFY2lVSGdFZHM2VFZzSjlzdk9yOVdDMUNIWk5ibkkzR2RpTUxnWURt?=
 =?utf-8?B?VU4zVnJkektiNHFqWHZTQWV2dXNvWlRvTjhLenFNR2xUSThiVEN3K3ZzYWhR?=
 =?utf-8?Q?Pf6VOZJ++J/vMfxM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e1643c-d3f2-49b1-3856-08dea0499398
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 08:31:40.7161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f6L6x078Atgf4ctTQ/MBVf4Cpiuy9P32ol66QC32tFzEPyhUNRB/iKcs5eocUY7OfkRL4HHD5z1g1sr9CgTgprI7BjPxyT9pUtzdUg4YwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989106
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

Hi Lok,

On 18/3/2026 11:00 am, Chen Huei Lok wrote:
> This patch series updates the N5X platform support:
> - Replace defconfig with ATF variant
> - Switch to upstream Linux DT
> - Convert firewall setup to device model
> - Add ISSI QSPI support
>
> Tested-on: Intel SoCFPGA N5X SoCDK hardware.
>
> Chen Huei Lok (8):
>    configs: socfpga: n5x: replace defconfig with ATF variant and simplify
>      VAB
>    arm: dts: socfpga: n5x: enable DT register settings and update GMAC
>      nodes
>    configs: socfpga: n5x: enable CMD_MTD and SPL SDRAM support
>    configs: socfpga: n5x: enable required configs for DDR retention
>    configs: socfpga: n5x: enable ISSI QSPI
>    arm: socfpga: n5x: Switch firewall setup to device model
>    arch: arm: dts: n5x : Switch to using upstream Linux DT config
>    arm: socfpga: n5x: Update SPL data save and restore implementation
>
>   arch/arm/dts/Makefile                      |   1 -
>   arch/arm/dts/socfpga_n5x-u-boot.dtsi       |  56 +++++++++-
>   arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  21 +++-
>   arch/arm/dts/socfpga_n5x_socdk.dts         | 122 ---------------------
>   arch/arm/mach-socfpga/spl_n5x.c            |  30 ++++-
>   configs/socfpga_n5x_atf_defconfig          |  90 ---------------
>   configs/socfpga_n5x_defconfig              |  31 ++++--
>   configs/socfpga_n5x_vab_defconfig          |  91 +--------------
>   8 files changed, 122 insertions(+), 320 deletions(-)
>   delete mode 100644 arch/arm/dts/socfpga_n5x_socdk.dts
>   delete mode 100644 configs/socfpga_n5x_atf_defconfig
>

Patch series is not properly threaded (Patches 5, 6, 7)
Patches 5, 6, and 7 have Message-IDs with completely different thread roots:

20260318031612.4003-1-... (Patch 5)
20260318031635.8384-1-... (Patch 6)
20260318031708.9418-1-... (Patch 7)
They are not In-Reply-To the cover letter (20260318030034.25889-1-...).

This means they are floating as standalone patches and patchwork cannot 
properly associate them as a series.

The cover letter also lists them, but patchwork only shows 7 entries 
with this fragmentation.

All patches must be sent in a single git send-email invocation, 
referencing the same cover letter.

Patch 8/8 is missing from patchwork.

This is a submission error, the series must be re-sent with all 8 
patches properly chained.


Best regards,

Tien Fong

