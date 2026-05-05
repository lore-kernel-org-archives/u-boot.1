Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF7CCD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59FFF84687;
	Tue,  5 May 2026 07:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DuMyc/iX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B14088468B; Tue,  5 May 2026 07:03:55 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8157B84683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQqA1CprN+9pcKsHd8WYD2xdk3Gok+0ePZaYKivCc3hkpAuXW/mX3Ne7gf2RoLnv5egDjPN8Sa2hRROSJfK65BMDolsMcyR5Bti4VTXgEkcJojOq5Kn1vD/F4t2+o6oc/Ahnap9R4t0UL7OKNd+gfomPoZMYUTKDkXm5e8d/S3Tx51ZbTMDwRybnYi4H5DhYnfwxzBkotuNchf8DErsL6epongliVKVflrVrd6saAJPLe9ZhrLtUa1kIAMYX28B4HUPbpjsCIMEU4l2zGqk3YHS3JXAFC8ffdmGgojWilO2KqLxzqbXktcp4VvzzGog1+e+vi1x/odXAuJZR7oUQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EarhyF4NaZ1udSx+tEcdmZKBO6FLIsAO9+72BZmguOk=;
 b=efrLQPcS3HPQnFmMrXARzFnLOq4+lwxiGiDZLjLQMSjVhF3iTxxlrOxsXBi0gl3LtVvcOjsnoVhP/CtGaEiL1zKmWWE8yYtPzsAjzTtUZXyhOWDz/LkuLhFGP5BR1gXb3c5RZymh04oA1nSVu1lwVBPDD3DDCUAaVKFjONnRTH2BXt0dyYgr/Uj962wmDABgZIUh/IqobGrfJZj/8OtdiGWZj2l8owmSlZ2+eXiPDiKffC3qdS5pbZvCaWB3aNFqvA/TxOZfG6qy/1bEmKzkwDRTCc4lQSefrb8yls6XUMaG+CwJULCY8MWbJcydmi3bqffQedbUGZx7HMGBtysBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EarhyF4NaZ1udSx+tEcdmZKBO6FLIsAO9+72BZmguOk=;
 b=DuMyc/iX2sR1US7oncBekhtAPloqjychOC1Y792NPDoNOCNzmBdcyltUldIeOdaCrAa7yKxRq9+/mSxO5tggD8NvMM/GbkKR25+uinyWvtFjvi1FRjnbEM85EQ2NcGMLUpUNtdDHpu+/TfWe6pmL/fooJarVJa0Z0q7FUf19iXBTVqvUm8KMqsdXT4rk2APiWvzQyITaerUSWfmndUh7nAGWwnMz9aVFGdaaaRhmrPYlM8CTa6jLpc4qdpkPk1/ra+hLDlduOTfULBbQUY1RwGV+KeLU2s6n3SgqY8Ct2sI10xFFe/dVuanydgUhYtQ4dIpAZHwgq+UA4Ao3aJ0dQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV4PR03MB8282.namprd03.prod.outlook.com (2603:10b6:408:2d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 05:03:50 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 05:03:50 +0000
Message-ID: <5ce3b23e-97a7-46b5-a0d6-2ba28d7a2c68@altera.com>
Date: Tue, 5 May 2026 13:03:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-2-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260428033230.7777-2-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|LV4PR03MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccdc449-24bb-4831-09de-08deaa63b213
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: ul4g0c7/OuMznIZ6UTn1noy+B+UAXqHAc/Rg8VxYaHb3f2gQqYyfd0WJejKsA9Tcaz+d3L8vWSMd9EvYw6IPVmNNRJe2+W/e42Wh1AWFj5S/sUkNx7Ln41oPkXn3QH+QsVqDXB+VypL2XwuUTA0hNudH6suRUIfw8zNWj9svMFZOurhUIrTW5/+WlmCMwkdjEMCo7BfYg5DkmHMawh7wlgllslZtSp4luHKBO5dL0Yz7HwjAswBpPXEgYF0UEXThlmxBEkP0UMkz9QNTD2iiIGoizU2rxgx13T8dWpfc8t9JpSxmh0FjkjxBCqgaVYx/wqzOQOyySXQw+ehKx9wLmZVCAqwRvlAybcV4w46Bxe84ePOxOmt0PYbhllYGTO1jgeSpOl8DA9ZVuEuWurUU30+f06m8RgfVXvaIkZahR2404W10yydqTRIySdCeOk3+EFkcsEAxsZkCCVipFiinBFQiE5rVaghcA8rh/F8lOYYEJqL3mcXl3LuEBhSYP1TGQQJ+IFIhILT/bPECDLZgrYwv2jYez5Y+88cN3RtCRJY7bN3H0zwsXk4bswDyYK0CDRw7iOi6j9YT6xdmw8OVwZZr8NXtri3sIn8kYjzr6rC7dgv7tzpROy7lFPE+lPqUpY5u94PXTDqVzqmVuiPSYa666r3KUzPgAGWOOrtZIfHiM5pOZts5eeK9YNT+hkf1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmNpc2JwZXhUa3owcHMyT2dzTEgvN3o1ZSt2bkxaTEx3Qi81UmhxZ2Y3WEx0?=
 =?utf-8?B?dHlqcDZtbjh5NStMUklvS2lQcHhlK3pKNk41WDRyWE1MU1dnTHdMcXhvQitX?=
 =?utf-8?B?Wmg1YWZnNTBhTnFIdlpoWklrTWpWay92Y01Od2h1Q25NbG9QOU1hbTFyV3d4?=
 =?utf-8?B?WjU4ZU9vRUJ0Vnp6ZEVPRVpCOHYweE9iYTFoaUxnYUJsTHBRRWNNY08yTS9I?=
 =?utf-8?B?bVpUZjlKWEpNeGk3N2N5UzRxQkg3KzlkUFhuUE1EVUNodGw0VkxmUlRXOUoy?=
 =?utf-8?B?ckt2RjAvMEtSeTc2a2YyRTc2ZnpJeGdPZHdIZmpidDlTU24zRGN0NjREczVY?=
 =?utf-8?B?aGlqZ1Z5aDZsSlJrdVpFWDhCZEtiOExBQmtpQ3JSZ3M3b2ZtaVByMi9qUitW?=
 =?utf-8?B?NkhKYlNJZ1V1MVRnWHEzY0NGM0RiZklYRktoajhRZWpvZlNnL1d2c0duZkho?=
 =?utf-8?B?RDZBdW85QU41Wms4RENuL0p1OHN3ZzdnN2t0bHRaSnFmZzV3dE14UWVjSXkw?=
 =?utf-8?B?eWs3Y3kzR2d3L1Uxa2Yrd0NndnB5UFd1QnFsNHRadlkwbFc5V3Rnc2hnQmZU?=
 =?utf-8?B?Y0FCQldOekNhOVlIVERENmN3RDlLOXZaVmRsS2h2eTlDNlNja1QwZ0xmRFVj?=
 =?utf-8?B?VHl0VkVuTWZpT1htVFJXbmxZdDUzd1FETXJQV0lFNjlMdWRtcEFSTnJVQW1z?=
 =?utf-8?B?bGZQL1dYQzlrakZMVmFUQnd1REdYbWh6SzJGKzc5a1dSSE10cFNreC84L0ZP?=
 =?utf-8?B?bGdtd3FxVTJnS0piVnpOZGJmZXF1c01yQkJreWYxVlZ4V3hoNENoc3NCRHdN?=
 =?utf-8?B?dFFvMTNab2gxWnZyS3F2bHp1YUk1a0dyMklKSjZpeldmQkZqUlVBSGRidStx?=
 =?utf-8?B?Z2NaSDdMV0E0Mm5IN0NHRmllOWx2VWdlM0hqQmwyV0VuUmI4OHp6aVdoWHBu?=
 =?utf-8?B?UzM1Y0VYOSt3NjBVT3U2c0tvaDcyYnBUVHQ1WG1rTmFmN3JKUmJpVU50OTFt?=
 =?utf-8?B?VzZWamFiOWJFUzYvWkIrbGxaTmQ1aHpVeGpZYVdoSjUwdEh4TVVqUFNGSnhP?=
 =?utf-8?B?NlRwZDRaUlJ3N2pKQXpjQVVaWUJsb0FlTnJoNmppaTh1Z3BIRHIza2p4T25m?=
 =?utf-8?B?Z1ZPa1JjOGJPYnRXSEN5eVQ5MHlSbDduUlJERkFZOVIxMXVqVE9Ldmhza0h3?=
 =?utf-8?B?U3U2RSt5clhTQzJMZGFGa1hIeXRhVTdZd1hrZTZNR0VGY1YwS1JJZEFBdkRX?=
 =?utf-8?B?S2luVHhCSjRRZ3Brd3JtQU5lOXFtV1FWWENFNVI5dWorQXROR1ZqMHdmK0I2?=
 =?utf-8?B?WkRpZVJJd2dGYTYyaHFRY3BJY3RMN05KRnRYZnpURjBrU2k3WU9hMTYzRlBN?=
 =?utf-8?B?ZUlteTlXWEJsYi9pVS9kQm5hT3hMOUp2SVRhbGtiQlZGVnJRZDF3UFhjNVBj?=
 =?utf-8?B?aERuU1g4K2gvU25DOGdrNyt4T2VGTEE2TmxGN0xIN1pNUmNkdTkyZXR3M1hU?=
 =?utf-8?B?R2pMdy9GU3h0cEJuL09WejRRZ3k0Q0xweUhDTFlhRklnUllXSmJTVUF1SXYz?=
 =?utf-8?B?OGgrK3ZoMXkwdkoydGY1anlsdW8yK3dQL0FXNXJWNlZrS3l5N0lvaTFkdmw5?=
 =?utf-8?B?ZkpGb1FCdSs5elhScDlIcnpBeG9XTDNtTjV1YVlBc0w1SCswL0kwNWsxejBK?=
 =?utf-8?B?aW1XQ1JmZDVIZ1NFcFpnY2Vsd0dqbW9ZSEkxSjFJeVd5V0o3Y013WU4zMHFC?=
 =?utf-8?B?eTVqb0VsV2dsMFczK2E0OGRFdjdKTVZZK2ZTa0hwTVQzQnhiQnpsOXRYVWNZ?=
 =?utf-8?B?RGVIalhQRzUxMGRhclQxTTZkSVprS1ZYODRSSjV2d3hWdFlPUHFqU0FKaHpG?=
 =?utf-8?B?TDJTUHcvQjhrbGJseVJ6WjZqVTNrNDE1NkNmbWIvUDdpeG4wRGFjVmtGYlE2?=
 =?utf-8?B?bU1kSVJpVjlTTVpMNzdCTWplZi83L0tCcU1xRjFicmtOd3R3Ym14K1lDWExD?=
 =?utf-8?B?QW90MjE4S2RVVm90c3NnaWVmQnozUGJjOHFVbXpBT3hSWmdNdGx1d3hKcVhP?=
 =?utf-8?B?cU5mZ2lBaUtDUklXRXRLZzFzakhnazJENVBaQkNGNGNTdUFkNUVpRloxV1Fn?=
 =?utf-8?B?aE1OV2x0dTVIQmZCTW5Ha3UzN0JieEZSYkoxYXM4RmY5NlI4alJTdk56ayto?=
 =?utf-8?B?N0pUS0Y4bGl3KzFocEgvTCtBYm1yOTcrb0NGRTV1dlBHOFdYU28yWmF5bWZR?=
 =?utf-8?B?V2xhZTFTUWF2ckFWNTJTZTQ4Q0RaRnJPQzdnanBVZ0YrbEF3aWhzUUF0Wms2?=
 =?utf-8?B?bElxTDhjNWk0TXF0dGx3czVKcWFjUklIMllsbUcxSFpPdmtVU0IrM2owQ2lR?=
 =?utf-8?Q?nuaE+jsX5aUEbqB8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccdc449-24bb-4831-09de-08deaa63b213
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 05:03:50.3388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvXc3FHbqw/2+JnF69GWGCZ8FBcSMMmIr6ry9KeUxMSOgIe2N5ACfcl+xsghd2qvDVVas9ROzYS+v7MsodACltPzwzqv/ksylUSYTchDHLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8282
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

Hi Alif,


On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Relocate the dram_bank_mmu_setup() implementation from misc_arria10.c to
> the common socfpga misc.c and update the function to correctly handle both
> pre-relocation and post-relocation cases for DRAM cache enabling for
> consistent MMU/dcache setup across Arria10 and CycloneV platforms.
>
> These changes help to improve maintainability and consistency of DRAM
> initialization as well as MMU configuration for Arria10 and CycloneV
> platforms.
>
> New Kconfig is introduced to enable this implementation only on the default
> Arria10 and CycloneV boards as this will increase the SPL size which
> will exceed some Gen5 devices' SPL size limit.
>
> Fixes: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before relocation")
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   arch/arm/mach-socfpga/Kconfig        |  1 +
>   arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
>   arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
>   3 files changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index fb98b647442..e2fdd6bb30f 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -115,6 +115,7 @@ config ARCH_SOCFPGA_CYCLONE5
>   config ARCH_SOCFPGA_GEN5
>   	bool
>   	select SPL_ALTERA_SDRAM
> +	select SPL_CACHE if SPL


Concern: Two-step SPL_CACHE Kconfig creates dangerous intermediate 
bisect state

Impact:

Bisect or backport landing only patch 1 forces SPL_CACHE=y for 
TARGET_SOCFPGA_TERASIC_SOCKIT,

TARGET_SOCFPGA_EBV_SOCRATES, TARGET_SOCFPGA_SOFTING_VINING_FPGA. SPL 
exceeds 64 KiB limit and fails to boot.

Fix:

Remove the 'select SPL_CACHE if SPL' hunk from patch 1 entirely.

Add the correct conditional form 'select SPL_CACHE if SPL && 
SOCFPGA_ECC_SUPPORT' only in patch 3 alongside SOCFPGA_ECC_SUPPORT.

Best regards,

Tien Fong

